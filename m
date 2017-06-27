Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C23F2082F
	for <e@80x24.org>; Tue, 27 Jun 2017 15:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbdF0PG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 11:06:56 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36477 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdF0PGr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 11:06:47 -0400
Received: by mail-pg0-f42.google.com with SMTP id u62so17032521pgb.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rHvxGyserXYi29iVCpyTXravZf0SP8fMTXWldw8a4sY=;
        b=hHe2uCJ8JKyqbGfjROXjKjqdyOrknVnqlfHgJIovNm3Kr5/UdmxTuvlLRUs1UTcYKk
         S+hI4ziPSyKQpO1sr1lNlAd+7QOFWZh6bVBMZn9DXqR/dYlnGt8NKuVlr6WdKm50j65V
         pi+L0jx824K9oB+nS6OdoktW7l9Qj+egJui8tqDe0gkrdRwal6er3djiEHvYa4/lesK7
         OCg3wpBp2zrpUULrHYOXDX4VcVE4FGktdbBYT6Nr4OFB80XGUks67rZUYdKwK4DgqZZr
         BFqAfBqyrzJppUb8pe6EF5e2EluCqiyjQrUIXXbeBmSPgRHA4epTeI+kHiY+XKgZBysq
         7exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rHvxGyserXYi29iVCpyTXravZf0SP8fMTXWldw8a4sY=;
        b=cnAFXoSsUd5a8bkyyohOh8bD8Stf/8FtjAJfRoq9dFKTOpxSz4TwSeRB5j9RVpBeDM
         mnOkLyBncW5vzO6c1l74bV6kvD8TIVcIY+icR/PdzAnuTdI8jcRPtfAsqf4TjovwV01k
         7yti6P2y/UbRPz7RQ0A7Tpy2pyAA4EmBZ048QKNZTrgcgFZ1litsorlO0EIIgiWlZtqO
         n6hHrUQ7/BxAH4lGCaBpgLaBQwDaFG7bt1cOdzCY+uQRCq8bT68s4cYaNjWog4BEofpu
         5ay7GBTjzrPjWvPjmVUtvn/K7FvGoBGOj1AzCx0kG1LZ0Q3uH59qDJQK1LVL/0rvC/vm
         TNjQ==
X-Gm-Message-State: AKS2vOyEupVyicba5wSP2RKQQ5d0EdsGOirePW2S3qOtBBC7FUBRfo3G
        belTZgIcnLsH4w6iRcc=
X-Received: by 10.98.111.194 with SMTP id k185mr5803544pfc.235.1498575982055;
        Tue, 27 Jun 2017 08:06:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id u17sm7436649pfa.133.2017.06.27.08.06.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 08:06:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Siemer <Robert.Siemer@rohde-schwarz.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: submodules of submodules use absolute gitdir in .git file (instead of relative)
References: <0d924a0671b642d2b8ba79af8d4fa0d7@rohde-schwarz.com>
Date:   Tue, 27 Jun 2017 08:06:20 -0700
In-Reply-To: <0d924a0671b642d2b8ba79af8d4fa0d7@rohde-schwarz.com> (Robert
        Siemer's message of "Tue, 27 Jun 2017 13:16:01 +0000")
Message-ID: <xmqqr2y531xv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Siemer <Robert.Siemer@rohde-schwarz.com> writes:

> Hello everyone,
>
> $ git submodule foreach cat .git
>
> ...shows that the gitdir registered in the .git file of submodules is relative. But if you run 
>
> $ git submodule foreach --recursive cat .git
>
> ...shows that submodules of submodules (if you have any) have an absolute gitdir starting with a slash.
>
> 1) Can you confirm that behavior?

Nobody can without knowing which version of Git you are using.  I
suspect that we had discussed and addressed something related to
nested submodule's "gitdir" pointer in not-so-distant past.

> 2) Am I right that this is a bug (at least because of inconsistency)?

