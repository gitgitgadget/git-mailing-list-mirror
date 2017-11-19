Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83486202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdKSRWK (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:22:10 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40203 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKSRWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:22:09 -0500
Received: by mail-pf0-f196.google.com with SMTP id u70so5541045pfa.7
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FM4E8iAS6pQT5CvMYEUG4BLsd9NaC3amphhtY3di8zM=;
        b=AgThrHf1cfgRrWfZl5pVcHi+lsvSsI8fNTwHw5wtGH8lXclWiBToa6Goq3NEcNqCP+
         ncVYqwWYl9KvnqXpWPTIl74XN0DlHEGSCNgDr/lWwcvQgrry56F1MUPyOuVZ84jwgaiq
         Rk6dvbxA2VEI0pudmc4KCg4YHo4ecztzafapHKVnvO6vNfwm93Ye4mHoMjg+z9i+JcEN
         8d8mPzvksxHfqQcfb27nH/AhxbY7uddJmzmPeGPDD1IuSzsW3l9IAOT3tj0u+B32EDtq
         epBMnhg+sM8BuCGwVX0wXESoscLfxJqNGINoNhD3ssvrW0YrHxVYRF3qX6oN4BpWtjB0
         8qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FM4E8iAS6pQT5CvMYEUG4BLsd9NaC3amphhtY3di8zM=;
        b=GAO4TZPwe4skzDxPcOW2JAnXp2Hs5EtJa4kcqDT4yKejvS/hDnrNi+DNfDuJmeuyTk
         /jfKZZvJMq1HK+jrlIkyOiZW+gnUS2dZh9SWG8/qt9tNFmI+tVYc6A6+J+auF2ikYJuX
         u9HI8EQzTj0q+21NCjq3gWyBn9FSvZOpmsa5HMwYxZZr/dMdCsRfs/pb96VN/+u/V/jC
         aQz0ckNl9iZNo8GjujZoyrXreNqTcNeXCAlr7ADi8C2UN/QpWQ5VY/vjT1a1U82+zN8B
         ERhAZGvit8/Da6hojBxdNybpt1tvAjbpzT8WjUdEtEEGcbjG7V4/PoOFuIxjW6SuK8SC
         HwuA==
X-Gm-Message-State: AJaThX6TQV3VetP8VJAT7BWGiLSnpc95MCFsK1fq8aLqHA+vHT8ZgJVs
        zlqwVnHPlIapmypEMU+57II=
X-Google-Smtp-Source: AGs4zMZ3DOr+1BZmnHrTUVCY+PCxUnfa5i4x7RqoxUaOUO1qLwx/dVOGf9uZLU2KJaY70yUAyHP91g==
X-Received: by 10.84.218.72 with SMTP id f8mr11701748plm.143.1511112128568;
        Sun, 19 Nov 2017 09:22:08 -0800 (PST)
Received: from ?IPv6:2405:204:72c8:8b21:b8b1:7c41:1a33:6334? ([2405:204:72c8:8b21:b8b1:7c41:1a33:6334])
        by smtp.gmail.com with ESMTPSA id t25sm14929918pfh.67.2017.11.19.09.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 09:22:07 -0800 (PST)
Subject: Re: [PATCH 4/4] builtin/branch: strip refs/heads/ using skip_prefix
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-5-kaartic.sivaraam@gmail.com>
 <CAPig+cRrJVhYMYfoFhSi+FOLv0X4or1-YV=M8_X10_d_Bbt3pA@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <a3bba8dc-0f4c-808c-9b6e-2252160a2cc1@gmail.com>
Date:   Sun, 19 Nov 2017 22:51:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRrJVhYMYfoFhSi+FOLv0X4or1-YV=M8_X10_d_Bbt3pA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday 19 November 2017 06:34 AM, Eric Sunshine wrote:
> On Sat, Nov 18, 2017 at 12:26 PM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> @@ -462,6 +462,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>>   {
>>          struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
>>          struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
>> +       const char *prefix_free_oldref = NULL;
>> +       const char *prefix_free_newref = NULL;
> 
> A bit of a mouthful.
> 

Quite possibly.


 > Perhaps name these 'oldname' and 'newname' or something?

How about the following ?

1) "interpreted_oldname" and "interpreted_newname" or

2) "stripped_oldref" and "stripped_newref"

I couldn't come up with better names for now.


---
Kaartic
