Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A86F20372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbdJMAYn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:24:43 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:55788 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbdJMAYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:24:42 -0400
Received: by mail-qt0-f173.google.com with SMTP id v41so6583575qtv.12
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UlaFaRfV2DkV2zPC1LCbvE8K3aLDU0k0UTNi6oCI13s=;
        b=iXfoRtDDqjd7jST7Dt0skCD2ncVvwT6NeRD33XdC1665DhfcaXis/i1vJdJvn168gk
         9/1VJXlIOWyVB/nk5HevSI3npesAgC3hOIHOsKAlqIa2Bpsl2i2qu6ME6dijcwvB/knK
         suyRDotasLOUvrXVLdKE6qc4PphyGfxz1etiIGeFMSTnlg7wN8Y/jqDfywlVzB9gRR3m
         WVB/sFbJhmJ6QV8SBFiKqBzoj/ncheqmsmv8tVBtS2UH37gO4306KlTOXZGDwipFl1qY
         osDo4aAW2yMwgfpWweHwEOLOKpJPEvHREcEHK1TCGphGtPN1eLHcy4cE2S+W98hezo1+
         FI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UlaFaRfV2DkV2zPC1LCbvE8K3aLDU0k0UTNi6oCI13s=;
        b=Snrk5pQXfnXyOxYWPhR2EXizEG9mn/+knS31+p3Z1/pI56A8qc44ovrowpPipF/uA7
         ZJ9yJLGHj7G4ROP+qBxKWYezC6CCg+19PXJsNBI9iKHVH64gIUru0lwM9a3CIIYKjmwQ
         XXIIgyRrtshyZhqCcUgDPAgxfC4Wl9uzWVpc26xm3MpWM1kpV9KnDTaAbVtpv3IkXVbW
         afjhlPoq0rFj6lc0ZbDC5DyN3kQbCx7WAc3wwLQI/4tiWOzgUMVM+AppdY1wV29ES9BG
         kQ/c5a4MWjnNXu5q5CmSF4JRF+rgeYlkoxEyobUabceDRkWllvCK4pgKEj+65ZU8OX5S
         OmLw==
X-Gm-Message-State: AMCzsaU74wo4AbQdNLj7RTMilTngvYAokXQochRTs3Bx/fXqTqewtwnS
        9peMooL5uxwTQNO7QHfNC7pPmhi5hmEH4KXYguDhgacVQ6k=
X-Google-Smtp-Source: AOwi7QAoTwLUoVZ8XrJQtdbWqSgWSHXxQuoXLfJsGKYJSm4FgUcXLMrNF46xOXPUen4qxxFwucG/tzA4VDNVFMifV0c=
X-Received: by 10.200.41.89 with SMTP id z25mr6270679qtz.79.1507854281854;
 Thu, 12 Oct 2017 17:24:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 12 Oct 2017 17:24:41 -0700 (PDT)
In-Reply-To: <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com> <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Oct 2017 17:24:41 -0700
Message-ID: <CAGZ79kbBb=MOK5MsDNXeTwvrYPgnmVsfMEcGhMq_iWurkzETQA@mail.gmail.com>
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 5:20 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 12, 2017 at 08:18:37PM -0400, Jeff King wrote:
>
>> Fix this by entering the conditional only when we actually
>> see whitespace. We can apply this also to the
>> IGNORE_WHITESPACE change. That code path isn't buggy
>> (because it falls through to returning the next
>> non-whitespace byte), but it makes the logic more clear if
>> we only bother to look at whitespace flags after seeing that
>> the next byte is whitespace.
>
> I think there actually _is_ a bug in that code path, but it's unrelated
> to this one. If you have whitespace at the end of the buffer, then we'd
> advance *cp until it matches *endp, and then return whatever is at *endp
> (which is nonsense, or probably a NUL) rather than returning "-1".

Good catch! This plays together interestingly with
IGNORE_WHITESPACE_AT_EOL, too. If that is set the endp is just put
further to the front, so we'd actually compare white spaces after endp.

If that flag is not set, we'd get NUL or nonsense.

> I'm out of time for tonight and not familiar enough with the color-moved
> code to come up with a reasonable test case quickly, but maybe you can
> see if that can trigger bad behavior?
>
> -Peff
