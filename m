Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1381720C11
	for <e@80x24.org>; Mon, 27 Nov 2017 18:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbdK0SbA (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 13:31:00 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:40289 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753191AbdK0Sa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 13:30:58 -0500
Received: by mail-io0-f175.google.com with SMTP id d21so15174919ioe.7
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wb9SteYiw7zXRl6oCPABsrig6jhOtBKsdqyAeEGFpI=;
        b=C0/4PD8x5XwDNpEJACAf5sRXoeZ1Fbix1SPeDuP5pnCIu0eND39697tP2vLQzao3wP
         SRQpgsTpqGU5wFehaIAUSRtNny4Ox9+7vd4Gojd9UxM6gifeM1sqAJ6rpVMEco+mY8YU
         iJw41dO+SjVdYi+aIW0JW5XS5styuXOPoHncHKbk0VS2pCpIZ4/0sEfbhGSc0GeTXrrm
         hbhRnoBc+uZ0sLJ8h4hi4ZQSrOHpIb7GfYdpVIBdKQDfxAATnBYBZ6i+gesxZDVMRYrk
         bguWutXT67UDdyUn94BOmQDWqE1fzVmOhNu1AGO7iABlnX08wLoZwlOZH1JQ5UaH/fRY
         LXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wb9SteYiw7zXRl6oCPABsrig6jhOtBKsdqyAeEGFpI=;
        b=ceesfAlCuKEA7cVBTSuNzResciZ48l0L5CZ9PazuaPkFVI1DuQWOCy0gdQHj2q5Ma3
         R59F6+6f5m8H6Zsy2qHiBR+h7mkxgdqyQu/rr9gQ3FkKlgFY6KiycF8CFV5lpjYefmql
         poVBXMLUdvoSw8481GW96nUSQpsn+f5AJ/2bS9LcOGDqDk7HUp9y18Dpa4msdfOxN7/Z
         u5tIu100RH+NOxSLySMDjnwChi7Q/YmXRlzb+OYo7Sy8VLOyGukWnfPO8kqiY+7xAIhl
         pWHDi7+iT7nsrGvxehDspk5GRvstWgHd8qyMp4CqUrJnxxNW+VMPv3YA0HhklfIPY41o
         sjXw==
X-Gm-Message-State: AJaThX4iDQKQzRFHT0LYQ2eM4lkNe1wPldVKJFNYfrPpHCaOTJ8GyE/B
        sI+ZSuETpLHyisozrW7NkotR205qWKs=
X-Google-Smtp-Source: AGs4zMbsKfPdDpNAd/ycuvzzWmLrVRyCpyraiSgL4R+AAlIfMgTp98E16oQBWJYEAx/6nLRj3+aVFg==
X-Received: by 10.107.112.14 with SMTP id l14mr41000102ioc.185.1511807457664;
        Mon, 27 Nov 2017 10:30:57 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:cf3:7be1:dd8c:8f94])
        by smtp.gmail.com with ESMTPSA id a139sm7620255ita.24.2017.11.27.10.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 10:30:56 -0800 (PST)
Date:   Mon, 27 Nov 2017 10:30:55 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] xdiff/xpatience: support anchoring line(s)
Message-Id: <20171127103055.a10ccec6b4e2adc2c2c26c22@google.com>
In-Reply-To: <xmqqh8tlr9sp.fsf@gitster.mtv.corp.google.com>
References: <20171121221717.155301-1-jonathantanmy@google.com>
        <20171122234152.72901-1-jonathantanmy@google.com>
        <xmqqa7zdsqb6.fsf@gitster.mtv.corp.google.com>
        <xmqq3755sprp.fsf@gitster.mtv.corp.google.com>
        <xmqqh8tlr9sp.fsf@gitster.mtv.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Nov 2017 11:47:02 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Thinking about this a bit more, I do like the basic idea of the UI
> even better.  What we could do is to sell this to the end users as a
> new kind of diff algorithm choice (i.e. myers, patience, ... will
> gain a new friend) that internally happens to be implemented by
> piggybacking on patience (just like minimal is piggybacking on
> myers) and call it "anchor".  Then just like this command line
> 
>     git diff --histogram --patience
> 
> makes the last one win without complaint, it is sane that these
> command lines
> 
>     git diff --histogram --anchored=<pattern>
>     git diff --anchored=<pattern> --histogram
> 
> make the last one win without complaint, either.
> 
> Hmm?

This sounds good. There will be a bit of inconsistency in that in "git
diff --anchored=<pattern1> --anchored=<pattern2>", it is not the last
one that wins, but both of them will in fact be used. But I think that
in practice, this will be fine.

I'll send out another version with this UI (and with Stefan's test
suggestion).
