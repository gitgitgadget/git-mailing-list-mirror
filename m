Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45971F4E2
	for <e@80x24.org>; Thu,  2 Feb 2017 21:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdBBVT6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 16:19:58 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35062 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbdBBVT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 16:19:57 -0500
Received: by mail-oi0-f68.google.com with SMTP id x84so24181oix.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 13:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uD4piyEWx7eGAStxa/bG8cU0rmDRb+tI5lTYJ65wz+I=;
        b=OVM4RIiKdEOeMQncbyCJnXf+X0yXav1swjt+amCHIQLkvPjc8rCdRk2KBJ79nqmb/h
         Yqwu2nLclwJ6Ru0GHD1u5C4LvMNfDPbNzs+Rma9HgAjR2ZU5r1Zmclh7YvElxUodaGx3
         tuceF/XtxjyJPOWFbZ/pLb9D5VrMF5X0wBIPdyHzlTo1eku9dhBgmRvS6FOWiMhA2ybP
         vHhWgBBN1Sp0G1l9uSirb4/eNmfoAFcnNWYFA8uEIJltNeAZoyu9NyKc+VjR4AktDLhY
         OUPu/sZMIE3ggXmbSSAm/f7kDaIBxv1ZgqMQRQv/fGxbkJwaKz83c9U5880cBAA0aCBF
         bfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uD4piyEWx7eGAStxa/bG8cU0rmDRb+tI5lTYJ65wz+I=;
        b=RLS0QHuMSjOVUf+Nr86wGdaInBCxb/Iu8jmy7i6FU6hxYpnABQqVLGT8zSHggC7ona
         niwOfLiI+ntxjsL/akSVzP7PO5mpjQG9A7K2PJQTgsMAOLTFo+IqmgG+fuiLZtQ7X+Lt
         +NReVUZZsaaxP4UDnEW2Zgq/ssa3hpE4dsKBMl6gd+YceYcBLxGgFPbVv6gii7LeDTX7
         5YWIhT0BNekP7ue0Isg4oQHZK5NTcW0FDWmG7xb4WkHJVM04BmHxPmAjpE86Y81qwF6/
         DPacJUFFYtqvXDPbhGqYWL5RF5sc1PIjhgApZvcD33/xBHg/ZFuyPvVfBcsLXMoYNRsK
         iYCA==
X-Gm-Message-State: AIkVDXIZnTihozS33U7THc4Yr5ibAEIz3lZv+v+mo4gbstJ1GSDdaEvUgN+WZ3uBHkLKoCEa6RcjLdPOR+mqpw==
X-Received: by 10.202.237.139 with SMTP id l133mr5477837oih.55.1486070397060;
 Thu, 02 Feb 2017 13:19:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Thu, 2 Feb 2017 13:19:56 -0800 (PST)
In-Reply-To: <xmqqfujws3pl.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702021143470.21619@i7.lan> <xmqqshnws6ma.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw14UXMa6OJ6YLHjy3tzOD+VSNytw6kMpaxFEfyuO2hAw@mail.gmail.com> <xmqqfujws3pl.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2017 13:19:56 -0800
X-Google-Sender-Auth: SpoV6NNvT6cmHwwuHJfBzZp4-Fg
Message-ID: <CA+55aFy27uEXX2FfQB7q5SWAaV-E0etCrBf0MnFRzARb1P2CaA@mail.gmail.com>
Subject: Re: [PATCH] ls-remote: add "--diff" option to show only refs that differ
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Another case I can think of that "--diff" would help is when you are
> inspecting your own mirror (but that can be seen as a special case
> of the "they have copies of yours plus their own", if you think of
> your mirror as "them" and the difference is "being stale").

Yeah, that's actually what I did for some testing (not having stale
branches, but just to check the expected differences for my upstream
kernel repo with my local pulls that I haven't pushed out yet).

The actual real use-case is something that only happens for me only
very occasionally. I end up sending out "did you forget to push"
emails perhaps a couple of times every release, but every time I do I
will have gone and done a ls-remote on their repo..

                     Linus
