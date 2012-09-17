From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 07:18:51 -0700
Message-ID: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:19:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDcAU-0003fO-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 16:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab2IQOTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 10:19:13 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:59162 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320Ab2IQOTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 10:19:12 -0400
Received: by qaas11 with SMTP id s11so1587723qaa.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9mpQRQy0Sj0l1CzM3pL0FKHcCEH09/PXvRTw4Nb1E2w=;
        b=d/+HtNj0J4tHUMfmsLPTrATy2drjP1IyydNDKiVbHLF+O3ASxv9dR0ykwrmGhFsx0K
         Qzuw4uhM0a+sB1h0u3wwyIzwpA6xSw7xkkJRZl87b6gmEgbcQORSMBCvh/bRHzPPWCpz
         QzpGpgtA3ISN5ZLmqtYOP3s5eS26UOQFoheq354n+iFwEEo5LLa4hdEYOIQVpUv0eyFr
         lCvfyplLl5vuRPrhvjC7wk7jcHUZ0HMLE6YJirSR80hzTPMnuCf3aPeYEchi9+MK1K8k
         9CKXt1WRlv7GJFCJlx858Z2q8oA88ZUQOyZSu/0IibjcjDXp4E/2xmI6NxSBPaF/gd9S
         NH9A==
Received: by 10.224.213.10 with SMTP id gu10mr26011161qab.10.1347891551788;
 Mon, 17 Sep 2012 07:19:11 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 07:18:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205690>

Hi,

The following test in t1304-default-acl.sh fails for me on the latest master:

test_expect_success SETFACL 'Objects creation does not break ACLs with
restrictive umask' '
	# SHA1 for empty blob
	check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
'

It fails in the `grep -q "user:${LOGNAME}:rwx" actual` step, because
"actual" contains:

# file: .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
# owner: ramkum
# group: domain^users
user::r--
user:root:rwx   #effective:r--
user:kseygold:rwx       #effective:r--
group::---
mask::r--
other::---

I'm not sure who or what kseygold is.  I haven't dug any deeper.

Thanks.

Ram
