Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B441FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbcLIX4U (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:56:20 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34252 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbcLIX4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:56:18 -0500
Received: by mail-qt0-f179.google.com with SMTP id n6so30766962qtd.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 15:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vEpjBvCrzGkpXELpcCyViOSFCnVSE4PgaD2k6GXAWDk=;
        b=lbNaBphf/P+3CR6jr5G6c+nbKqfM3UlhXit9KUavDvgNv8TmM9OFirmbzWpIaimBUN
         RVnVDtzHphZf7ZOm7cFdaGz8WX42hpyAtA5RYkgl7HJeUMNfxoh0s8BXOz0+chgQ2jNW
         P4+yje5OoZgF6bHoOsSS2f9+L7f/nu1NvMWDzr48NrediKcRaYRBn+nH5zaIQwZhVFOa
         QtTYGLp8yHnAbSvhWebM0H6ove6ZO7l+0icBo/huzj6RzKra9JlQr6Z/+HHMSM0qERUI
         X+QrYOTF28fBERdWXNbLspN+YW9+mYGXYm2Q5+bNyYRBM0WjWMEOiL/OrnxP9p+bfroL
         RGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vEpjBvCrzGkpXELpcCyViOSFCnVSE4PgaD2k6GXAWDk=;
        b=flGY3XdMD2Dk0C8rabU4A7EyEsYYmKcq4ZmVaoKJfcSdsunmisnNgSKz1pJQ4H54Nl
         8/UOP95K1yd5XmKJRusYCWkHNus89R02Nf3wlfyAZ4BW2Eppg+eWqKyaFq0t7advjVhZ
         0hU5WUiee+A0UVuhheHUMqLvGZ3u5A9IGtuLpU8WemE/JN/ZNuPjmeJkE9bzmnapBd9J
         /4p4l3/BOV2GJr5+AA7umTJlkyXPZrmz2Tsf77aDgFMHHBZKNCzxDUIjtPOGrmyDr32b
         cWw4kXjFRfiFXTHn7MwvROH6zhmU17IG9FZuaRHkTGJiQ8u+6fYVBc3Ayj37e73vp8SL
         YPfw==
X-Gm-Message-State: AKaTC016nlS+dGHb73ypymZkfRAQDlbMJmrD+SHqcAqHpqAzjmuyrV3exEZKWvHizE9FWwXq47Vb7wZemN40WITH
X-Received: by 10.200.50.53 with SMTP id x50mr72146279qta.207.1481327777685;
 Fri, 09 Dec 2016 15:56:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 9 Dec 2016 15:56:17 -0800 (PST)
In-Reply-To: <xmqqshpwpsn8.fsf@gitster.mtv.corp.google.com>
References: <20161209203449.17940-1-sbeller@google.com> <xmqqfulwraq2.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaqw=XqrNF5+Ta8CwcD7FyA853UQUdMxHmBAaMHPMHrXg@mail.gmail.com> <xmqqshpwpsn8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Dec 2016 15:56:17 -0800
Message-ID: <CAGZ79kZKify7VLfNp3FXXvc4UOGjdXfUaspNaeW0t5+hWc+cpw@mail.gmail.com>
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending email
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So you are suggesting to
>> * have the check later in the game (e.g. just after asking
>>    "Send this email? ([y]es|[n]o|[q]uit|[a]ll): " as then other information
>>   such as additional @to @cc are available.
>
> Yeah, probably before the loop starts asking that question for each
> message.  And hook does not necessarily need to cause the program to
> die.  The question can be reworded to "Your hook says no, but do you
> really want to send it?",

You could, but that would be inconsistent with the "*** SUBJECT ***"
treatment, which currently dies. That could also ask "do you really want
to send out an unfinished series" and continue if the user wants.

I assume we want to be consistent with the existing UI and just ask the
user to use force instead?
