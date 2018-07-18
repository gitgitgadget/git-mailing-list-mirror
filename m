Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CECA208E9
	for <e@80x24.org>; Wed, 18 Jul 2018 21:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeGRWg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 18:36:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36224 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeGRWg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 18:36:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so4336082wmc.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vu4P0V4cLT7xNpFMzWWG4M6xmjD41CSCdoHhXThpqh4=;
        b=Lf6UqT5+MqoOAHGIsF7g5V5ddk+RFARutI+RwWKXV8WhvezPpJCsZR1JkwbMaQ5tBK
         3jLxndBTTuW5kxVCR9mkY76euRm07t8G3wnHWrpxGOvjVbXtyUhU5opzu7Z2gbLek7DF
         D0FkzvoNFsa9XrjjaFa5WmQQBVydJCMB8ATPtjq2/YQLWGrtnmfWOQPkPyVZqbkQfBDF
         o7f+i90y12lxfVqbLACFxnMJX20dYlijUDeXMr6yS06wcHFmz+2wKuqFHH5CX2avpFEd
         8/jmVSN++CiQfmMtmlAUISTgk+OwlZJ8r8j7EnNY3E7xjVm7DmS7NWRH0z3+X0gzNJzk
         I/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vu4P0V4cLT7xNpFMzWWG4M6xmjD41CSCdoHhXThpqh4=;
        b=VSjs8A2JiKE69Yby9l+jQoQ5MUXG3/CfpY110WNsV4y9gPjANB00rBMaWYx7kL4Q0Q
         aG8IXldoGpNj+oIHCVOEMhka8Go35GdtgrmB1+6rgxEdIrdJ19WlHN0PPdnGB8JVHIFw
         w1BMLktHpoZlQxaUo9Tb/rx/qPzrhKwKPUbuzD/2kjToXJr6Uf7cIKWpqhoeo269cVSl
         b3ayqDiKEwLm4dBab8G3RcJih3jrnTvgz5av4IIRejia7o7YRlSX6puSP+rpzMDbxtWv
         WaigUzMRmMk009TcYrl1yIJg17l7ToYSwfT99FDxHZ7DtOPsmPfWn6bmqHHcEQcVV7MZ
         Hdzw==
X-Gm-Message-State: AOUpUlFTQcclV2XvAr1eaSWI0x55gQRIrixGc9n1YaMw6OiGnOXrcEvD
        1SwqfiUPh8Sl/YhxjDhDKM4=
X-Google-Smtp-Source: AAOMgpeDmQw4LF6cF1nG8M8HrOnRMOGSsOQ5HHUyIM5Sq7tNMk0z3xjRkygdclBa1g2M6a05aBen2A==
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr2498381wmb.118.1531951021625;
        Wed, 18 Jul 2018 14:57:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4-v6sm12774011wrv.71.2018.07.18.14.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 14:57:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
References: <20180717002654.120375-1-sbeller@google.com>
        <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
        <CAPig+cRx5-2TYOm_8oayFfbKGpmTJf=M0cNR3L5UJGGC6vHPDQ@mail.gmail.com>
        <CAGZ79kYCDR=m0C1Vmh5U2tsj5bTTpGUo1mKe0BMDKmO5riBLLw@mail.gmail.com>
        <CAPig+cT9zCcNxn1+DPMQWqJ-hfxb7gE7rKyfbqHjTC+FDNY_mw@mail.gmail.com>
Date:   Wed, 18 Jul 2018 14:57:00 -0700
In-Reply-To: <CAPig+cT9zCcNxn1+DPMQWqJ-hfxb7gE7rKyfbqHjTC+FDNY_mw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 18 Jul 2018 15:55:38 -0400")
Message-ID: <xmqqy3e8i4wj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I did consider placing the range-diff before the diffstat, however,
> what convinced me to position range-diff last was that the diffstat is
> usually short and easy to skip over both visually and via scrolling,
> whereas the range-diff often is long and noisy, thus more difficult to
> skip for someone more interested in the diffstat.

I find that quite sensible, from a reader's point of view.

