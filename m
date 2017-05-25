Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD84D20209
	for <e@80x24.org>; Thu, 25 May 2017 03:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941501AbdEYDNH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 23:13:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36154 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941498AbdEYDNF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 23:13:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so36127662pfb.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W7Y0E1/4ogxYVERpHUQbtnb80FAkDXqugKqAr78Ugbw=;
        b=bwPUDfK8D6JiXf4OfdW6JwVv0CeJEXoCLOfRsstPKTlBVzQJBLO4rd5aOVLampI4mH
         CcXOWG52SMciaXSyZW3fA1FFIs93rba0BQyL+VsgktnfdUsGvFXm+3eWPgJudBLln2+5
         bakDWIaLzJ5OUpl2IzRo5XekKt37V2oB78vetmW5cLd9/ZljhMf79NoJ55k8gqSNBwQG
         i35d9jnRT0ZVDbu2WRp3zh6Fr5sKGPRDW63c+pXotjUpBT7u4DfaJjsCMxNH89UmAd27
         6F8FtE8uYPr1xBaszZ2V8OxMgBU2mJ/0rXJRwFzkQZ0G/adTD0e36MqxoYbkMYyC9icE
         8kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W7Y0E1/4ogxYVERpHUQbtnb80FAkDXqugKqAr78Ugbw=;
        b=tsK+qr7J4nd+opyMA5204W2vK9erlZY5Lv6IerjuMY4tyDEvG+gheKP1W3L7r9j359
         nykHHE0m1KNfBXcH0gL5y00WcWIzcFwDQAAkkzJT8wtvgWjwXvXbK293c4xB2X9hIgDC
         Bcn3eRGjiqh16EAIztzJhmLhGHLWnIceacs7C2S9gLOCIPm0iGEHvlxaO/5Go0RTuq0w
         iUTuBE4yGc6QLkrkrp1WpsbQYxNTZnW9MCrMLMR2MprcRxFj+vbWneXX+bf6NxWARWiG
         9iWgyd1h9G/sJ0CHcCrkr0U20V2yDEFHCowQk+ZYSKR1cjy6X0d+MjEcSiOMNosV8lFL
         vBCA==
X-Gm-Message-State: AODbwcCoJkH7ADp03lSWPL99hpaHJEMZzbMTiAglria3nHU85XYaC0or
        I1N8APJP0zs54w==
X-Received: by 10.84.248.4 with SMTP id p4mr31942613pll.155.1495681985164;
        Wed, 24 May 2017 20:13:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id n22sm10231741pfa.123.2017.05.24.20.13.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 20:13:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?utf-8?Q?F=C3=A9lix?= Saparelli <felix@passcod.name>,
        git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
        <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
        <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
        <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
        <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 25 May 2017 12:13:03 +0900
In-Reply-To: <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 25 May 2017 10:36:14 +0900")
Message-ID: <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Unfortunately, it can't, because the ref doesn't exist:
>>
>>   $ git ls-remote git://github.com/passcod/UPPERCASE-NPM.git
>>   efc7dbfd6ca155d5d19ce67eb98603896062f35a	refs/heads/MASTER
>>   e60ea8e6ec45ec45ff44ac8939cb4105b16477da	refs/pull/1/head
>>   f35a73dcb151d336dc3d30c9a2c7423ecdb7bd1c	refs/pull/2/head
>>   0d9b3a1268ff39350e04a7183af0add912b686e6	refs/tags/V1.0.0
>>   efc7dbfd6ca155d5d19ce67eb98603896062f35a	refs/tags/V1.0.1
>>
>> There is no HEAD line at all, so we have no information about it on the
>> client side.  Likewise, if you run with GIT_TRACE_PACKET=1, you'll see
>> that the capabilities line does not include a symref marker either.
>>
>> So if we wanted to improve this, I think the first step would be for the
>> server to start sending symref lines for HEAD, even when it does not
>> resolve to anything.
>
> Yup, noticed the same and I agree with your conclusion.

We probably should make head_ref_namespaced() to take the
resolve_flags that is passed down thru refs_read_ref_full() down to
refs_resolve_ref_unsafe().  For the purpose of the first call to it
in upload-pack.c to call back find_symref(), we do not need and want
to say RESOLVE_REF_READING (which requires a symref to be pointing
at an existing ref).  I suspect all the other calls (there are 2
other in unload-pack.c and yet another in http-backend.c) to the
function should keep passing RESOLVE_REF_READING, as they do want to
omit a symbolic ref that points at an unborn branch.

