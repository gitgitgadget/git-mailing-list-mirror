Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1D61F404
	for <e@80x24.org>; Thu,  6 Sep 2018 18:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeIFXRC (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:17:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37206 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbeIFXRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:17:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so12243797wmc.2
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FF2Q782CwzKO1dRLj6Gfrgaz5kd4klcaGBMOKotrwnc=;
        b=liJX9o4xAW+9qubMvCk/KUYHHfrUz6zFMy6MZdqJeH6xsyjk5KoZFQEBjquF+RIFPH
         XewAkgqG54TabDg5z1kf7F9k+czqjLETuJLqWlFF+Xefwd6VmWZpYBceAsGA4ehB5RKR
         VzMBOle0+ZgPiygnIcUAwumHLhrC/HkavqDJpI4Lq7A6mugmpHIj9YU1E5JJblfE2oSz
         zgyRlQphmIS87ZQCXQo79SVmuW1o4KZnpbpMYa42SGlzwZbX16hd2JjX7p1DU+VMdSnJ
         0JjSFX8S+rWJYpLj4If+O6SGdt89f2uA+woM7kh4qoKSSzv/7g5UP6/keW2ZoXFxdEJR
         xtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FF2Q782CwzKO1dRLj6Gfrgaz5kd4klcaGBMOKotrwnc=;
        b=GIzDG+tjvrNTj1R7RB2HOj0cIgovneceKvfsMB7zsc1jmfDExX5Wyo1BWA1xIAxH2P
         ISDcSNEHsVYaplRf3D7NCHyhqqtGGDSWjP0uX4WADWWFvtOpZliTLbpcjBI1X8CcavA3
         LSc3zj5V6F41tPhgEhAR3VuLZlPGRLZL7kgBGnoHtrm7C7QyccexhyrmhYLcMLU+blRg
         vNDBsXnSiqnKmxY/8hofcFGmxR87/c1fSDdPQQ1VMlxQZYIhKyTmdnswWfA2MLMVR8jF
         grj5Rl7F/7KUYFl2gYQtdmGtmXwYunOuE2O0D0m3WtGx79yE0/n2KhYSYw7M3g0y5gkY
         z9mQ==
X-Gm-Message-State: APzg51BQRJgCUCu8VzesoV1plFQvlZzkERxPWa+LftpmfTvx5KoOv2iw
        7L9goPKCuvMraIUB6x1hqTw=
X-Google-Smtp-Source: ANB0VdZtivQnJmERsTMUFvVZBqyxLKLHpRUOGFZAvZapb5cchtQd6Wi4nRKx1XSg+r54XPjWp31xMQ==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr3181680wmf.114.1536259215747;
        Thu, 06 Sep 2018 11:40:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v133-v6sm8062087wma.36.2018.09.06.11.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:40:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
References: <20180905085427.4099-1-timschumi@gmx.de>
        <20180906101658.1865-1-timschumi@gmx.de>
        <20180906145942.GB1209@sigill.intra.peff.net>
Date:   Thu, 06 Sep 2018 11:40:14 -0700
In-Reply-To: <20180906145942.GB1209@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 6 Sep 2018 10:59:42 -0400")
Message-ID: <xmqqy3cezcz5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 06, 2018 at 12:16:58PM +0200, Tim Schumacher wrote:
>
>> @@ -691,17 +692,23 @@ static int run_argv(int *argcp, const char ***argv)
>>  		/* .. then try the external ones */
>>  		execv_dashed_external(*argv);
>>  
>> -		/* It could be an alias -- this works around the insanity
>> +		if (string_list_has_string(&cmd_list, *argv[0]))
>> +			die(_("loop alias: %s is called twice"), *argv[0]);
>
> I pointed this out in my response to Ævar, but I want to make sure it
> gets seen. This call assumes the list is sorted, but...
>
>> +		string_list_append(&cmd_list, *argv[0]);
>
> This will create an unsorted list. You'd have to use
> string_list_insert() here for a sorted list, or
> unsorted_string_list_has_string() in the earlier call.

Correct.

Also, normal users who have never seen this loop that implements
alias expansion would not have a clue when they see "called twice".

I actually think the caller should also pass cmd to run_argv() and
then we should use it (and not argv[]) in this die() message.  When
the original command was foo that is aliased to bar, which in turn
is aliased to baz, which in turn is aliased to bar, especially that
"git foo" invocation was in a random script written six weeks ago by
the user, it would be a lot more helpful to see 

    "alias loop detected: expansion of 'git foo' does not terminate"

than

    "loop alias: bar is called twice".

given that 'bar' is not something the user called, or written in the
script she wrote six weeks ago.

> It's unfortunate that string_list makes this so easy to get wrong.
>
>> +
>> +		/*
>> +		 * It could be an alias -- this works around the insanity
>>  		 * of overriding "git log" with "git show" by having
>>  		 * alias.log = show
>>  		 */
>> -		if (done_alias)
>> -			break;
>>  		if (!handle_alias(argcp, argv))
>>  			break;
>> -		done_alias = 1;
>> +		done_alias++;
>
> I don't think anybody cares about done_alias being an accurate count.
> Should we just leave this as-is?

Good point.  The only caller treats it as a bool (i.e. "should the
failure be reported as failure to expand an alias cmd which resulted
in (updated) argv[0] that is not a git command?").
