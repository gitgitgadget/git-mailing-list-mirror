Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1F51F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeIDXgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:36:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52522 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIDXgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:36:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so5505948wmc.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=11DfUZA3DSy82fewBWZsuNnJ+Za1G1+l/d6HvfQ0BfA=;
        b=K8ITlEyb4E0WfGzcUkgN46qjzYZ63jfdYIByLtiSNoLpueMsDa4cAWcJGbw3rfKGYa
         UbxtZqp6id3OYkV89OuSWTYW3uw3YU538Y3+jUw5+XGLaStFTMqs/Jr10SEOrq2IO12m
         ooniArQ65DsusPtajMZ8AAUTDxT85NBET2rSP97n5ZkaNJtoa4rEKoGvDdaD46MJpfbE
         aOHREUPkN5TcrhUgumoDLIulpEzadtapWitdPZiKXdRrfoWv+z+Aff/4WDVLke1feKoK
         KvNlR2Vdtb0Kr3HtZ4avtobRr5Cf2uCqzm9+7yMX7PYYT3tPe3MPqel/UE1+WeEOpQ25
         ObGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=11DfUZA3DSy82fewBWZsuNnJ+Za1G1+l/d6HvfQ0BfA=;
        b=mW0ZuSZ4P0heHT08ltRwuZ9pjWWsGmQ/BncGFygg3heWxreCkLd6uhkwxYwoH26eG5
         z5gG5Kge4Zbyf2jqegGI0Kevue2qaByh2p53uJGuuRfTbGg3GOd9rw7Uab1YGDsfa/Bi
         w1SPrxx8PRbPR0FhXloivEgLAcf6tardi/ni4rtAVc9LIhqbRK9ue65VtB4UdM2fjbbF
         E3TNex8ps/hgtURK7H3iHFyZkFhf1Mqg3NL43qhHVi7idWOALX6OKawVbn9KdiWutu8T
         Tpv1aaWfjpajnicsttxtcBDdrEWSKfOnl3J646FcEr/9lgso/ZTwsdUI/Hx1N31SHTQk
         xpJw==
X-Gm-Message-State: APzg51CbRvrDVLlzSji18fMqUHD6cvPgF7C/G0ZmxeykWJwfC9o4iKL0
        eUhrMSxu1IrqNH4QZg7QWhY=
X-Google-Smtp-Source: ANB0VdYFTJo5GOHwKNrh8aY2ZmGt5GMc9dk4VHv9FuqJBShxodnJsjUgHg6hBAfTOjMod2cY+M7oDg==
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr3254394wmg.67.1536088180605;
        Tue, 04 Sep 2018 12:09:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d10-v6sm35228713wrv.70.2018.09.04.12.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:09:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re*: [PATCH 1/2] rebase -i --autosquash: demonstrate a problem skipping the last squash
References: <pull.30.git.gitgitgadget@gmail.com>
        <8753c4e5fba5bb9cc42fdf438f4a69e702261a15.1535759099.git.gitgitgadget@gmail.com>
Date:   Tue, 04 Sep 2018 12:09:39 -0700
In-Reply-To: <8753c4e5fba5bb9cc42fdf438f4a69e702261a15.1535759099.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 31 Aug 2018
        16:45:02 -0700 (PDT)")
Message-ID: <xmqqd0tt9j0s.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	test_must_fail git -c core.editor="grep -q ^pick" \
> +		rebase -ki --autosquash HEAD~4 &&

When merged to 'pu', this reveals that "git rebase" rewritten in C
knows "--keep-empty" but not "-k".

I did a quick eyeballing between master:git-rebase.sh and
pu:builtin/rebase.c and I think that it is the only one that is
missed, but somebody may want to lend us a second set of eyes.

-- >8 --
Subject: rebase: re-add forgotten -k that stands for --keep-empty

630a70ea ("builtin rebase: support `keep-empty` option", 2018-08-08)
forgot that the option comes with a short-and-sweet -k synonym.  Add
it back.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 87590047b3..b26f9c10cf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -847,7 +847,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 &options.allow_rerere_autoupdate,
 			 N_("allow rerere to update index  with resolved "
 			    "conflict")),
-		OPT_BOOL(0, "keep-empty", &options.keep_empty,
+		OPT_BOOL('k', "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "

