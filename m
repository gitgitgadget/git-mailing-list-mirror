Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833ABC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbiEXUkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiEXUkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:40:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA46C575
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:40:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so13040182otf.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MUGb7LOYbq6wNsz3eC6qPMXI9J8UvjjNHbqyJaGdRUw=;
        b=LQyFL2/g/Wj9+7GzP+OLDbiI7ohm9H1Qn0bmPuS8FERTAbv+zujaSMcgoJl3gHdMQA
         BlZW7TvZEZBXKkyAgxIHncDs3GeBS8eXUxNmWrPt3RxUDQhw7aVSUAd76Wkx3nRIRiGw
         +LGeqms4Nao58ESqFfYbdPqqq+u4xG/4ymfUA1V9PRLRBZYGpW9y9GtGIUjsMFFbnk1s
         8cXN+qQbGCUNkFdtcnieIi1IfiOjSGiDRNZnk/MZZCqNucPl3k6xHRMKULUS9F7exPeZ
         m4hcCzaxDodhXVdrCIIm++RfqB9mYuv5AapNYJlGUZ7eoWYTIer4jmvA2m5WOFX8ozYG
         5MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MUGb7LOYbq6wNsz3eC6qPMXI9J8UvjjNHbqyJaGdRUw=;
        b=BEwo5KbG55md5NKTs04aUar4wa9hdI3HE4HHuFELbaGQUlV/hGtURfLst0zZfXhLMV
         +ldVn0eCYdHIRnEU6PgXB62D318sA4tPU24VZtfzJOLFCDQWi2wFRqEHttgzEMYDxp2u
         RwJcWeM2lpi/VejriX92i4QRYYC3iqOYAQJFtRIUPyxvGIIb9yUsuKiWN4/1i93wR3+q
         BhPP9k+yvHAJHm3PBlkDqeJQ2nM2cKOKYuctbDs9bFDdDecU2ATCzpgZkryi0emwoPQe
         1TNhgV802UnTsFbGES0L6KK5L9/YhPi/joqGAwpiLylgliIrKyOBecyGtwf33jtkqwio
         o/Mg==
X-Gm-Message-State: AOAM531k7jFxRQrBqAO6uWCD15i08A30sjgDLJmA4yKulkqIywnytJ4f
        DtA6bkf1P3dN6HhFIwUnFCrG
X-Google-Smtp-Source: ABdhPJyyN9fwbelfyFuMZ3DCwIgI8oTppFW5n3yYL1Qg9Fq0cMNmKG/7aUaxKpv8T/8Z3zm94fUZUw==
X-Received: by 2002:a05:6830:54d:b0:606:a7d6:f809 with SMTP id l13-20020a056830054d00b00606a7d6f809mr11569297otb.139.1653424818388;
        Tue, 24 May 2022 13:40:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e? ([2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b000e686d1389esm5515738oao.56.2022.05.24.13.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:40:18 -0700 (PDT)
Message-ID: <e311a560-0606-e5f7-0c41-a6b0f42062cf@github.com>
Date:   Tue, 24 May 2022 16:40:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] setup: don't die if realpath(3) fails on getcwd(3)
Content-Language: en-US
To:     Kevin Locke <kevin@kevinlocke.name>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
 <8b20840014d214023c50ee62439147f798e6f9cc.1653419993.git.kevin@kevinlocke.name>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <8b20840014d214023c50ee62439147f798e6f9cc.1653419993.git.kevin@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 3:20 PM, Kevin Locke wrote:
> Changes since v3:
>  * Free tmp_original_cwd in both codepaths.
>  * Return after strbuf_realpath() fails, rather than jumping to
>    no_prevention_needed, to avoid unnecessary free(NULL) and NULL
>    reassignment.
>  * Invert the condition and remove the else block to match the
>    return-on-error code style for better readability.
>  * Stop adding "Try" to comment, since strbuf_realpath() hasn't
>    been optional since v1.

...

>  	/* Normalize the directory */
> -	strbuf_realpath(&tmp, tmp_original_cwd, 1);
> +	if (!strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
> +		trace2_data_string("setup", the_repository,
> +				   "realpath-path", tmp_original_cwd);
> +		trace2_data_string("setup", the_repository,
> +				   "realpath-failure", strerror(errno));
> +		free((char*)tmp_original_cwd);
> +		tmp_original_cwd = NULL;
> +		return;
> +	}

This is much easier to reason about.

>  	free((char*)tmp_original_cwd);
>  	tmp_original_cwd = NULL;
>  	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
I had considered trying to remove this duplicate code freeing
temp_original_cwd. It requires adding a variable storing the
return from strbuf_realpath() _or_ knowing that tmp will have
zero length if strbuf_realpath() fails. It would look gross,
though:

	strbuf_realpath(&tmp, tmp_original_cwd, 0);

	if (!tmp->len) {
		trace2_data_string("setup", the_repository,
				   "realpath-path", tmp_original_cwd);
		trace2_data_string("setup", the_repository,
				   "realpath-failure", strerror(errno));
	}
	free((char*)tmp_original_cwd);
	tmp_original_cwd = NULL;
	if (!tmp->len)
		return;

	startup_info->original_cwd = strbuf_detach(&tmp, NULL);

...and that doesn't look very good at all. Thus, I think your v4
is ready to merge. Thanks for working on it!

Thanks,
-Stolee
