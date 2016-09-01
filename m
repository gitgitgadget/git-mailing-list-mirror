Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C151F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbcIAWdk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:33:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36078 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbcIAWdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:33:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so489287wmf.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KSnFVU6KcIJFdQF3Ea38o5IfITeNkHcfui7GHcPmBzo=;
        b=K2OvS+un92Hr4OJhzU7Nf8xHUvKBp4Ar1w+oZpAAfpBJvNJVH2uR4IDHk6aiRgXGQM
         wqsjB4KkGoG2MIywVpO3yr2M26K/oz2j96aRpf9gsvqn+KLdhSznf7hZFQe1/QjyHHro
         lq5B2+awomAGvN5Se83egM52z56E86RiQNtPkUPqORtSuej1aPNAAg+q5kIC/RI4yg1j
         QDvcrP8ONjVET0VrpPej0s07TqvsCwbdgoNtsQqFg3TXOIDtscQGSfnPADKzgaE6uPdz
         d6uyId6+hFNQAccH4AqrjbcKyP75Zc19pySdgR7LVp1+aGd1ozvPQHn5diPqNkarBlRc
         9VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KSnFVU6KcIJFdQF3Ea38o5IfITeNkHcfui7GHcPmBzo=;
        b=PtFg9bXJaAEbXupYUcH8n4AqC7H8keFU4iOTmPIHNLAg9FMgIZrh/sOxGiHhbObSxN
         mTssBOu/kfORZSLMbzoT7xXRv7knpYSQ1Dxhlff0yQ1+nqCjFx0yslz9ww6Cz2ql0jCr
         4gN14m9AQzHERqmnIygqzV9Ojw+/1OQBYeNmnqh/YgkUnJ0zeSe8ojd1ENhIyiWqZ7Jl
         UFOYDflSyEgqKZ0mrIz5UN4H+GYzjBXJdNcLxjDxyZogtobnYc3xWwWE74Zy7B7SUeAM
         3uAYTnFmJcFQI7sLX7iw2LYltjU0AKkvWyrRuVgtygp5Yi0oOIVxJf7zyAD7E0PUZR5A
         boBQ==
X-Gm-Message-State: AE9vXwOfGGnjILta4x0C5XaQGKwPAYiUueUQ1mRoo6q/GkkLl1TVv5tCqZzGV0sZf/gHSA==
X-Received: by 10.194.87.169 with SMTP id az9mr2179738wjb.81.1472769215694;
        Thu, 01 Sep 2016 15:33:35 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id va3sm7402812wjb.18.2016.09.01.15.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 15:33:34 -0700 (PDT)
Subject: Re: [PATCH 10/22] sequencer: avoid completely different messages for
 different actions
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <1e940c58329ff5f224ec5bc48927a28ff4d1bf66.1472457609.git.johannes.schindelin@gmx.de>
 <30b04497-dfb8-914b-42c4-8bc66347d347@gmail.com>
 <alpine.DEB.2.20.1609010950150.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <198780d4-dbef-c0cc-fb4c-fc8986a33002@gmail.com>
Date:   Fri, 2 Sep 2016 00:33:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609010950150.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes

W dniu 01.09.2016 o 09:52, Johannes Schindelin pisze:
> On Wed, 31 Aug 2016, Jakub Narębski wrote:
>> CC-ed to Jiang Xin, L10N coordinator.
>> W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:

[...]
>>> -	/* Different translation strings for cherry-pick and revert */
>>> -	if (opts->action == REPLAY_PICK)
>>> -		error(_("Your local changes would be overwritten by cherry-pick."));
>>> -	else
>>> -		error(_("Your local changes would be overwritten by revert."));
>>> +	error(_("Your local changes would be overwritten by %s."),
>>> +		action_name(opts));
>>
>> If I understand it correctly, it would make "revert" or "cherry-pick"
>> untranslated part of error message.  You would need to use translation
>> on the result with "_(action_name(opts))", you would have to mark
>> todo_command_strings elements for gettext lexicon with N_(...).
>>
>> I am rather against this change (see also below).
> 
> Okay.
> 
> Unfortunately, I have to focus on the correctness of the code at the
> moment (and Git for Windows does ship *without* translations for the time
> being anyway, mostly to save on space, but also because users complained).

Users complained about having translations, or not having easy way to
switch them or switch them off?

> 
> So I will take care of this after v2.10.0.
> 
> For the record, how is this supposed to be handled, in particular when I
> introduce a new action whose action_name(opts) will be "rebase -i"? Do I
> really need to repeat myself three times?

I think you should be able to mark strings to be translated,
without translating them at the time of definition,

  static const char *todo_command_strings[] = {
  	N_("pick"),
  	N_("revert")
  };

then translate at the point of use

  	error(_("Your local changes would be overwritten by %s."),
		_(action_name(opts)));

I assume that action_name(opts) returns one of todo_command_strings.
If not, there should be array with possible actions.


Assuming that such lego l10n is preferable to multiple translations,
more free-formt.

-- 
Jakub Narębski

