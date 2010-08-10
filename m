From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/7] tests: use skip_all=* to skip tests
Date: Tue, 10 Aug 2010 19:52:41 +0000
Message-ID: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:53:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiush-0008At-UD
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab0HJTw7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 15:52:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39957 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab0HJTw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:52:57 -0400
Received: by eya25 with SMTP id 25so4039327eya.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=XIPgVXR/4ne5IH1LRLDhoNbYQrc0n8vgJKLAUNv5saU=;
        b=GXBShIHVbOXDqSeBg8nsQeJ9jM/vmyfUjcM7GEJEuqvKzWRHOmbpTdGu0bW6QshPtB
         Dkh+6CmYecIPb+G8N8FHuB+ATlwCfJV2PhZowsy0RzpRNyAXw9tNhl6D177sW26aG9hW
         u63HoVXJ0UiGySFGJF62as3Trtq5Y4eEVrKmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=hvHLzCs2cNoIea4NpHfxCjdBJqhdKnNFnUYByr1TXgUnl4c03MilU38ldJN1dsq1JV
         MyL8buSYpIg8a74Y5GoB2o1wVwZrabXmlfPe3p5u2yQGwQUEvmYFulLZrJkXohDz6mvf
         z+gmB0rTDqDNxNpqqCCI41jg7AvqKrC6AMwso=
Received: by 10.216.21.7 with SMTP id q7mr4380020weq.19.1281469976230;
        Tue, 10 Aug 2010 12:52:56 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p45sm3602981weq.21.2010.08.10.12.52.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 12:52:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153143>

Here's another series that changes the skip_all=3D* usage to prereq
skipping. I didn't do all the tests that use skip_all=3D*, but this is =
a
large chunk of them.

The motivation is to improve our test metrics. I want to get
statistics from the smokers about how many tests are being skipped on
each platform/OS.

This is arranged in one commit per patch for ease of reviewing. It
only contains the following changes:

  * Change skip_all=3D* && test_done -> test_set_prereq, then use that
    prereq with test_expect_success.

  * Setup work for subsequents tests has been moved to tests. This
    avoids work on platforms where we aren't running the rest of the
    test, and catches edge cases where the setup work fails for some
    reason.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
  t/t1304-default-acl: change from skip_all=3D* to prereq skip
  t/t5705-clone-2gb: change from skip_all=3D* to prereq skip
  t/t7005-editor: change from skip_all=3D* to prereq skip
  t/t5503-tagfollow: change from skip_all=3D* to prereq skip
  t/t4016-diff-quote: change from skip_all=3D* to prereq skip
  t/t3902-quoted: change from skip_all=3D* to prereq skip
  t/t3300-funny-names: change from skip_all=3D* to prereq skip

 t/t1304-default-acl.sh |   15 +++++---
 t/t3300-funny-names.sh |   82 +++++++++++++++++++++++++++++++++++-----=
--------
 t/t3902-quoted.sh      |   38 ++++++++++++----------
 t/t4016-diff-quote.sh  |   24 +++++++++-----
 t/t5503-tagfollow.sh   |   33 ++++++++++++++-----
 t/t5705-clone-2gb.sh   |   11 ++----
 t/t7005-editor.sh      |   10 +++---
 7 files changed, 139 insertions(+), 74 deletions(-)

--=20
1.7.2.1.295.gd03d
