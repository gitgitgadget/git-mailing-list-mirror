Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA711FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbcLFWYU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:24:20 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33234 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbcLFWYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:24:19 -0500
Received: by mail-pg0-f43.google.com with SMTP id 3so153846994pgd.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OF2c55L7KsuDeMjSaMCtrhCJ0thXZ1Tk6IiuWEsTW3o=;
        b=P556+hpA1YhoGeHf/LilRSqtQL/8j2cKU2dOHFFq+2tRt/os+esi6UZ2kc8xLKCjhC
         LhvVgRfEuFVgX0ieqE9yLzLb20Xotuv+vtIb/bX/DkoLHXpomQ34FKKIbHYR/qDhSf/q
         q4E0u+Q6xXamlPTWm3/XgbxvUQlm1TDZksj6xmCiZt4P2pWuW3JqNcQsiW6bVFzH7GcT
         sSS9LztVcyoEfDOZtrJi31fu8s3azamrsbfEgRIHC8IBLmsTo7lD9eIwRG19Ii6Q35Om
         i+ZnGCfI3K8v8rYHoRhjL1JPfm7R9iMSa/UISADT66ZjblSo0t6y5RqZWLExUv2JSvQa
         Vn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OF2c55L7KsuDeMjSaMCtrhCJ0thXZ1Tk6IiuWEsTW3o=;
        b=gGAizl2LBnABnvqaaf3xSZQxmQvcd7ZlLibzMantyqLHrbMnYAVgGHUE0B70qAQTuy
         pMpNc9QXZkoDU3D7MQH8QJK9mnLGYG64uhI6lgBzGA0yjsMAdV4p+6EBERZkCaYdoq5b
         goqz7nEdxcFGeCKZ0QwNfu+zqsdVKNC3CssT4LklMB4JMEnYRyayow0c6KDjjkGbhZ4R
         4Nzr35figljw6HM/XP/DJ7AfggBlb22DEfyVTztL5tZIdnSpkSh/kpi17zPg/JgnBuJk
         juw5CWn6rc09Q9cLcd3tHY5erFcIVXCZHUWWpcxL3yseUsrbBrq7BsOoIrHVr5q8tNHS
         Qd4Q==
X-Gm-Message-State: AKaTC00rxLf2icolz0wArOab1d+euDIYkIpBjkHcXnh1sRg5CzVm2xYohLjftr7PnHxLyse0
X-Received: by 10.98.130.1 with SMTP id w1mr64726761pfd.35.1481063058533;
        Tue, 06 Dec 2016 14:24:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e0c5:1a05:7bf2:5496])
        by smtp.gmail.com with ESMTPSA id 186sm37065332pfv.61.2016.12.06.14.24.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 14:24:17 -0800 (PST)
Date:   Tue, 6 Dec 2016 14:24:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161206222416.GB103573@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
 <20161201235856.GL54082@google.com>
 <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
 <20161206135113.i7nlr45vg7uzgfcn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206135113.i7nlr45vg7uzgfcn@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Jeff King wrote:
> On Mon, Dec 05, 2016 at 12:04:52PM -0800, Junio C Hamano wrote:
> 
> > > I'm sending out another reroll of this series so that in Jeff's he can
> > > just call 'get_curl_allowed_protocols(-1)' for the non-redirection curl
> > > option, which should make this test stop barfing.
> > 
> > I was hoping to eventually merge Peff's series to older maintenance
> > tracks.  How bad would it be if we rebased the v8 of this series
> > together with Peff's series to say v2.9 (or even older if it does
> > not look too bad)?
> 
> My series actually fixes existing security problems, so I'd consider it
> a bug-fix. I _think_ Brandon's series is purely about allowing more
> expressiveness in the whitelist policy, and so could be considered more
> of a feature.

Yes this was really the main intent on my series.

> So one option is to apply my series for older 'maint', and then just
> rebase Brandon's on top of that for 'master'.
> 
> I don't know if that makes things any easier. I feel funny saying "no,
> no, mine preempts yours because it is more maint-worthy", but I think
> that order does make sense.
> 
> I think it would be OK to put Brandon's on maint, too, though. It is a
> refactor of an existing security feature to make it more featureful, but
> the way it is implemented could not cause security regressions unless
> you use the new feature (IOW, we still respect the whitelist environment
> exactly as before).

Either way let me know if there is something I need to do.

-- 
Brandon Williams
