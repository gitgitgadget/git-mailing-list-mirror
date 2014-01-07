From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 10:47:00 -0800
Message-ID: <20140107184659.GF11060@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <xmqqlhyrek02.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 19:47:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0bgV-0002i6-An
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 19:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbaAGSrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 13:47:09 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:35266
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895AbaAGSrG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 13:47:06 -0500
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id B6Xb1n00227AodY596n5B6; Tue, 07 Jan 2014 18:47:05 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id B6n31n01B152l3L3f6n4Rd; Tue, 07 Jan 2014 18:47:05 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C6587EA923E; Tue,  7 Jan 2014 10:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389120421; bh=wc2MrLD5exPXFXp4jA49Si+DdZWJqng/H7RffZ3qcaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdkCjzdYAcjxWofRzsu5qYicA7RiFWoI4MwctOCluBAMdw0EakdDPtruivYZeL2Lf
	 h+XW/55c0BuPvf5HTCsA2YWgyL5sg/dpaXi97F/4DUIR0nMk03am5qKUyLffCjwor3
	 yaNfpJcgBMBadxv78DHxfxLIDWBCdz/7j061TmbA=
Content-Disposition: inline
In-Reply-To: <xmqqlhyrek02.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389120425;
	bh=j8wEa/WX1WM3WQeMzkcTeKHz3Mi3ktugStFjaqjq6/s=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=FvlAcf2afoNZHcST+vIeSmBJFn/Yx0mz80mWq8zkG33v1jqaEeTZj57BIArpeGwdN
	 Sk67sjEezovkkOiUdfvXARY3BaA5qdU9tau9RQChpKOVxAWxUyVxnfHH/DkgPqglfm
	 vdz+ZZZObRyoIZ9yhG43fUaEapxrg6lqi8FK/oJztHkKwg1C3XLGMY51/Han/tAB4A
	 0BwTZ1bPHBeifa9ImeGmtbrPGQUAQw5Cbxra3mDonStu+w8exSsft3AKqoANo/AgXX
	 tUV5JHtc1qypcX1JICeuGrk4kNwpZ4Xr4IxjxrSv/9YnPHGLdVaYElZ3tt0q3cSK7Z
	 aztwu9lymyQpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240127>


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 10:15:25AM -0800, Junio C Hamano wrote:
>     submodule: respect requested branch on all clones
>=20
>     The previous code only checked out the requested branch in cmd_add
>     but not in cmd_update; this left the user on a detached HEAD after
>     an update initially cloned, and subsequent updates using rebase or
>     merge mode will kept the HEAD detached, unless the user moved to the
>     desired branch himself.
>=20
>     Move the branch-checkout logic into module_clone, where it can be
>     shared by cmd_add and cmd_update.  Also update the initial checkout
>     command to use 'rebase' to preserve branches setup during
>     module_clone.  This way, unless the user explicitly asks to work on
>     a detached HEAD, subsequent updates all happen on the specified
>     branch, which matches the end-user expectation much better.

This looks reasonable to me, but there are still changes I'd like to
make for a v3 (e.g. using submodule.<name>.update to trigger local
branch checkout).  However, I'm currently leaning towards a new 'git
submodule checkout' command with explicit preferred local submodule
branches (see [1]).  Maybe this should all wait until Jens rolls out
his update implementation [2]?

> Having writing all the above and then looking at the patch again, it
> is not immediately obvious to me where you use "rebase" when doing
> the initial checkout, though.

It's used to shift the local branch reference from from the
(arbitrary) cloned remote branch tip to the explicit submodule $sha1.
Otherwise the default method for that operation is a HEAD-detaching
'checkout'. I tried to explain it here [3].

> "W. Trevor King" <wking@tremily.us> writes:
> > The current Documentation/git-submodule.txt has:
> >
> >   update::
> >     Update the registered submodules, i.e. clone missing submodules
> >     and checkout the commit specified in the index of the containing
> >     repository.  This will make the submodules HEAD be detached unless
> >     `--rebase` or `--merge` is specified or the key
> >     `submodule.$name.update` is set to `rebase`, `merge` or `none`.
>=20
> Side note but doesn't Francesco's "'checkout' is a valid update mode"
> need to update this part of the documentation as well?

That would be nice.  I don't think his patch changes the docs, and I
don't know if mentioning the --checkout option belongs in that patch
as well, or in a separate fixup ;).

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/240097
[2]: http://article.gmane.org/gmane.comp.version-control.git/240117
[3]: http://article.gmane.org/gmane.comp.version-control.git/239953

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzEuiAAoJEKKfehoaNkbt+7QQAI4DSeSNI/ASsnDqvTlzQnCa
WJMgtbHP9xFNJzrrK9vqkek70bX3xGsa0/7qCM8UrJoop1nG93cEhKQhXbofm7wg
A/XhHyXhL27cJQfRDmDzcNlJ4d8CmtTFPXzIneY/H3Wwp7FwIkYm61Y9Gg/tO/aA
tP9ISCQkpDkcToclcQUj74Fkt/UN3wZ2iyihXNSu3zR+76Fxgr2+J1Doj0exgAWv
y3ovlOQB+wn/zA3dnWFvEjwg9BggQ9Ro9cjp4Yj0qCVmJvcmexjTD6ih1bP8RfpS
y8JFSjrL7vviEtT7t0lgfukLlt+b8UDCgmKYYbNwOiAiGEWHkhNo2whKeBujeeTl
WTJZsQPJ6vw86998AcoOCo0cLUQsDIaDGHd3JkGDjwFw9UBy+l9Ik6ejh0YrwFON
AREliGtY3LSiCSQCB46QDKW+tpNHtOf3sImprNEDnplKay1zmsYBOn0xEaGnbsL5
A0gNNCIVk6eOhuZCUh2Uk+r/RNL4xxgFmQpHQCwr8LztsSEJo8Ap6EmnUMQrFV3M
P+4WWbBs2Dt8m0k7mpS77U/xW9dk7tdzoJuZLyHBmTNIo2wHeDK6Ssmi7uivSYc2
1L2UIquki4WfM2mnqevLVBJLLjbDBTrNl/71inet3jQ7HXjlqgjXX10cgUwa7ITO
esQ9KtPRHIHET1SUQoeK
=eVW6
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
