Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520A51FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbdFMRdL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:33:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35222 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbdFMRdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:33:10 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so19998377pgc.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hQcDSmRtEBgqibhYTEm5h3sIFJT2Xl7R827OZfjerfg=;
        b=S+oh85RoLq32MEQAJsp3M4p7117alWB5teT9ENYWkHE4uC4hgyPckrtSWHv13CySt2
         THlzeNN52EqPjX9dhCy/pIKeVCNawiDtaavkN/J0iUOmaaTvuhvZ1fTFYkTpPc8UBYYA
         F060avHDt/98u5dw1dzSzpwRk8/Wisys4Xf/XQXscbxL0kvQG/IgCP+GrjylSGuv+Bgh
         qFAEiVfFuBi0mfsasMbJ7n3fYGQIlLeQta38uAxX0tDnh1F7SaEi3fRa+Pi0t4zC15zm
         2t5YctZctPTqJmZs4we8vcO8GSy52rNxjNioSw6dCl8M43+5pu36x25wYMubn1WXZnaT
         +eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hQcDSmRtEBgqibhYTEm5h3sIFJT2Xl7R827OZfjerfg=;
        b=BkEZf5pZWqTTbahqm13+Ft0rvJreFuwNmLSE4QyInRztBNCOa9PPihMbeVnCls8qL4
         R1MgmCmV11tlQ0RCUX4LD5nuw0dzoqN1BSJOhjmq6+vSk3p+O5Tmwplvp8ZrtFBjOfls
         FkEYfEEfJ9VZlILGeaCYwQGbrzQrzUU2fyqcZAbDc5m2XKq6tendE0rkntb1tMVy9zb6
         D+sUDKKeXhcPEOERXonOmIELiTaLf8QB0atkktdE/mW2vwqEB1wf5DmFBLhaRiKVhQ0Y
         ZhoulvtReHz0NQsBfRe8vUnP3p02B15Sze9KFx22JB4mXshIYAHUKZQPgSFaL82x1OYA
         LeBg==
X-Gm-Message-State: AKS2vOy2WtRVXZAB1NpddvaPJ2fX4DNHAYj12PFGRoYLRTqXYyM5nrm3
        gL1rts3qqbP0/w==
X-Received: by 10.99.103.70 with SMTP id b67mr714763pgc.96.1497375189648;
        Tue, 13 Jun 2017 10:33:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id v186sm24627388pgd.9.2017.06.13.10.33.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:33:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
References: <20170613023151.9688-1-sbeller@google.com>
        <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
        <xmqqa85b9626.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
        <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kafV5aXd9SAOHHGOgsAdpuY=YV6yWoWSsuG9rncLYhphA@mail.gmail.com>
Date:   Tue, 13 Jun 2017 10:33:08 -0700
In-Reply-To: <CAGZ79kafV5aXd9SAOHHGOgsAdpuY=YV6yWoWSsuG9rncLYhphA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Jun 2017 10:30:22 -0700")
Message-ID: <xmqqbmpr7pyj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> But you do not want to (yet)? The goal is not to tell you where the bounds
> are, but the goal is to point out that extra care is required for review of
> these particular 3 lines.

And when you _can_ help users in that "extra care" by pointing out
where the boundary is, what is the justification for hiding that
information?
