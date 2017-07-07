Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D92E202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbdGGPxm (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 11:53:42 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33816 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdGGPxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 11:53:41 -0400
Received: by mail-pf0-f169.google.com with SMTP id q85so19072218pfq.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Iw+SpIa/3wE/xNUUnlBILkL8koabbDT/Nb03II3bNRg=;
        b=LV2YYwFA2f4ZbBtSqHRvyAG7S1RbbQAmiRKF+IcR11eWPnHxcWxKW2BCblCF1DZ2cv
         Eicg8bmCT16TE8zEkP8vaDJssQg9u34AOXPORf2ktgd82ykuGvVeAHfJ2DFq9WUuHOht
         4yAG+Z66v3irnBu4nuLMqH56UAvRPkFsOOPpQnpUfptfRVNFXLTGmJyfa9rwYZFJpZHn
         /8wFbudiNucx02pKIOAG4JcHYn9rYucb12vRhRM4tJWWiNm7jhOp7kFoMjCbSkgT0dfD
         Uc19Kc42416OZ4vHmG2pLnlWKO7TD+as6m0S5XQcbTp7lZ3dZeAb/cEMi6XX87nL2HlB
         Rfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Iw+SpIa/3wE/xNUUnlBILkL8koabbDT/Nb03II3bNRg=;
        b=osEFOzlpZRuLO9jdCIIHhiolrDpBpzurmFJnmn3C4wGtAhBjRZbGditEmq6Z7T4a8F
         5+5SflfuKkbm0Hqa5lqLwNgQcBy78HFckWl9mUqa4g6cWu6jJdPbw6dWGxElnX/zpA7I
         AXQxSokPYJ9EfqjRiQeeJhSuWRAOX96Axiy24PjkhC2KoCD2AnxTuGh5qmFpMi3rjYxT
         40DcZkR2VbUarhqctEYqaqeLTQ3n1BBKeiIke3XBsp1MZRdGBehCxnucZFb7viT1rcIO
         tf/IeYsw8vFw5soempu5MmvAZoztGBIzf4EZoQZB6/4KozvnlV3JnHYCdPTDBW4zzQu9
         TJSg==
X-Gm-Message-State: AIVw112oPGauuU5p9TyHrxvn/foj3xh4rSE7dpR5r8PqIFBdVs4ws/u/
        ntgJKT2JZpZKUQ==
X-Received: by 10.99.119.194 with SMTP id s185mr2097670pgc.256.1499442820722;
        Fri, 07 Jul 2017 08:53:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id t67sm7910286pfj.98.2017.07.07.08.53.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 08:53:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug during checkout of remote branch and uncommited changes ?
References: <20170707123727.dgd5rub2ycrg525y@ltop.local>
Date:   Fri, 07 Jul 2017 08:53:39 -0700
In-Reply-To: <20170707123727.dgd5rub2ycrg525y@ltop.local> (Luc Van
        Oostenryck's message of "Fri, 7 Jul 2017 14:37:28 +0200")
Message-ID: <xmqqd19cckfw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> 	$ git reset --hard
> 	patching file afile.c

Is that a message from something?  It does not sound like something
"git reset --hard" would say.

> 	$ git co <abranch>
> 	fatal: Not tracking: ambiguous information for ref refs/remotes/<aremote>/<abranch>
>
> What can be ambiguous here?

I think the message "Not tracking" is given when there is a remote
other than <aremote> that also has <abranch>.  Between the time you
got the message and the time you tried to checkout <abranch>, did
anything happen to cause the second attempt succeed?

> Strangely, trying a second time, succeed:
> 	$ git co <abranch>
> 	Previous HEAD position was ...
> 	Switched to branch '<abranch>'
>
> -- Luc Van Oostenryck
