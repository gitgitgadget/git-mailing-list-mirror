Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FEAA20A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 19:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdITTzw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:55:52 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:54725 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdITTzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:55:51 -0400
Received: by mail-qk0-f174.google.com with SMTP id d70so3823001qkc.11
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=efuR+tTY1KYmH0kY07ZtJnlYw1QwAZ12yUqLxVoLC0U=;
        b=uN6YswEvs4Wt9xq9YMSl70ti0OBTyehCdUkWMNSoYoF5gIrlPl4gBRcZ6Ll9yyXiC7
         32OJHUiGMzvpvkIRt25GJwWYzXrE+Qf+rwMyL8G4E+INOKGagRFWywLeojLpeJyhnCfS
         duGjvRuCrZdQY2O4hOK4VKaLUPmjx6wHCkT4ApjW45H8nc2CeF2IGtbbG3h8hOr/3Zdf
         TsCZB276IkpNGABL829yvz5b1JfS+sdLLAmtjJqUZcJumVuTgKnaiqvak0D5Cx+MStBh
         qzIcss7702KSKJb+rcDS91jjmt7owMfmUkQE4tWGLg7MhFRGzWDldKh2/iLPahGrd9/c
         VBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=efuR+tTY1KYmH0kY07ZtJnlYw1QwAZ12yUqLxVoLC0U=;
        b=im/IOGGqh9hnX1IsYF0JHeOpTDNkGjr+CNo1fPWGTxhVCwmHOVykEFl6t9d22aUgQX
         pWbkRzgcoi/Fmz0k9JV6F3qOqujr1A8TVxAbMT7XqNuLJ05H2mfelI9g3PPtNnx1vO1X
         waF8MGMoMSJjMC7OpsD0kuW3a5YfyUN2MO0yXPdYv5xPCWfssfxFdankWSgxuKGeQrKJ
         nKNOOxkQ6+X4URhrEwy475SubpDOL5SaanvE4UsRzUvu+sYrOx5fBsoUqMC+MzdrtL78
         f/tqJYpkJco8umb3cv0pffGJN+kjNxlvI78wWCpp64C4MZ1dF9IyqdWeIigVlCT1gGu1
         7+dw==
X-Gm-Message-State: AHPjjUhTcW5LKounfgH5WrrBIzvFt5YXXXqtuyvVo/kTC+pGBq4jNohz
        1OFETWx0o+FKTPwkm/PqCzTrng62UheTvn2yFTerkw==
X-Google-Smtp-Source: AOwi7QAkD8IArQWRc28+plC9nUZADIWD0ui1Ug4AE4/RUcFS9qHAmyY/FAZl/pGzHWhDKRfLXij8fpkvnT/R1gjdXZU=
X-Received: by 10.55.127.7 with SMTP id a7mr9085698qkd.45.1505937350972; Wed,
 20 Sep 2017 12:55:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 20 Sep 2017 12:55:49 -0700 (PDT)
In-Reply-To: <1505542931.27598.4.camel@gmail.com>
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com> <20170907220429.31312-1-sbeller@google.com>
 <1505542931.27598.4.camel@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Sep 2017 12:55:49 -0700
Message-ID: <CAGZ79kaN4nKwGXq9t+Lv9e4X6qkBUAj4S8gofrNj3VZYw1sv+w@mail.gmail.com>
Subject: Re: [PATCHv3] builtin/merge: honor commit-msg hook for merges
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 11:22 PM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Seems 'Documentation/githooks.txt' needs an update related to this
> change. Previously it said(note the **s) that 'commit-msg' is invoked
> only by 'git commit',
>
>     commit-msg
>            This hook is invoked by git commit**, and can be bypassed with the
>            --no-verify option. It takes a single parameter, the name of the file
>            that holds the proposed commit log message. Exiting with a non-zero
>            status causes the git commit** to abort.

Yes that needs an update. When writing the patch, it read ambivalently[1], such
that I decided to not include the update to the man page.

[1] at the time I was reading it as "when producing a [git] commit", instead
of "the command `git commit`".

I'll send a patch fixing the docs, though with this thought, maybe we need
to fix other commands, that produce commits as well?
(git revert, others?)


>
> ---
> Kaartic
