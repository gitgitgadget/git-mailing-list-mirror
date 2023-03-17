Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94102C6FD1F
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 02:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCQCwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 22:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCQCwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 22:52:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450928ABEF
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 19:52:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q99-20020a17090a1b6c00b0023f0c6c6b3dso1652656pjq.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679021528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXNC0+6JQlnJGyHBNgYtSFBE7ul4ctY0sP01wdypH+o=;
        b=ZgcheY+ym7gJd9Xvx91OZl+kslLcHVtrZOZnkk2i//qU5FhMh6G1SQbYJ80w64lq3e
         rsKv1dePKUon7dFrNUU8BPRK5U5YqrjHEB8KeGSA20NwyZqa9DBBOENPl3OLcyuAVZFg
         c0/qIspqIEvaOzjflKpvZoyDZBCpp/GiOOXMLWQ7qMcfJ4pyaZ+uA4ichpaNHUyrjG2e
         nKQOoz36gulvpd8ADEbjTmX2Zr4RLQe/93zM7KQTGQcl0RY+eAsJ0YBh3eMdDfWjXso3
         svNtL2SQM0tzClKIhmCnnyV7uXHXOz+lUN3uYxo19l3KfKjhWiKX2lx+OasY+MHX/THy
         eUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679021528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXNC0+6JQlnJGyHBNgYtSFBE7ul4ctY0sP01wdypH+o=;
        b=KtRkdC6TJN0mSQ4ERdUsOLXOmCyG2qeUWzV/imM8GbAHMFWaIARx7hA44PWyVGUfrV
         VR6+yIbmPFgymbN5/Kq22kIm1iCLIlRg05TDgLD2T1rBSTOouk5nNqk8dDhK+piQ/gKF
         8rclcnsBctjK8z1MqF4Mm39UDM8uXyEWrEbdXatP5Us/NZJfnGLbTTdYNzFgSLynKQnY
         tfVSoByo+j2D5+OGBilfiUjEiuqGCxVNlbW05DcPjFauzK520j9HDlvHtNuMFU38X2Gw
         +bTaZmvfkJWhGPCzIp2I3e4+2lYlR4JZGVgkPZ4GaNSGALqd6375ORLELEgw8/Rfbgl1
         rjbg==
X-Gm-Message-State: AO0yUKUvnxwzJmWkGiOQyQcD+Tpn44lM1TOMzSsT0CE4vjjI87e8p0/i
        FolDevErA9BqPeJcoP8sHBmwbl0/6OfMYA==
X-Google-Smtp-Source: AK7set97yZ2RwedJD+r9Dk0WuaKaIVAR2Udbys1V1L/yybXceLcWdw7tI2+1FSInpYJVh8GpIUzuxIcFwJYfdA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:148e:b0:623:8990:4712 with SMTP
 id v14-20020a056a00148e00b0062389904712mr2195286pfu.1.1679021527771; Thu, 16
 Mar 2023 19:52:07 -0700 (PDT)
Date:   Thu, 16 Mar 2023 19:51:58 -0700
In-Reply-To: <kl6ljzzguqss.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
 <20230302220251.1474923-6-calvinwan@google.com> <kl6ljzzguqss.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6lh6ukum29.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v9 6/6] diff-lib: parallelize run_diff_files for submodules
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> It would be good if we could avoid mixing unrelated information sources
> in "struct submodule_status_util", since a) this makes it very tightly
> coupled to run_diff_files() and b) it causes us to repeat ourselves in
> the same function (.changed = changed, record_file_diff()).
>
> The only reason why the code looks this way right now is that
> match_stat_with_submodule() sets defer_submodule_status based on whether
> or not we should ignore the submodule, and this eventually tells
> get_submodule_status() what submodules it needs to care about. But,
> deciding whether to spawn a subprocess for which submodule is exactly
> what the .get_next_task member is for.
>
>> diff --git a/submodule.c b/submodule.c
>> index 426074cebb..6f6e150a3f 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1981,6 +1994,121 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>>  	return dirty_submodule;
>>  }
>>  
>> +static struct status_task *
>> +get_status_task_from_index(struct submodule_parallel_status *sps,
>> +			   struct strbuf *err)
>> +{
>> +	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
>> +		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
>> +		struct status_task *task;
>> +
>> +		if (!verify_submodule_git_directory(util->path))
>> +			continue;
>
> So right here, we could use the "check if this submodule should be
> ignored" logic form match_stat_with_submodule() to decide whether or not
> to spawn the subprocess. IOW, I am advocating for
> get_submodules_status() to be a parallel version of
> match_stat_with_submodule() (not a parallel version of
> is_submodule_modified() that shuttles extra information).

It turns out to be quite difficult to implement a parallel
match_stat_with_submodule():

  a) we can't remove it because it still has another caller
  b) its internals are quite hard to refactor: one conditional arm depends
    on "changed", which is set by calling ie_match_stat(), which in turn
    requires the "struct stat" to have already been lstat()-ed...

So even though this series adds a lot, it is just about as minimally
invasive as possible.

I suspect that there are some possible cleanups down the line, e.g.
is_submodule_modified() is rightfully only called by diff-lib.c , so I
think it should be a static function there. And once we move that, we
can make our parallel function static, and then we don't have to worry
about tight coupling to run_diff_files(). To keep the range-diff
manageable, that can be left for a future cleanup though.
