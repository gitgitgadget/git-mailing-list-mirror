From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git commit generation numbers
Date: Thu, 21 Jul 2011 12:19:52 -0700 (PDT)
Message-ID: <m3mxg7sasa.fsf@localhost.localdomain>
References: <alpine.DEB.2.02.1107202119440.5355@asgard.lang.hm>
	<20110721124351.25143.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, spearce@spearce.org, anthonyvdgent@gmail.com,
	git@vger.kernel.org, hordp@cisco.com, nico@fluxnic.net,
	torvalds@linux-foundation.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 21:20:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjymw-0002wv-Tf
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 21:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab1GUTT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 15:19:56 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:45638 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab1GUTTz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 15:19:55 -0400
Received: by fxd18 with SMTP id 18so3956919fxd.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Jc0GjJXDpgfMB1tBhEa7PNDOAbBWWALMndcJ5OlNQP0=;
        b=wyFoYg97Nf7YXR3GvRMv3LTJkWlCgL2AgTeLloK4/B3ROAZDnTevDbB8Hmhs+dD7iV
         j/YAwLPDn9tVfXuqX1ZJXgIybokMRg0fksITPydUpqqCv6oE0mFpZYC7Xgu6uNoCVGfg
         bLOX2tUP5dPFMGRxCNn9AI8YmE7U/Z4p1m3xc=
Received: by 10.223.77.92 with SMTP id f28mr770913fak.37.1311275994083;
        Thu, 21 Jul 2011 12:19:54 -0700 (PDT)
Received: from localhost.localdomain (abwr62.neoplus.adsl.tpnet.pl [83.8.241.62])
        by mx.google.com with ESMTPS id d6sm1583156fak.34.2011.07.21.12.19.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 12:19:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6LJInde004922;
	Thu, 21 Jul 2011 21:18:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6LJHwXa004915;
	Thu, 21 Jul 2011 21:17:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110721124351.25143.qmail@science.horizon.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177615>

George Spelvin, could you please try not mangle CC to include only
emails, stripping names (e.g. "spearce@spearce.org" instead of
"Shawn Pearce <spearce@spearce.org>")?

"George Spelvin" <linux@horizon.com> writes:
> On <david@lang.hm> wrote:
>> On Wed, 20 Jul 2011, Shawn Pearce wrote:

>>> If the algorithm is always "gen(A) =3D max(gen(P) for each parent_o=
f(A))
>>> + 1" then it doesn't matter who merged what commits, the same commi=
t
>>> appears at the same part of the graph relative to all of its
>>> ancestors, and therefore always has the same generation number. Thi=
s
>>> is true whether or not the commit contains the generation number.
>=20
>> I have to think about this more, but I'm wondering about cases where=
 the=20
>> same result ia achieved via different methods, something along the l=
ines=20
>> of one person developing something with _many_ commits (creating a l=
arge=20
>> generation number) that one person merges far sooner than another, c=
ausing=20
>> the commits that they do after the merge to have much larger generat=
ion=20
>> numbers than someone making the same changes, but doing the merge la=
ter
>=20
> Can't happen.  Using the basic algorithm as Shawn described, the
> generation number is defined uniquely by the ancestor DAG.
>=20
> The generation number is the length of the longest path to a
> root (zero-ancestor) commit through the DAG.
>=20
> If you look at past discussion, several people have thought it was
> okay to bake into the commit precsiely because it can be computed
> once and will never change.
>=20
> However, git does have some ability to amend the history DAG after
> it's been written, using grafts and replace objects.  These can
> change generation numbers, presisely because they change the DAG.

There is also another issue that I have mentioned, namely incomplete
clones - which currently means shallow clone, without access to full
history.


Nb. grafts are so horrible hack that I would be not against turning
off generation numbers if they are used.

In the case of replace objects you need both non-replaced and replaced
DAG generation numbers.

--=20
Jakub Nar=EAbski
