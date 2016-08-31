Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5631F859
	for <e@80x24.org>; Wed, 31 Aug 2016 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161267AbcHaR6w (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 13:58:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35946 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030312AbcHaR6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 13:58:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so8657496wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oD7foEKdUeyBjEUu+MIqjo8TfjkXjqlVQ7KtFaNWUvA=;
        b=yZSyJxSxqF1x4ckXpOq9l20S3pa+pKcWi0i/zZDXUGFfHfAtLBQWhtwcJtShMQvp1T
         gdbnRyAOF8+/K6JA6MHn3VdFfSuTPDO7C4SJlPWoNVgYt5z/NkF22eQcD3+Eu58aTEo7
         3rtlKO10y2+dDcYDnWy2mZE2AEPs03DC+/HcrXM4wYtmXSI6p0H3ou67vzsnPtbb+M7H
         43IY8D7Rj9LCB5tjPDzPSqPPaPd1Cuc0BRu9qRNiBGwi0ffjYf2mAndM/WICGZyDUe+L
         efRLRffYj5/YQuSvyuHAUhUTpCOeoF/EjY9zodnVBbCvG+42WgPSYP+AgoqHJt3QW5QR
         0D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=oD7foEKdUeyBjEUu+MIqjo8TfjkXjqlVQ7KtFaNWUvA=;
        b=Ns8K4ti5lCnVDs7rRLRiodJKInffo38rDAHebhq+PAL0keqHi9gbmXHt9JWHdFAwGV
         mP7tMMjbmiPUgb37rrdz1MuH3UU62fIXJ2rVAHtiyYymbfdJwQXIyfRX5Ev6Qt0CD4px
         DZ+e7dekwZP0aC8TW6q5uBxkYFccQruSD6tF5ZNjma1tl7oSHBPOnIlHe4FhznRXVrbn
         2T4v4LPDuWLUzbSMGWm+pRLOBqH61KiOUEoxQdgH5jo3APJBLrbI2eaqDVRzI7yKDj3y
         P3g6XxbGvWVZrsRIPyjKNpPoMv8rNAx1icnqtZ+LcuT3nUobBEPDeAusR0Q08ouqycpX
         v/4g==
X-Gm-Message-State: AE9vXwO4d4rOYsk7nnIs0emlpGsIOUMEFPwrU1VEO0AIBfFbInfoQi4OTleLyGVuIdHBAg==
X-Received: by 10.194.74.72 with SMTP id r8mr7941995wjv.176.1472666314560;
        Wed, 31 Aug 2016 10:58:34 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id g67sm10087418wme.5.2016.08.31.10.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 10:58:33 -0700 (PDT)
Subject: Re: [PATCH 10/22] sequencer: avoid completely different messages for
 different actions
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <1e940c58329ff5f224ec5bc48927a28ff4d1bf66.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <30b04497-dfb8-914b-42c4-8bc66347d347@gmail.com>
Date:   Wed, 31 Aug 2016 19:58:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1e940c58329ff5f224ec5bc48927a28ff4d1bf66.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CC-ed to Jiang Xin, L10N coordinator.

W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index cbdce6d..1b65202 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -232,11 +232,8 @@ static int error_dirty_index(struct replay_opts *opts)
>  	if (read_cache_unmerged())
>  		return error_resolve_conflict(action_name(opts));
>  
> -	/* Different translation strings for cherry-pick and revert */
> -	if (opts->action == REPLAY_PICK)
> -		error(_("Your local changes would be overwritten by cherry-pick."));
> -	else
> -		error(_("Your local changes would be overwritten by revert."));
> +	error(_("Your local changes would be overwritten by %s."),
> +		action_name(opts));

If I understand it correctly, it would make "revert" or "cherry-pick"
untranslated part of error message.  You would need to use translation
on the result with "_(action_name(opts))", you would have to mark
todo_command_strings elements for gettext lexicon with N_(...).

I am rather against this change (see also below).


From the first glance I though that there would be no problem with
translation legos / jigsaw it introduces, namely that the "revert"
and "cherry-pick" would require different rest of text:

 po/bg.po:msgid "Your local changes would be overwritten by cherry-pick."
 po/bg.po-msgstr "Локалните ви промени ще бъдат презаписани при отбирането на подавания."
 --
 po/bg.po:msgid "Your local changes would be overwritten by revert."
 po/bg.po-msgstr "Локалните ви промени ще бъдат презаписани при отмяната на подавания."

 po/de.po:msgid "Your local changes would be overwritten by cherry-pick."
 po/de.po-msgstr "Ihre lokalen Änderungen würden durch den Cherry-Pick überschrieben werden."
 --
 po/de.po:msgid "Your local changes would be overwritten by revert."
 po/de.po-msgstr "Ihre lokalen Änderungen würden durch den Revert überschrieben werden."

But it turns out that "revert" and "cherry-pick" can be of different
gender:

 po/ca.po:msgid "Your local changes would be overwritten by cherry-pick."
 po/ca.po-msgstr "Els vostres canvis locals se sobreescriurien pel recull de cireres."
 --
 po/ca.po:msgid "Your local changes would be overwritten by revert."
 po/ca.po-msgstr "Els vostres canvis locals se sobreescriurien per la reversió."

In some cases "revert" and "cherry-pick" are not translated literally
(but compare translation for similar language: po/bg.po, without this):

 po/ru.po:msgid "Your local changes would be overwritten by cherry-pick."
 po/ru.po-msgstr "Ваши локальные изменение будут перезаписаны отбором лучшего."
 --
 po/ru.po:msgid "Your local changes would be overwritten by revert."
 po/ru.po-msgstr "Ваши локальные изменение будут перезаписаны возвратом коммита."

Similar for (but here one side uses untranslated English term...):

 po/vi.po:msgid "Your local changes would be overwritten by cherry-pick."
 po/vi.po-msgstr "Các thay đổi nội bộ của bạn có thể bị ghi đè bởi lệnh cherry-pick."
 --
 po/vi.po:msgid "Your local changes would be overwritten by revert."
 po/vi.po-msgstr "Các thay đổi nội bộ của bạn có thể bị ghi đè bởi lệnh hoàn nguyên."

For some I don't know which is the case:

 po/zh_CN.po:msgid "Your local changes would be overwritten by cherry-pick."
 po/zh_CN.po-msgstr "您的本地修改将被拣选操作覆盖。"
 --
 po/zh_CN.po:msgid "Your local changes would be overwritten by revert."
 po/zh_CN.po-msgstr "您的本地修改将被还原操作覆盖。"

Unless we want to require to use English terms:

 po/sv.po:msgid "Your local changes would be overwritten by cherry-pick."
 po/sv.po-msgstr "Dina lokala ändringar skulle skrivas över av \"cherry-pick\"."
 --
 po/sv.po:msgid "Your local changes would be overwritten by revert."
 po/sv.po-msgstr "Dina lokala ändringar skulle skrivas över av \"revert\"."


>  
>  	if (advice_commit_before_merge)
>  		advise(_("Commit your changes or stash them to proceed."));
> 

