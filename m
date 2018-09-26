Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790581F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeI0AfB (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:35:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44381 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0AfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:35:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so28001665wro.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cFS1IeULUCNcqTH6WqAmpbgCNs5nqsYltZkUY9lV0s8=;
        b=sgL5d/NOLHgGuL9aLWaMb/QJDgLxcJDo7K7ql5ZIHsrWC/xfPDz64lcmMTjS1OfGpL
         C9nE1oyrkueEgEmTH0fhxcu39ezu7PG2R0yi2dmbjFAEfuAf2WN8XZ9ZWd5JQDHxbIYD
         S4MY0ZXBMmaNIen57nXQiHc/AoRbyRg7IPQuf18OMd1xlSsgUAjPmjd0kRGW5uAc/IPM
         mvMN1CoybUGlsJwbM/jOO/tkPbvFMRr9nNaOhkgKymkVew2NZ/MOmUdzGZHT3toL+Ck3
         kh1d9K4nipqhLAVus1rcgUU98UYQOa23DJ3iQYocPEazZxx9wL0mnhOfarYnqjwWuKn+
         EA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cFS1IeULUCNcqTH6WqAmpbgCNs5nqsYltZkUY9lV0s8=;
        b=tlagT3EIXuQ915LZYI3CKf/bZD7xhfOn94Xz/HMjT7Bbq5K4Oki9pqOg2p9bVKFJfB
         265tsQnrbDcxL9pxl+FWEM/fOIpricVgGZY35WMnbB8bENNyrfibS9lDaZq7ESYjVS1r
         6CVwqqS/uh214PcQUv6GAGXdjDih2Do39qAf6zkWKS7uXU7Vqtz0WiQtotMVwbBNriIs
         wZsQYLVc1vRy8/ti1ZN2Y+DQeh9fQlfEUBJqo5BE8sgdjy9mfCogIcYWRwRz/7a8U5Hz
         EjNMOeadKWMIhuyQQSCUDs1dTZNcPgEIZ3S3UzoxxCQZQIkQC6bsutElCqEeP57TR3xz
         uqYA==
X-Gm-Message-State: ABuFfohS8mf+zoDqpTKA2xjFz1c1fR9/G3ce9KaiXovkgDj8DLlcjZBx
        i1rx0IEHy/QqZvxeYByepnk=
X-Google-Smtp-Source: ACcGV618DxIlyZESrQriKBZ/7IB1vQIB65WXDA0jEEZoGj/S609hx1DLZVYsqkXWubUpy+qVnuiSIQ==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr5763115wrd.253.1537986047399;
        Wed, 26 Sep 2018 11:20:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d2-v6sm6051986wrm.71.2018.09.26.11.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:20:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
        <20180926143708.GD25697@syl>
        <xmqqtvmcmg2v.fsf@gitster-ct.c.googlers.com>
        <20180926180911.GA63889@syl>
Date:   Wed, 26 Sep 2018 11:20:46 -0700
In-Reply-To: <20180926180911.GA63889@syl> (Taylor Blau's message of "Wed, 26
        Sep 2018 11:09:11 -0700")
Message-ID: <xmqqh8icktmp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This pause (though I'm a little surprised by it when reviewing the
> code), I think strikes a good balance between the two, i.e., that you
> can get help for whatever it is aliased to, and see what that alias is.

And I need to react to it within subsecond with ^C when I want a
compact answer to "what is this aliased to"?  No, thanks.
