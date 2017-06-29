Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8EE820281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbdF2SLM (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:11:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34760 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753188AbdF2SLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:11:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so12769311pge.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0ZzVreSs1KBVcPBDZatQwfKPej50CZd9P7LW+1apxSE=;
        b=PJdDN5zDmwRY8n1wtxf6rnOkjF4Xd7UBwVDJKI4ABIZr5dZiWJeIAsCu3oKNUD510o
         ltZ3EpCbpiDMQqGWKih1ObuP/KRtBDkSCzA9an9VQcetpjdZbY6x8EXecuRNEMlF/iOH
         An5PzV+m6Ic22hXxGi1jy40Ein/O006djOcq3G5mnUn8kfMUWz1Asu0vwDmmeKCFiiKm
         Y2PLu6DVRRwY2GQlCZMKTlONRZy5uGyFZ6mH/7Or9NORGJis78C1i9L3svO37XdTy/QQ
         DJVqPNFn8gWtQrqC3IjSow992hYAMZWxqj59YsPcGVAhSfn9jYlFWzENIKr5BA6MEUWi
         UJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0ZzVreSs1KBVcPBDZatQwfKPej50CZd9P7LW+1apxSE=;
        b=tLJ1b4kfLFqfRSnrMrf2p18qFhY88qr0mN2S0YLKNvcM2NexcOYmllyes7vgXQhTAQ
         dfHoMv1C2KwPWEjMvSn86S0tKpH7TVtiDChXkZmY1CohNB9+Wz6jYV8Hdo+cC/U/tJHg
         DDIAdRyokXR7tRBocHNzX3yzZ2Xgvb6k2wBVSjpcz2l+oqXCkBn/TQ23WCk+z1NNmfqU
         8NW0LgYFMJfphOgziivm1zXtjC1eJKTMMA6EA/A68paDkzT3lsIN6OmGZYrWN1o7ZClm
         U7dDekDk0ibSCc4uDjuyygm4ZCqwwn9qt2ZHF1eWYp5sh3Av1v6aPC7do6csopCifzzI
         iFYQ==
X-Gm-Message-State: AKS2vOyf/zX/rwufITqDLeKNbZEHDk+ppYNoJGjwvd+VyrHIFnYUIM5q
        LPrkcd+0bzSiwg==
X-Received: by 10.99.47.66 with SMTP id v63mr14848650pgv.207.1498759867196;
        Thu, 29 Jun 2017 11:11:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9846:b2e3:b31e:8976])
        by smtp.gmail.com with ESMTPSA id x3sm16861149pgx.29.2017.06.29.11.11.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:11:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] hashmap.h: compare function has access to a data field
References: <20170629011334.11173-1-sbeller@google.com>
        <20170629011334.11173-2-sbeller@google.com>
        <xmqqvaneu0qy.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Jun 2017 11:11:05 -0700
In-Reply-To: <xmqqvaneu0qy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 29 Jun 2017 11:06:45 -0700")
Message-ID: <xmqqr2y2u0jq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I haven't looked at the use of keydata in patch-ids.c and friends to
> decide if that "abuse" claim is correct; if it were the case, should
> we expect that a follow-up patch to clean up the existing mess by
> using the new mechanism?  Or does fixing the "abuse" take another
> mechanism that is different from this one?

I see that you corrected patch-ids.c "while at it".  That may make
it harder to revert only that "while at it", I suspect.

Thanks.
