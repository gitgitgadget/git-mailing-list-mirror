Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB58E1F404
	for <e@80x24.org>; Sat,  7 Apr 2018 18:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeDGSlF (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 14:41:05 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:45222 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeDGSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 14:41:05 -0400
Received: by mail-lf0-f41.google.com with SMTP id q5-v6so4747747lff.12
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8OZ8FdJpGBsg7Jj70QeoBaBRAYhsSWGStfExs4H6Ai0=;
        b=ltArY6q9ysTjU1cO7w3qApU6Cj5EuzaQS1Nx6GQ2EAKYuaz0hFnr1kBjwzf65ZHxVC
         AQZ/8fz0al1KPeKm9tT+MK1lwuS1Adj1ETmAApIvf3mSxD5F2WaMOA2x8mTJZTybVY1m
         nr21b/9J4NKMiWrvH5/+BQhpPedeD3aMrux2TQFmUVjGxfz+jv56jz5WPFuvxnF3cxwi
         cZRHcUUtcC/IqDB5ELNLXd4Z+4QijcWtFjKgGoXa00NfrytPdl7YjnMgJVV0i/U2sKf4
         FrchRboID3+NftIvUWRedMQxjvqqbL0LxXZc9fQcTBJM3csP62HcYD1lJ0cAQXDozIfw
         d0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8OZ8FdJpGBsg7Jj70QeoBaBRAYhsSWGStfExs4H6Ai0=;
        b=tKfO4YJlJ2ftPqxLWy/mFHe+uBWMcddkIn/ebGaC04n2SQu0qKwVRWqU79XIx9h5Pt
         aygsn64jxz2o7pwDN8SfSlFhKqouAEepuyHwWlVddau3x2yzU45yTAE/syfwBiNTCPJg
         l2r2vIVkmVa812k0ZCYVtwKeasXk168pjnkeV5hP6K+k8R6NHUjKgFE0BcQwTxS66Ca5
         w3kY3a9I7Ag80sAyFbIoeyILkiI3MkAINizKKk2UXf9SjrsapTd0b+ZfXnSSCAgA4RL6
         S6aRA6mQFhRAQoInKuINGcWMhuTmq2VXDq35RqyYs+G3Kuxbtvv71Apmwj5yPtFSRUso
         KeBQ==
X-Gm-Message-State: ALQs6tBoE/PPAwI+OmzFSC5tRlKVPuEvaqvCKLrtF9VViQQDOCk7lcd2
        EewxDL4B/MAJIqKNb42yQls=
X-Google-Smtp-Source: AIpwx4+zXdyYXYI5YO366fRbUs/y7iJeCPwacMaqDtw5WJx4n3Ssjc7mao6UoM5a8gLkbtAyDxq82g==
X-Received: by 2002:a19:4402:: with SMTP id r2-v6mr19113621lfa.105.1523126463623;
        Sat, 07 Apr 2018 11:41:03 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ega165.neoplus.adsl.tpnet.pl. [83.21.64.165])
        by smtp.gmail.com with ESMTPSA id h66-v6sm2653022lfi.89.2018.04.07.11.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 11:41:02 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, avarab@gmail.com, larsxschneider@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
References: <20180403120057.173849-1-dstolee@microsoft.com>
        <20180406190919.167092-1-dstolee@microsoft.com>
Date:   Sat, 07 Apr 2018 20:40:59 +0200
In-Reply-To: <20180406190919.167092-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 6 Apr 2018 19:09:30 +0000")
Message-ID: <86y3hyeu6c.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

[...]
> On the Linux repository, performance tests were run for the following
> command:
>
>     git log --graph --oneline -1000
>
>     Before: 0.92s
>     After:  0.66s
>     Rel %: -28.3%
>
> Adding '-- kernel/' to the command requires loading the root tree
> for every commit that is walked. There was no measureable performance
> change as a result of this patch.

In the "Git Merge contributor summit notes" [1] one can read that:

> - VSTS adds bloom filters to know which paths have changed on the commit
> - tree-same check in the bloom filter is fast; speeds up file history che=
cks
> - if the file history is _very_ sparse, then bloom filter is useful

Could this method speed up also the second case mentioned here?  Can
anyone explain how this "path-changed bloom filter" works in VSTS?

Could we add something like this to the commit-graph file?

[1]: https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexm=
v-linux/

Best regards,
--
Jakub Nar=C4=99bski
