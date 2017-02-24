Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2AA201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdBXUGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:06:05 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34831 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdBXUFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:05:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so4184970pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EwfxWthHvPKsyE3N8Ozo55/OyWDUCF20NtQU0I9QPQE=;
        b=RUjNMLcmkVAN+XQjwLPA8fL+ziuofZ8Bj5NGI7iLFN8DXrqe6DasXVCOEVMBH2ILfg
         MRiBfX1gr/sjSLiDFPEPhWxfIrC3Ns03B62qpGLCIOFhBZ2ueT6/eUu2a/5M5h8afzKg
         qw7HF6gmM7uCRkOsnNXMAQT9eLFEqI7cKgRHbfrePrNMz7DxWyOUE1deAScS8ITjTiTg
         IFiEpe8FfsKu0n0r8JHf26TI079SECfy6iptDrs+Py/4cWWxWTGXGosVemAGHvE/K5iz
         I9evY/6zTfVPwsO6jMMgVJE3gsGL3VmwTXxvvhynCWANb4d50dAPoN/q0+Ar+dQT0TTt
         pq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EwfxWthHvPKsyE3N8Ozo55/OyWDUCF20NtQU0I9QPQE=;
        b=HhWhHybanRpyEfZCcyWCTzdQfdEZnoCjsQ/1JtScdBIjKPRMlBFx46MtI9j+RlTZSY
         WUft/ih99O4Itb61Ql1sNY1G/kEBATgn8hqudGig7A9nfSqb1ENsfydIZtCGP4FsRe1N
         JoUTGDTS1Ya2qpWED9TERV7chqFV+4H2R0e8euLAtmWKR3UsYTE+BwmX2n0cai+FdWJ2
         Y0bk41/7Vmp1WO2UqUMkgaCotgieIG73Up6nDYKU/HPs9snArJwH+3cCWsh0n08JOt5o
         lusIr0mKoWSkJYfWNsNrq0MWYeTnKwsATdfkI/EuhFBgZq1A0jVxSaas70XHjm+bIO1/
         9NWw==
X-Gm-Message-State: AMke39l+7kMWc/SBBP+TPu4b32zhSFCGuR7kdJV4XOkJMnrNnTFKLO6OznF02kYloxDQwA==
X-Received: by 10.98.91.131 with SMTP id p125mr5665636pfb.165.1487966753533;
        Fri, 24 Feb 2017 12:05:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id v9sm16548603pfl.102.2017.02.24.12.05.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:05:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
        <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
        <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Feb 2017 12:05:52 -0800
In-Reply-To: <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Feb 2017 11:20:39 -0800")
Message-ID: <xmqqpoi71hi7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The not-so-well-hidden agenda was exactly that we _SHOULD_ not
> mimick PGP.  They do not have a requirement to encourage everybody
> to use the same thing because each message is encrypted/signed
> independently, i.e. they do not have to chain things like we do.

To put it less succinctly, PGP does not have incentive to encourage
everybody to converge to the same.  They can afford to say "You can
use whatever you among your circles agree to use and the rest of the
world won't care".  If two groups that have used different ones later
meet, both of them can switch to a common one from that point forward,
but their past exchanges won't affect the future.

You cannot say the same thing for Git.  Once you decide to merge two
histories from two camps, which may have originated from the same
codebase but then decided to use two different ones while they were
forked, you'd be forced to support all three forever.  We have a lot
stronger incentive to discourage fragmentation.



