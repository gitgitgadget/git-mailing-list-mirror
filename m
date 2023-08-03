Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237AC04A6A
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 16:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjHCQXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjHCQW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 12:22:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E2BE67
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 09:22:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5844a99c268so12616777b3.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691079774; x=1691684574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2ytoqHF0mn7bpWSmq2wxZMWMnRYERTXCkXIn7OSCY0=;
        b=hs+DNJdZ9d+jWy3uYgDIKWjJ0z8CyeDvAN39YUfgSJkHAxFOb5KRqPA64NpuS0E9Wr
         MOoKyFKm/PMDmjBOxOEWi+Yck6uX4c5Mg3/9IyutLRsxKZBuEiOSBcYyx8ZKNXLtYDwp
         74irgzSCGr6Ar6ivHs5P/1k9mvXcIhTBWZ1LT+J0iVyZOW83kE2H1rvZM3EMGvu0U2fz
         1FOhNuWm0ZzphljZDcNyBFB0249uH8seHtrQ+/eJqgaT0zP1iOBxPFzAcd+jcl28YbKe
         3Fe9wBG6c/0BoP4toUFDbUjUI88biq1GhM+a4jkq+uuHPuncGa4oPWoq78+cxb3AiZOJ
         cu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079774; x=1691684574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2ytoqHF0mn7bpWSmq2wxZMWMnRYERTXCkXIn7OSCY0=;
        b=f8KSte8wxB+pSrYknkS5/4R7Z2rh1b3PXEykX+NjRuvXLFc43Rx6JXLC25aQLFrTdv
         IUmrhcwgUao+IT1gDQ0ATCYxKe1FpAyaQGQ/c7gn4Gg/LMjUU4wY7fgdIWk22dVMkLDD
         24nGECI69tvWK01e+F8rdMClzeSiDboXBJq2wtwzH5vh3kjiikas24A3SeWQJUqXSpjy
         6iEMjQyF1qEp9v6rVn5oUQ5AmMpPjRi1V/apSHYD1Lr/6XVZQkeonrbMDHhMlFITjhUx
         rvVFl0+YDRl312pRnZokLkklu/NTkbefX+nJDGAwqZpmFZ/u/hWqQVu7Tg/CV99rBg5d
         RN7w==
X-Gm-Message-State: ABy/qLbFsCBST51PceaNgUk5+zJz6k/Xv+Mnz9rFO3kU48CA4Wjjx3YC
        dBpFli6FQKew+rXWxwuGKQdhung7Oczz/Q==
X-Google-Smtp-Source: APBJJlH7exKsRvAJwMWUEMbulyLcLVHup2io4Tq5acmsy/znHFulHNolt9uGrcB0e6VtaikaSScdklc/PrQ8wQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:a789:0:b0:586:5388:82ba with SMTP id
 e131-20020a81a789000000b00586538882bamr92251ywh.6.1691079773874; Thu, 03 Aug
 2023 09:22:53 -0700 (PDT)
Date:   Thu, 03 Aug 2023 09:22:52 -0700
In-Reply-To: <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
Mime-Version: 1.0
References: <20230711133035.16916-1-cheskaqiqi@gmail.com> <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-3-cheskaqiqi@gmail.com> <5e478d8b-9ef4-864b-41e4-e0a79877d278@github.com>
Message-ID: <kl6la5v82izn.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 2/3] attr.c: read attributes in a sparse directory
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye <vdye@github.com>, Shuqi Liang <cheskaqiqi@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's something odd that I spotted that I think other reviewers haven't
mentioned. That said, Victoria has already given quite extensive review
and I trust her judgement on this series, so if I accidentally end up
contradicting her, ignore me and trust her instead :)

Victoria Dye <vdye@github.com> writes:

>> -test_expect_failure 'check-attr with pathspec outside sparse definition' '
>> +test_expect_success 'check-attr with pathspec outside sparse definition' '
>
> Re: my suggested change to the test in patch 1 [2], when I applied _this_
> patch, the test still failed for the 'sparse-index' case. It doesn't seem to
> be a problem with your patch, but rather a bug in 'diff' that can be
> reproduced with this test (using the infrastructure in t1092):
>
> test_expect_failure 'diff --cached shows differences in sparse directory' '
> 	init_repos &&
>
> 	test_all_match git reset --soft update-folder1 &&
> 	test_all_match git diff --cached -- folder1/a
> '
>
> It's not immediately obvious to me what the problem is, but my guess is it's
> some mis-handling of sparse directories in the internal diff machinery.
> Given the likely complexity of the issue, I'd be content with you leaving
> the 'diff --check' test as 'test_expect_failure' with a note about the bug
> in 'diff' to fix later. Or, if you do want to investigate & fix it now, I
> wouldn't be opposed to that either. :) 
>
> [2] https://lore.kernel.org/git/c3ebe3b4-88b9-8ca2-2ee3-39a3e0d82201@github.com/

Because the 'diff --check' test is broken, and 'git check-attr' still
expands the index (as noted in the next patch), the code that implements
'read from a blob if the .gitattributes is not in the index' is not
exercised by the tests in this patch (it gets exercised in the next
patch). IOW, you can remove this logic and the tests still pass, like
so:

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
diff --git a/attr.c b/attr.c
index 1488b8e18a..abfa2078ac 100644
--- a/attr.c
+++ b/attr.c
@@ -23,6 +23,7 @@
 #include "thread-utils.h"
 #include "tree-walk.h"
 #include "object-name.h"
+#include "trace2.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -847,9 +848,11 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 	    S_ISSPARSEDIR(istate->cache[pos]->ce_mode) &&
 	    !strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) &&
 	    !normalize_path_copy(normalize_path, path)) {
-		relative_path = normalize_path + ce_namelen(istate->cache[pos]);
-		stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
+		/* relative_path = normalize_path + ce_namelen(istate->cache[pos]); */
+		/* stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags); */
+		trace2_printf("Tried to read from blob");
 	} else {
+		trace2_printf("Tried to read from index");
 		buf = read_blob_data_from_index(istate, path, &size);
 		if (!buf)
 			return NULL;
----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

If I were writing patches and encountered this situation, I would squash
patches 2-3/3 together since both are closely related and quite small,
but I'll leave the decision to you + other reviewers.
