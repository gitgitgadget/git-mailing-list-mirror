Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A863C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiFBNnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiFBNnh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:43:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E122411A
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:43:35 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y12so4824627ior.7
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=noGHlEfIRRNur533I3nkB89I+yG+m/3HzpOGm8JvQz8=;
        b=O2BunPWVhVWnCDPlHlDD9gXgZWjm7LPPYTu6y5z5+KokPlrUuUalNGQFK5lQuTmCUs
         MMYh4E+0RtrfTnUYyxQWuHb43NpcQE91EypT4kX8PJUyuDTvbm6i9wWEs8cYyjc37xQV
         YUr+VjbTVTURmE000BkVVY1hkSmzgtlO/Av9Y2ZJW4jryEG6LNt1uxLJuW+XaYHlLd0y
         Ged137J6aiWkBrxyczY8f1RRScBKgDlZYrUADVarGsK4xT62X5+9fDEKEvDPccTY/Jev
         3YVQLDrOfW8/YhSrX072aDjJ7fIBTFU8Em/Ay0vT0sxvCoModo55UWgXmtmN0k84eCTZ
         TAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=noGHlEfIRRNur533I3nkB89I+yG+m/3HzpOGm8JvQz8=;
        b=XEDKsNSgORFrSoGnECe/DecZfQ8CYbgjw89nC8pb1aQCNSO6hVqxV3Dm2ImyVnC1PV
         00eQ3YFc71Uq2OWsTwMVNuW0Rm00JHGfsh30144gJ/36tdWd67j3KaNMczNyn2q87mSj
         vpPUul8owrtP7GQ+Uat1KylmD8auTrZMuPqzDacRj2aOV/ny0UoOq0ApnSa7QwL1BnTQ
         0ZrReU/0N+EupoovcFDk1CDrRXEVsmnQchzXZ3AkSzX17jCfR2JUm9m2GpNYK+NJYDDo
         GG4aomHCiEuKp6ZAPqpO4WJ8cHI09oCl9O08s3LmCRRGTKSPGY+G5ct6hkGjok5t/POW
         RFew==
X-Gm-Message-State: AOAM533ejT1lYe4IyJXwBRbBIH8K3VS0UUn8o8k5wyYQLh7aoayH6Xof
        KaD1BJhMVddnTMkChCJcrbJSuPejvSR5+pc=
X-Google-Smtp-Source: ABdhPJwEwjs1nGnb+3sP+p33XvvGjkdc3yRXkaJXi8o+QTVC35o+eR/hAICOOGga0fUj1inv9XQCIg==
X-Received: by 2002:a05:6638:144f:b0:330:b4c3:450b with SMTP id l15-20020a056638144f00b00330b4c3450bmr2975177jad.113.1654177414909;
        Thu, 02 Jun 2022 06:43:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id q24-20020a027b18000000b003313005be01sm1209615jac.141.2022.06.02.06.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 06:43:34 -0700 (PDT)
Message-ID: <049aae88-f5b3-788e-3979-34e8178e6bd4@github.com>
Date:   Thu, 2 Jun 2022 09:43:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated
 warnings
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
 <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
 <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
 <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com>
 <220601.86r148yxi3.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220601.86r148yxi3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2022 3:33 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jun 01 2022, Derrick Stolee wrote:
> 
>> On 6/1/2022 8:29 AM, Ævar Arnfjörð Bjarmason wrote:> 
>>> On Wed, Jun 01 2022, Derrick Stolee via GitGitGadget wrote:
>>>
>>>> From: Derrick Stolee <derrickstolee@github.com>
>>>>
>>>> The previous change added a warning when valid_remote() detects
>>>> credentials in the URL. Since remotes are validated multiple times per
>>>> process, this causes multiple warnings to print.
>>>
>>> Why are we validating remotes multiple times per process? Can't we just
>>> do it once?
>>>
>>> Is this a case of two callers going through the whole machinery and not
>>> being aware of one another?
>>>
>>> Perhaps it's a pain to deal with that in this case, but it would be
>>> better to note why here than taking it as a given.
>>
>> We could certainly investigate this more, but it seems like a more
>> problematic approach than the one taken here. We could add a "is_valid"
>> bit to struct remote, but then could some code path modify that struct
>> after it was validated?
> 
> I tested this a bit and I think this alternate approach is simpler, and
> it passes your tests:
... 
> 	+static void valid_remote_at_end(const struct remote *remote)
> 	+{
> 	+	int i;
> 	+
> 	+	for (i = 0; i < remote->url_nr; i++)
> 	+		check_if_creds_in_url(remote->url[i]);
> 	+}
> 	+
> 	 static const char *alias_url(const char *url, struct rewrites *r)
> 	 {
> 	 	int i, j;
> 	@@ -687,6 +692,7 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
> 	 		add_url_alias(remote_state, ret, name);
> 	 	if (!valid_remote(ret))
> 	 		return NULL;
> 	+	valid_remote_at_end(ret);
> 	 	return ret;
> 	 }
> 
> I.e. we already have one spot where we get the full remote config, you
> were just hooking into valid_remote() which we call N times while doing
> that, let's just call it at the end.

Thanks for finding a place where the current behavior only runs once.

I agree that this is a much simpler approach and reduces this series
back down to one.

Thanks,
-Stolee
