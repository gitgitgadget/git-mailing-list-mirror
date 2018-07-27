Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699CC1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 16:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbeG0Rbo (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:31:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388701AbeG0Rbo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:31:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so5581873wro.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pzxbg4PAcQXRQO8zxrc1A3ShaltPWOvTQw4U99EMij0=;
        b=Pif9ilNRqzyJGouB7fhOjnSoZcbRPrc+a1uXSeatcvA8bBJxcnZ72pU/nwaArcr43l
         fokR28RDJbsGOd5dpW5qel5Fc9y1zVdC2+qKZdtCXJ/BvAPaaLSBrpfooJTHM0+HBeLs
         hiK0hVLNetwX38D77YIz7CkK5/xjFpLgmRrPo+HSg1ZG7NZhCQBS/yVamkK21n0i0UIy
         G8foQpxhMMLRRDqw2gcVKzpScwcPVESqlyXOGfEcsxBBBxvNN9kBP08kSoSKuEHTlfN0
         KgmmAFsW//3ea3Q+uIE4Q+XjQ7TVNhZLzNnlNxyyITg67pcKVDqunKkqpOMhLrUzmP6o
         myHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pzxbg4PAcQXRQO8zxrc1A3ShaltPWOvTQw4U99EMij0=;
        b=KZqH6YXD3qEef3Lteiuz7kipieJUeqBBkKacGu/JU101lZYLEzvYvlEhaSwe1fRs1C
         In58JbXwHAzRf2YdEicygMkhE5D66VyBNzVdzA6IT00K80QeZ6DaV/NqYgXp9puy707C
         ETCOn3IchZHLM7V93zfBTHtuaC9UFq9EXcO2K4EDc/S1EfhLo++i9mV3kxzBpxAy49Rt
         Jg+e/YCqTkG1GcZo/Ue2GHt5juJaUhWQxDRB0xwY6BqgMb5fLHRWfDMhhq4r7dJKNTXe
         RCsDSb5RNUJbbS9sd7lU+U/twNzuRJPKyIZTSF1yvnYz7fi5rGcPztZtlOlAMi7SwY30
         Kw+w==
X-Gm-Message-State: AOUpUlGaVoC//OEcgeRqqjwWiPN8hModus4PtJ24HA8QzgIusLnQFEvN
        qQ6d0SNLxPprQZlgYnT8D5A=
X-Google-Smtp-Source: AAOMgpd3IBWrWb7cHF89RonqYS5fCj7MAy+1S6GaoKuKLfncYEgL2FkaOUUo0X/V6tMwtRuMTsOoPA==
X-Received: by 2002:adf:87f1:: with SMTP id c46-v6mr5229346wrc.246.1532707747990;
        Fri, 27 Jul 2018 09:09:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r140-v6sm8591738wmd.7.2018.07.27.09.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 09:09:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 1/4] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180726155854.20832-1-phillip.wood@talktalk.net>
        <20180726155854.20832-2-phillip.wood@talktalk.net>
        <xmqqin51pz5u.fsf@gitster-ct.c.googlers.com>
        <b28e1f88-bc87-2f57-ba41-cc4a67c9a5b0@talktalk.net>
Date:   Fri, 27 Jul 2018 09:09:06 -0700
In-Reply-To: <b28e1f88-bc87-2f57-ba41-cc4a67c9a5b0@talktalk.net> (Phillip
        Wood's message of "Fri, 27 Jul 2018 11:05:04 +0100")
Message-ID: <xmqq4lgkpsnx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 26/07/18 20:36, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>> 
>>> +sub label_hunk_lines {
>>> +	my $hunk = shift;
>>> +	my $text = $hunk->{TEXT};
>>> +	my (@line_flags, @lines);
>>> +	my ($block, $label, $last_mode) = (0, 0, '');
>>> +	for my $line (1..$#{$text}) {
>> 
>> $text is a ref to an array so @$text is the whole thing, $#{$text}
>> is the index of the last item in that array, and $text->[0] is the
>> first element of that array.  This for loop runs with $line == 1
>> thru $line == $#{$text}, so we are somehow excluding the very first
>> element?
>
> Yes that's right, $text->[0] contains the hunk header

OK, thanks.

>
>>> +		$line_flags[$line] = 0;
>>> +		my $mode = substr($text->[$line], 0, 1);
>>> +		if ($mode eq '\\') {
>>> +			$line_flags[$line - 1] |= NO_NEWLINE;
>>> +		}
>>> +		if ($mode eq '-' or $mode eq '+') {
>>> +			$lines[++$label] = $line;
>>> +		}
>>> +	}
>>> +	if ($label > 1) {
