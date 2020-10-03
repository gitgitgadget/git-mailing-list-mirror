Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DABAC41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B695320691
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 17:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JK1dJ/9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgJCRWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 13:22:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61724 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJCRWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 13:22:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D99B382668;
        Sat,  3 Oct 2020 13:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PqErt1AbQbM9yOnFl3in/3JOOHs=; b=JK1dJ/
        9eZQAM6zL+XO6VDLx3tDfRLxh4PKyLVnSHZFAoQFa9gdjSLve7KUXwHrktJlIgI4
        Nc/0jb+Ei28lWq3WfASreTMQjUH8w+rERO4V+yM2ZgZ8l8wRY1ik0UF6EGpdSCBi
        WoCAg5B7ayQKMaLoX/hBJ9LVoFMnMJDFFOfEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VBgEKVTaryprx9TsGfvPR7fnjgmXj9NF
        vOd3omysvb05NO8CDJ9YFIwGeb+v5jpKhNa4qXoKkhUe5O6LM5y+gY9GysgRsY/l
        WA7ifZl3sKruTr+0Gnz0I8WBtoxD7BrBo1nXybqTJJ2oCyy20xCLyVxanixV+yQe
        TJaBtiT+uY4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D19D382667;
        Sat,  3 Oct 2020 13:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D09182666;
        Sat,  3 Oct 2020 13:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test_cmp: diagnose incorrect arguments more precisely
References: <xmqq4knxwhkc.fsf@gitster.c.googlers.com>
        <20201003070412.33015-1-sunshine@sunshineco.com>
Date:   Sat, 03 Oct 2020 10:22:13 -0700
In-Reply-To: <20201003070412.33015-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Sat, 3 Oct 2020 03:04:12 -0400")
Message-ID: <xmqqpn5z8bsq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA9E5A6E-059C-11EB-A57E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09) taught
> test_cmp() and test_cmp_bin() to diagnose a missing input source. Even
> though the arguments to test_cmp() must name regular files (or standard
> input), it only diagnoses whether a source is missing, which makes the
> check a bit loose. Teach the check to be more precise by diagnosing, not
> only a missing source, but also if the source is not a regular file.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
>   On Wed, Sep 16, 2020 at 5:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>   > Eric Sunshine <sunshine@sunshineco.com> writes:
>   > > [...] I ask because test_cmp() was updated not long ago to
>   > > provide better diagnostics when one of the files is missing.
>   > > [1]: d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09)
>   >
>   > Yes, you did this with the commit,
>   >         test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
>   >         test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
>   > and I do not immediately see why "test -e" shouldn't be "test -f".
>   > It should ideally be "stdin is OK, otherwise it must be a readable
>   > regular file".
>
>   Perhaps the present patch suitably address your concern?

Certainly s/-e/-f/ is better to reject directories, but if we are
doing more checks, it would probably be more maintainable to have
a helper and catch unreadable files.

Note that

	mkdir one two &&
	test_cmp one two

would likely succeed, so I am not sure how much this matters in
practice, even though we would catch

	mkdir one >two &&
	test_cmp one two

as a mistake.

 t/test-lib-functions.sh | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d59b90348..ddaa14275a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -938,6 +938,20 @@ test_expect_code () {
 	return 1
 } 7>&2 2>&4
 
+# helper for test_cmp and test_cmp_bin to diagnose programmer errors
+# usage: test_cmp_missing "$funcname" "$filename"
+test_cmp_missing_check () {
+	if test "x$2" = x-
+	then
+		:; # standard input is OK
+	elif test -f "$2" && test -r "$2"
+	then
+		:; # readable file is OK
+	else
+		BUG "$1 '$2' not a readable file"
+	fi
+}
+
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
 #
@@ -955,9 +969,9 @@ test_cmp() {
 	test $# -eq 2 || BUG "test_cmp requires two arguments"
 	if ! eval "$GIT_TEST_CMP" '"$@"'
 	then
-		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
-		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
-		return 1
+		test_cmp_missing_check test_cmp "$1"
+		test_cmp_missing_check test_cmp "$2"
+		return 1;
 	fi
 }
 
@@ -990,8 +1004,8 @@ test_cmp_bin() {
 	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
 	if ! cmp "$@"
 	then
-		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
-		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
+		test_cmp_missing_check test_cmp_bin "$1"
+		test_cmp_missing_check test_cmp_bin "$2"
 		return 1
 	fi
 }
