Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3A71F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeIJVcR (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 17:32:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38391 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeIJVcR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 17:32:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so22097653wmi.3
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q8qTchw3SZGhSovRGCm0UOL76QedGCeyVtQwn7wbVRk=;
        b=bQayHHvC9OCcWle9CE2boVIEWBWHB4Q6QajckpnS08vwAz2nbpXWPxpkzHSkWa4IY9
         sVpvnxrS/6QKachRmiM5IaP/wEXRqNv5Ld9M/z7VIfYrIiy9fSnRQrPZHTHQNWQvGI57
         an6feZgXIQuEKvPL7BGuVjqcqjPb7hjjnD87EhIVM0rdAayj6O5UNoF30hwJdOzKeRtS
         1aQo76/Ckap1uquvhkVlOAcIp+2rmMQAXodSf2ZPhWqqwrwHfSJcyEplmfQeSFEHYZsc
         7ZephJF8Q//mJUN3se8Aorl842KHqq8i112xfWpqHohH0qZ5NIyBIkGR2nQFL+oX7UqI
         zI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q8qTchw3SZGhSovRGCm0UOL76QedGCeyVtQwn7wbVRk=;
        b=gTVSbtJe/3HxVip/d8no+KYO7YNo5RvNPawsGjBh1dCUGnwCqPwssgbqN4vzBO7180
         1LX10l4Rb8/S0f3vDRn58WMbft6kBShT0U2G2OuCZ2c/FkoKogdhq1EsZnYmpr9OeOHF
         A0SUC23jkJR3MEnaVOVkHoLZR03HB/DhhonjX7DoRzwvhPz6x41tE/Aw1woH10+LkM9l
         5uBZc+yLM8+FKoF7Cers9L0AEuA21sQx/Aad19FmjBz1gd73bSR9ZU9WshF6gAUiOITM
         jxzRf7TWDaWNUujtWW6+dllmd/OLH2ChKSgyTmqB8Jnj8P55TaO0/1bJOISmLVrQ0ObS
         QCYg==
X-Gm-Message-State: APzg51DyGhAqMQAc4ygKZ1ZUmnZVFYluNlsH6zIRMPhR8IFE9F7cqstY
        AZAGsYwqQgW26VpL5Cwgqq0ihMia
X-Google-Smtp-Source: ANB0VdZhj6IItv3efjba4Yhr7zYCBroZsRyrgZvUnosOh58Mmw3lCJVmbhVxs+XZbRLypXAlSXSF6A==
X-Received: by 2002:a7b:c143:: with SMTP id z3-v6mr1260850wmi.105.1536597441377;
        Mon, 10 Sep 2018 09:37:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z16-v6sm25097618wrq.78.2018.09.10.09.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:37:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH v4] http-backend: allow empty CONTENT_LENGTH
References: <20180907033607.24604-1-max@max630.net>
        <20180909041016.23980-1-max@max630.net>
        <20180910052558.GB55941@aiede.svl.corp.google.com>
        <20180910131724.GA5233@sigill.intra.peff.net>
Date:   Mon, 10 Sep 2018 09:37:20 -0700
In-Reply-To: <20180910131724.GA5233@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 10 Sep 2018 09:17:25 -0400")
Message-ID: <xmqqa7opux4v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But that couldn't have been what older versions were doing, since they
> never looked at CONTENT_LENGTH at all, and instead always read to EOF.
> So presumably the original problem wasn't that we tried to read a body,
> but that the empty string caused git_parse_ssize_t to report failure,
> and we called die(). Which probably should be explained by 574c513e8d
> (http-backend: allow empty CONTENT_LENGTH, 2018-09-07), but it's too
> late for that.
>
> So after that patch, we really do have the original behavior, and that's
> enough for v2.19.

To recap to make sure I am following it correctly:

 - pay attention to content-length when it is clearly given with a
   byte count, which is an improvement over v2.18

 - mimick what we have been doing until now when content-length is
   missing or set to an empty string, so we are regression free and
   bug-to-bug compatible relative to v2.18 in these two cases.

> But the remaining question then is: what should clients expect on an
> empty variable? We know what the RFC says, and we know what dulwich
> expected, but I'm not sure we have real world cases beyond that. So it
> might actually make sense to punt until we see one, though I don't mind
> doing what the rfc says in the meantime. And then the explanation in the
> commit message would be "do what the rfc says", and any test probably
> ought to be feeding a non-empty empty and confirming that we don't read
> it.

The RFC is pretty clear that no data is signaled by "NULL (or
unset)", meaning an empty string value and missing variable both
mean the same "no message body", but it further says that the
servers MUST set CONTENT_LENGTH if and only if there is a
message-body, which contradicts with itself (if you adhered to 'if
and only if', in no case you would set it to NULL).

Googling "cgi chunked encoding" seems to give us tons of hits to
show that people are puzzled, just like us, that the scripts would
not get to see Chunked (as the server is supposed to deChunk to
count content-length before calling the backend).  So I agree "do
what the rfc says" is a good thing to try early in the next cycle.
