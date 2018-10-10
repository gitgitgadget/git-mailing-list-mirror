Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22D31F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeJKFip (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:38:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37668 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFip (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:38:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so7406286wrd.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bUaGLwRvxepBLSFqtm6mhmTLHGAyBwx50IxVn/l7l+s=;
        b=gz+9JJrZOgt6mxXr0rpZAmjh8f9ac3OcCsh1BIoGq+2/IVXmHoN6KjcmgE+U/D7sF5
         H60xiRtmeSTo4pXNu4I5ed2I+mvVay1/SKWI1n1Yygqfh7+mf+GddRR6Au0Im3qQ3+Kz
         +Pncn9bu5H2YWEMwJzH8Mzj0E+Y7/AWS7mzJ5A03ufe6KHkI4CAJpvG23lvMPzj1Heti
         g0AIfdNnm1x+ZabEGoefpwLltEoM+Ckpqr9zGQi0RoS4CoyRHg60SIEyTaw8sshoffTr
         y7a3vRFS0/hLRevb0n9vK/6zBtgMduXGN/9x6CIuOlwWjEUNFtS+OrFfO+e9VUrgo52k
         YwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bUaGLwRvxepBLSFqtm6mhmTLHGAyBwx50IxVn/l7l+s=;
        b=OyFXcBXCI1SK87SJyVGtxk9myzvW0b8qV+xgFS+FBwsk3RvZydLM7umA+QFdm23aEp
         Utptx30ZJAoWeV+mawamMJkxUWtZnrFJhXJ95CmN7X1DSMPCDDTDsaE7zTdchy3cOyfn
         uBkzeOQ+AqpvxHVSCkqW4IWDwGgHtVheohtbZWoE71DL8bbRKVuRJY6BHA2KgJ/a/srU
         spZZ74b8Vhy1oz44VmkRxcUY3lrWafcz8H0eC/+YhGrszk8zLezpXNzd8Uii+ZTNuzdm
         n6/jOPo4Oiq/5EW3Tg/1/p7FUFIS1nrQGFoOMUP6xqTjrgte2tbKSEkE3kvqcwf4nbuo
         Pfdg==
X-Gm-Message-State: ABuFfohpkd4fMq51GQqDE5Nzb5h87v6faSkfrw7BmAJ4vzvhawfjOUOT
        mz3TyEad+zi1OAIVeObLVmg=
X-Google-Smtp-Source: ACcGV62bca8e/O3piGhu62pKc2M6AFbmTnr2CRGa/849S4IHTelHMP8OJHt8G9tbQazgChpUH3vO+Q==
X-Received: by 2002:a5d:6450:: with SMTP id d16-v6mr23091202wrw.64.1539209673882;
        Wed, 10 Oct 2018 15:14:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m2-v6sm16780905wrj.80.2018.10.10.15.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 15:14:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v5 17/23] userdiff.c: remove implicit dependency on the_index
References: <20180915161759.8272-1-pclouds@gmail.com>
        <20180921155739.14407-1-pclouds@gmail.com>
        <20180921155739.14407-18-pclouds@gmail.com>
        <20181010145116.GA11772@sigill.intra.peff.net>
Date:   Thu, 11 Oct 2018 07:14:31 +0900
In-Reply-To: <20181010145116.GA11772@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 10 Oct 2018 10:51:17 -0400")
Message-ID: <xmqq7eipla9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I get why you're doing it: your topic here only cares about removing
> index dependencies, so you did the minimal thing to move that forward.
>
> But if you think about what this function is doing, it is quite clearly
> dependent on the whole repository, since the userdiff config we're
> looking up may come from repo config.

In the case of userdiff that is pretty much limited to read-only
operation, I fully agree, but in more general cases, we would need
to pass both the repository and an in-core index separately, I would
say.  Imagine doing a partial commit, where we construct a separate
istate that is not the "repo's index" and use that to write out a
tree object to be wrapped in a new commit, and update the current
branch ref.
