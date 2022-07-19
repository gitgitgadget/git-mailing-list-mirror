Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9A0C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiGSRqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiGSRqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:46:48 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20363C149
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:46:47 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n7so12417706ioo.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oGBdfdlIsDXof1uoYAwecVvP1wEze7OHwSKSVoYGRaQ=;
        b=FuFC40OdshoIVIfwLlWWTJf3mogJqz5nONYMsF7z05Ov9B8JUeQlMGUTijT9tmSLyB
         ImcCFYw5dZs8oSbMoq+B/F6uMI2ANVb6SrzSdU6yyR9sQZntbFVEU4DpGz7lvby7JBN3
         P6QYo5RTOs05KtHGSEBdMfojEY/h90uWSn9eMLg6MKM/7FjLeGHHsHmuig1ehc6wRSlH
         97Nh8jmcCg/aYD4jIqzP2pp9Xq0F+t3IMAgLu58CjeBk3bnIRnqPtCJ4J70JNVajwVcl
         mC5AbVR4JIeMPsMlSpeqFFnJpg5iRD1qs3IFZU/TRm8ayXMGDWDGEqKf8jHTsFhpAwNa
         VTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oGBdfdlIsDXof1uoYAwecVvP1wEze7OHwSKSVoYGRaQ=;
        b=IMYTGfBbLphwsrOhy688Z2wHekoo2IKdyFMcL6TuRv/BxFIIwE2YTsLVsl9D1QF8/d
         D9zMHforW6rS5xj4CMiIOcWVG27bmOM5wCLQD96QtR8g3nV4kRTHdR8Lk77NiCQthNsy
         AKrDc5Hxo3Qoscu/HrAW6MJc8Auar2/GPi8UG/s1Mh9ZPzcwO8zXCJU4puq/PI1nZk57
         ABhi69zcwGt/vZNutt6JH5Mt1gMExvdHAWgWzfBf5KkaYrNFVahS/8BFFdF+ugvlpDvI
         +vnMknOH6rZ4KlRLO5Opjotl5prs6DnGYJf2PwTfqTxx1xcSISlBQi168YvHS09XInzR
         JPKA==
X-Gm-Message-State: AJIora96hII9fpJVp10sa7+oyKv7PpytpdH2UN/+n8Sz00EXpeam9XuT
        jBRYlJOSsx3zrn/Gjpa23uRLM9P+J3K3
X-Google-Smtp-Source: AGRyM1ud8AHBnQp/1/ZEOOCXfPljAYbx+0fxfHh66tYG9aAhlqoGin/JtFHP1wt1YimmtvhBAgTc3w==
X-Received: by 2002:a5d:9758:0:b0:669:7d33:c556 with SMTP id c24-20020a5d9758000000b006697d33c556mr15382586ioo.2.1658252807134;
        Tue, 19 Jul 2022 10:46:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id s17-20020a02b151000000b003316f4b9b26sm7058588jah.131.2022.07.19.10.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:46:46 -0700 (PDT)
Message-ID: <0a93bea5-2d5a-298d-f501-ec4bb9a9c45f@github.com>
Date:   Tue, 19 Jul 2022 13:46:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/7] mv: free the *with_slash in check_dir_in_index()
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-4-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220719132809.409247-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:> *with_slash may be a malloc'd pointer, and when it is, free it.
It might be worth mentioning that you are reorganizing the
method to use gotos.

>  static int check_dir_in_index(const char *name)
>  {
> +	int ret = 1;

Interesting to "assume error", but that works since there is only one
place where the success is guaranteed.

Should we use -1 here?

>  		if (ce_skip_worktree(ce))
> -			return 0;
> +			ret = 0;

This could be

	ret = ce_skip_worktree(ce);

unless you really rely on the "1" value.

>  	}
> -	return 1;
> +
> +free_return:
> +	if (with_slash != name)
> +		free((char *)with_slash);

Good check to not clear 'name'. It's unfortunate that we need to cast here,
but it makes sense.

Thanks,
-Stolee
