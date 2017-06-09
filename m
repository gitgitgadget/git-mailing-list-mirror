Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08BA1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 17:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdFIRFW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 13:05:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33028 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdFIRFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 13:05:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so9148760pfe.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kkyb5pQGfJxNfWwX68hX3oaEc6xOFVeYg58tGslJaJs=;
        b=DYEBX6WA72wDDLMdooCy/SES6w3fGgs5xisClD/oDnA+qlZJkct8E3AvRNNXHKldc7
         hr3Upm5lZsdCcspZqWN/pFC5K0WCBExzD0GJKWsGeXau7ps+OPYK43Tc92wzxrhpjWFA
         W0Cpr1a6wwB0cPy/fVKVcd1O2RQTnj9OQa3mBj3wKzQZhVTGRT94ab63U4W6Gne0/bqE
         GwK6ZaZczeHgYMKFhGvvU27OnATgqL+Zbt3U/HLuMda3ToUdgkSVNo814+X70Bj9PABT
         WZzmwHPyzA++1A3eYgIjeFcbRxv67EjQbYWUuQvYlTEKEWo7Vy8SNuQX7QOkIdlCcsqd
         IUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kkyb5pQGfJxNfWwX68hX3oaEc6xOFVeYg58tGslJaJs=;
        b=PnRfQ3H5IKN1PV3l2jsL+063L37d6IESFsbkYn4ttejsAFRxO0xJeKam9lOr+qFT1B
         0SWCT8gYGKi0GDgPwu+TxXdsh4aGreAIyVaLpstGENFPsOaLYn/0D6lggOolIbOUU3DI
         ugbrsbHetJEaFQTuLOM4e3QFkKpzJZqAMymMTBsiehiXJVO6TZEEm67vQ70zIep0IqRw
         uG3F9uSH6T0poc1SgayhPfo0nf3hBfmqQYxNe8v5xAHOLG7g46rkPl1TX4kMGFcabVTm
         eSIA/Hq9rRFcQrgMvLyRoq1YVCeE7+DiTAtNKGjTJfC0UA3+QB/DnBqZH4xBZnBMqABy
         Aefg==
X-Gm-Message-State: AODbwcD95hyb/oooHV7nusj4Qb19QkarZWz1+TaitT9+t2dRrgIm3Cwe
        GH590FpgwvFpJmm3FCE=
X-Received: by 10.98.71.206 with SMTP id p75mr4659450pfi.106.1497027921376;
        Fri, 09 Jun 2017 10:05:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id a187sm3472019pge.45.2017.06.09.10.05.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 10:05:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] help: use early config when autocorrecting aliases
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
        <d7b77cbd688b7536aebee49df652af594d2a1293.1496851544.git.johannes.schindelin@gmx.de>
Date:   Sat, 10 Jun 2017 02:05:19 +0900
In-Reply-To: <d7b77cbd688b7536aebee49df652af594d2a1293.1496851544.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 7 Jun 2017 18:06:12 +0200
        (CEST)")
Message-ID: <xmqqink55bxs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is slightly less performant than the previous way, as the early
> config is used *twice*: once to see whether the command refers to an
> alias, and then to see what aliases are most similar. However, this is
> hardly a performance-critical code path, so performance is less important
> here.

Yeah, the list of unknown but similar-sounding commands is produced
for interactive human consumption, and the above reasoning is
perfectly sound.

Looks good.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/help.c b/help.c
> index db7f3d79a01..b44c55ec2da 100644
> --- a/help.c
> +++ b/help.c
> @@ -289,7 +289,7 @@ const char *help_unknown_cmd(const char *cmd)
>  	memset(&other_cmds, 0, sizeof(other_cmds));
>  	memset(&aliases, 0, sizeof(aliases));
>  
> -	git_config(git_unknown_cmd_config, NULL);
> +	read_early_config(git_unknown_cmd_config, NULL);
>  
>  	load_command_list("git-", &main_cmds, &other_cmds);
