From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 26/73] gettextize: git-commit "middle of a merge" message
Date: Tue, 22 Feb 2011 23:41:45 +0000
Message-ID: <1298418152-27789-27-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tm-0007ye-28
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab1BVXn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:59 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab1BVXn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:58 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=E1/PPeuP1ixcBb1sY/Okf+68gsSwSPzINTMrr+Bi7d8=;
        b=HXL+1tj/GYuSYbQHZJ68Li7H3S6cAmRTZS+BuxsQk0i28LG5hOUsnZlQ2ldOFn7M/w
         bp1ofuJmEPKrRzIyXGtKGFVg3A8q8fWYobMW2lWz5U9jFcFxhifgsj3vOFJCtg7OUoTO
         cK4CgSK+toGcQswzNG8j4aMYtxAOMLP0kkGe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UnLQP7F85BW7bjpbnybXQypVzzPAr0UHb0gFSn2/EKyXt/bilBVlwBmFfA+VkOVfE2
         16a17k/NEofJWBhpd1ahyQRYWFIWq5gjqQWL1C4zFgvssBvFbV8ln2nlmqRoS/9j8yiN
         AmrHZ87vLg3p+0ziflj2LESR1IQrDGTEv0WjI=
Received: by 10.204.50.196 with SMTP id a4mr3019223bkg.213.1298418237214;
        Tue, 22 Feb 2011 15:43:57 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.56
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:56 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167595>

Gettextize the "You are in the middle of a merge -- cannot amend."
message. Several tests in t7110-reset-merge.sh explicitly checked for
this message. Change them to skip under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c       |    4 ++--
 t/t7110-reset-merge.sh |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c57f603..0198e90 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -928,9 +928,9 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
 	if (amend && initial_commit)
 		die(_("You have nothing to amend."));
 	if (amend && in_merge)
-		die("You are in the middle of a merge -- cannot amend.");
+		die(_("You are in the middle of a merge -- cannot amend."));
 	if (fixup_message && squash_message)
-		die("Options --squash and --fixup cannot be used together");
+		die(_("Options --squash and --fixup cannot be used together"));
 	if (use_message)
 		f++;
 	if (edit_message)
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 70cdd8e..b42820a 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -233,7 +233,7 @@ test_expect_success '"reset --merge HEAD^" is ok wi=
th pending merge' '
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
 # file1:     X       U     B    C     --keep   (disallowed)
-test_expect_success '"reset --keep HEAD^" fails with pending merge' '
+test_expect_success C_LOCALE_OUTPUT '"reset --keep HEAD^" fails with p=
ending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
     test_must_fail git reset --keep HEAD^ 2>err.log &&
@@ -259,7 +259,7 @@ test_expect_success '"reset --merge HEAD" is ok wit=
h pending merge' '
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
 # file1:     X       U     B    B     --keep   (disallowed)
-test_expect_success '"reset --keep HEAD" fails with pending merge' '
+test_expect_success C_LOCALE_OUTPUT '"reset --keep HEAD" fails with pe=
nding merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
     test_must_fail git reset --keep HEAD 2>err.log &&
@@ -280,7 +280,7 @@ test_expect_success '--merge is ok with added/delet=
ed merge' '
     git diff --exit-code --cached
 '
=20
-test_expect_success '--keep fails with added/deleted merge' '
+test_expect_success C_LOCALE_OUTPUT '--keep fails with added/deleted m=
erge' '
     git reset --hard third &&
     rm -f file2 &&
     test_must_fail git merge branch3 &&
--=20
1.7.2.3
