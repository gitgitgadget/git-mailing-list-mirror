Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA151FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbcHWWaN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:30:13 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36439 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbcHWWaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:30:12 -0400
Received: by mail-yw0-f171.google.com with SMTP id u134so81442335ywg.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ocJpSyTnE0GdAJk+ChdpPn8kbeRZemVAm/GrLe0wKJM=;
        b=PPI0srNDi1v6xMdlOQRt3w4/a9WQ+ceII7z8ykU17dmXH7smXASZXdYMl6wnjR2Zx3
         toxe7aWfezdBshRlZ0u9VQdWOB8SQK0QRMWXgLKm7mOlPy+imEor+AmoOHp3nP3d6x1g
         B+A6olSlwyxIR82iFcsP3/ASn1V9O3yRHRdgk5ciyxHsDgVQ8FBfD5UBPzughXiIyE/r
         SZaHaXnQpBP/mPZJX+JHSGP3QET3J+uEqaUWrZ3ME/fpWkQWt2JiYNmUix1Fn6TG8yyl
         A5TOuAjf2VP9f5tb0HkZ+6EeptNXfmEHTcJyACMdiiP15qWRhIVKV+Ulxng/Psw9J/mQ
         L9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ocJpSyTnE0GdAJk+ChdpPn8kbeRZemVAm/GrLe0wKJM=;
        b=Qda81eDy/57eS4mtSo5Wv750SBd4hirUwsPQoFShyMXzLOlLjTDqh5mFq3+IVKa0g7
         dQmbF3y6i+F3d6yiH88kRL5GC/iFFP7cTRr8dPDnR/cQBWDhZfoMArpm+rpad5lgdzrD
         2RRI8Zr6MtaI0Aq4NDdRsYg3N5yPqdwIs0sp/GZTmjGxC1Y6xrmPMGY58zGRGpEeSfY0
         rq3OHmb06PFiSmRO9O5rNSkqV0N9VDVjh3drxwk5mTSA+MEMTpWXAodgASbE9omvRL43
         CQ4BIxilAsNHbuxPW/g/byqr/M//zIPR9vW5OSSjgb6K4XFJEqrhN3mHEItivKzA7HUt
         WUAA==
X-Gm-Message-State: AEkoouvHS84iCEgGS8Xc/1Xm/CAgIvpzYmvNDOKuzR8HJ7gknx67E0SZc+f+JBX/PvGxVmkmZ30fmkWKabATjQ==
X-Received: by 10.129.135.2 with SMTP id x2mr23819086ywf.310.1471991411807;
 Tue, 23 Aug 2016 15:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:29:51 -0700 (PDT)
In-Reply-To: <20160815215327.15682-6-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-6-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:29:51 -0700
Message-ID: <CA+P7+xrd4eagXSFQen+TZop7u+h2eyLgQ_0vjT03Bjov-KNL7w@mail.gmail.com>
Subject: Re: [PATCHv5 5/8] clone: factor out checking for an alternate path
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> +       if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
> +               char *ref_git_git = mkpathdup("%s/.git", ref_git);
> +               free(ref_git);
> +               ref_git = ref_git_git;
> +       } else if (!is_directory(mkpath("%s/objects", ref_git))) {

I realize this was directly copied but the use of !repo to determine
what file path here was definitely not easy to process, because it
made me think we were adding .git twice to the path. Not sure if there
is an easier way to expand this and avoid that confusion?

Also, what happens if repo is false, so we run the first block above,
but is_directory fails? We just continue along even though it appears
like we should fail? I'm not 100% sure I follow the logic here.
Regardless this appears to be a pretty direct copy of what was there
before so I don't think it's worse.

Thanks,
Jake
