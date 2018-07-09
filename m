Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCD61F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933136AbeGIUCE (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:02:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50356 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeGIUCC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:02:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so22364256wmc.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P0RuN3SBMG91r5IkmDOYTj6xqvYtIJU/hxSBOyiqJ4Q=;
        b=VP1lNITNinzKxaw4kwQNj0JcPMpXowUw0BuKffU/WQM8CBhksCb02wQN64cfSlShVZ
         HkHi5VYJ9nOcALwIj8rDrRcMf0ln2eh0h4SNlXauOLdBTF97nQOQP3ERPe9bEQSa0IG9
         ycLSqxgutYuFvn1TNs9bVkDJi0bFmFQZY21MxE5y4dLDmsJcl6quXpbzasbD7JfHQizS
         Vso3xuxU03E6Ybpj0QY2xpnnvke6SdDEp7JgqxZDAoLXVnrXep7mCm0VOQtwJ5oYrb7b
         W8Gq0nVQUfNBAuW/eqs3puvWFh4zao2Jw2AvbF4poguKvJaXeTMW1pSmB/mtvBS3kWgi
         OQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P0RuN3SBMG91r5IkmDOYTj6xqvYtIJU/hxSBOyiqJ4Q=;
        b=hSKEZYftEuPG4OW4QADgjhu12igNJqtcYZyuXIs6qYfNrOrpy7Z8qcHX2OFQqC7Cys
         fzFa7fa6rSj/APehn0r0CJfAyjbZVz/8KGH9tQWec83/nPJ84g8V9w808sgx4StOdOrR
         Q/x6Pn5P44QxMzPJdk+D9YBqcfV+0XFyJZzVIInkaAcZel3f8++L3xcQSIcoymp5HjLR
         GvbJSLylB1F9hi0PB17kzmMv6MVzU7sFjiYnXiR68N7/NIm/9EjBvQ+TX33gto+G0Izv
         3wgyh3UAWr5YWFm/jq59EmVB1+VJh73W53Z4HmTjBLDKr1W459fcyAzPfK9HXfZ5Hsp8
         OgZg==
X-Gm-Message-State: APt69E1Ht2Z2ejJprVREoVhR9ciITwf01wK9jIQPgOpdb9BkUqp6Itlr
        iR11Hv2OZu1yAxW1m4+uMKA=
X-Google-Smtp-Source: AAOMgpcGa8O/NZREXxa/BcuhHCrQiIdcsz7DABKAsMSgwQs06TIrsvJEUFktAQUUaYYCTtEGYKSZ8w==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr13941384wmg.102.1531166520603;
        Mon, 09 Jul 2018 13:02:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y203-v6sm15890337wme.42.2018.07.09.13.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 13:01:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes.Schindelin@gmx.de, jehan@orb.com, whee@smaertness.net,
        me@ttaylorr.com
Subject: Re: [PATCH v1 1/2] convert: refactor conversion driver config parsing
References: <20180708183036.29459-1-larsxschneider@gmail.com>
        <20180708183036.29459-2-larsxschneider@gmail.com>
        <5D87BD79-983C-45D8-A284-1CFC65FBDDB8@gmail.com>
Date:   Mon, 09 Jul 2018 13:01:59 -0700
In-Reply-To: <5D87BD79-983C-45D8-A284-1CFC65FBDDB8@gmail.com> (Lars
        Schneider's message of "Sun, 8 Jul 2018 20:35:50 +0200")
Message-ID: <xmqqtvp8ch54.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On Jul 8, 2018, at 8:30 PM, larsxschneider@gmail.com wrote:
>> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Refactor conversion driver config parsing to ease the parsing of new
>> configs in a subsequent patch.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> convert.c | 64 +++++++++++++++++++++++++++----------------------------
>> 1 file changed, 32 insertions(+), 32 deletions(-)
>> 
>> diff --git a/convert.c b/convert.c
>> index 64d0d30e08..949bc783e4 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -1003,43 +1003,43 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>> 	int namelen;
>> 	struct convert_driver *drv;
>> 
>> ...
>> 
>> -	/*
>> -	 * filter.<name>.smudge and filter.<name>.clean specifies
>> -	 * the command line:
>> -	 *
>> -	 *	command-line
>> -	 *
>> -	 * The command-line will not be interpolated in any way.
>> -	 */
>> +		/*
>> +		 * filter.<name>.smudge and filter.<name>.clean specifies
>> +		 * the command line:
>> +		 *
>> +		 *	command-line
>> +		 *
>> +		 * The command-line will not be interpolated in any way.
>> +		 */
>
> I stumbled over this comment introduced in aa4ed402c9 
> ("Add 'filter' attribute and external filter driver definition.", 2007-04-21).
>
> Is the middle "command-line" intentional?

I think it was a deliberate but ineffective attempt to emphasize the
fact that the command line is used as-is, and does not get split at
SP nor goes through interpolation of placeholders using API such as
strbuf_expand().
