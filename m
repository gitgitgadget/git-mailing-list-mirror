Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E821FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbdBPStK (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:49:10 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36190 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbdBPStJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:49:09 -0500
Received: by mail-pg0-f68.google.com with SMTP id 13so1723826pgd.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YHAyhWo/tS1GSLmDDsq/gUdPVJL8F+Gw4qIWpbtWVxY=;
        b=eqMwJVUlbXulLR+j21AQRdH9/N3JW/TFx1ZnnPz8zRTTThMwd6f9z38wOsbzudjoa1
         poBS/knXixpdm2Rt95gRcXigf4YP/nC3j7p9JYkfy2dBBaMi0uMzAbslkLnsZnTar0yq
         PCdahgiUaNNrJKZvy6hHVMdDXR0YJvgzK4stS7atOHDpN6fmU9ZEPAH3NwTFP8Cn37rk
         50luz0ON9NSz/JbPcHgkQRnjCy2SpC+mC8oRNfEg4p8DrozoG7K1SXntjuhWy9ZCzgT0
         QFpV3KmUE+UhkuC890l+miL/N6/disw0gv7zFDv86DQE6aUdpDwhLEV/4KjnpXA5S4R1
         ju8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YHAyhWo/tS1GSLmDDsq/gUdPVJL8F+Gw4qIWpbtWVxY=;
        b=pRI8V9M/xnMp79K1RvDbd7+HwQXQYdh7Fz9Ee28Tze74FZ0DILl1mGnq+Qo8LpCvTh
         6wIAzuip45Udls7eCMDNko4i0/j3Lt0R4evvrGMDqrIhbhJbwNlUWmDQSEc6VQw/1ZxS
         SAw1asmESDG//cA2A04fE+loeLZidWaKH6fnErFz1Z4aFCXSyPItOQMcVHAuaL1vkdKv
         VMh9ywBFcmrAQzBPNY8Pj4TsBE3gBIH/AZIuSw6M3eB6q58NQnDhsXtLqq2m67T5Q/+p
         B5oy5skoYU9jcfWEmUVtjGjwRjX6fbutadT1GhRY2CpyrEkT4v5HZPEq3ZIzs6hKbCQ4
         XXTw==
X-Gm-Message-State: AMke39lsK1y5zMcFuz63w774TT8gOLFBasTGtABYSC2cW+4gNSpwJnpls4a0KC9bznkILA==
X-Received: by 10.84.176.137 with SMTP id v9mr5163042plb.59.1487270948854;
        Thu, 16 Feb 2017 10:49:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id h68sm14943968pfj.124.2017.02.16.10.49.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 10:49:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <c609866a-f1b9-6fe5-f97a-d2180c290983@google.com>
Date:   Thu, 16 Feb 2017 10:49:07 -0800
In-Reply-To: <c609866a-f1b9-6fe5-f97a-d2180c290983@google.com> (Jonathan Tan's
        message of "Wed, 15 Feb 2017 15:33:05 -0800")
Message-ID: <xmqqpoiix97g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 02/15/2017 03:11 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> Perhaps something like this?
>
> This looks good. I was hoping to unify the processing logic between
> this CLI parsing and the usual stream parsing, but this approach is
> probably simpler.

I looked at the stream parsing before I wrote the patch for the same
reason, and I agree that the stream parsing of course does not get a
single variable name at one place [*1*], so there is nothing that
can be shared.

[Footnote]

*1* Instead "[<section> "<subsection>"] <var> = <val>" is split and
    each piece is assembled into section.subsection.var with its own
    downcasing.

