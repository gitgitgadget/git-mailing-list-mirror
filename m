Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2CA2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdKUXWD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:22:03 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:44467 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdKUXWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:22:02 -0500
Received: by mail-io0-f174.google.com with SMTP id w127so21269919iow.11
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iX6YNuTolEmfE563waYPm3B2QOg+HARqVGDjoILzvKU=;
        b=gipovVlU9hE2Cszu7ELnMUy8c+S5/0q/XSOGrqEtLN0jUCktQk4tji+cvh5re0uizA
         4+1DFoMyVjlp5bIq+8QUht15BF+yy4Ck1lhJkqlkvnBlh/tU5olYG1P7+chzuhduCO6y
         /rTZ3ghWaiU60o0NH+XrhaEQTRg6mSZMycyEMOH/ILL+xmWEZcTE5TazppLbVtIIhCzj
         G/vvoestKVb81q3XLf/zP/2flqLPkloTbIC6F/OSTiJ39FuLep7S1BVEMPh0oyd7g9TT
         7jlNmNENcvQHb9ZfEK+K0FhapghRU86JCASyHQO2bKZJwg+x/SYSepn1pMvrZ0f/3JmS
         TC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iX6YNuTolEmfE563waYPm3B2QOg+HARqVGDjoILzvKU=;
        b=rs3/QkzEo6Zzm75+CFFvwsPQoHrQRHtl8mvQq6qOABQNW56wyk09SZuxPrqbiXHXZm
         QHRjt9LnF/pRdZ1JnNcpnFqhX7QfRGen0InhVqUZGpykvuM7OH3O4S6OB/iSOpFzbPa4
         hEwb/RtTKVtSi6AvvvUwn4g+AlWtuFTMOIncbO2k5VEw7Rc75fgoQQ40qrPNEBsOGOiG
         sEMHgTxsOJqT8DgtcefzZYXTBLye24CpSH09SU8a44L//STkr/6o2RNXHWmcZ5srBq78
         c2ZsbyPotBYhso8QoHuUfHnUyThBrpNUPwFxO+eUTThiIHan9MSuRuiCPrW6Pk86wfsQ
         7SYA==
X-Gm-Message-State: AJaThX5ggqX2u1g6ENf1UhNRSti9ZcDgOlBMEBJOFceaR1AOR054gKXg
        A9ry5zxKOKlgMOfU6MvmU1g=
X-Google-Smtp-Source: AGs4zMZzTFIqnH2DC0hLTX+xbobXNgJejibg/KqrgYSiWffQhrlPw2q6ZG8sXqbH+efWPhdxvnQV8A==
X-Received: by 10.107.47.234 with SMTP id v103mr11812725iov.96.1511306522287;
        Tue, 21 Nov 2017 15:22:02 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q88sm5847016ioi.78.2017.11.21.15.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 15:22:01 -0800 (PST)
Date:   Tue, 21 Nov 2017 15:22:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: stash: learn to parse -m/--message like commit does
Message-ID: <20171121232200.GL3429@aiede.mtv.corp.google.com>
References: <CABURp0qadq2cAwR_Nk76J8RqpQk4DZwtnu6aS5hR=LjVD-dGgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABURp0qadq2cAwR_Nk76J8RqpQk4DZwtnu6aS5hR=LjVD-dGgA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Phil Hord wrote:

> `git stash push -m foo` uses "foo" as the message for the stash. But
> `git stash push -m"foo"` does not parse successfully.  Similarly
> `git stash push --message="My stash message"` also fails.  Nothing
> in the documentation suggests this syntax should work,

"git help cli" says it should work.  Thanks for working on it.

>                                                        but it does
> work for `git commit`, and my fingers have learned this pattern long
> ago.
