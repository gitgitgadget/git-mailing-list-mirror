Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833FD1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdGYXfO (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:35:14 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35274 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdGYXfO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:35:14 -0400
Received: by mail-pg0-f41.google.com with SMTP id v190so76300646pgv.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F+IDFwJ/4vA825a862iFF/LTNkLbDFgSzrYLGHnUSYg=;
        b=fkwk6xjcuwhIUFvWUsibvUF3HQnbupQCnZtcVWLfRYr6U0c9MaLL3HSVfxnZdZ2x20
         0VSyfFt8/iKiSQsX1Y+BH2BARM1k1b0E+zDILy7VMzUUz/xAirgBpA8TZiyqGS6Fyfg1
         LrD07+adZnxrNvtD/YicaZVbWwW0j7+BDUi6Vb9edlnFkNgEBuBVObQrF3RKVFNjJ3il
         oMT9xS+nBwqoXu4TbjJ5j0vrIjVRAbI01AfLP2taP9qXrrUOakS4pFi2ptgKSB2NgR/x
         wGT+DRdbM5CdTpKxiNnjgN7ADJLKgjiB0jk3GNZwkR56oio+wUCHMqRkM3YefbLV2oaB
         Y6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F+IDFwJ/4vA825a862iFF/LTNkLbDFgSzrYLGHnUSYg=;
        b=WM5YKEE7npI1OXDk9TEJmw7qeDWIk/Xl6EFj/RndgKkZiFJwbGShBFRii61ZZaE7Ob
         F0kepacqQX6x/J/2gy768RuvhHVUPt3dx0TRkv8WiYT4qh7faeCVAu2h0r+69GZno1GA
         S8uasopbgqIiN5xFQUkpHKP+yxR6A65XwLv03tfEb1fhcis2lYgyXC5D1/C/o0PCkh/9
         WwH4VBkhZaPCurZvA7Xz2e5kf1b54Tp8pbfVBGPvy2oGfH1zJwSWRUTqCQ40i7uXExo2
         rnCRxIfxbsheGI1LZVTbyDWW1gyEvagu1qIGY0F/18Zf6QmecJM/Sdh4k78WAY01cvkc
         EEMA==
X-Gm-Message-State: AIVw112jBsV6C/lUfESoohdYauoHhlyyiOeQw6GOxYp8kmrClSGPR3RT
        IKDA0Hi0qHlkB10HQzeHIAQGb5m5CxI9
X-Received: by 10.98.204.136 with SMTP id j8mr20818865pfk.275.1501025713454;
 Tue, 25 Jul 2017 16:35:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 16:35:13 -0700 (PDT)
In-Reply-To: <20170725213928.125998-5-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170725213928.125998-5-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 16:35:13 -0700
Message-ID: <CAGZ79kaof5O2EwFjg6-NpGMYdVYWdSxL+5STfEm8WF5gV1qbGQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] submodule--helper: don't overlay config in remote_submodule_branch
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> Don't rely on overlaying the repository's config on top of the
> submodule-config, instead query the repository's config directly for the
> branch field.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
