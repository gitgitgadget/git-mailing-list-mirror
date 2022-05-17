Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0964FC433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 21:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiEQVv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiEQVv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 17:51:57 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278E1CFF9
        for <git@vger.kernel.org>; Tue, 17 May 2022 14:51:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cd6-20020a056a00420600b00510a99055e2so140608pfb.17
        for <git@vger.kernel.org>; Tue, 17 May 2022 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5Oy8hLI24trn3Vy+pGZ6U6k2vvoxCrb6x1XIYZIJMVI=;
        b=BSqkgrxTqrBxGKiKQSUknapZY8rYIX3dhozckDR+SEjrIbF47tD4h4M+RXMQYXMTMQ
         tlN/P+NLEUEykC6MatAp92aZtYfIx+RknMXHhzpgfDI1JgmvxBNwkfCT2ASljex3iAOE
         dLybfh5hSqA9Lf6suJQ7tuMdhDIxF2hVTzXknVpHPHGFU97Gf5Kkzm1l+JPXO7ZVW7sM
         2RJDlSOkJsQHO0DdICjhkPqkJKc+QDWIPZ6GyokOVeb0pUeGSWrG2YjcDr5y1c58jfJR
         Av2YtCh6EqFzNcZJ+//qeI+g2F0svbr+f9BIRGJIwcWDTux0TrG/xkpi40b6eqZbHyAN
         8OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Oy8hLI24trn3Vy+pGZ6U6k2vvoxCrb6x1XIYZIJMVI=;
        b=mnqm93h+wwCicWn0+Dix/MtXG6ioj/xe7QrQEHtOGrr7MdzoYx2n/X/oIKXy1O2gac
         DDxUv9vd5HTpLgW171LwqV63Dv2mlZ0P1lzGWLMs+6/vCqkL5hSyWCu6oOvoS/VVzaJ5
         JZCEi52zIsbjoeV6aY58BmbO8V69TAlcnWd8/9sb5iOPkh7j6UMqgmaBOrwss+i8EZpi
         0M3UkLQ3DONUipQToVnTnP/g5yJHD8ZZSTB5hqLzMz07XZdKvhm1627pJLwPDDN3f13H
         Ivg9+oDrt653sFPPxWHDbpzs1CEFjrm+ow5SIFlb76IHE+Jx3xa2wvnBukcCSM2f6B5w
         4NyQ==
X-Gm-Message-State: AOAM533gUyva2BfHo57v1tfbblWoRXTnIuznjFyPSh0iR095UyLZR7/O
        JFXCn8t1Az9AoBE2+EWp/sz2nyiW7AOVQw==
X-Google-Smtp-Source: ABdhPJydIns+NDzzErJ062Q9RVgJh8/dy+joLpZfyur6zCJpgiOG51f4/s5OzF8KEGJepcsnXa+Y8T7nfnd52g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:cf02:0:b0:50d:3e00:60c with SMTP id
 b2-20020a62cf02000000b0050d3e00060cmr24468475pfg.69.1652824315440; Tue, 17
 May 2022 14:51:55 -0700 (PDT)
Date:   Tue, 17 May 2022 14:51:47 -0700
In-Reply-To: <kl6lilq3j4aq.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lfsl7j098.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
 <e5139922-9b74-ebfa-756c-629918e0456b@github.com> <kl6lilq3j4aq.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 1/2] setup.c: make bare repo discovery optional
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>>> +static int check_bare_repo_allowed(void)
>>> +{
>>> +	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
>>> +		read_very_early_config(discovery_bare_cb, NULL);
>>
>> This will add the third place where we use read_very_early_config(),
>> adding to the existing calls in tr2_sysenv_load() and
>> ensure_valid_ownership(). If I understand it correctly, that means
>> that every Git execution in a bare repository will now parse the
>> system and global config three times.
>>
>> This doesn't count the check for uploadpack.packobjectshook in
>> upload-pack.c that uses current_config_scope() to restrict its
>> value to the system and global config.
>>
>> We are probably at the point where we need to instead create a
>> configset that stores this "protected config" and allow us to
>> lookup config keys directly from that configset instead of
>> iterating through these config files repeatedly.
>
> Looking at all of the read_very_early_config() calls,
>
> - check_bare_repo_allowed() can use git_configset_get_string()
> - ensure_valid_ownership() can use git_configset_get_value_multi()
> - tr2_sysenv_load() reads every value with the "trace2." prefix. AFAICT
>   configsets only support exact key lookups and I don't see an easy way
>   teach configsets to support prefix lookups.
>
> (I didn't look too closely at uploadpack.packobjectshook because I don't
> know enough about config scopes to comment.)
>
> So using a configset, we'll still need to read the config files at least
> twice. That's better than thrice, but it doesn't cover the
> tr2_sysenv_load() use case, and we'll run into this yet again if add
> function that reads all config values with a given prefix.
>
> An hacky alternative that covers all of these use cases would be to read
> all protected config in a single pass, e.g.
>
>   static struct protected_config {
>          struct safe_directory_data safe_directory_data;
>          const char *discovery_bare;
>          struct string_list tr2_sysenv;
>   };
>
>   static int protected_config_cb()
>   {
>     /* Parse EVERYTHING that belongs in protected_config. */
>   }
>
> but protected_config_cb() would have to parse too many unrelated things
> for my liking.
>
> So I'll use the configset for the cases where the key is known, and
> perhaps we'll punt on tr2_sysenv_load().

Since I'm trying to replace read_very_early_config() anyway, is this a
good time to teach git to respect "-c safe.directory"?

My understanding of [1] is that we only ignore "-c safe.directory"
because read_very_early_config() doesn't support it, but we would prefer
to support it if we could.

[1] https://lore.kernel.org/git/xmqqlevabcsu.fsf@gitster.g/
