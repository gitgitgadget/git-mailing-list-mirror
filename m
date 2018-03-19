Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AAF11FAE2
	for <e@80x24.org>; Mon, 19 Mar 2018 19:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965981AbeCSTYQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:24:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40892 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934989AbeCSTYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:24:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id z8so10076785wrh.7
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6tTjIW2/SQntO5GRLjCHuXuo+gvDsCkhAlEwNeZMdR4=;
        b=tAUVhuoahWlKOdf/u/nUUiat6hkjdJz8aN5C7mY8o3TIAB+M9k3SRR2EXiVhwkViUh
         +ZL/DfRq+SnfXZiZtTOJS178t6rcy5K95dMvkjvUuKp94bVqcFVudRSyx7Ft/Vj3OJ1s
         M3PnpEyP7GpQ2tlI1Ey2fSbY1ZIpVk9lBC0whksOtMogVQvWlEjCF+M+KI3ddQM7BIQF
         vJmR/ZnYQP4hw+qe82R4k9AJVVaii/LFkq8OvsgOkWj2T6jjF4H9kTztC7K6S9idIRsn
         olb92HBcv3CJf7WZchPIONvVolWyTAIbl0+Lo4r7OVfOTUOqloWzvbpzlGwfNrfyn9Lt
         RCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6tTjIW2/SQntO5GRLjCHuXuo+gvDsCkhAlEwNeZMdR4=;
        b=j+yG7Bb1z3ZV8UhrPwPGgEwEmivugwTrynMvDeI4bppuwnjijdnHyeKlitnwUJjh88
         ksVvyXZZGM0j015ACYctMGuTJcelHDego46pl+13Eq4AnlaTkmZdZl8IV3Vx+6ZvMTTw
         IczQ8pEHtFMYC8aRR953ibPCr+3bydydopS84gDuhI4nYxTtUTXTJLLZea/+4VZAtYoY
         nS8i4gbXBxpvtZ0PTW9xi4i+KmaxfwDZY8bpMp+r+3awxA5JsvLWZUOvvzNKPCzFZUX1
         W1v5zdoSBp08VxJkg56WjczPqcPnFt3XjiOCKCFWMF5M7YWrl1mI/DgrcelvmpLjFeh4
         vJyg==
X-Gm-Message-State: AElRT7E7C31Qk4ny5o+xuK1tJf/EZ53wbPmCGgSwCKWBOSKprWBuld8K
        tYFavsB+d1G2la8VdvnX9F8=
X-Google-Smtp-Source: AG47ELsZIzGSRCSxNISg70m+OcOzFUqk42D99i/6INi3ep8991sfroRr3jFMN5GVDDbYM/ViBXynXA==
X-Received: by 10.223.136.217 with SMTP id g25mr11072722wrg.203.1521487451238;
        Mon, 19 Mar 2018 12:24:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l10sm882764wrf.37.2018.03.19.12.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:24:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ref-filter: add return value && strbuf to handlers
References: <010201623e594401-906aa5ca-545b-405a-810a-607491fe09a7-000000@eu-west-1.amazonses.com>
        <010201623e59448f-2db7a920-fe77-481a-b105-de6bbff253eb-000000@eu-west-1.amazonses.com>
Date:   Mon, 19 Mar 2018 12:24:09 -0700
In-Reply-To: <010201623e59448f-2db7a920-fe77-481a-b105-de6bbff253eb-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Mon, 19 Mar 2018 13:01:00 +0000")
Message-ID: <xmqqbmfjvpgm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Continue removing any printing from ref-filter formatting logic,
> so that it could be more general.

"more general" sounds overly broad.  Is this to avoid calling die()
so that the caller can decide what error messages it wants to give,
abort operation or not, etc.?  From a quick scan of the patch, I
have a feeling that "any printing" is not the problem you are
solving (calling die() is).

> Change the signature of handlers by adding return value
> and strbuf parameter for errors.

Could you explain what the "return value" means?  We can see from
the patch that the function signature is being changed by the patch.
What needs human explanation is why and what the values mean,
e.g. "to allow the caller to notice an error, the function returns 0
upon success and non-0 upon failure, and an error message is
appended to the strbuf *err" (don't pay too much attention to "0" or
"non-0" in this example, as I do not know what you chose to assign
the return values to signal what to the callers; this is merely to
illustrate the degree of details I would expect).

Thanks.
