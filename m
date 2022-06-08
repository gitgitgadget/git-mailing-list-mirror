Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6299FC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 02:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiFHCrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352055AbiFHCqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 22:46:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF12198C0D
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 17:22:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b9-20020a656689000000b003f672946300so9306893pgw.16
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/HqIhTYAzG34v6sWrklD+9/zT9W+NKebAfQ5WIRYJhA=;
        b=Yw3HRmDt0sph8f/xX52LlmuDZQ0jQcjt9PpxcriH8SG1FaxcS4bf0NKPuKUQnBReTl
         GUFCLgFibDgWbNcSpi3MSNv2L9I0HrVHIhbZOI9bUGbVD7itNKPSuCB4luxCBdlsnZsD
         CF4zJvoozdT333Jbl+h20A8mUXC2yejAS+BBZQq1Bpg5Q6yoNHmZSGWXbDO1413EKGBD
         eHcusnc0pssZuR439R7Z6cVxwAfXnsx50G3010b562fPEdVQxSZX6pItMKibahWgkDG+
         pdO3Ct4Sl3ggZLZfL9DAY/r+yJV2wwF/ONDaN/AKHKZYYsbuhyy5BxU+B0n5zwsI0sgz
         Rdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/HqIhTYAzG34v6sWrklD+9/zT9W+NKebAfQ5WIRYJhA=;
        b=CuodxqcRwb/QC+iKtxnypCeh/96m6Gj4EkefXyFno/X+Y/bqJisMMhsLr2bftlA2gq
         bfVzgQT9cdzfxoovTIfkKeXa3G4Kyl9f22/pZGv4KkyitrfV1IozK47H5qB1IhzZVHtJ
         yZ8BF2gotyUhMrrCepSF3YclQjWJV3IDL+Q4AfgKuPCzHK5UG27G0e0KqnW3ZzqYiJ93
         9kN+JQJCynhOP9a+xiRE6Dl0MalYgbuF+1N7xZ4ko6uCcrUsjOK8dCIShwYOi5RqzuLp
         li8RVmY9ghdcAyyZ/shaof92nL7HleyNq/IN/K+M9RqhWVRgwobITuqeTtMWTJgaiP79
         +pNw==
X-Gm-Message-State: AOAM533FqQRIRsIQ7FnNfDrGP3waU1UVryvLPznypmD9fXss150Iqzk9
        HJM3XJHu+vyV7VvIQu19077lic6u57UUgQ==
X-Google-Smtp-Source: ABdhPJyhBxZQ9e8ZHM6z1bcEBr1Un9OJFmbWkY71H1uHlsl8mWdw/nGeov1ouWi42jWqXkrxBYtX/rbkyL3Gmg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d505:b0:167:6662:c7fe with SMTP
 id b5-20020a170902d50500b001676662c7femr18525734plg.31.1654647772221; Tue, 07
 Jun 2022 17:22:52 -0700 (PDT)
Date:   Tue, 07 Jun 2022 17:22:50 -0700
In-Reply-To: <xmqqbkv4t7gp.fsf@gitster.g>
Message-Id: <kl6lbkv46m1x.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
 <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com> <94b40907e66b2f6e0874ab49f8b73fdd58eb06d5.1654635432.git.gitgitgadget@gmail.com>
 <xmqqbkv4t7gp.fsf@gitster.g>
Subject: Re: [PATCH v4 3/5] config: read protected config with `git_protected_config()`
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index 3a851b36066..09f48317b02 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -1321,18 +1321,27 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
>>  		data->advertise_sid = git_config_bool(var, value);
>>  	}
>>  
>> -	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
>> -	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
>> -		if (!strcmp("uploadpack.packobjectshook", var))
>> -			return git_config_string(&data->pack_objects_hook, var, value);
>> -	}
>> -
>
> The lossage of this block is because this general git_config()
> callback routine that is used to read from any scope is no longer
> used to pick up the sensitive variable.  Instead, we need to get it
> with a different API, namely, git_protected_config().
>
> It is probably is good that in the new code we are not encouraging
> folks to write random comparisons on current_config_scope(), and
> instead uniformly use a git_protected_config().  That may promote
> consistency.
>
> An obvious alternative to achieve the same consistency would be to
> introduce a helper, and rewrite (instead of removing) the above part
> like so:
>
> 	if (in_protected_scope()) {
> 		... parse sensitive variable ...
> 	}
>
> We would not need any other change to this file in this patch if we
> go that route, I suspect.

Yes, and as noted in the commit message, this approach seems to work for
`safe.directory` and `discovery.bare` too.

>>  	if (parse_object_filter_config(var, value, data) < 0)
>>  		return -1;
>>  
>>  	return parse_hide_refs_config(var, value, "uploadpack");
>>  }
>>  
>> +static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
>> +{
>> +	struct upload_pack_data *data = cb_data;
>> +
>> +	if (!strcmp("uploadpack.packobjectshook", var))
>> +		return git_config_string(&data->pack_objects_hook, var, value);
>> +	return 0;
>> +}
>> +
>> +static void get_upload_pack_config(struct upload_pack_data *data)
>> +{
>> +	git_config(upload_pack_config, data);
>> +	git_protected_config(upload_pack_protected_config, data);
>> +}
>
> Where we used to just do git_config(upload_pack_config), we now need
> to do a separate git_protected_config().  It feels a bit wasteful to
> iterate over the same configset twice, but it is not like we are
> doing the IO and text file parsing multiple times.  This looks quite
> straight-forward.

Yeah it's not optimal, but at the very least, I think it's easy enough
to understand that we could replace it with something more economical in
the future.
