Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929031FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 15:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdFVPdT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 11:33:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34471 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdFVPdS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 11:33:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id d5so3490872pfe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SosCmzMOAzq3sQNqHaBOKPaBBSb5+KEm9//w5DzZuIM=;
        b=OurBdzs9X4cjB7XeS+PMSLWQt1ZjkDSaB3DDWuM1gnzMB+Pnmnm7ihJfnYPSuoeawU
         3I8nJ2eemM69ITM2kSx8oKP0tbQ/aHHI/rzR6IRWhDw2NV0WZnNGzBJ8fHHXPqt88V2T
         m04U9nXgyAezqH0WDZWpEz+NAbpDjOd9DdUdtdeLULMaxCQYt8ALoU65+86smJJVDZyx
         6IJGP2mSpfsbEcR6isJ9p6J7COqMl8xg+/cgvJK97goAskIR9BtEsuGM1aXOqO6r1dzl
         LyvTMSoBx4F7rW5CxZ6c7cvxYlWTGnjzsH5JMfCoWYUJjgiQDIZzIJXcVwIdy/avzF/h
         Upsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SosCmzMOAzq3sQNqHaBOKPaBBSb5+KEm9//w5DzZuIM=;
        b=os8BxJabWRxKuoHGieooLHMEl/UG2adLuDUj+lmBveDAgyx+PayZUWN3Dsr1qYq3sF
         RL2wFIq1USPpTZmOD3Lk7SnVGYRFSH01TQ10KiMjksK5iwGAqe88n2e01QFBrOeadQVL
         +J4JUBIvuNRavvPIoOYmOOZqkMfqH1k2VfWgciU8VefJPUeTO1Yo3vtbihqxL0kvZfMF
         qFBDDBCsnKZrtkrY7girBpAX3Ht0eDNCU1Vkz2InjyqHxQbaL2kZJ3vQQWWVYSCa7cX/
         nmawJiYMwEJqwNJenNRt5YkApI3OCWSZQWAhknOqJ07Ol6gUfb+Zu2GOZ4ZuuwhC8TQT
         gyWg==
X-Gm-Message-State: AKS2vOw1Z50C6NP+tVuw6W2QKjEgjwasuv/37HbQK+P0swm8SfBrFjF+
        ldUOYrdtWjOo2g==
X-Received: by 10.84.216.71 with SMTP id f7mr3601025plj.266.1498145597846;
        Thu, 22 Jun 2017 08:33:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id q68sm5263398pfj.40.2017.06.22.08.33.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 08:33:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/28] Create a reference backend for packed refs
References: <cover.1497534157.git.mhagger@alum.mit.edu>
        <xmqqzid3stdw.fsf@gitster.mtv.corp.google.com>
        <xmqqvanrsru4.fsf@gitster.mtv.corp.google.com>
        <20170619194315.tzdmo7xel2dztoju@sigill.intra.peff.net>
        <20170619195330.fhjlfiqmcwhgttaa@sigill.intra.peff.net>
        <05ea33a0-adde-54df-07e8-bdfba9c7d503@alum.mit.edu>
Date:   Thu, 22 Jun 2017 08:33:15 -0700
In-Reply-To: <05ea33a0-adde-54df-07e8-bdfba9c7d503@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 22 Jun 2017 09:36:20 +0200")
Message-ID: <xmqqwp84kpfo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I have prepared a re-roll of the patch series, but I can't submit it
> until I have Junio's signoff on the test that he suggested [1]. Junio?

Sure, and thanks.
