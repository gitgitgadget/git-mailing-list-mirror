Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4808C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B372C21744
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 03:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzNQDle/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgHFDZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgHFDZp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 23:25:45 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E180C061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 20:25:44 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v89so10714207ybi.8
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 20:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m/jltfTIL/lDYAzJVkiSIXaFoiFm+ghCkW8kDR0RgJ8=;
        b=YzNQDle/pgy/nMn4QvtFlrUavwZCAx1cx5rX+Ihvgk1BFi8gOlDN2GeaCs1o7wzUxm
         +e0iQXShbDWmtB06CmgJkwC7k9VjQ8DLitt81qQmHZvsnTU7FCg893oRMuuzJteichv2
         6IRdZiVp9A1Yk23OnTOVjHpwUZeRX+p/9SU5JnCkQ1f3+IVbn0JaBbpCGMc6LU67WMFM
         flUeG34tVttWR+tXbtLYcriA6arTprcYnsBLUQUxj8sitFwO+HNe5X1OVUmU5U2Fcy+n
         4zkNfbLLa4LFGRFtMkrgd2E4yzU1esnVjZPVdOlKeeb6innj08jDcVcWi0zwI/NXGusm
         TYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m/jltfTIL/lDYAzJVkiSIXaFoiFm+ghCkW8kDR0RgJ8=;
        b=uTKiM9AOZx7LqYGkncMmU5IPcBs3oQCRcJjN5PcW73Lxarax68MHouutUfpMLgXjAX
         gCc8ZadZgGfV2rJ78i03ULSqORm6VwWTU1/hPG20UA69aidC0Ww8dBZLEFWMNAUXZeGj
         O34ACHIvs6GAQrVJ4bZyWivwXrxXQrcrWGYavKnzy72/ZGdv0rJ2AV91ArB4Poh2C2E1
         OvkH8a+3A9w/8cR2XUfEYBI9nznCHgjJDkHMA+OAX48Yn35wNtBLbtQ72tvZLO79zZsK
         HwwpTMPNpodFOdbI9SgNmU9O4Y+Kkd3sz3BIA7xsW1QfvzPLPcGmxcZt+a0Xk1McrX3z
         +A5w==
X-Gm-Message-State: AOAM531paOXVJnH4Dwbxjzn7wR39IoUzYXR7x8fWA0Fyaw6NjWOjn7mA
        zvxAK4TgJQ66/0bHlR0LSzNpc3pVBMx3JOXkYRk=
X-Google-Smtp-Source: ABdhPJx10LLGcQr7WBGEgdE57vMJXhMBB+hu7HkYB7kKfXNMb2WCk9R/fD63m/nZMd5soaycY2RKi6UZTb5GpCIpYdk=
X-Received: by 2002:a25:bec6:: with SMTP id k6mr9563596ybm.41.1596684342872;
 Wed, 05 Aug 2020 20:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 6 Aug 2020 11:25:31 +0800
Message-ID: <CANYiYbFjYAtrfdvPKKqveF8ADddhLG=9G9YSgJx5W_e2rxXUrg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:37=E5=86=99=E9=81=93=EF=BC=9A
>
> --------------------------------------------------
> [Stalled]
>
> * jx/proc-receive-hook (2020-05-18) 11 commits
>  . doc: add documentation for the proc-receive hook
>  . transport: parse report options for tracking refs
>  . t5411: test updates of remote-tracking branches
>  . receive-pack: new config receive.procReceiveRefs
>  . refs.c: refactor to reuse ref_is_hidden()
>  . receive-pack: feed report options to post-receive
>  . doc: add document for capability report-status-v2
>  . New capability "report-status-v2" for git-push
>  . receive-pack: add new proc-receive hook
>  . t5411: add basic test cases for proc-receive hook
>  . transport: not report a non-head push as a branch
>
>  "git receive-pack" that accepts requests by "git push" learned to
>  outsource most of the ref updates to the new "proc-receive" hook.
>
>  Ejected out of 'seen'; somehow its tests seem to break with clang
>  cf. https://travis-ci.org/github/git/git/builds/713443572

Will check the build log.

BTW, I want to extend the syntax of the config variable
"receive.procReceiveRef" like this:

    git config receive.procReceiveRef "kind:new,remove"

So "receive-pack" can pass commands for creating or removing
tags/branches to "proc-receive" to create pull request for these
operations.

--
Jiang Xin
