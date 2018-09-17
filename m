Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768941F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIRBRm (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 21:17:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36715 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeIRBRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 21:17:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id j192-v6so11047563wmj.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1Iq2JsehWooffiM8U6OWoerIe2+U2YWTaesrHKUCKHU=;
        b=oW6gJdh/CFb15MhYOHB6prVrGkSQE8N3KNPLYl0Y1fXb6emCkMmH6JfkE/KjNOxFn4
         iEw/1CwuXJosLXfDeF3J2GVxzIx8CNaBTCCEGnl1eLeai7d7iiehjS0Lt95QMeAJGkYB
         5ozhtkHqNLpBppRDKsE/j0ZgZwEJeGH0xgxaQmgaVGQMmGQQiI3pGZdWfe7kGMgiZ93p
         T3UfZQW/8o/+9ZugsQmPbZsYCwcRXVVCRP/1VZC1MwXQ2d44Mdm+ZzN1QjJ6Y6DBhqRV
         aXQAFUpC1Kzucv0JY2sKiNhwQvSY06y1416yUTKDA6CPoq0QvqvSRwpqXKT7t99KJFki
         rrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1Iq2JsehWooffiM8U6OWoerIe2+U2YWTaesrHKUCKHU=;
        b=igVvVgGGXEYgzHHPOXV0aKJwsLgy8RDyMTqx1doUrznqfL1QI8Ty+mhPdcjKAV/0k8
         wX9nsPiEa1kNS1sF43Hn7uP+zImSWTPGYxcQKqSmxMg0OdF9vvHZfzL6fdiMnSSQEF1B
         xdBxmuy7ST07qodyvGh8aI203h/KA47vfxWMBoHHwStXdGf+pvCjROHh56Q+EFzZzTNx
         Q/fN3yyKsaFaEcJZcYJRuSm/EnYVCABpyvN2gmd6xvui4L9Sz0TuoxR9njTT+IIYTRCB
         9Ir27/v16bzJixcBxmkyuJxCad+aXiCHC5Ju/sHzCOfhwK3jrf2GV4BPUjKb1U2Gnxcp
         9JoQ==
X-Gm-Message-State: APzg51Dnaqlrl1DZokCeJhcixpa+56PgOahUo1g6YLCrbDpkADWcQAdC
        /6lJae2zEx6CXGgsW892O6Y=
X-Google-Smtp-Source: ANB0VdYMUF076CUiuCADGn39xC/f9Kemmxq/eGYRPasHo8sAS9cdG24VJoLZ6lrkTj69RbHyDq0KjA==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr13452505wmh.134.1537213733012;
        Mon, 17 Sep 2018 12:48:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n5-v6sm20693wmh.1.2018.09.17.12.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:48:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary files on "make clean"
References: <20180830195546.GA22407@sigill.intra.peff.net>
        <20180831063318.33373-1-sunshine@sunshineco.com>
        <20180831063318.33373-4-sunshine@sunshineco.com>
        <20180917183258.GC140909@aiede.svl.corp.google.com>
        <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
        <20180917194214.GG140909@aiede.svl.corp.google.com>
Date:   Mon, 17 Sep 2018 12:48:51 -0700
In-Reply-To: <20180917194214.GG140909@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 17 Sep 2018 12:42:14 -0700")
Message-ID: <xmqqy3bz6h24.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'd rather that we revert this change altogether.  I have nothing
> against a convenient command to do this kind of non build related
> cleanup, but it shouldn't be spelled as "make clean".

OK, let's do this for now as I wanted to merge the remainder to
'master' today.

-- >8 --
Subject: Revert "doc/Makefile: drop doc-diff worktree and temporary files on "make clean""

This reverts commit 6f924265a0bf6efa677e9a684cebdde958e5ba06, which
started to require that we have an executable git available in order
to say "make clean", which gives us a chicken-and-egg problem.

Having to have Git installed, or be in a repository, in order to be
able to run an optional "doc-diff" tool is fine.  Requiring either
in order to run "make clean" is a different story.

Reported by Jonathan Nieder <jrnieder@gmail.com>.
---
 Documentation/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 623f1a866d..d079d7c73a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -331,7 +331,6 @@ clean:
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
-	'$(SHELL_PATH_SQ)' ./doc-diff --clean
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-- 
2.19.0

