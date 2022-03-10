Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53073C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 23:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiCJXyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 18:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345026AbiCJXyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 18:54:32 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F519E73E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 15:53:20 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t18-20020a63dd12000000b00342725203b5so3724912pgg.16
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 15:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X/ctD4p5cU0zuf9RqDiKYlQu4bR0MGWhusHM1qUSlks=;
        b=NIaLlDSrL7hkJEgZwAafPKJoGghbO2EAJcn/a66FOd4Hi8x3fc+azrATBAYsAT96AL
         PJ0rviBixruvMcVLT2+GKdSSdmMiJchOxXdN15Ydjjg4sRmBa3Aj7I1SojutNv/0Kd5u
         6+7C3GDBKKldAmE6ToAT1zRS+P2lWUs/44fluPPdiErgz72cnPbTCA06V/6uvnSMAzvD
         thSDniz0LCj0H59Wp9uK1jcDT9GTozw1LOA/bykm+AJ4LWCe7jtVOESewF0NFVWFnB6S
         W8599UWctKjqZPuzN/P5VXv+TknJb0hcsz+EsppZRj8jWLEvLFGQa65FCe7QrLr+jBeN
         r41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X/ctD4p5cU0zuf9RqDiKYlQu4bR0MGWhusHM1qUSlks=;
        b=0GX2ccHS6Jf5V58a0Vvb+SQNuUSdWAmuzWoDlYRxQFJgYPSivpXieZypEJXJPq7fFL
         2IkJJx7IwqNJohD3RkxltPeWkbc7kUnyQOPBiDn3bVaYX8hNzUhJa0b4+4YCaDMOmyE/
         15TvgVF3g+XrX/BjToPD8qzwYT7a04u+jfa52Iw5lc4Qn9ZaRmLDDVUrNpeqRCWGut/v
         WtzMnzlhV/tJJq8ZWRss9xH77g9BDOFlFBBr11qlKcorUsmZaEsCBsYwi33VsD3bzHgi
         Fxf+7Bf7e7Gg3nj5539vVaF3mgO//XNbtSP3xPcEwS2MqneTsQyPtrWIB1cH1kpEU4df
         L2HQ==
X-Gm-Message-State: AOAM533XS8brw14pfhBeswh8wz0sJB8lEDmFp+WqDBrFm/BwWuJZoVKf
        lLOZG17qLQzh7bfCwlkmWl1RlEVWMhG/gg==
X-Google-Smtp-Source: ABdhPJyqqzZfMvv+izQmv8vLxtLV/6JSMYF0mTVWOdEYFPjn02TNr8zT1pvfDvxaYmnyFHEYkJ1ip94XckwvtA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP
 id oj1-20020a17090b4d8100b001bf8ce44f51mr308535pjb.0.1646956399599; Thu, 10
 Mar 2022 15:53:19 -0800 (PST)
Date:   Thu, 10 Mar 2022 15:53:17 -0800
In-Reply-To: <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6l1qz9s6tu.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com> <xmqqtuc6h83m.fsf@gitster.g>
 <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnh1bgr4.fsf@gitster.g> <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>> index bef9ab22d4..f53808d995 100644
>>> --- a/builtin/submodule--helper.c
>>> +++ b/builtin/submodule--helper.c
>>> @@ -2672,6 +2677,11 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>>>                                             &update_data.update_strategy);
>>>
>>>         free(prefixed_path);
>>> +       /*
>>> +        * This entry point is always called from a submodule, so this is a
>>> +        * good place to set a hint that this repo is a submodule.
>>> +        */
>>> +       git_config_set("submodule.hasSuperproject", "true");
>>>         return update_submodule2(&update_data);
>>>  }
>>
>> That matched my tentative resolution I made last night, but what do
>> you think about this part of the test added by the patch?
>>
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 11cccbb333..ec2397fc69 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>>  	)
>>  '
>>  
>> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
>> +	(cd super &&
>> +	 test_unconfig submodule.hasSuperproject &&
>> +	 git submodule update &&
>> +	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
>> +	)
>> +'
>> +
>>  test_done
>>
>> We go to "super", make sure that superproject does not have
>> submodule.hasSuperproject set, run "git submodule update", and see
>> if the configuration file in "submodule" subdirectory has the
>> variable set.  It does not clear the variable from the submodule
>> before starting, so the variable given to the submodule when it was
>> cloned would be there, even if "git submodule update" failed to set
>> it.
>>
>> I am wondering if it should do something like the attached instead.
>>
>> We
>>
>>  * clear the variable from "super" and "super/submodule"
>>    repositories;
>>
>>  * run "git submodule update";
>>
>>  * ensure that "git submodule update" did not touch "super/.git/config";
>>
>>  * ensure that "git submodule update" added the variable to
>>    "super/submodule/.git/config".
>>
>> Clearing the variable from "super" is technically wrong because the
>> repository is set up as a submodule of "recursivesuper" and if we
>> had further tests, we should restore it in "super", but the point is
>> that we are makng sure "git submodule update" sets the variable in
>> the configuration file of the submodule, and not in the superproject's. 
>
> Yes, the test you've described is closer to what I thought the original
> test was trying to do. Seeing this test pass gave me a false sense of
> confidence hm..

Correction, seeing the _original_ test pass gave me false sense of
confidence.

>> With the conflict resolution above, this "corrected" test fails and
>> shows that superproject's configuration file is updated after "git
>> submodule update".
>>
>> This series alone, without your topic, this "corrected" test fails,
>> and that is where my "are we sure we are mucking with the
>> configuration file in the submodule"? comes from.
> - Set the config in the submodule even though we are running from the
>   superproject (this is possible, ensure_core_worktree() does this).

If it helps, I was able to do this up by copying
ensure_core_worktree(), and this passes the amended test.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4d02dd05ca..3bb7a65762 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1838,11 +1838,6 @@ static int clone_submodule(struct module_clone_data *clone_data)
    git_config_set_in_file(p, "submodule.alternateErrorStrategy",
              error_strategy);

-	/*
-	 * Teach the submodule that it's a submodule.
-	 */
-	git_config_set_in_file(p, "submodule.hasSuperproject", "true");
-
  free(sm_alternate);
  free(error_strategy);

@@ -2560,6 +2555,20 @@ static int update_clone(int argc, const char **argv, const char *prefix)
  return update_submodules(&suc);
}

+static void set_hassuperproject(const char *sm_path)
+{
+	struct repository subrepo;
+	char *cfg_file;
+
+	if (repo_submodule_init(&subrepo, the_repository, sm_path, null_oid()))
+		die(_("could not get a repository handle for submodule '%s'"), sm_path);
+
+	cfg_file = repo_git_path(&subrepo, "config");
+	git_config_set_in_file(cfg_file, "submodule.hasSuperproject", "true");
+
+	free(cfg_file);
+}
+
static int run_update_procedure(int argc, const char **argv, const char *prefix)
{
  int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
@@ -2622,10 +2631,9 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
  free(prefixed_path);

  /*
-	 * This entry point is always called from a submodule, so this is a
-	 * good place to set a hint that this repo is a submodule.
+	 * Teach the submodule that it's a submodule.
  */
-	git_config_set("submodule.hasSuperproject", "true");
+	set_hassuperproject(update_data.sm_path);

  if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
    return do_run_update_procedure(&update_data);
