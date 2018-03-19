Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53F41F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969870AbeCSTl5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:41:57 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39738 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969799AbeCSTls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:41:48 -0400
Received: by mail-wr0-f179.google.com with SMTP id c24so8018051wrc.6
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FyP2T/tXAutkQY20hmpUfjEFECnf9F8yWlmTuuEXCJc=;
        b=Ss9b628OsoFMcnTsimSiRCUuCfsLcf9n+ACYs8IJ18zy/OGET6Ynu7NjmPvr7flhak
         h7SakfyUEbuGI9Z8YZyJWPqA3vzmE7kwhY8F/Zq6jp8yA1OHKEb18Hi59kaOGk+abGRX
         pWW63+1WhscCS8wNfGeCSNPcUf61zTuRq37JKB/O56Gr4CL1qZ4oa7twiiU/VpLJfbuf
         IjVUKrFtRBW/nS7ROL/SRDsGwPqReZAefj4AYDhFQO8BZqeLF7Z+o+T0qnT7x/aOkbxq
         lBzcKWSmmE9mI3mVrHk2cypKKxhG8kMx7KHNAAOr4KV2oxED+BQQD3Wv6SQvL2UjjaK0
         SLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FyP2T/tXAutkQY20hmpUfjEFECnf9F8yWlmTuuEXCJc=;
        b=JGBp175qXPIi5MDcD8lm9PHtCh8QaY6VLpEClSyqlUlyN/fFPNHgxO8C7strD+/nZC
         gPec9nEuHbPYsGrhhVfHZhFPG4e9fss5zJbUVBFJqir7buhAJiLMJwJ+OfgWLG30Jd0H
         Hriw6pD6nJ69sOSUrLjqI+1S4NOJXs/5LTeShabbBU/xHi9I1YkuttLhE0P+7eF4qK1e
         3VREbj/77VNGgj/RokeGOLpDM7meabNg92kIDz68cabogwBlUi+BbFVfM+/YV8HHS8gX
         YcTa/ZfmLs17YSWUF0YU+tIgk+26zTHisZddlgKwrm2k5W81bMqjXCJD5levBQ9ksaXs
         Stlw==
X-Gm-Message-State: AElRT7F6Jq1soUxETRxcRYDm5FpCljPaX4xzYlSfxWo1ImMyzVfgWbyj
        8pEniofzUPl5Q/eNR/rR3WA=
X-Google-Smtp-Source: AG47ELsG8pxR29RxwIEICvCYWSjZRHDOmqpPtzbU4wy3B2FIltx8l2Naw+hTJ2JRBbhrVteB9aNwCg==
X-Received: by 10.223.174.2 with SMTP id x2mr11186495wrc.211.1521488507035;
        Mon, 19 Mar 2018 12:41:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w40sm997493wrc.33.2018.03.19.12.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:41:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ref-filter: change parsing function error handling
References: <010201623e594401-906aa5ca-545b-405a-810a-607491fe09a7-000000@eu-west-1.amazonses.com>
        <010201623e5944b9-8d44ad36-a6df-4bd3-97e7-de4ee54af3c0-000000@eu-west-1.amazonses.com>
Date:   Mon, 19 Mar 2018 12:41:46 -0700
In-Reply-To: <010201623e5944b9-8d44ad36-a6df-4bd3-97e7-de4ee54af3c0-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Mon, 19 Mar 2018 13:01:00 +0000")
Message-ID: <xmqq7eq7von9.fsf@gitster-ct.c.googlers.com>
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
>
> Change the signature of parse_ref_filter_atom() by adding
> strbuf parameter for error message.
> Return value means the same except negative values: they indicate
> errors (previous version could return only non-negative value).

"The same" meaning?  The same as before?  It shouldn't be too much
work to describe what it means instead (and mention that you are not
changing the meaning as a sidenote) to help the readers, something
like "The function returns the position in the used_atom[] array (as
before) for the given atom, or a negative value to signal an error".

