Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B121F404
	for <e@80x24.org>; Thu, 15 Mar 2018 15:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbeCOPzN (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 11:55:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43878 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbeCOPzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 11:55:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id o1so8788650wro.10
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g9QiS1xpY6cer3usp5lK4Qah9HW3+ZZd9ZlDKyzZU+Q=;
        b=RtW07gdgXz+phMD5Ekx4CBx+8IS3HC6iDZsrk91VD/yh4CbBm9dFPtKMhExcySEn5m
         4VBSJbzPt4o9S8hyVl6nvx25XlUmDscflld8peIoePj9mBaYtSi0rax8eKkhKWBwF3AW
         fK521YAP9GU2Vxe5ww3rYOB/EFfXn5pEjQ5TUktNylkRtnFoys3utWjZK2tYlNE2Dn3s
         FVsd+zAvIA0AU5bGv2cVCceFZRv2dHQDMUU63gISRlZ3wpRJECnsu6gYozjOiUO3pIUM
         YugBVpzU+hneSF6N5vA6ucPe2vqGIgD5Adp50IDrBI+n7JVuWPpBlfusv9n7R3O21sJ8
         cGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g9QiS1xpY6cer3usp5lK4Qah9HW3+ZZd9ZlDKyzZU+Q=;
        b=ZavYpQJjElgYVVgO1GrDvOpOj+jtxbxBJm1KnAjPwtiSjxIpbMbICBdoT6pAATadbD
         QEBB6vIipc0vaHaQOCdnEez31U6VO/9tqpJchxSEQRs0W3cp0E/3AVuWnrvkaYd09zrw
         BK2rcBF10e1u73LnzuqJ/dkUxFt48uhvDKFy2/Ac0Z8MvPpMxILrV1YK83hYuIneCpV4
         EoqLLHIY6bNEpYs+f1N7szGdtCCU3fe7AiUj/aJBTbzqiVrOfMrG570RgQx9rQgxpGac
         gbPemviOY9ln1BPxvBCdaS0C7FzlZBQwSRipQ9mL/Vxbtl/8yBdUFE1nSrDAkv4kVhi3
         o4Dw==
X-Gm-Message-State: AElRT7HtHihBnJeKJPfRLTxDaHsXHWCxQky28/eWMPvAQ43vkGVKXhpg
        kLjhZsf0ZJjgrpCdLzXPyL0=
X-Google-Smtp-Source: AG47ELsM0whwDR/5uNpmwatD8GyImUxamMd3NmNg1iDsORA6SCAlVqsMmcv97lWSCqXEfOyVdb0bqg==
X-Received: by 10.223.160.42 with SMTP id k39mr8116028wrk.138.1521129309050;
        Thu, 15 Mar 2018 08:55:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i66sm5449906wmd.0.2018.03.15.08.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 08:55:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michele Locati <michele@locati.it>, git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
References: <20180315130359.6108-1-michele@locati.it>
        <20180315141220.GB27748@sigill.intra.peff.net>
        <xmqqa7v973b5.fsf@gitster-ct.c.googlers.com>
        <20180315154815.GA29874@sigill.intra.peff.net>
Date:   Thu, 15 Mar 2018 08:55:07 -0700
In-Reply-To: <20180315154815.GA29874@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 15 Mar 2018 11:48:15 -0400")
Message-ID: <xmqq605x72qs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hrm. I took the goal to mean that we used to exit with a failing "1" in
> this case, and now we would switch to a more-specific "2". And I think
> that matches the behavior of the patch:
>
> -test $commits -eq 0 && die "Found nothing to rewrite"
> +test $commits -eq 0 && die_with_status 2 "Found nothing to rewrite"
>
> Am I missing something?

No, other than that I wrote my response before sufficiently
caffeinated ;-)

Thanks, then other than the lack of doc updates, I do not see an
issue.
