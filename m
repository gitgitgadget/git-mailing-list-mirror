Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E8F1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeKEK3O (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 05:29:14 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34054 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeKEK3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 05:29:13 -0500
Received: by mail-wr1-f50.google.com with SMTP id j26-v6so7652533wre.1
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 17:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4UogalK6wad7eRGGUYXd0wn3q0VciQt3mBDAOaYessg=;
        b=VNFmNGFobyAW07PWH9TzKK4EVddZKnx7njuZkjMWhcn8Fi0btdxk5y1GiJze6jyBq5
         vXF25d/6BOZyo3uuKA7waVghSqZyIhDOjSur/h6vjWygOx4Ape0Ns5/TcD50DkmftJ2W
         khh61UPXxXg6OIv74R5OFsFV18cWIrUaaWtoBU5M7Whj8qMG/StVmgy5iK3+aSK1IcJO
         QoaViI3mhnB28iHS2k1TOGnZr/CbTcDM5Fmv1byBqASJjhVJYzTXTMxsWKP+ob+F8L0o
         D4giDEuKLPpuLSXqTbK0YrMSK9jQAu0sLO7u5HScx5CxUI3Q/FL3uXVMUPjN/gSWzKPJ
         8LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4UogalK6wad7eRGGUYXd0wn3q0VciQt3mBDAOaYessg=;
        b=b3yTcIjF96a9h+i2xlupOpuxhacKT9ZwG3nGxSYJVKjNLk61h55I4VuDMMsddXz33M
         qXpskOZnw/OWWFhz2U/CSw0UUyDw9SWqzucOoCRYpY1cQT2/GuDfQE8UqgrZninGSCia
         2p8/S0h4RWYC6vt+XArNrU23+bMIpbCHar8LzovSCz6gFJ/ESfvzerYJln6GBzNM8sg3
         yVNn2OMOMxXUgS8QU/HL9EdV3fkGDOK4L1PA0n849oLieHisxq2/FeHwyHCpYHVs2Arr
         B5ucoFYVkA7N04WzKr5LcmdCPb6LQWGKas1MyBA9KEUeF0AY4gGj5IZVp/2yx/iQGMUi
         5cdg==
X-Gm-Message-State: AGRZ1gKau51gMomJ0VrTP9TEeAFG/MciUN0qz6LjntmRpoxS7dJjqft4
        PInSD92fVJoU+jyBc5TFCAY=
X-Google-Smtp-Source: AJdET5fw3LjXx+BnzMQSdyqRqzpicQbpKDYUNmPmULqe+HvXSsWojHdojdQe7IJwK6D5WP0hZ8DXSQ==
X-Received: by 2002:adf:ce8b:: with SMTP id r11-v6mr8149434wrn.194.1541380329168;
        Sun, 04 Nov 2018 17:12:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2416783wma.6.2018.11.04.17.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 17:12:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Urlichs <matthias@urlichs.de>
Cc:     git@vger.kernel.org
Subject: Re: "git checkout" safety feature
References: <6afef19d-08f6-9cce-a491-3a49808c57ec@urlichs.de>
Date:   Mon, 05 Nov 2018 10:12:07 +0900
In-Reply-To: <6afef19d-08f6-9cce-a491-3a49808c57ec@urlichs.de> (Matthias
        Urlichs's message of "Sun, 4 Nov 2018 20:12:54 +0100")
Message-ID: <xmqqk1lsl448.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Matthias Urlichs <matthias@urlichs.de> writes:

> A recent discussion on LWN https://lwn.net/Articles/770642/ noted that
> "git checkout <release> <file…>" does not warn if one if the files has
> been modified locally, nor is there an option to do so.
>
> IMHO that should be fixed, preferably by somebody who knows git's
> internals well enough to do so in half an hour ;-)

"git checkout <commit> <pathspec>" is a feature to overwrite local
changes.  It is what you use when you make a mess editing the files
and want to go back to a known state.  Why should that feature be
destroyed?

