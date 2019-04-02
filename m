Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1893202BB
	for <e@80x24.org>; Tue,  2 Apr 2019 01:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDBBsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 21:48:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39965 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfDBBsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 21:48:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so14392287wre.7
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 18:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XHkM4+x5T872DAhMhZRqDgUqtPUZIz7pqHHrSZ9wbW4=;
        b=uSG3odxaceFoR34l1KhgwfynSUKbe0+6ARyjCKWx3XDG2yfDknh/7x+4doUPW9woma
         BobAdj53erzRnX/Ft7BRegG2HAcw82RL56fLeaaW+6JLikOwy78izSAztEQKlgwQajvk
         8lf+GtHuuDacpULqJ+qaVZv9rHWLqwTPz1QuoN96x2FRE26qjLgQ6XMkRZTwgUbxmeMk
         QQSVp3yb2+AfVWOXAlo/2tXTpNheekaxTyVlFD9OyWUTO2R3JJKcuD1VkSKjREKqQGQK
         pNeA1+dQ9wKj/8kf+hcYAGTgxOWlq38WObmF/eBOdZKQ0wXbFR+1Hf61IAStC3szqzzH
         5E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XHkM4+x5T872DAhMhZRqDgUqtPUZIz7pqHHrSZ9wbW4=;
        b=n93b5MitoASfbwhvqE00jlVhb3wlUfc3FCzSSge51lqJjoL0FbXBo5RMmu1C+PqUwv
         RhLev4lpy9HqkMemPkjwNg63GxnaZMHIFP1dNbPyC2tUfDVzIgLt36+16c7tdfCBinGP
         XXQg6WHyB43Z3khnSkD7xatdaykycOuWDjRjcYG8YVWNesiwlYRugx+f6DVvqelK3o7X
         1W7zqmTeYHpUsB9wHdlwUoRea4eX5NqLIhN/Fpd3CNQd3VgiWsNusm5qKp5+d3BUKRgn
         Drkg4MUABNVP+cFdDzEK60tLSWoXyMIBqc7VOvj6Nv0gH5A5azdALM3/j+z1Sy9cPfkY
         dYqQ==
X-Gm-Message-State: APjAAAWe2e8cltouiuITjcTvucB+OnuSUPK9OXTsCVaZFo6KyLeZLMVJ
        LDy+Ee1wveOQajPBZrDySlM=
X-Google-Smtp-Source: APXvYqwRgfwUAbUVUZN9+iwyNVOD+rHHMbjE72LWYPi+6DHAupiUxkiLV3cqiURT9waFze3tefl1ng==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr9040342wrn.273.1554169689503;
        Mon, 01 Apr 2019 18:48:09 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 13sm12625788wmf.23.2019.04.01.18.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 18:48:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 3/4] rebase: fast-forward --onto in more cases
References: <20190328221745.GA3941@dev-l>
        <cover.1554151449.git.liu.denton@gmail.com>
        <281443b2ae2dcf6a5a4d5766d4c006a4d0e22c91.1554151449.git.liu.denton@gmail.com>
        <xmqqsgv1tcyi.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 02 Apr 2019 10:48:08 +0900
In-Reply-To: <xmqqsgv1tcyi.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 02 Apr 2019 10:25:57 +0900")
Message-ID: <xmqqo95ptbxj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> Before, when we had the following graph,
>>
>> 	A---B---C (master)
>> 	    \
>> 	     D (side)
>>
>> running 'git rebase --onto master... master side' would result in D
>> being always rebased, no matter what. However, the desired behavior is
>> that rebase should notice that this is fast-forwardable and do that
>> instead.
>>
>> Add detection to `can_fast_forward` so that this case can be detected
>> and a fast-forward will be performed.
>
> OK.  As long as the 'onto' commit is a strict ancestor of the side
> branch being rebased, the 'upstream' that is used only to determine
> which commits are on the side branch (essentially those that are not
> reachable from upstream but that are from the side branch) should
> not count in the equation to decide if we fast-forward or not.  That
> makes sense.
>
>> ---
>>  builtin/rebase.c               | 40 +++++++++++++++++++++++-----------
>>  t/t3400-rebase.sh              |  2 +-
>>  t/t3404-rebase-interactive.sh  |  2 +-
>>  t/t3432-rebase-fast-forward.sh |  2 +-
>>  4 files changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 77deebc65c..7aa6a090d4 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -895,12 +895,12 @@ static int is_linear_history(struct commit *from, struct commit *to)
>>  	return 1;
>>  }
>>  
>> -static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
>> -			    struct object_id *merge_base)
>> +static int can_fast_forward(struct commit *onto, struct commit *upstream,
>> +			    struct object_id *head_oid, struct object_id *merge_base)
>>  {
>>  	struct commit *head = lookup_commit(the_repository, head_oid);
>> -	struct commit_list *merge_bases;
>> -	int res;
>> +	struct commit_list *merge_bases = NULL;
>> +	int res = 0;
>>  
>>  	if (!head)
>>  		return 0;
>> @@ -908,12 +908,29 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
>>  	merge_bases = get_merge_bases(onto, head);
>>  	if (merge_bases && !merge_bases->next) {
>>  		oidcpy(merge_base, &merge_bases->item->object.oid);
>> -		res = oideq(merge_base, &onto->object.oid);
>> +		if (!oideq(merge_base, &onto->object.oid))
>> +			goto done;
>>  	} else {
>>  		oidcpy(merge_base, &null_oid);
>> -		res = 0;
>> +		goto done;
>>  	}
>
> The above does not change any existing logic, but purely simplifies
> the code.  In your picture in the log message
>
>     A---B---C (master)
>          \
>           D (side)
>
> where "rebase --onto master... master side" is run, "onto" in this
> function is B, and "head" is D.  There is a single merge base B
> (i.e. merge_bases->next == NULL), so we jump to the label "done:"
> with res==0.
>
> So why does the remainder of the function need to be changed?
>
>> +	if (!upstream)
>> +		goto done;
>> +
>>  	free_commit_list(merge_bases);
>> +	merge_bases = get_merge_bases(upstream, head);
>> +	if (merge_bases && !merge_bases->next) {
>> +		if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
>> +			goto done;
>> +	} else
>> +		goto done;
>
> This computes the same between C and D (instead of B and D).  Why is
> this needed?
>
> Stepping back a bit, I understand that your argument we saw in the
> log message was that we only need to know if the commit we are
> transplanting the history on (i.e. "onto") already is an ancestor of
> the history being transplanted (i.e. "onto..head"), and it does not
> matter what upstream is.  Am I mistaken?  Why does this function now
> need to know what 'upstream' is?
>
> Puzzled....

So I replaced the part for builtin/rebase.c from your patch with the
above suggestion (attached) and the result seems to pass the three
tests you touched.  I am still puzzled.

Thanks.

 builtin/rebase.c               | 7 ++-----
 t/t3400-rebase.sh              | 2 +-
 t/t3404-rebase-interactive.sh  | 2 +-
 t/t3432-rebase-fast-forward.sh | 2 +-
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..fe61c2a899 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1682,13 +1682,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Check if we are already based on onto with linear history,
-	 * but this should be done only when upstream and onto are the same
-	 * and if this is not an interactive rebase.
+	 * but this should be done if this is not an interactive rebase.
 	 */
 	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
-	    !is_interactive(&options) && !options.restrict_revision &&
-	    options.upstream &&
-	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
+	    !is_interactive(&options) && !options.restrict_revision) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 460d0523be..604d624ff8 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -295,7 +295,7 @@ test_expect_success 'rebase--am.sh and --show-current-patch' '
 		echo two >>init.t &&
 		git commit -a -m two &&
 		git tag two &&
-		test_must_fail git rebase --onto init HEAD^ &&
+		test_must_fail git rebase -f --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
 		grep "show.*$(git rev-parse two)" stderr
 	)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b60b11f9f2..f054186cc7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1066,7 +1066,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
-	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
 	test_must_fail git rebase --edit-todo &&
 	git rebase --abort
 '
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 3e6362dd9c..414b4216d6 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -54,6 +54,6 @@ test_expect_success 'add work to upstream' '
 changes='our and their changes'
 test_rebase_same_head success '--onto B B'
 test_rebase_same_head success '--onto B... B'
-test_rebase_same_head failure '--onto master... master'
+test_rebase_same_head success '--onto master... master'
 
 test_done
