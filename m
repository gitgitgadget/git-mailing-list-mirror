Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E38C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 02:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKGCkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 21:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGCkA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 21:40:00 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71713634D
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 18:39:59 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l2so6239231qtq.11
        for <git@vger.kernel.org>; Sun, 06 Nov 2022 18:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxjE+BCGEXIODJafNYly9Qa88BagfmAmXr3UyMvuHxc=;
        b=hUWDLPh2795Hc4qQTBFilkOumyIZz+x44sgpHGCHoicrzYGz0Ed7Q1CJtEUem613Au
         KM0zRE4G+1v01WAhggs78Wl+yMqYTvLI1gCo7lYmcpYfaJTf/io0AX8toYr3J+SBlL8w
         B+5faOnt+sHxDBIKKWGXiaOhGhDLZ3/gZ4OHI7ENR8CfrTFQrCtHfuky+6wtGG3zdf/r
         o6SFp+dtbmPh2Uk09ieDSEqza0vWvTqp7BZ/DGaad2Fz/5YfLXKV4MX3SOcF6n5tAa0f
         UHRaCwD4z54s2D2WaVowWG3edgIvgzFjtb/CUEGBsAEfuN+pgno6jYW0ZyQPazldmdpG
         GEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxjE+BCGEXIODJafNYly9Qa88BagfmAmXr3UyMvuHxc=;
        b=qr3HlSUZ6gHA6aXrw1/bu4f9lnc8dEzFTMm7dRYcifNhWCo9KchDOipbM49t1oJ4e7
         Pf7Xai8bz31ADjXRE5rJnO3NVNjiDr5wxo0OTCv+DEH5HNXDogQeJjvb7ATJkquTpGoL
         /RTFGVIiwzEg7hq19EnNU9PKv4bBvFO3uouuEibqk/8en4lRt1rFouImR/xPmeXJTJY6
         zv20rw1chiUCv82rXfDYIyBshFRiNRl31+5rIgzDpqf7o53NJjqEsJUExV34FtS3gijj
         1SJP4q1iiowKHOb1y4TYrXJ+w4b4jTPGmKp3JYYqDml6rAcQaaad5uCNXIcxZECSl86T
         YOew==
X-Gm-Message-State: ACrzQf36C/hnD0ux+Ge65GBlz3FA/bLYPvstIOWYl7eCnRwbaBFSQJKu
        VvYkgYKroN34FlTiIo/PissV
X-Google-Smtp-Source: AMsMyM5c9gnEkamw0IfNwy6byJisiuEyMgMLIvLnSXA6SeJ792mqLMeTge+oeq0dLMfbuXcjxji67Q==
X-Received: by 2002:ac8:5895:0:b0:39c:c5fa:2936 with SMTP id t21-20020ac85895000000b0039cc5fa2936mr38544777qta.420.1667788798526;
        Sun, 06 Nov 2022 18:39:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id a9-20020ac85b89000000b003a54a19c550sm5195700qta.57.2022.11.06.18.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 18:39:58 -0800 (PST)
Message-ID: <20221c91-e473-c66a-a0bd-b650a6626e31@github.com>
Date:   Sun, 6 Nov 2022 21:39:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] rebase --update-refs: avoid unintended ref deletion
To:     phillip.wood@dunelm.org.uk, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "herr . kaste" <herr.kaste@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <bf5bc739-cb88-61ff-ed6b-09b1316f2f35@github.com>
 <20221104165735.68899-1-vdye@github.com>
 <6c022318-afc0-2ad7-b29c-ccb87f2f2e94@dunelm.org.uk>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6c022318-afc0-2ad7-b29c-ccb87f2f2e94@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/22 4:12 PM, Phillip Wood wrote:
> Hi Victoria
> 
> On 04/11/2022 16:57, Victoria Dye wrote:
>> In b3b1a21d1a5 (sequencer: rewrite update-refs as user edits todo list,
>> 2022-07-19), the 'todo_list_filter_update_refs()' step was added to handle
>> the removal of 'update-ref' lines from a 'rebase-todo'. Specifically, it
>> removes potential ref updates from the "update refs state" if a ref does not
>> have a corresponding 'update-ref' line.
>>
>> However, because 'write_update_refs_state()' will not update the state if
>> the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
>> result in the state remaining unchanged from how it was initialized (with
>> all refs' "after" OID being null). Then, when the ref update is applied, all
>> refs will be updated to null and consequently deleted.
> 
> Thanks for taking the time to track down the cause of this bug and fix it.

I will add my thanks, too. Thanks for jumping in when I could not!

>> To fix this, add a 'force_if_empty' flag to allow writing the update refs
>> state even if 'refs_to_oids' is empty. The three usages of
>> 'write_update_refs_state()' are updated as follows:
>>
>> - in 'todo_list_filter_update_refs()': force_if_empty is 1 because update
>>    ref entries are removed here. This setting fixes the ref deletion issue.
>> - in 'do_update_ref()': force_if_empty is 0, since this method only modifies
>>    (does not add or delete) ref update entries.
>> - in 'todo_list_add_update_ref_commands()': force_if_empty is 0, since this
>>    method strictly adds ref update entries.
> 
> I think not writing the list if it is empty is just an optimization to avoid creating an empty file. I wonder if it would be simpler to unlink() any existing file if write_update_refs_state() is called with an empty list rather than adding the force flag.

I agree that an unlink() is the best option, barring one point
(that I will mention below).

>> +test_expect_success '--update-refs: do not delete refs if all update-ref are removed' '
>> +    git checkout -b test-refs-not-removed no-conflict-branch &&
>> +    git branch -f base HEAD~4 &&
>> +    git branch -f first HEAD~3 &&
>> +    git branch -f second HEAD~3 &&
>> +    git branch -f third HEAD~1 &&
>> +    git branch -f tip &&
>> +    (
>> +        set_cat_todo_editor &&
>> +        test_must_fail git rebase -i --update-refs base >todo.raw &&
>> +        sed -e "/^update-ref/d" <todo.raw >todo
>> +    ) &&
>> +    (
>> +        set_replace_editor todo &&
>> +        git rebase -i --update-refs base
>> +    ) &&
>> +
>> +    test_cmp_rev HEAD~3 refs/heads/first &&
>> +    test_cmp_rev HEAD~3 refs/heads/second &&
>> +    test_cmp_rev HEAD~1 refs/heads/third &&
>> +    test_cmp_rev HEAD refs/heads/tip &&
>> +    test_cmp_rev HEAD refs/heads/no-conflict-branch
>> +'
>> +

This is a great test! I'm glad that it handles the existing
case. I think the only case that might be interesting is to
make the rebase actually create new commits and show that
the removed refs are no longer in the history of the new
branch, but are instead reachable from the older tip.

For this test, we could create a 'fixup!' to 'first' and
use --autosquash to generate new commits. At the end, we
can compare first, second, and third to different ancestors
of refs/heads/no-conflict-branch _and_ guarantee that
no-conflict-branch did not move. Or:

  git rev-parse first second third no-conflict-branch >expect-oids &&
  ...do the rebase...
  git rev-parse first second third no-conflict-branch >actual-oids &&
  test_cmp expect-oids actual-oids

should work to guarantee these refs were not updated.

I wonder if anything interesting happens if after we remove
the update-ref commands we have a 'break' command and then
re-insert some of the commands. Will things like the unlink()
direction cause a problem then?

Anyway, here is a potential diff on top of your patch that
adds these modifications to the test. They work with your
implementation changes, but I also didn't try the unlink()
modification.

--- >8 ---

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e7d3721ece8..4b09b73525a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1971,21 +1971,60 @@ test_expect_success '--update-refs: do not delete refs if all update-ref are rem
 	git branch -f second HEAD~3 &&
 	git branch -f third HEAD~1 &&
 	git branch -f tip &&
+
+	test_commit test-refs-not-removed &&
+	git commit --amend --fixup first &&
+
+	git rev-parse first second third tip no-conflict-branch >expect-oids &&
+
 	(
 		set_cat_todo_editor &&
-		test_must_fail git rebase -i --update-refs base >todo.raw &&
+		test_must_fail git rebase -i \
+			--autosquash --update-refs \
+			base >todo.raw &&
 		sed -e "/^update-ref/d" <todo.raw >todo
 	) &&
 	(
 		set_replace_editor todo &&
-		git rebase -i --update-refs base
+		git rebase -i --autosquash --update-refs base
 	) &&
 
-	test_cmp_rev HEAD~3 refs/heads/first &&
-	test_cmp_rev HEAD~3 refs/heads/second &&
-	test_cmp_rev HEAD~1 refs/heads/third &&
-	test_cmp_rev HEAD refs/heads/tip &&
-	test_cmp_rev HEAD refs/heads/no-conflict-branch
+	git rev-parse first second third tip no-conflict-branch >actual-oids &&
+	test_cmp expect-oids actual-oids
+'
+
+test_expect_success '--update-refs: do not delete refs if all update-ref are removed and some re-added' '
+	git checkout -b test-refs-not-removed2 no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git branch -f tip &&
+
+	test_commit test-refs-not-removed2 &&
+	git commit --amend --fixup first &&
+
+	git rev-parse first second third >expect-oids &&
+
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i \
+			--autosquash --update-refs \
+			base >todo.raw &&
+		sed -e "/^update-ref/d" <todo.raw >todo
+	) &&
+	echo "break" >>todo &&
+	(
+		set_replace_editor todo &&
+		git rebase -i --autosquash --update-refs base &&
+		echo "update-ref refs/heads/tip" >todo &&
+		git rebase --edit-todo &&
+		git rebase --continue
+	) &&
+
+	git rev-parse first second third >actual-oids &&
+	test_cmp expect-oids actual-oids &&
+	test_cmp_rev HEAD tip
 '
 
 test_expect_success '--update-refs: check failed ref update' '

--- >8 ---

Thanks,
-Stolee
