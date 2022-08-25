Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D1EC04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 07:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiHYH5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiHYH5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 03:57:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A69A970
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 00:57:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bs25so23548409wrb.2
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=qsL2T0mGs5iKhEeOT9p6C67KgtD5c5MMeoABqrp0wAU=;
        b=JSBivNWCGRKj0Gc4l+AF8AOX5eKLVm5VPtCDDJgyRe6tH/ow4la54IgoxQFj5ICH8c
         eS82n3Jh8tBHpru6ZF9HeJTIxlXyOkc3kIispONGYFg/KzlxgBtrpzLRgDez+UFexnly
         tXnYipSJ+od/6/VW4wGJTlS8y3gqZDMlC30J/KFf0dj86eMeehYLJVhCFNXa3k6EQezK
         tC+bNJRhsFdmYOp7ioJo+5fk4iasjHxDL9jrH5kBL5FGm6qo/UKy20G6oJVaAMTd8ssr
         cW1kT6nuHk6cb3CPCXs/HVphmL1irkxRp/FMbKNA+6qoSBpF+DF7GHJgbOYSrVZPLfRI
         RfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=qsL2T0mGs5iKhEeOT9p6C67KgtD5c5MMeoABqrp0wAU=;
        b=wvtraBHL9r3B4p0C42E7/qgyN7bTM2F0xRKkndBYj1xs7GTcelxJ56AsrNIBtls8wl
         3Q7CsMPjTxzOMSM3R+/xAwIpkl7lwWKd9/ApQl+XUESy8aKiDLwOBpivDvpO+2+le8Ru
         n2BF+hUr+BZCMghoj5u93Io00Lt/OE5BkRjItvUGoQcQjze+kbpI1gGqdxZtAcg+vbY+
         kkaw0O249CQztM1+XnJc+mT6OMXFWUOTLS7Pgf4s6CYZs2Ie6gbQnXLbLh4jiD4AJdo+
         Nq/NWlHy8+GVbQs6igC0Q6zf7oSzEk0pSdU8sU40TAO6G5txJekJ/boITyjBYHUAdcrw
         rSdw==
X-Gm-Message-State: ACgBeo19c1SKPffj4PxnypnsTeGtzfjH+3zZZi5BSKDCoYi7joTKBo7e
        Vlola6VISQtUDtb0k6JACd2M45Tn18M=
X-Google-Smtp-Source: AA6agR5Ghd2Rs8CeidmdvKiPVNqXvdUFFpAyOJhYMJUMKycZxWwM4vJPQImjvT/pA4nRYreQe9blvA==
X-Received: by 2002:adf:fbd2:0:b0:21e:e983:165f with SMTP id d18-20020adffbd2000000b0021ee983165fmr1369195wrs.517.1661414249258;
        Thu, 25 Aug 2022 00:57:29 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id c191-20020a1c35c8000000b003a2cf1ba9e2sm4399707wma.6.2022.08.25.00.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:57:28 -0700 (PDT)
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Rub=c3=a9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr> <xmqqk07iu3c3.fsf@gitster.g>
 <5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr>
 <55n449n3-71r9-28n9-094q-6r61545r7505@tzk.qr>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <4d8eb431-dc25-5ea9-14b8-3f84ae0c1561@gmail.com>
Date:   Thu, 25 Aug 2022 09:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <55n449n3-71r9-28n9-094q-6r61545r7505@tzk.qr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 8/19/22 3:05 PM, Johannes Schindelin wrote:
> 
> Rubén, do you want to take this a bit further?
> 

Just wanted to delete the previous branch, I didn't want to enter in a 
deep change... but here we are :-)

Allow the "-" in setup_revisions:

diff --git a/revision.c b/revision.c
index f4eee11cc8..65e7eb85d8 100644
--- a/revision.c
+++ b/revision.c
@@ -2802,7 +2802,7 @@ int setup_revisions(int argc, const char **argv, 
struct rev_info *revs, struct s
                 revarg_opt |= REVARG_CANNOT_BE_FILENAME;
         for (left = i = 1; i < argc; i++) {
                 const char *arg = argv[i];
-               if (!seen_end_of_options && *arg == '-') {
+               if (!seen_end_of_options && *arg == '-' && 
!strchr(".^~:@", arg[1])) {
                         int opts;

Then, consider "-" as nth_prior, just like @{-1}:

diff --git a/object-name.c b/object-name.c
index 4d2746574c..87b4c33cce 100644
--- a/object-name.c
+++ b/object-name.c
@@ -934,6 +934,9 @@ static int get_oid_basic(struct repository *r, const 
char *str, int len,
                 }
         }

+        if ((len == 1) && (str[0] == '-'))
+                nth_prior = 1;
+
         /* Accept only unambiguous ref paths. */
         if (len && ambiguous_path(str, len))
                 return -1;

diff --git a/object-name.c b/object-name.c
index 4d2746574c..87b4c33cce 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1420,18 +1423,24 @@ static int interpret_nth_prior_checkout(struct 
repository *r,
         const char *brace;
         char *num_end;

-       if (namelen < 4)
-               return -1;
-       if (name[0] != '@' || name[1] != '{' || name[2] != '-')
-               return -1;
-       brace = memchr(name, '}', namelen);
-       if (!brace)
-               return -1;
-       nth = strtol(name + 3, &num_end, 10);
-       if (num_end != brace)
-               return -1;
-       if (nth <= 0)
-               return -1;
+        if (name[0] == '-' && strchr(".^~:@", name[1])) {
+                nth = 1;
+                brace = name;
+        } else {
+                if (namelen < 4)
+                        return -1;
+                if (name[0] != '@' || name[1] != '{' || name[2] != '-')
+                        return -1;
+                brace = memchr(name, '}', namelen);
+                if (!brace)
+                        return -1;
+                nth = strtol(name + 3, &num_end, 10);
+                if (num_end != brace)
+                        return -1;
+                if (nth <= 0)
+                        return -1;
+        }
+
         cb.remaining = nth;

Two checks needs to be adjusted:

diff --git a/refs.c b/refs.c
index 90bcb27168..0ed9f99ccc 100644
--- a/refs.c
+++ b/refs.c
@@ -198,6 +198,11 @@ static int check_or_sanitize_refname(const char 
*refname, int flags,
                 else
                         return -1;
         }
+
+       if (component_len == 1 && refname[0] == '-') {
+                return -1;
+       }
+

diff --git a/object-name.c b/object-name.c
index 4d2746574c..87b4c33cce 100644
@@ -1684,7 +1693,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, 
const char *name)
          */
         strbuf_splice(sb, 0, 0, "refs/heads/", 11);

-       if (*name == '-' ||
+       if ((*name == '-' && name[1]) ||
             !strcmp(sb->buf, "refs/heads/HEAD"))
                 return -1;


I know this changes open the possibility of having things like "-^2" or 
-@{yesterday} that you said was not desiable. But, why wouldn't we want 
that? Having parse_opt_result to handle that:

diff --git a/parse-options.c b/parse-options.c
index edf55d3ef5..2757bd94c1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -740,7 +740,7 @@ enum parse_opt_result parse_options_step(struct 
parse_opt_ctx_t *ctx,
                     ctx->argc != ctx->total)
                         break;

-               if (*arg != '-' || !arg[1]) {
+               if (*arg != '-' || strchr(".^~:@", arg[1])) {
                         if (parse_nodash_opt(ctx, arg, options) == 0)
                                 continue;
                         if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)


With this changes, all the current uses of "-", with the hacks already 
removed, keep working and fixes the weird cases:

$ git merge branch - other_branch
$ git branch -d branch - other_branch


Also, I've checked that work:
$ git diff -
$ git show -
$ git blame -
and branch -d :-)

I've checked the current tests and added new ones for this, all passes. ie:

diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 4a5758f08a..231457df50 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -40,10 +40,18 @@ test_expect_success '@{-1} works' '
         test_cmp_rev side @{-1}
  '

+test_expect_success '- works' '
+       test_cmp_rev side -
+'
+
  test_expect_success '@{-1}~2 works' '
         test_cmp_rev side~2 @{-1}~2
  '

+test_expect_success '-~2 works' '
+       test_cmp_rev side~2 -~2
+'
+
  test_expect_success '@{-1}^2 works' '
         test_cmp_rev side^2 @{-1}^2
  '

Still needs some work, for example: git log shows "-" in the warning:
$ ../git/git log "-@{10000 minutes ago}"
warning: log for '-' only goes back to Wed, 24 Aug 2022 14:16:17 +0200

What do you think, is it worth the change?

I've created a PR with all the changes and tests.
https://github.com/gitgitgadget/git/pull/1338

Thanks.
