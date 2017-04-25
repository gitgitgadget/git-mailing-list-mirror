Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214F2207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 06:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980808AbdDYGbr (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 02:31:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35470 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980803AbdDYGbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 02:31:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so8064963pfa.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=68VoPvN+2PknjHwdXXplZDnToYfWByL+NLo8sfurPu0=;
        b=edA9OTJYySOh7d2GkjaDx2VP10iE3slvSOFYsDdYoZPRuWBAoICkc5SKfCYJUUnNY+
         8mfoc/4PhNnCS61LSKTQNS9juPIAIlrpTN5FtocNsBYzO+/++8kAquM8up6yBkh/mIQo
         WyDApauwvM/RP0kOrloJeM3PwOSZSJXxxlzfc2KG1bxlL4h4Z21PQfXQXdZKKZnt8hvf
         hsDxuUbDE+0P8TJWjZBHZ67swH2W0tcj63rF5HhhpU/HsC1aIO3Ql1RYY4OQuOl4RZXz
         nKxd0YPydN5h7Kosqp3M4keFe6O13cd67tvQCBKDPJNs4Xa1LVVFWUfpcHset7LqZvvZ
         abmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=68VoPvN+2PknjHwdXXplZDnToYfWByL+NLo8sfurPu0=;
        b=VNoxE3jYdwWNRiGzzzJ7RpQRGURz4g/xHbJHzZYEkS3tICOUPCf/KjV33tWfGUAFHH
         6QyIaxmXmKur4QuTud7tnZ4ZSakNRDOGyFpqbwcIFg6GrevVBouE6PZl99ej674EdZvX
         9Ctlagw7oPd0PBT4jwE/BYa6uhVtgttluw8e1K/iTUgrykGDJ7QrvCcKnpMuAV2//rCV
         pFuTgtT3ejupJykT2chLtbQ13dCg99nFhUwfPepQerWWgU+l6KPBwvSk9e1ojauRariK
         UaVjlxw75rcS6pEaGoXumaQc38k++WEeuCIgK9fHzoGZT3dDZ1+RaCBZJU2/hIV4AopW
         /zHQ==
X-Gm-Message-State: AN3rC/4ocq5+iBQPj7F2zyHo34K0UyNGj/hqfKRv4c4LhviFCbn0f4Mq
        mMukTKEPfjEWEA==
X-Received: by 10.84.225.129 with SMTP id u1mr36406895plj.123.1493101898519;
        Mon, 24 Apr 2017 23:31:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id y6sm34295354pgc.40.2017.04.24.23.31.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 23:31:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
        <20170420165230.5951-1-szeder.dev@gmail.com>
        <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
        <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
        <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
        <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
        <xmqq60hu1mhq.fsf@gitster.mtv.corp.google.com>
        <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net>
        <xmqqmvb5uin8.fsf@gitster.mtv.corp.google.com>
        <20170425060728.bprvsmiazho6ceyt@sigill.intra.peff.net>
Date:   Mon, 24 Apr 2017 23:31:37 -0700
In-Reply-To: <20170425060728.bprvsmiazho6ceyt@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Apr 2017 02:07:28 -0400")
Message-ID: <xmqqefwhuhfa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Sort of. It still has the bug that it dies with error() when "--debug"
> is used.

Ah, I forgot about that one.  Let me squash it in without the
remove_trash change then, perhaps, but not today.

