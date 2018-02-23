Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056271F404
	for <e@80x24.org>; Fri, 23 Feb 2018 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeBWQHY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 11:07:24 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34373 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWQHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 11:07:23 -0500
Received: by mail-qk0-f179.google.com with SMTP id l206so11356027qke.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T1bUTLyheQG1q9qaLGW41YwOTLls4Swa5l7cNT0HFaU=;
        b=aC+RxeS21Ktw5uTwpNtrbE5K4212cMjYYEv1c16mibWivJxT9kUCFSZWnBv7nI6tFx
         AHs/NbGXh3j5HT2Ya9rp09ZNxTvdKggo3gd92oUJuFiQ7tWbSaq9zCX+Eti9eVL3fUya
         mf6VtnkZqJKMVec4Ir2DAiX/Bv6S1SvOTAENUOq/aC8FWB6qjxmx0lcF4E4EAuhQGkaO
         zFrDFUenZJw7gUYYb5tk3Nhp9v1B/ux2u2QWlfuuiEkPfrtDM+/pyjYA0zyElNQKQgpD
         BiPmW4S39Ovwm9hajgP30/wdhd0SoDSPdJpace4fOcA+6aPs3Gxf5uUxdRGsddbZeXGm
         UjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T1bUTLyheQG1q9qaLGW41YwOTLls4Swa5l7cNT0HFaU=;
        b=PedW4We6woGQRtyEei1u+LUDAnc6sfF9IJWVcWYQRNzKFGZobXwk0HkPw0+/JeceS7
         JJ9yfXw1hPLg8o75UpheuoV+9+qVW3NyaD4lIKG3EawrH62McT+Paosgd82IIOEtuDr8
         KT/mzaEpbAxsbqU1V+D2FN3fPsZPiO/sTGo3L4Ne8UhuuA49EVwjta1lahz6QM39pS8J
         dy4i2J0c7l0Vi9gmoGLvVPTAVyT6dDKCDV+vRC6J6AW2unVAxWZVOI7TAcEuChvs0PWp
         taaYJ2dHUArjtUbycbL70aSjy6IuHpUtuwNlO3HHHwOKONbJ/Hi8bHbsow/DTELEyMBZ
         UYNg==
X-Gm-Message-State: APf1xPDDGZl8rsJd7llaobds5WRxt2mUFGE+5fbv2MMiowPzoH37QrjE
        ZKiN+iNYe+ZRlcxRgnTVoG8=
X-Google-Smtp-Source: AG47ELui+4Su7jEUAvROp7fUG3HX8HGB+JFNqTP17TqZ1TMky8cVyToUoeCYjnqY7AQC/2haK3ODPg==
X-Received: by 10.55.20.40 with SMTP id e40mr3219220qkh.66.1519402042812;
        Fri, 23 Feb 2018 08:07:22 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id t10sm1882396qkg.39.2018.02.23.08.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 08:07:21 -0800 (PST)
Subject: Re: [PATCH v4 03/13] commit-graph: create git-commit-graph builtin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-4-git-send-email-dstolee@microsoft.com>
 <xmqqvaer1ga1.fsf@gitster-ct.c.googlers.com>
 <xmqqd10yyxsu.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c9d38f72-536b-887b-eaa7-3395746ef8e3@gmail.com>
Date:   Fri, 23 Feb 2018 11:07:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqd10yyxsu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2018 1:58 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> +int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>>> +{
>>> +	static struct option builtin_commit_graph_options[] = {
>>> +		{ OPTION_STRING, 'p', "object-dir", &opts.obj_dir,
>>> +			N_("dir"),
>>> +			N_("The object directory to store the graph") },
>> I have a suspicion that this was modeled after some other built-in
>> that has a similar issue (perhaps written long time ago), but isn't
>> OPT_STRING() sufficient to define this element these days?
>>
>> Or am I missing something?

You are not. There are several places in this history of this patch 
where I was using old patterns because I was using old code as my model 
(places like 'index-pack').

>> Why squat on short-and-sweet "-p"?  For that matter, since this is
>> not expected to be end-user facing command anyway, I suspect that we
>> do not want to allocate a single letter option from day one, which
>> paints ourselves into a corner from where we cannot escape.

I'll drop all single-letter shortcuts.

> I suspect that exactly the same comment applies to patches in this
> series that add other subcommands (I just saw one in the patch for
> adding 'write').
>

Thanks,
-Stolee
