Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990FC20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFAXTn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:19:43 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36759 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFAXTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:19:42 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so39926937pfg.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3N6+dFm3W6+NCr5J7VpHo8W4L8lKMhAAWmy2SN8nYA0=;
        b=MQpNw5wTwVoqQUtC6TO3M0hkDhiuDG7vxIeghVC+tVE0zx+yNn3ecwCd43CrU3s06b
         z7X/6hcd9g4gqAiYfy9vjXdS7NwvlcWGXKp6Iha94+zn2uDO4rM1vrBoW0vlHYUbIVrJ
         UcPwWh1EmTkMnf0euC153CuRERkbKPLoAO2zspjyS1MIdbERTUBj8f36vfaom3GV+fxY
         hKKGjmM+q6dMY06UPcaPWS0gW61YeHFEXNnVy6vKxSbmCe8pDhTfYVXGBZZ/5LOw2ztV
         t9er99Bn9MLhXwnVmeatE0oZ/KcbY15OqqAxDPfipD1MOZpFSMKbd6tg5LTPoZ1IdsrK
         ZrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3N6+dFm3W6+NCr5J7VpHo8W4L8lKMhAAWmy2SN8nYA0=;
        b=HK97eHSACBSKl0XU5fBs3PWR728ppnaR5vyIRMULGkeuZYPyB4WzrSyE6Bbr2BQOJE
         TyleuwlQ7CYirZNRL0C/4fHSb1wDMZDeUa2R89MRgmpe96nMtZKjUE877ln8rTMEu3xW
         GYoELzDygskZK/mku5waqrLiJoXlPjluXGDdpRN2O5/92fNaVfAxq8jDBKdY8HQGeX9R
         vFIN1yEbbe8PfKLe2rIHlq3Q1cH+Xr71pIZ7HkhvUWLh8WC0waJ8KYVCF1id+2IiSPFV
         2I23y0Bfh41YNnvduzeNzSfWabBcz53SVaR18HM7ZzoGMNEzptHw+3oXkYOw2X5jbCo5
         WNMw==
X-Gm-Message-State: AODbwcBqg648KRCsSe0Zk/Ko4dbSZ3pLAGkP8UfQHtyetvEjShwxe/2p
        HpUVeesUfE5z8raULJIyxQ==
X-Received: by 10.84.142.133 with SMTP id 5mr38445533plx.21.1496359181977;
        Thu, 01 Jun 2017 16:19:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id g20sm37204332pfk.21.2017.06.01.16.19.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 16:19:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <dturner@twosigma.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: preserve untracked cache, was Re: What's cooking in git.git (Jun 2017, #01; Thu, 1)
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706012052480.3610@virtualbox>
        <CAJZjrdVS5e5udjLtZoZcTEUg8WGFPuaG+MB_enPJ9poti3LktQ@mail.gmail.com>
Date:   Fri, 02 Jun 2017 08:19:40 +0900
In-Reply-To: <CAJZjrdVS5e5udjLtZoZcTEUg8WGFPuaG+MB_enPJ9poti3LktQ@mail.gmail.com>
        (Samuel Lijin's message of "Thu, 1 Jun 2017 15:16:38 -0400")
Message-ID: <xmqqfufj47oz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

>> What is holding this topic up? Anything Ben or I can do to move this
>> closer to `next` or even `master`?
>
> It's in `next` right now (3196d093d6).

Thanks for pinging and checking ;-)  

I think the topic was merged to 'next' on the 23rd of last month and
graduated to 'master' in the past few days, together with other
topics.
