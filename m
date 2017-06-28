Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350142023D
	for <e@80x24.org>; Wed, 28 Jun 2017 23:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdF1XPz (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 19:15:55 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34679 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdF1XPy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 19:15:54 -0400
Received: by mail-pg0-f43.google.com with SMTP id t186so38826829pgb.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FkNj1zPPxNvTJ3Co/+N9tsR+LpdtVsXqPF+AZwp1YKQ=;
        b=DsklSx7pLOEbXm3HOR3YANk59iPYUkZekftVfZR4yVy/ndt42Q0ILno1DWSAmlnxez
         +VqxorI1Rwg52P90lTF4oXimIFg/lSpunzKIXuiLqoKsICkj8CraDNjT3yRsF2ngiKWf
         576D2z8nNB/NYdlxC7w4yc9H1lwe5BMUlwD4u0UrFZfHPBV/IF6B/cEOPMKw78KfPx4r
         ZYbvWIB8GaW8oTEwCMSWiRNFS/XTm90Annj2dxYMWziiaNLIF6Tl3U7PsXyu3FdYN0AY
         3FcfdfrflN42VTeLJh/3qwjLrGM8yvq4REwRFXeYfd80hEEYr/1wMnN9C0IeN/7OaIZ4
         E5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FkNj1zPPxNvTJ3Co/+N9tsR+LpdtVsXqPF+AZwp1YKQ=;
        b=h/TLFPR3UVTEZSBz16J6rNNap7x65do8kZARm//RzameziSHU98UXapNHXzM+Ff5F8
         BqHUHCssdQTb1+J5GuotnnvUD127GKKuof7qKy/r3MqPN1N9raMZDXWChFHXIcgx54qz
         vmMY0o2MpLkVQ9xNzWKm1AlmlCBSTvXVXJgCQkzYLb87OOfPK0JmxJLiGpscSHR9usk+
         Vzisy3dWtuvaLzb1OJwsBhAgdpBHkCcaQZlkZIRVooHJCN6vXoQ5Nwv8SoIGzpkmwsBs
         t2s+qCOeqRMebSDXPMPGUH81oIjfvRM18vcuuzpBtf2sM6ud2pKPvVzBdK+N5kb1OSst
         Qrgw==
X-Gm-Message-State: AKS2vOxGMq5pCrPJT6a1zO4nWcb7cSPYT+53lEB3sdfzyr9PW6hVldvb
        mj1o/9iBoqFPQw==
X-Received: by 10.84.198.129 with SMTP id p1mr14488241pld.120.1498691748295;
        Wed, 28 Jun 2017 16:15:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id 68sm204606pfi.69.2017.06.28.16.15.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 16:15:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
References: <20170615231549.20085-1-avarab@gmail.com>
        <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
        <20170615231549.20085-5-avarab@gmail.com>
        <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
        <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de>
        <87injfkd0j.fsf@gmail.com>
        <433f9fb7-a202-1091-46de-04535b2a49e1@web.de>
        <87efu3kaog.fsf@gmail.com>
Date:   Wed, 28 Jun 2017 16:15:46 -0700
In-Reply-To: <87efu3kaog.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Thu, 29 Jun 2017 00:30:07 +0200")
Message-ID: <xmqq8tkbvh3x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I get exactly the same thing as you do below when following these
> steps. So it seems your patch in
> 2122b01f-7627-cd1b-c7df-751c076f90ff@web.de is just fine as-is and I
> just screwed something up when testing this.
>
> Sorry about the noise. Since this works your original patch is obviously
> preferrable since it's not duplicating the rule.

OK.  Unfortunately I screwed up and merged the revert already to
'next'.  So I'll queue René's original again to 'next' and we'll
only have one rule at the end.

Thanks, both.
