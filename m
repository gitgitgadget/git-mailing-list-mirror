Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48017C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 14:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiCNOub (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiCNOua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 10:50:30 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DEE36B66
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:49:20 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so20564376oot.11
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/anGuqac98ZyZXSa4Dd7C3gl7CD4F7pUdZj1rKAGrlE=;
        b=iUh59Opc5UXEos1kExxiCzXPksRDZFUamC5ag1dagVZjsfpmuUIXsliHXcRuvjPkm6
         1+EAki2aCAhD0cP8jCxFoaryjOVZ4LIER4H2t1aK8MPR1kSLwghNXSNLUeY9IMJWoMiI
         qVV5Yr3Dws6xcd3lMXHOT4TwH3OT2Gw7FIAEDdf2eQwMpqSaF9p4pQLnx/lk6laXQ8RC
         FGcRvywduajIe3oSEJKGnkTMFtzmdyxBIHltS3Ve00cLVXz3tfryds2DIcr//O7SMSgn
         Uriu3etrflBsitA1XNNu0RwpFS9KTvf7nc+8x8YgHJMshYmOzE8w4H1hHN+HuHYA5yXe
         cEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/anGuqac98ZyZXSa4Dd7C3gl7CD4F7pUdZj1rKAGrlE=;
        b=Z+JpjMCzUY/mztuTIJht0+kc/7Of6z/F6JCVDhhnB56Y+bqcC/0oUe202xUdhe151M
         SxjgqjfcK+ekn4W1Q+Xd9gV+i5o1JAKTL+KqVJSUKYfLe/2MxGxVUO3WrOH5cv62Oe66
         Sx9rKTnWEjQtvgZRA0NzKadSJMw2RVCPr3McFfUqmUhCxOT5PoX05qx4JMkDlvsTP6pt
         ySnoI0LGgZgCqioVPyhcjOPTGL8lCdkO2ucaLZwSrGpfn0qbGdsegkBalY6Y2VGhhLoB
         J6UIDVAWA2nnpEfD2uOV6nhOCsiwnG3fh+pZHEDQ9kxFT0JgDoFaIkLV77dbqjsihMNa
         JiNw==
X-Gm-Message-State: AOAM532Dkwb8cs017o2ejmmQ1ULn4FTxBZiI8PZR08l+rirPul1N31WM
        bF35wGWcEc5OzJXA5Xli7ia4
X-Google-Smtp-Source: ABdhPJzYBp6ugLEaqkTll9YD8fZmcLBSUyjOgGHgzPLq5XpcO32XQmoU3g/fV0vOkmsxk+9ERgJGoQ==
X-Received: by 2002:a05:6870:6592:b0:d9:b66f:507f with SMTP id fp18-20020a056870659200b000d9b66f507fmr12048828oab.173.1647269359709;
        Mon, 14 Mar 2022 07:49:19 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f7-20020a056830264700b005b2503422d4sm7901216otu.81.2022.03.14.07.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 07:49:19 -0700 (PDT)
Message-ID: <7ddeffc4-3442-b4a1-e6f4-e68b3aa3f5ec@github.com>
Date:   Mon, 14 Mar 2022 10:49:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/16] fsmonitor--daemon: refactor cookie handling for
 readability
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <84df95be620c76afed73d1679722459e2ff32018.1647033303.git.gitgitgadget@gmail.com>
 <220314.86bky9ezdw.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220314.86bky9ezdw.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2022 4:00 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 11 2022, Jeff Hostetler via GitGitGadget wrote:

>> +	/*
>> +	 * Technically, close() and unlink() can fail, but we don't
>> +	 * care here.  We only created the file to trigger a watch
>> +	 * event from the FS to know that when we're up to date.
>> +	 */
>> +	close(fd);
> 
> It still seems odd to explicitly want to ignore close() return values.
> 
> I realize that we do in (too many) existing places, but why wouldn't we
> want to e.g. catch an I/O error here early?

What exactly do you propose we do here if there is an I/O error
during close()?

Thanks,
-Stolee
