From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of post-rewrite
Date: Fri, 22 May 2015 08:44:51 -0700
Message-ID: <xmqqh9r4fwgc.fsf@gitster.dls.corp.google.com>
References: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
	<0000014d7bc3f7a5-332dd95f-907f-4f46-a5d6-6b9e5dc70b0a-000000@eu-west-1.amazonses.com>
	<xmqq1ti8heu9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri May 22 17:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvp86-0001FZ-LU
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 17:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058AbbEVPoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 11:44:54 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37692 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757728AbbEVPox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 11:44:53 -0400
Received: by igbsb11 with SMTP id sb11so35681547igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iFtr5EUpdqR0FHnyVk/eC2t4Ml0dxXlvsotJGMtcNNc=;
        b=qo5e59jZD+PH0rjhG1SJRdi25IG5tp4AiyXJ5xS0VKKxPrgCizHL5ti97RW+awyAYa
         SKFIqPkncbVvd1mrwg6xZcq/S+HghO83O2Qnz1zw4cB38lMN0ucXlbmPYWumInlKHtBT
         /Ij7NXm0jcXufREL5Vgrh0UIk6FnDmRXKCMPx2fQU0ijM9bD0GEfA/9H/tvJjvLe8B1n
         FjO1poz1zZ2veha7gFkDqxJ9wb85tv9pLqI6Q8JYkdmLvtZqcBZYk99uZM0LGHJC+7PV
         huXFh+lVaiNhrWHJuC/PgpyBvqWyRMtOcTAUPh0F09qYKnSnji5J98dSpimXuoqPcvrD
         N/tA==
X-Received: by 10.50.57.112 with SMTP id h16mr6418714igq.35.1432309492688;
        Fri, 22 May 2015 08:44:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id a74sm2021070ioe.36.2015.05.22.08.44.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 08:44:52 -0700 (PDT)
In-Reply-To: <xmqq1ti8heu9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 May 2015 07:22:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269729>

Junio C Hamano <gitster@pobox.com> writes:

>> +	cat >expected.data <<EOF &&
>> +$(git rev-parse C) $(git rev-parse HEAD^)
>> +$(git rev-parse D) $(git rev-parse HEAD)
>> +EOF
>
> By using a dash to start the here-document like this:
> ...

Sorry, I should have checked, as I know you know that <<-EOF thing.
Your patch is done this way to be consistent with existing ones.

I'll do a separate patch to clean them all up on top.

Thanks.

-- >8 --
Subject: [PATCH] t5407: use <<- to align the expected output

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5407-post-rewrite-hook.sh | 80 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 06ffad6..7a48236 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -61,10 +61,10 @@ test_expect_success 'git rebase' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse C) $(git rev-parse HEAD^)
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -77,9 +77,9 @@ test_expect_success 'git rebase --skip' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -89,9 +89,9 @@ test_expect_success 'git rebase --skip the last one' '
 	test_must_fail git rebase --onto D A &&
 	git rebase --skip &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse E) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse E) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -103,10 +103,10 @@ test_expect_success 'git rebase -m' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse C) $(git rev-parse HEAD^)
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -119,9 +119,9 @@ test_expect_success 'git rebase -m --skip' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -148,10 +148,10 @@ test_expect_success 'git rebase -i (unchanged)' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse C) $(git rev-parse HEAD^)
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -163,9 +163,9 @@ test_expect_success 'git rebase -i (skip)' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -177,10 +177,10 @@ test_expect_success 'git rebase -i (squash)' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse C) $(git rev-parse HEAD)
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -189,10 +189,10 @@ test_expect_success 'git rebase -i (fixup without conflict)' '
 	clear_hook_input &&
 	FAKE_LINES="1 fixup 2" git rebase -i B &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse C) $(git rev-parse HEAD)
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -205,10 +205,10 @@ test_expect_success 'git rebase -i (double edit)' '
 	git add foo &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse C) $(git rev-parse HEAD^)
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
@@ -222,10 +222,10 @@ test_expect_success 'git rebase -i (exec)' '
 	test_must_fail git rebase --continue &&
 	git rebase --continue &&
 	echo rebase >expected.args &&
-	cat >expected.data <<EOF &&
-$(git rev-parse C) $(git rev-parse HEAD^)
-$(git rev-parse D) $(git rev-parse HEAD)
-EOF
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
 	verify_hook_input
 '
 
-- 
2.4.1-439-gcfa393f
