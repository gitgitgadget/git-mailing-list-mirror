Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E556E7D0A2
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 20:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjIUURh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjIUURW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 16:17:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729C2485E
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:11:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-274b9b7b033so805023a91.3
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316290; x=1695921090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3IgmDqpLgLOGc50Wz5LRbZkkR6X3MwhhldMvkKnNGo=;
        b=mbmWy48TMt03Irf5Akx7QxvKQxAJ5MBi8gsKKOAOpRrG4PFYUuGirvjTY6BwO7stuK
         PMT5k9cRnzTFczNRjAf3k13GGdDpXlnhCU/qr24SkXumz4mugirZ57mZQFWTddw903w4
         cmZK30GTGuoxQzMVuG+Dev2Y6ItYAQF3GF2BUUJTdemqjElSry38oez4w5D7pSlryuok
         WoJgjnKtJVfdRYBTrr6ysbsGKw+eN+Lz+aMLDcX6FIDyq+AG6TxmvMaJj70A06fS4sha
         NxKjRcITY8HE1jArjxw85xkP6jM/0HyFqyPj9eO1Nsv6Hvjam0gqfNEaEsd2tYjC5ATe
         abTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316290; x=1695921090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3IgmDqpLgLOGc50Wz5LRbZkkR6X3MwhhldMvkKnNGo=;
        b=NXPA5lJbbT5icy3dh6Ye52UPk2Kr9k7p04iiJ2+957wEuJNpyqefX2xD9YVngJlVY9
         zTeWAopriVj1UvgA7gZp+BCYBtb0bgh+7hIdmQ0jko7Zjuhx5IR1SFbTVnottA/zzoVg
         Ln8D8wnNxIWGZkAGMe35wZO9VF+BLzMvGomNRNzJZLP7URs8vvrmo1w0jrODFKVm6hBJ
         qIjz8ab7Yi5eSUueqAg90V9lU9WFnBHxBHJ5BmldDexAW3VB6JLt2w7HTkHhYpGk9q+y
         ttthLh0AXC9NxN47h7uLTfNZDACOYrINZfy00LqNmOk1ERIyAUpwUQ2pFxM5TYI4+cUJ
         75TQ==
X-Gm-Message-State: AOJu0YwEejRXFA1io2fFBGhMAgYb3Ffqe3Lu/C0PexijSQwiIOzLMw1i
        Qg9exUrjdoxnauo/sMCEjZrmfEr/4ZY=
X-Google-Smtp-Source: AGHT+IGGEEJXNhAWjDYiigipDug0xvq5JrJoRAYDa28gXOLn06VTFyz01Y4mStD78pDNdAUv4G1CiQ==
X-Received: by 2002:a05:6a20:7f92:b0:14e:32ad:3f3e with SMTP id d18-20020a056a207f9200b0014e32ad3f3emr5682422pzj.44.1695282701441;
        Thu, 21 Sep 2023 00:51:41 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jx4-20020a17090b46c400b00274a43c3414sm2420784pjb.47.2023.09.21.00.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:51:40 -0700 (PDT)
Message-ID: <d6527c54-7dbc-46ee-b73d-49653edda0d9@gmail.com>
Date:   Thu, 21 Sep 2023 14:51:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Git Mailing List <git@vger.kernel.org>
References: <ZQhI5fMhDE82awpE@debian.me>
 <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com> <ZQknHjKdGZV3vJpV@debian.me>
 <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
 <118975ef-c07f-c397-5288-7698e60516a7@amd.com> <ZQrQsa5GJEVhBttT@debian.me>
 <xmqq7cokc0kj.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqq7cokc0kj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/2023 22:43, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> Originally, I was intended to report regression on handling multiple
>> addresses passed in a single --to/--cc/--bcc option.
> 
> You refer to v2.40 and v2.41 in the message I am responding to, but
> do you have a bisection?  There seem to have been five topics around
> send-email during that timeperiod.
> 
>  $ git log --oneline --first-parent v2.40.0..v2.41.0 git-send-email.perl
>  b04671b638 Merge branch 'jc/send-email-pre-process-fix'
>  64477d20d7 Merge branch 'mc/send-email-header-cmd'
>  b6e9521956 Merge branch 'ms/send-email-feed-header-to-validate-hook'
>  c4c9d5586f Merge branch 'rj/send-email-validate-hook-count-messages'
>  647a2bb3ff Merge branch 'jc/spell-id-in-both-caps-in-message-id'

I'll make one on the separate report.

-- 
An old man doll... just what I always wanted! - Clara

