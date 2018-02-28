Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24E91F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935356AbeB1W3q (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:29:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37818 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935151AbeB1W3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:29:46 -0500
Received: by mail-wr0-f195.google.com with SMTP id z12so4094252wrg.4
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ggpn5HKoo2WU230cD8/fspNUz1C+yo3giXQZhD8/Sb4=;
        b=auHFU+Ojs2R0g0atKWwClz7lgc/z1VsNwYOamZzDjlY40lgutBugrBNJsALBySM1Pi
         HPpoJ+zSSB2LHvg2rkGUTPzv4JZNwoF1WnmKCbu4XD7hlap54G/BF6Xu6MCbR6Wc1Ac3
         yW/8yfJWWqptt5rRMyIDbnvf2/37/k9Np/LnRItTBYIfUIr5DsdUdoJY0JG/MjOhRZON
         AUYpSt2yTgZzWvyFlPAXl9w/v7jU/mpuFpHjy+2CW67giP5wc5ZZRgib/Pc3L4FUiA+z
         5fgljQZabIuofJq6NLRlLv5lWScPXS2B9aoONAsmJ88pnyLSiCaHo8+dWnewJWWGFs13
         k3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ggpn5HKoo2WU230cD8/fspNUz1C+yo3giXQZhD8/Sb4=;
        b=geiP4n6CWonN6CLXTLYYJftSWFaTYKw/cgiowZKwKh449f+mnGvPvKvdjvHWEVVOlc
         337Raai3t9ov9Zx6C9oQH7t3FpBN8ewTtrv1i9zOpCrPRZ+/Uy8X7GVmk3staVHI7EuT
         eRj45kleaoJgjztLGlYjf4sxFuixB509u8GqfhTzxVFwuisYmZdFt40igxlAjO8dI37W
         vePdP5kvSTpAxlcqHpBpXewqLdJTmwv6HDrkmQaKPf96bMO6kDFxBZvJ9tzOnITXruM5
         dyKsmFVHO/mJDKk+yzy8WlgkC6H+rFrQcO0NHEaZrLgoYcMnK5cT4Fwe/S/9eibJKFfQ
         DtKg==
X-Gm-Message-State: APf1xPB+2ztRXOdbeF00Afp060reqIU6bpCrmOsGCFlE//SZG49e0keA
        GRpXE1F2LTfQFtpYWC34gnI4Ioc7
X-Google-Smtp-Source: AH8x225vFRJ7gJiMQAJIR3OZhbpNBSoCcoqhKc082A2RD0nI6wOVcoa3SqbKTrZDW8HHMqjwYMD8BA==
X-Received: by 10.223.178.26 with SMTP id u26mr18231755wra.63.1519856984577;
        Wed, 28 Feb 2018 14:29:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w134sm2823138wmd.45.2018.02.28.14.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 14:29:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: run git gc --auto just before the pre-commit hook
References: <20180228221358.16286-1-avarab@gmail.com>
Date:   Wed, 28 Feb 2018 14:29:43 -0800
In-Reply-To: <20180228221358.16286-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 28 Feb 2018 22:13:58 +0000")
Message-ID: <xmqqzi3siw88.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the behavior of git-commit back to what it was back in
> d4bb43ee27 ("Invoke "git gc --auto" from commit, merge, am and
> rebase.", 2007-09-05) when it was git-commit.sh.

... which was to run it just before post-commit.  Do I retitle this
patch before queuing?

The code seems to run it "after" post-commit.  We need to explain
why we chose to run it differently from the old practice, when we
claim we resurrect the old behaviour with this change.

> Shortly afterwards in f5bbc3225c ("Port git commit to C.", 2007-11-08)
> when it was ported to C the "git gc --auto" invocation went away.

So this is a decade late regression fix?  As they say, better late
than never, probably.

> @@ -1608,6 +1609,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	rerere(0);
>  	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>  	if (amend && !no_post_rewrite) {
>  		commit_post_rewrite(current_head, &oid);
>  	}
