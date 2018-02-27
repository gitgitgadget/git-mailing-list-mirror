Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F73C1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeB0TZS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 14:25:18 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41455 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB0TZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 14:25:17 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8so11968627pli.8
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 11:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Azil/alcEG9IECXYq37JTvre5N8KXE0p+s1+eiRnKps=;
        b=KnyM4y09ioj03yFRM48YgBbqEdagssIh3DvmTJYBI1tB0hDmiEiZwpOr/XnskX77Y4
         BXxZS6ulLYROSod2Nzb48/7EoYxU/trNERXlwdCC8xT51Dp2+Cdg6APlMl8ZaoKSZPHv
         tyd6kCUdTmbv4Db4rfgZky7Ib+mODriIXThqAAbDAMgKpVdsPJMS+idWa/B8GoLFtwGX
         4wViG8ROKrXQ88NKZX35LSU3keLE3LixitNtiiipleTcxzMMJHpVhUcvK00yK0u/uuqu
         jFu6dy+vVVGrbLWGq5Uqz82UyO05JNF7dznWl18kLim9NgFOGn7xbi4PJTbAihyOSKFu
         fMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Azil/alcEG9IECXYq37JTvre5N8KXE0p+s1+eiRnKps=;
        b=kP2weh0Pr7I7h04TZ2u+JHIOoVGbKJSjPeQoMDuP6/vx1cnppGNMKq7C8osRNKxIQk
         WaNS6/98gWEpiwfv2JkE58/XxsiDzom2z/zMorSvZgoBRtQM2cmOw2dI/XFcALmqHNk2
         Dw+HMBvrEtLBvuxwI5tiCNye+4m4HWb2axusV710i7VtqLkkGzC5OoLg+U/luYtQVT0V
         yA6dbK6JU32F1o8oT2fUQetE340DrxRmNfzWzy9c0y+5cvqpB7xICEdzEIJdeW5Geyny
         egpcZ1lJ1wS3jVCPJP7frlmpEKA+eFYrcpVPlC64p8vmbf7kv3abwU56x/EnLuKc3Two
         k0Pw==
X-Gm-Message-State: APf1xPAEVs9NYyCluCe5Z7Xnda+Zf13xfhdMl9orJ60kYgvxVu/XkIM6
        +kPSQN1tgRdLtRedk1ISlp0=
X-Google-Smtp-Source: AH8x22642uYDNLKH+v3cca3h/RcZc3TcJ+87gtOsQYGWSfaawQu3i4urvqXFnR+Za2ZRgFFQG5Lrdw==
X-Received: by 2002:a17:902:522:: with SMTP id 31-v6mr15296590plf.122.1519759516682;
        Tue, 27 Feb 2018 11:25:16 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b8sm24899309pff.31.2018.02.27.11.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 11:25:16 -0800 (PST)
Date:   Tue, 27 Feb 2018 11:25:14 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 06/35] transport: use get_refs_via_connect to get refs
Message-ID: <20180227192514.GC174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-7-bmwill@google.com>
 <20180227060840.GD65699@aiede.svl.corp.google.com>
 <20180227181715.GC209668@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227181715.GC209668@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 02/26, Jonathan Nieder wrote:
>> Brandon Williams wrote:

>>> +++ b/transport.c
>>> @@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>>>  	args.cloning = transport->cloning;
>>>  	args.update_shallow = data->options.update_shallow;
>>>  
>>> -	if (!data->got_remote_heads) {
>>> -		connect_setup(transport, 0);
>>> -		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
>>> -				 NULL, &data->shallow);
>>> -		data->got_remote_heads = 1;
>>> -	}
>>> +	if (!data->got_remote_heads)
>>> +		refs_tmp = get_refs_via_connect(transport, 0);
>>
>> The only difference between the old and new code is that the old code
>> passes NULL as 'extra_have' and the new code passes &data->extra_have.
>>
>> That means this populates the data->extra_have oid_array.  Does it
>> matter?
[...]
> I don't think its a problem to have extra_have populated, least I
> haven't seen anything to lead me to believe it would be a problem.

Assuming it gets properly freed later, the only effect I can imagine
is some increased memory usage.

I'm inclined to agree with you that the simplicity is worth it.  It
seems worth mentioning in the commit message, though.

[...]
>>> @@ -541,14 +537,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>>>  	struct send_pack_args args;
>>>  	int ret;
>>>  
>>> -	if (!data->got_remote_heads) {
>>> -		struct ref *tmp_refs;
>>> -		connect_setup(transport, 1);
>>> -
>>> -		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
>>> -				 NULL, &data->shallow);
>>> -		data->got_remote_heads = 1;
>>> -	}
>>> +	if (!data->got_remote_heads)
>>> +		get_refs_via_connect(transport, 1);
>>
>> not a new problem, just curious: Does this leak tmp_refs?
>
> Maybe, though its removed by this patch.

Sorry for the lack of clarity.  If it was leaked before, then it is
still leaked now, via the discarded return value from
get_refs_via_connect.

Any idea how we can track that down?  E.g. are there ways to tell leak
checkers "just tell me about this particular allocation"?

Thanks,
Jonathan
