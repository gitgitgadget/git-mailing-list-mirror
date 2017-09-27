Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277B3202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 06:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdI0G6B (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:58:01 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:53201 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdI0G6A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:58:00 -0400
Received: by mail-pf0-f179.google.com with SMTP id p87so6793780pfj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3wulENTXLe3ao2U9lEmFlGK5IaW/1tzgwHmVp74XlLU=;
        b=Gtcr2SaR9uLIM2CB1eKryR4OQBecNiNChW/HPKJ385/fyfRFGzTzqdhDgZ56pDypmi
         vTMoPrCDHjP17hf4zCuG1A48IiYnnZv8WBfWVW40dfjmJZTGJ57AwMccH2Xn+Heb2ipt
         Vh61BI1feD74gZGZG6lk2N0OL2wpIgChtFNC8HidVHo1gx6PdtmpJArr/pG0Mpwyv0GA
         XI0q1cuiiO+R83aN+T5ZfOmO6gc0elAJ4X+blSYUCfBIFyyn4bqYh6CzjUcELfmb3MgC
         /hAldW50eKo8Z8xm0bSEXtLGUM7uCIQyeHEFUw8eulcXy36Yd/osfrPHqR3+F2jTS0zX
         ixcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3wulENTXLe3ao2U9lEmFlGK5IaW/1tzgwHmVp74XlLU=;
        b=cQXz0zLYnancVpAwOJI9dDM0y/qJGCRG/vjxmeyk8kol+bbbsf+l35s5WULD4NFnRk
         e+G9JGxv8oabwCF91Ha+e/B9LZ/uD/vjG7qrGWbGm2bkWzi4sRBS6nB/Y2QPACDnskfr
         fzBHmuH0Lrvwte+jE6tErJVA143scFCC3Dldceik/+398olzQXxhNRqs+iccQm4BPpxE
         baaTugZRO0x7voCwa/vefiHUaY21Z+9jcNaY8inj0C+nRwFmpp/BRkr1quj0Y3fOqvj5
         8Pv4TuCJIQy1hdgGEzLptdDNipdqUKWpDTdlJm6feuPKHgotMQZYK8ocx22cL43VuvX3
         KA1w==
X-Gm-Message-State: AHPjjUjHKoXaAYHEZ3XtCZtCq0o8yTyS0DVA70hzKWplGiWyHrbaTzlw
        xH+YnJ5M5uu88Flm7S8QOLA=
X-Google-Smtp-Source: AOwi7QA/PjoUxBkYsEGqdiU6Ix42YIFkZgjaowXC/KFJx0bIN+hVvOIR+tm1GjVfeV/kzkaHdAPNlg==
X-Received: by 10.98.211.193 with SMTP id z62mr442982pfk.118.1506495479478;
        Tue, 26 Sep 2017 23:57:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id b66sm19431390pfe.165.2017.09.26.23.57.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 23:57:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/7] read/write_in_full leftovers
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
        <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Date:   Wed, 27 Sep 2017 15:57:57 +0900
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 27 Sep 2017 01:54:24 -0400")
Message-ID: <xmqqy3p04oi2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I dropped the "read_in_full() should set errno on short reads" idea (3/7
> in the earlier series). It really is the caller's fault for looking at
> errno when they know there hasn't been an error in the first place. We
> should just bite the bullet and have the callers do the right thing.
>
> I also dropped the "xread_in_full" helper (7/7 earlier). The lego
> sentences it created just weren't worth the hassle. Instead, I've fixed
> all of the relevant callers to provide good error messages for both
> cases. It's a few more lines of code, and it's probably rare for users
> to see these in the first place. But it doesn't hurt too much to be
> thorough, and I think it's good to model correct error handling. This is
> in patches 4 and 5 below.

Thanks for being thorough.  My comment on 3/7 might be taken as
contradicting with how 5/7 ties the loose ends up, but I do not care
too deeply either way.

Will queue.
