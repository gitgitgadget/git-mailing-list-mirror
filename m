From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Mon, 25 May 2015 23:52:52 +0000
Message-ID: <20150525235251.GJ26436@vauxhall.crustytoothpaste.net>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
 <20150525222215.GI26436@vauxhall.crustytoothpaste.net>
 <xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PpocKf6TCvdC9BKE"
Cc: Christian Brabandt <cblists@256bit.org>,
	Christian Brabandt <cb@256bit.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 01:54:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx2C3-0007sl-IN
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 01:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbbEYXw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 19:52:58 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51141 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750894AbbEYXw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 19:52:57 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd6a:414d:f0e6:5f35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 54E9B2808F;
	Mon, 25 May 2015 23:52:55 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Brabandt <cblists@256bit.org>,
	Christian Brabandt <cb@256bit.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269916>


--PpocKf6TCvdC9BKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2015 at 04:27:40PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > My use case is determining whether a patch to a pristine-tar
> > repository introduced trailing whitespace (which is not okay) or
> > just left it there (which is okay).
>=20
> In your use case, where keeping trailing blank that is otherwise not
> OK is fine only when the breakage was inherited from the preimage,
> wouldn't it be equally fine to keep other kinds of breakages as long
> as they were inherited from the preimage?  E.g. "The original used
> 8-space as leading indent, and you would not use that for your new
> lines, but the breakage was inherited from the preimage" would want
> to be treated the same way, no?  Why trailing blanks so special?

The goal is to keep the code as similar as possible to the old code,
since this is third-party code.  If you're changing the whitespace
significantly, your changes are too invasive.  If you're inserting
lines, you shouldn't be adding trailing whitespace, but keeping
upstream's bizarre indent would be acceptable.

Trailing blanks aren't necessarily special, but they are the most common
and the easiest to fix (or not introduce) on a piecemeal basis.

I agree that a more generic solution would be better.

> If the implementation were addition of a new option to check and
> mark all kinds of errors core.whitespace would catch for new lines
> also for old lines, then it would be a somewhat different story.  I
> personally do not find such an option interesting, but at least I
> can understand why some people might find it useful.

The vast majority of the whitespace errors I see are blank-at-eol, so I
felt this change was, if anything, a good first step.  Having read your
response, I agree the generic solution is preferable.

> [Footnote]
>=20
> *1* To support your use case with the ultimate ease-of-use, it would
> be best if the new option were to squelch the whitespace error on
> the new line when it was inherited from the old line, which is
> different from showing and marking the breakage on the old line.
> But I do not think it can be implemented sanely, so I will not go
> there.

I'd rather see that there's an error on both so that I have the
knowledge when reviewing a patch.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--PpocKf6TCvdC9BKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVY7XTAAoJEL9TXYEfUvaLUzkQAJKD7PS0eXYS1KNYLfMBNHjL
/dhPSLYU4/4agVoyZ3n2mgbtaz0MNATILtM3tMW0tAOZS+XFypZbufXt0oyOKBB+
ePVHeddUpEApsfFv/Xp3fycu5Zexzrn7efQPWgIyC4CZOrY73KJ9FOggvvbTjaYE
otJZuRLv7mS/oevFlcg29OwJFeDtKJEdsx+FK+Tg26pB3SxzjgWNgckfYPzvBUt7
T4SgMTrm3TMgKFagEdO1dnDa8tnqczYEI/5S554q6SmERTAUbLB47GrukUtSpiGn
AIvZlHBkIWSog3Y+nZcqYNDg+HbgcF0eQf6YSGNZtL3yqcxwk51kY2dcSag/kmAm
ddY8kAd7f/t0r1OG+dbPvwjXVpibwPnbcrGcrG4rpVpNTn3PE3tDczLyFq6mfv0f
uKWsSSstuYw6kBLYyhK7+UQQSjRoYVsLt/LSkcdyvlps1ivs1BXni/pfog4iO3h1
JhUSwVSr3s+nEcJns8W8ExyyEGwu5YwM1JRIi8+qbgL3GKqZW7HXzgUPbP3I8shs
p55glFIXlfN1fnjJ7XainfmEpaXb+nsIvvPeIb4Ag0RGgndVdTdWN1etpzbbHFuV
VSAxSN35DmMGah2NtqCDhuh22hZ+i65/E5ViZcT3mHL32yA4igBCj1EKH7knx2QJ
Lxp0CjoeaRm7ttNIxFVi
=nnhw
-----END PGP SIGNATURE-----

--PpocKf6TCvdC9BKE--
