Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D35020D14
	for <e@80x24.org>; Tue, 31 Jan 2017 17:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdAaRS1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 12:18:27 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34307 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdAaRSY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 12:18:24 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so28841319pfb.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lug8kDmGIiNQFt1wXY0wixe9MVcva9veOzt0rYDB5Xs=;
        b=Wn9A82cqpQdT1yaEgLczdvSCwUpTkxkXXFBl4IIHXj5GZA8FsvOqvK8c7Eps3pT4MB
         WJ8TZLD4FOV4hoTbw2aOCv0n5ngqDEpL2DVJYbEY2ThHE3UE+aOfW2F+9kBji1/HRCS0
         pT7pvuEPETxCt9EdtIL8RTPCaWqryGwe+6Avktl65u/+Ci6u83y8k9/BYEzfj12wsrMZ
         jf+2APM4mRyWuCe6HUoI83/Jt1f1YJHwXR95Fi4hV55ZjZKRTcpus6SBZQu3XnS/MdHu
         IvJeVCKAasXnkYj3/OHCxKchsZJcDtC/2IBOmP4bjBcL++4ExcQSZriwnl8bNTkAbBch
         U8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lug8kDmGIiNQFt1wXY0wixe9MVcva9veOzt0rYDB5Xs=;
        b=MnKRhydBiflxEx1ipMmfoFHoQszf0YHF0rvCKfNKumCmBdnph3An2piRJDgwAvEFGv
         eAmjinojtInbgNkgOc9EseFESCGKZqvVFUtIR29uLdoO7IMWiUdGtVXVAdrgXluYOc3A
         +1+h4+z4Hs1vo55GVzYFiTR8TJQISvneoAF09Yd/frqMldNVlDjCWb7Dn51VDqCUsPbo
         ODxUJDQ7GxKvbvBO1mjcCSP0ml+zJgZVoVmlb4tTw9UinCE8AhixGuVPgfEmUy/cLBIJ
         0c10MS4bPWIyLqibUzVDHmo/wRJWM9tXAokyrQeRFZ0gUkLThyRrbrlEhnMx6ZE4ooJm
         Vvnw==
X-Gm-Message-State: AIkVDXLk0AAnTPj7/tCbbH7xqqTlz6xj3x7PiLyNkdiAJhvZeHdXjjc4/65KxAoSfIn6Bw==
X-Received: by 10.84.211.7 with SMTP id b7mr40883988pli.82.1485882535410;
        Tue, 31 Jan 2017 09:08:55 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id c18sm42586989pfj.49.2017.01.31.09.08.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 09:08:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
        <20170127100948.29408-1-cornelius.weig@tngtech.com>
        <20170127100948.29408-2-cornelius.weig@tngtech.com>
        <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
        <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net>
Date:   Tue, 31 Jan 2017 09:08:52 -0800
In-Reply-To: <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 31 Jan 2017 00:37:03 +0100")
Message-ID: <xmqqbmunrwbf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I agree the current behavior is quietly broken, which is not good.
> But I wonder if "--no-create-reflog" is really sane in the first place,
> and whether we might be better off to simply disallow it.

Thanks for a reasoned argument and a reasonable justification.  I
agree with all that.  

I think it is probably a good idea to document the behaviour
(i.e. "--no-create" single-shot from the command line is ignored).
I am not sure we should error out, though, in order to "disallow"
it---a documented silent no-op may be sufficient.
