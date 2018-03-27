Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58E31F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbeC0Qwp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:52:45 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46995 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeC0Qwa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:52:30 -0400
Received: by mail-wr0-f178.google.com with SMTP id d1so11072983wrj.13
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RyZJLmvz+XKXU7MzVctDT/RFfef7PYSOQBi4RdSwExw=;
        b=nEmveG34nbI79YN0YtC8rHW6yKBjXWXT4bkhYkYhI8gqXDsihPLC8FSYcqNKxfT4xu
         K4rDfAXCJFryaqhrkPlxnj+/mOpASGW3cR19XESrn8uNY8+E8EzrN/HNGAwT/vNkavBI
         AtIx31odglgggZ39h/aH9/F6Tnk857suEeZ+hVluXQLMVvA83T9BNBu295sP9MaF5qt9
         lkQzki5/ZqsnEV6vMJIlKFct7vLwDH+6oRpbzPsQYg/vJQg41z1/ggoUAM+ria/3TzCR
         8aqJrjp/4zSRfrICYOhaOmyYFFzzQitQhB9Qt2LW/eOAtothJB78QWhYk3vkpyB96Na+
         YIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RyZJLmvz+XKXU7MzVctDT/RFfef7PYSOQBi4RdSwExw=;
        b=U10YF+zIHZfWhndZsjvgJ8vGgDPA2hpi9k5DemQVzhUIYB65xxj4mWCblbGdSf7eWH
         XjQaj+ACxq4XUVc2meafDEjyb4sNqB1ZvXom34RPISYB3fOg1026HAkEZYpfPDFJb04k
         jSAmmnFqktQOvxr5DkllNwZzt43j96TRxUkksCzE48tev34uLYFDH1vAwzX1KmZoPS/k
         pvMOhjfLc6lemCop2/89rHFI1cNwPJZacw5kXUX34OEBXIuA4uKdkb8zN7MH/CXGqUh0
         fHUsVCongnxenK23QIgjocgiHZTzQhT0UTnnPEiIobRsBpEFEYRwkOYoRAGqCcPdVztc
         9DjA==
X-Gm-Message-State: AElRT7FatLQ5hTthli2HFliVXQZr7XTKM4FxgD5/KIWw8nqI0AmmOKtY
        C1XE2rzGSqW3ft5MZ6y908o=
X-Google-Smtp-Source: AIpwx49M/w2IsPrAYQSuRT9N2+qgGNBQCzIodnX9+XgCZDtrQ6HHyk1U1t2sXFt13Gv8ALbBn4NUgw==
X-Received: by 10.223.163.25 with SMTP id c25mr123798wrb.58.1522169548739;
        Tue, 27 Mar 2018 09:52:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l34sm2319587wre.14.2018.03.27.09.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 09:52:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] Makefile: detect compiler and enable more warnings in DEVELOPER=1
References: <20180318081834.16081-1-pclouds@gmail.com>
        <20180324125348.6614-1-pclouds@gmail.com>
        <xmqqlgeebiml.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B_KPGroNVWskeTXu9NuYoSUAoSvYpfapda1_0A1PUwPg@mail.gmail.com>
Date:   Tue, 27 Mar 2018 09:52:27 -0700
In-Reply-To: <CACsJy8B_KPGroNVWskeTXu9NuYoSUAoSvYpfapda1_0A1PUwPg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 27 Mar 2018 17:03:14 +0200")
Message-ID: <xmqqh8p1a2b8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

 On Tue, Mar 27, 2018 at 12:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  - connect.c -Werror=implicit-fallthough around die_initial_contact().
>
> This I did not expect. But I just looked again and I had this option
> explicitly turned off in config.mak! gcc-6.4 and gcc-4.9 do not
> complain about this. gcc-7.3 does. What's your compiler/version?

gcc (Debian 7.3.0-5) 7.3.0
