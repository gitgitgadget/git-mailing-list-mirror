Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833111F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdB0VOQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:14:16 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36241 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdB0VOP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:14:15 -0500
Received: by mail-pf0-f194.google.com with SMTP id j5so2675250pfb.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 13:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TaTOXYWMuO0nJA0ZEUEG7+o6f78lSZvMo9/FnYsv/CY=;
        b=pTWmRUvUSWk8hj+6xYRVA3xsmx8JFC5AB+CpM/Grkkd01FfVnxmAI0F0mfVzzgNVjl
         u1K+NC1iUxD3+vRCE/qP6NxVSvHGzfjvbr2RefaZxONtXuHdoKv4HQuLe/KbhlsEIv9F
         aX16nSx8TMqI2RU4HaogNC3BJgC3EGSOfJSQW9Ez1RPO7mbW5mhUACyrhYbQriBBcPpK
         /lVEhIGXH5NZFh4XBG3UNfnFkmPUjbxXpO16uToHUG2QpcWcC1NP4Q8btVFee7ROxndv
         l2e8EG2FlZLzyHJzI9+0wsrHLo2Kwhq/xrY4MsINjt1NYPOnlpqAEt1uHY1klLrKXply
         IVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TaTOXYWMuO0nJA0ZEUEG7+o6f78lSZvMo9/FnYsv/CY=;
        b=uceNFlOgmpTyKYVG5qaYiWFgq3j94/btwdKEhdXQSkkUG4TC+ysulH/5wTvY+yARez
         XqDx9iNEWnI4fcwjVuA8Cu61lnXet8RNowURQ8JYSGR3QADP+l4K4gfhr6sfR1+RjgbT
         YAaC//9zqZ3SC06r11AhTybFwOvayOdydctjec2Id9UfF/XkC/Lgf8s5Vfyl3Vfoi+AV
         PGachBwbAjOCr2a4StmqhqUMRX/ZuTICJhn6avUXGhwaNScLoaPsVgumEiYibnZpTL/Z
         eLrXHHvZ6UPedAZUrDPXlpdTF5me0HaYwadsWqsKZeFhXF8C3Q/uwnCEoKg7H6Z5+bt/
         BuEA==
X-Gm-Message-State: AMke39mOsgNtQPvGu4p8S9mbHrEiIu46JvkDgR+R1ZHwv/SNBJXonK3Umof6xClxa6Awbg==
X-Received: by 10.98.163.17 with SMTP id s17mr23026061pfe.61.1488228174803;
        Mon, 27 Feb 2017 12:42:54 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id 187sm11801691pff.17.2017.02.27.12.42.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 12:42:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, bs.x.ttp@recursor.net,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] ident: do not ignore empty config name/email
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
        <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net>
        <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
        <20170224010823.my4wmdyezjuqajfx@sigill.intra.peff.net>
        <xmqqlgsw5iu8.fsf@gitster.mtv.corp.google.com>
        <20170224041807.5g3yogfnsoqegqkl@sigill.intra.peff.net>
        <1488208102.10235.3.camel@kaarsemaker.net>
Date:   Mon, 27 Feb 2017 12:42:53 -0800
In-Reply-To: <1488208102.10235.3.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Mon, 27 Feb 2017 16:08:22 +0100")
Message-ID: <xmqq1sujwek2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On Thu, 2017-02-23 at 23:18 -0500, Jeff King wrote:
>> On Thu, Feb 23, 2017 at 08:11:11PM -0800, Junio C Hamano wrote:
>> 
>> > > So I dunno. I could really go either way on it. Feel free to drop it, or
>> > > even move it into a separate topic to be cooked longer.
>> > 
>> > If it were 5 years ago, it would have been different, but I do not
>> > think cooking it longer in 'next' would smoke out breakages in
>> > obscure scripts any longer.  Git is used by too many people who have
>> > never seen its source these days.
>> 
>> Yeah, I have noticed that, too. I wonder if it would be interesting to
>> cut "weeklies" or something of "master" or even "next" that people could
>> install with a single click.
>> 
>> Of course it's not like we have a binary installer in the first place,
>> so I guess that's a prerequisite.
>
> I provide daily[*] snapshots of git's master and next tree as packages
> for Ubuntu, Debian, Fedora and CentOS on launchpad and SuSE's
> openbuildservice. If there's sufficient interest in this (I know of
> only a few users), I can try to put more effort into this.

That sounds handy for people who do not build from the source
themselves.

Christian, perhaps rev-news can help advertising Dennis's effort to
recruit like-minded souls?
