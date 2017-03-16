Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7FB20323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbdCPW6X (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:58:23 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35766 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbdCPW6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:58:21 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so25441029pfx.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=w3lCXAT4ju/9zqTGtpwmde6Zt8AOn5q8A39Ivw/5hQg=;
        b=AIrwcFwTdBfk9zCPnq+Oy3xWorTICaqE7NSESltVLnQ3fC7J74uwO8zBel3fXi1HiX
         576rOindravk3yXeyyTlHX/z74tymY8tJL9paDLfo5DyHc/ttrZXAR5RTEUz1oBKLtMe
         LKnyX3W1DSz8OXcMhtNzn359ZEF5kmjVRmjOJfdR9MxM54z87ECFiOKaGid8cWumDpzj
         fQitRP9y6ENx+aWCkrx8DJ9k2+TEXYMAgavfTgu2Azcj9LrCOJqTo93SJEXHgFUcRqoU
         7U0QUEvMjz93dvbbl3qnAIScAZSlcPA7sneACRRLGgRccu0nXl+rWum6JKk11n5jZUVb
         kvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=w3lCXAT4ju/9zqTGtpwmde6Zt8AOn5q8A39Ivw/5hQg=;
        b=Dsj9aiLrKRSZFHSMM+7f4F0e0vHLQAC0QzGkbB/f1MvV0haeY6+ywqzJdiza9Vyty4
         kfSAhHrll5I27edOv7MXQGKgDMZLtba0mApew8fovqzNG4pYa/6uqDhTY4IVyroXTjy/
         jHTwAjdp1GRXdBmEfs2jZbivtA9IHul6aXpb+7vPQ0a6Su20yNc+jkB6fK32oM9qaiyz
         9TS10UI7rrEtmViFrpmAVHfBZEfOnylJKWfaXMg7SI8EJ54LdS6gFiXl04FVu4KysEno
         TLYXJUb6HzDC0tuyr92IENrVw6LeC8BD0+IoDSmh5G7vhMczb4H9wHGhuxgPqPc31gD7
         GRmw==
X-Gm-Message-State: AFeK/H0D4fXCn0gqxAIqCu0vVE4iHxKTajVDlU/iuw43F+s97iM3BpTn7dJJ51gpI/uAwdOh
X-Received: by 10.98.13.16 with SMTP id v16mr13072113pfi.38.1489704501233;
        Thu, 16 Mar 2017 15:48:21 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:8d11:eba5:7754:a587])
        by smtp.gmail.com with ESMTPSA id x10sm12481548pfi.21.2017.03.16.15.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 15:48:20 -0700 (PDT)
Subject: Re: Proposal for "fetch-any-blob Git protocol" and server design
To:     Junio C Hamano <gitster@pobox.com>
References: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
 <xmqqinnafml4.fsf@gitster.mtv.corp.google.com>
 <90381e66-d91f-6412-6294-701f5f780645@google.com>
 <xmqq7f3oc45v.fsf@gitster.mtv.corp.google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, markbt@efaref.net,
        git@jeffhostetler.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <3c89fee5-2226-6760-f2fd-222432230612@google.com>
Date:   Thu, 16 Mar 2017 15:48:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq7f3oc45v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/16/2017 02:17 PM, Junio C Hamano wrote:
> Yeah, the example was solely to see how the system was to be
> extended, as one of the selling point of the proposal was:
>
>     > === Endpoint support for forward compatibility
>     >
>     > This "server" endpoint requires that the first line be understood, but
>     > will ignore any other lines starting with words that it does not
>     > understand. This allows new "commands" to be added (distinguished by
>     > their first lines) and existing commands to be "upgraded" with
>     > backwards compatibility.

<snip>

>
> And the lack of "capability negotiation" is substituted by "assume
> the better server, fallback to lower common denominator by detecting
> errors"?

Yes. I probably should have mentioned that this "forward compatibility" 
is limited - it does not include any potential new feature intending to 
reduce the size of the request. I was thinking more of this being able 
to be extended to, for example, add "hint" lines that certain blobs come 
from certain commits, or add "have" lines to present blobs that might be 
good delta bases (and even if the server doesn't understand these lines, 
its output is still correct).
