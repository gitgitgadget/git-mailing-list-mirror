From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 9/9] t3301: Modernize
Date: Wed, 12 Nov 2014 13:18:30 -0800
Message-ID: <xmqq389o3yop.fsf@gitster.dls.corp.google.com>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
	<1415752816-22782-10-git-send-email-johan@herland.net>
	<CAPig+cSVtAi-n4EKaOgNwDqLvajzvozRG5_o3XjfZAMzW8T8-g@mail.gmail.com>
	<CALKQrgd-XzAhyZCADmQbCuUL6bdr1nrY8XACBb7UbEv9c=X3dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>, Jeff King <peff@peff.net>,
	Michael Blume <blume.mike@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 22:18:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XofJH-0006hM-IH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 22:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbaKLVSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 16:18:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753309AbaKLVSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 16:18:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F8CF1D7CA;
	Wed, 12 Nov 2014 16:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QQ3qnRBfs3GP4QTn7R+ofx31maw=; b=Mxd4dr
	IlGHum4peAG9Ftw5/7mmFbzqjfuX+ArOADGXqgIYfIRDCLVN+e6brgCGFwA2/NKF
	TdgNM6cQ9hMIMNWL0pGELBVxQaaz/AYTaXshCY1FG1Dx5Agofvfgkc0VLuGs5dFn
	PypBDoeNK3dDqMfU4gelS5XKfG0kpN38qJIX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XnwOx/q6YSgb1IWZzjVpG63lxZixHobU
	GVBTN+QoTnYqdwGMshiz6voimYyECZX8oh67nyXhXhNxa/BInkpiLoEsBBnWyzYa
	YulH+9Bzd3X/X9NNhPLEjkDh6Xi916LdMjsQbadVeikLYbWAeHIlzQeCLw1RkUx/
	fZ5ISXkFOp4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43D961D7C9;
	Wed, 12 Nov 2014 16:18:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAB361D7C8;
	Wed, 12 Nov 2014 16:18:31 -0500 (EST)
In-Reply-To: <CALKQrgd-XzAhyZCADmQbCuUL6bdr1nrY8XACBb7UbEv9c=X3dQ@mail.gmail.com>
	(Johan Herland's message of "Wed, 12 Nov 2014 10:08:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7426D61E-6AB1-11E4-B278-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> On Wed, Nov 12, 2014 at 2:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Nov 11, 2014 at 7:40 PM, Johan Herland <johan@herland.net> wrote:
>>> +       test_line_count = 1 actual
>>
>> Broken &&-chain. This problem is repeated each place use invoke
>> test_line_count().
>
> Thanks. Fixed in the next iteration.
>
> ...Johan

Just FYI, here is what I came up with on top of 9/9 as 10/9, and it
can be squashed in.  If these will be the only differences between
v5 and upcoming v6, you can just tell me to squash them together.

One unrelated changes is that '\'' is a bit shorter than '"'"' (and
the four-letter sequence is idiomatic and easier to spot, once your
eyes are used to reading strings in single-quote pairs).

Thanks.

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 861c159..245406a 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -53,7 +53,7 @@ test_expect_success 'create notes' '
 	MSG=b4 git notes add &&
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
-	test_line_count = 1 actual
+	test_line_count = 1 actual &&
 	test "b4" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
@@ -67,7 +67,7 @@ test_expect_success 'show notes entry with %N' '
 
 test_expect_success 'create reflog entry' '
 	cat <<-EOF >expect &&
-		a1d8fa6 refs/notes/commits@{0}: notes: Notes added by '"'"'git notes add'"'"'
+		a1d8fa6 refs/notes/commits@{0}: notes: Notes added by '\''git notes add'\''
 	EOF
 	git reflog show refs/notes/commits >actual &&
 	test_cmp expect actual
@@ -77,7 +77,7 @@ test_expect_success 'edit existing notes' '
 	MSG=b3 git notes edit &&
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
-	test_line_count = 1 actual
+	test_line_count = 1 actual &&
 	test "b3" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
@@ -87,7 +87,7 @@ test_expect_success 'cannot "git notes add -m" where notes already exists' '
 	test_must_fail git notes add -m "b2" &&
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
-	test_line_count = 1 actual
+	test_line_count = 1 actual &&
 	test "b3" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
@@ -97,7 +97,7 @@ test_expect_success 'can overwrite existing note with "git notes add -f -m"' '
 	git notes add -f -m "b1" &&
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
-	test_line_count = 1 actual
+	test_line_count = 1 actual &&
 	test "b1" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
@@ -107,7 +107,7 @@ test_expect_success 'add w/no options on existing note morphs into edit' '
 	MSG=b2 git notes add &&
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
-	test_line_count = 1 actual
+	test_line_count = 1 actual &&
 	test "b2" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
@@ -117,7 +117,7 @@ test_expect_success 'can overwrite existing note with "git notes add -f"' '
 	MSG=b1 git notes add -f &&
 	test_path_is_missing .git/NOTES_EDITMSG &&
 	git ls-tree -r refs/notes/commits >actual &&
-	test_line_count = 1 actual
+	test_line_count = 1 actual &&
 	test "b1" = "$(git notes show)" &&
 	git show HEAD^ &&
 	test_must_fail git notes show HEAD^
-- 
2.2.0-rc1-84-gcd6439f
