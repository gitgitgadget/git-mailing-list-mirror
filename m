Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACAD1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIFCXT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 22:23:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35148 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeIFCXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 22:23:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so9240746wmc.0
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=owaHo6hwXyTOyYafO6oNhs4rJUVMbhFOhOmoU55BZR4=;
        b=LCg++rjd3csLSBW4tRjhWyKvwqsTGszex7CQDOP3ftXDsC0DU7nVoheFVzubESy6+v
         8sUqsIxUNrn3TrnHOdGBaPS4066tj4jxOHkoKVhF/OwrVAyFhSUY9ngbVxfFWBMK+Qf6
         8YYBhwA4jcy82gk6eTVhwv03YkqCSrirMslKNhZ1WJxoX1LLVU3bufnU4E1CAJkp+XkJ
         qy3JBGasJekCGtTOmGb+3RslxjVN7dfrqmNzWwZkP3AMt76I0VcSk4Xp7PgKbCSGcSfb
         nPlB2JBS2tQJGdt704VLa/Nbg6zA3nZc+Mh6jwPQnaDhfDz3j93I8JafBb6tofrpIy2C
         qT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=owaHo6hwXyTOyYafO6oNhs4rJUVMbhFOhOmoU55BZR4=;
        b=P3ANeu5UEBR4c8kMvC4bIRPh6JJfuCDrkYXAOXX4xc5laoiUs2jg+aS3BpSj0iIOsa
         V7HdgBThqVN1+yKA943EPFn9C++193bvW8TBBg3RaA/y3GRowGccwz5gth0gQLMrN02I
         HWUQSwxQuj3aYSvtABiLxHeg8pMAENytbhqMxAK1iryK32PyNsBuEi5KK8ZJwAhP6M98
         ur0nhfBYSRIfO57y8u3x/0CDFHqSX51rRFDX1bpDFkfNfz8Gk9Q83jdh6Z1AUAKrfO4M
         SmXCgJKZYGY2K/OAHg/qUhaS7IrjXv2jatSbWlSIm3V01sjgh3AzxtZjugLx2ohdT/F1
         Hl8Q==
X-Gm-Message-State: APzg51ClPoA6u++WHtk4QTLXyZ/vh01JtL95DN7cmY3LkbkvUJ3XZV01
        8K4LIq/YWZqWe6tcY0K9HT0=
X-Google-Smtp-Source: ANB0VdbTQG78zEf8UXdQvnLPnSiIIYOs5t9mbpyiOckG4QWBQRuPXLAUogTpzWF2VP/vzEURQxS6bQ==
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr203643wmc.48.1536184270515;
        Wed, 05 Sep 2018 14:51:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm2767852wmf.34.2018.09.05.14.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:51:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
References: <20180905085427.4099-1-timschumi@gmx.de>
        <20180905173455.GA2336@sigill.intra.peff.net>
Date:   Wed, 05 Sep 2018 14:51:09 -0700
In-Reply-To: <20180905173455.GA2336@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 5 Sep 2018 13:34:55 -0400")
Message-ID: <xmqqpnxr396a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This is what I've come up with to prevent looping aliases. I'm not too
>> happy with the number of indentations needed, but this seemed to be the
>> easiest way to search an array for a value.
>
> I think this approach is OK, though I wonder if we'd also be fine with
> just:
>
>   if (done_alias++ > 100)
> 	die("woah, is your alias looping?");
>
> The point is just to prevent a runaway infinite loop, and this does that
> while keeping the cost very low for the common case (not that one string
> insertion is probably breaking the bank).

Yeah, as a hack, I guess the simpler the solution, the better it
would be.

