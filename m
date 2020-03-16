Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93498C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FEF205ED
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 12:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+gvZ3Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgCPMbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:31:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42064 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgCPMbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 08:31:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so18348469ljp.9
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 05:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UjqQD+ElzWZSPBqmb+P9OmVjwVDwnQQBBbvzhwaZuc=;
        b=U+gvZ3SjDy58fPySZVai7qrVKwHQl3Ilz4o572klzBHkpcLGwXvNnF+jxOR6LRhN4/
         iIPlNn8nBVDsblMUApeCIHlXpOmV6cbQUX/+7qwrQvWTMLaMbyfjHIXHuT2FF5OPcVj2
         EolpSG7BBgqteE7t7zXIrhnamOZTfHCiBGQHuNYR71qHWQpjeQXAb6r4Xg0UHiAMD2QP
         Dx1VXRNAyM9XPfr7UztEic7hIrKV40ZISEzHQAuZDVaMKse+gGjsiil50Sebti7ivufT
         BtoAV2Vl95OPhS3WlGSNtTX5BkdpJrNTTqI2SMf+tJ5srLTK9rdPNIPTHC3Kc08idF+Q
         gsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UjqQD+ElzWZSPBqmb+P9OmVjwVDwnQQBBbvzhwaZuc=;
        b=bv729yb1l3nWkFLpoVlsVGbO9SpUgYaL+UR6ZCPjkCHJqham/5hcCOLYiOLHwOE2MD
         sjyzBaqWfcmfjhTcxGdrhWP8TKcqXJNnP2xeNIts0Bj5f42hg7MgqouHLhALnHyB4uYF
         IFfk/guLoLNYXZLvu6Zwq7DvyOFHJBa2/TZa/Ybal+wxqN988nmiCv7YtJj6Wu1SMgAg
         6wagii5bTNOxqsSFOBnI2IfViAV/G9rGuBBz32T8pfjtEvHCaPzmeUeGOz7nxpCEQzho
         GG5gtp7/cNehXgB8toPR2yH4dcyt82PhueStyGPt0URM9r+RmP5rncp0WmJV97yToXc4
         K1Vw==
X-Gm-Message-State: ANhLgQ1kW7zcwC4V9PmkhWEnUD7n33pHn0uExpxAhUoFDcmMR7OiVevz
        J2dhFgv2mMRzaMIP+MAlzzs=
X-Google-Smtp-Source: ADFU+vs4XZGE204ym88kclAD4usXtCCNGrMzLEGRnLl2gC6psUgM1tlbiRFFL2pP/7hS3KGvTKLlcA==
X-Received: by 2002:a2e:80d8:: with SMTP id r24mr14180318ljg.233.1584361882007;
        Mon, 16 Mar 2020 05:31:22 -0700 (PDT)
Received: from [192.168.1.117] (ipv4-188-121-23-206.net.internetunion.pl. [188.121.23.206])
        by smtp.gmail.com with ESMTPSA id o15sm4580037ljj.55.2020.03.16.05.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 05:31:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] dir: improve naming of oid_stat fields in two structs
To:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
References: <cover.1584329834.git.matheus.bernardino@usp.br>
 <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
 <xmqq1rpsako1.fsf@gitster.c.googlers.com>
From:   Patryk Obara <dreamer.tan@gmail.com>
Message-ID: <938146aa-e095-66fb-da0b-10e8796eaa12@gmail.com>
Date:   Mon, 16 Mar 2020 13:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rpsako1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/03/2020 07:17, Junio C Hamano wrote:
> Matheus Tavares <matheus.bernardino@usp.br> writes:
> 
>> Note: I choosed to use "st_*", as naming, for simplicity, and to keep
>> the code lines small. But should we use a more verbose "oidst_*" format,
>> instead, to avoid confusions with "struct stat"?
>> ...
>> @@ -334,8 +334,8 @@ struct dir_struct {
>>   
>>   	/* Enable untracked file cache if set */
>>   	struct untracked_cache *untracked;
>> -	struct oid_stat ss_info_exclude;
>> -	struct oid_stat ss_excludes_file;
>> +	struct oid_stat st_info_exclude;
>> +	struct oid_stat st_excludes_file;
>>   	unsigned unmanaged_exclude_files;
>>   };
> 
> I tend to agree with you that using prefix "st_" for anything other
> than "struct stat" proper would be confusing.  If "ss" used to stand
> for "sha1 stat", I would expect "oid stat" to abbreviate to "os", at
> least.

I think I stopped myself from more renames in that patch series, because
the number of touched lines across various functions started to grow too
fast and I was already stepping on brian's toes when touching oid
conversions.

> I also am wondering if we can do without any prefix, i.e. just call
> them "info_exclude" and "excludes_file", because the field names are
> private to each struct and there is no strong reason to have a
> common prefix among fields in a single struct.  Rather, it is more
> important for the fields of the same type in a single struct to have
> distinct names so that the reader can easily tell them apart and the
> reason for their use is straight-forward to understand, and the two
> names without any prefix convey their distinction pretty well, I
> would think.

The evolution of this name seems to be an artefact of refactorization
process, and not really a design decision:

info_exclude_sha1 (unsigned char[20]) changed to:
ss_info_exclude (struct sha1_stat) changed to:
ss_info_exclude (struct oid_stat)

There are some comments in dir.h still referring to info_exclude_sha1.

Therefore removing the prefix altogether (and fixing outdated comment!)
would be very welcome.

On the other hand, naming them sss_info_exclude or sos_info_exclude
would be quite funny, although I don't find hilarity to be a desirable
quality for a naming convention ;)

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
