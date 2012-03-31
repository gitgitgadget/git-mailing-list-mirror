From: Adam Monsen <haircut@gmail.com>
Subject: Re: [PATCH 0/3] "commit --template" fixes
Date: Sat, 31 Mar 2012 12:28:15 -0700
Message-ID: <4F775ACF.50007@gmail.com>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org> <1333136719-12657-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD6DCAEF8AC84FA720822CCEB"
Cc: git@vger.kernel.org, Ivan Heffner <iheffner@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 21:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE3yL-0004F6-6M
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 21:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab2CaT2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 15:28:21 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36572 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab2CaT2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 15:28:19 -0400
Received: by qcqw6 with SMTP id w6so960683qcq.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=yyVQ0yDvZB8+tvjyGtejvhPOn+niKPZVDtQ+/34zbP0=;
        b=FV+GddZvPn0Av8nsQ6CABnia7RY3XrvBCF5n5OwztlThReYw+TyHI1ZbbBmBhZJAKN
         drDrmn1ZpCjM8y2CXQK3GEaih8Y5sdUxXWxWKFDNOHKtAANazKGuJdHkWVWd8bYbw/mx
         MX2YqOlDq8/0Kc7PruqocyRLDiV3yahVwSbq/SE1e8w6oKyNa4nZaDM2TWGJwo+/CIxn
         6AAMBbIl9gLWccKK+aoauv70xHISke5BLq4+35H9eNPHOvLCGrY/C0ixx6IgVJYka6NL
         XqPPw6ldxEzUZqhSn7V2Qguj5I8WCb1Wqw251Wre8G9V4SrxcWkeXFSpoGc+AXi/VaRR
         +8gQ==
Received: by 10.224.86.208 with SMTP id t16mr4283186qal.16.1333222098647;
        Sat, 31 Mar 2012 12:28:18 -0700 (PDT)
Received: from [192.168.13.92] (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id gr10sm20363452qab.17.2012.03.31.12.28.16
        (version=SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 12:28:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <1333136719-12657-1-git-send-email-gitster@pobox.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194461>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6DCAEF8AC84FA720822CCEB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2012 12:45 PM, Junio C Hamano wrote:
> When the user exited editor without editing the commit log template=20
> given by "git commit -t <template>", the commit was aborted (correct)
> with an error message that said "due to empty commit message"
> (incorrect).  The goal of this series is to fix this, which is the
> third patch.

This is awesome. thanks!

I really like the new error message specific to the situation when
the user does not edit the template (as we discussed).

Your patches apply cleanly to maint b8939b2b3abaa.

I tested the patches and they work as expected. When I use
`git commit --template FILE` but do not edit the message in my editor,
I get

	Aborting commit; you did not edit the message.

Nice.

Only thing I'd add is a change to the git-commit(1) manpage.

* I prefer pragmatically explaining what will happen when the user
  uses --template but does not edit the message because it is more
  direct and terse (than "filling in a form").
* The below applies cleanly to maint as of today.
* I don't know the kosher procedure to add this commit to your patch
  series for further review, so hopefully this works.
* I'm not sure if the "Helped-by:" lines are kosher, I'm happy to
  remove them if not.

=46rom 91a62baa1fe89032e7a3598e5d39241f3eb8f84b Mon Sep 17 00:00:00 2001
From: Adam Monsen <haircut@gmail.com>
Date: Sat, 31 Mar 2012 12:09:29 -0700
Subject: [PATCH] git-commit.txt: clarify -t requires editing message

Make it clear that, when using commit --template, the message *must* be
changed or the commit will be aborted.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ivan Heffner <iheffner@gmail.com>
Signed-off-by: Adam Monsen <haircut@gmail.com>
---
I wrapped the text at 77 characters because that was the longest
line in the file (according to wc -L).

I used ":set noet nosta ts=3D8 sw=3D8 tw=3D77" in Vim.

 Documentation/git-commit.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 5cc84a1..f584a62 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -132,11 +132,11 @@ OPTIONS
=20
 -t <file>::
 --template=3D<file>::
-	Use the contents of the given file as the initial version
-	of the commit message. The editor is invoked and you can
-	make subsequent changes. If a message is specified using
-	the `-m` or `-F` options, this option has no effect. This
-	overrides the `commit.template` configuration variable.
+	Use the contents of the given file as the initial version of the
+	commit message. The editor is invoked so you can make subsequent
+	changes. If you make no changes, the commit is aborted. If a message
+	is specified using the `-m` or `-F` options, this option has no
+	effect. This overrides the `commit.template` configuration variable.
=20
 -s::
 --signoff::
--=20
1.7.5.4


--------------enigD6DCAEF8AC84FA720822CCEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPd1rPAAoJEJtdmT+DbynANWcIAKTVJskIAOrRRcLRNocq6Ewv
yefQitB1Tovkflfd/ORFrhpG8nYxGbfj7UgsYMjIyB/HG8mxAe1NN0leGOSJIKI9
q/vZHFIpjVRr5XHLlcDIAIRd5NWVs7gGwWvPOzexQMPLVRHN77WaU7jecab5Xihb
fz1hiinY+1WvfgmlKPhK+Zrx3PBUpBJVc+kqzyc5H9XRGzlqOIvdU9hpmT6+fHu1
iVMUgK4A1EE6rnnpotcvo+nnPVjzVa22X08sfkjBLGt2ZGp+4StNs5TI7hpBnh4B
u8ii+APmfABPCbCbgbaUlyJdUxOkWk9rI5mQgFBIfn9zK0UfWtpniOo03rc+394=
=e5IN
-----END PGP SIGNATURE-----

--------------enigD6DCAEF8AC84FA720822CCEB--
