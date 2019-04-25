Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A2D1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfDYMZU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 08:25:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39928 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfDYMZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 08:25:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id k45so18983322edb.6
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=d3N29o1zOzUQKy1EjZsLprZfbqR1CY0Nd2y05TJHWRY=;
        b=jWCd0rL0Ud6OCRFNrX/ydTW+r6Qj3sv/vYJVH3qLnvquZOgpHWmq6NLjL+dagaAnLV
         5EgETbhZCXkbIWsnRaLZUhXl9kw787LzsOqUZgWuzchC7tcpeCQx92zxmFQTm3sji8eB
         CruR+xZ0hDsQL8lvTgwqwQ0unXRNONbZXru0YmewXn4cymQJ6s7nPHI90Wt1n7I2XFLj
         fiAYVpVdKcmaRrZQUAmpHBbZnsxoZ+Gog2UpbfJHbreedckyT93HWaHsatEpKNASQhfC
         w1ZNPFI1R/s2+fIar4mH8OAFuv2df8vwDW2oaHDSlt0FNJadbdaI6HGCg4mHFnMrMWfI
         bLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=d3N29o1zOzUQKy1EjZsLprZfbqR1CY0Nd2y05TJHWRY=;
        b=Yb7lnjPadCEGLjB1bQpUm0GonVj8h/kXXsuTi7YOf/ArQ435uRiGpxcegnoQ5GD1bG
         exxHwktIh6ihZgUnTcRsRXSl+WmPpq0WhUdT2/FbyKH6+9hbppeZtOsplolQ3hyPWTwF
         W+diXZEjjORyAbodXOdYHlzRoQWgNBHjqQ33aVbjGIDOx1V7pO/2Yka5Pyp1rddozB5K
         xoNELKc+lcLPp+vy+Ip3jqsWmwkqzjtw/So1nwHAM63xNO6TAujRFwVHzKHTTzap+ez4
         wYHvl9UGrFGj+ofBT8hR0MWrAmWz/S6IffNO+Y+6kRNmGefsUdUE+BTzqkQ//40jSOlB
         /N8Q==
X-Gm-Message-State: APjAAAVb2tyIXcHk+eFOHUKHXFgiczokUS7KG4GAHkXRzd482osasvzJ
        JFcOz99tAz+FOiyJ8eZ8rPs=
X-Google-Smtp-Source: APXvYqy+kiEBlGBTGlNc2D49+BdejJpUZ7G/AJw9Yfb0rHRChiYEfHilOxMHGVMuK4UokobT/uegIg==
X-Received: by 2002:aa7:dada:: with SMTP id x26mr24216939eds.77.1556195117415;
        Thu, 25 Apr 2019 05:25:17 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id r4sm1532784ejl.50.2019.04.25.05.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 05:25:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use with -G
References: <87o94vs9cp.fsf@evledraar.gmail.com> <20190424224539.GA23849@vmlxhi-102.adit-jv.com> <87mukfrnp3.fsf@evledraar.gmail.com> <xmqqsgu6zzev.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqsgu6zzev.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Apr 2019 14:25:13 +0200
Message-ID: <87ftq6s252.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> I agree. I am a bit bothered by the fact that
>>> `git log --oneline -Ux -G<regex> --pickaxe-raw-diff` outputs the
>>> contents/patch of a commit. My expectation is that we have the
>>> `log -p` knob for that?
>>
>> This is unrelated to --pickaxe-raw-diff, -U<n> just implies -p in
>> general. See e.g. "git log -U1".
>
> The reason why I found this exchange interesting is because I think
> it shows a noteworthy gap between end-user expectations and what the
> implementors know.
>
> Stepping back (or sideways) a bit, pretend for a while that there
> were no "pickaxe" feature in Git.  Instead there is the "patch-grep"
> tool whose design is roughly:
>
>    1. It reads "git log -p" output from its standard input, and
>       splits the lines into records, each of which consists of the
>       header part (i.e. starting at the "commit <object name>" line,
>       to the first blank line before the title), the log message
>       part, and the patch part.
>
>    2. It takes command line arguments, which are, like "git grep",
>       patterns to match and instructions on how to combine the match
>       result.
>
>    3. It applies the match criteria only to the patch part of each
>       record.  A record without any match in the patch part is
>       discarded.
>
>    4. It uses the surviving record's "commit <object name>" lines
>       to decide what commits to show.  It does the moral equivalent
>       of invoking "git show" on each of them, and perhaps lets you
>       affect how the commits are shown.
>
>       Or perhaps it just lists the commit object names chosen for
>       further processing by downstream tools that read from it.
>
>
> So the user would be able to say something like
>
> 	git log -Ux --since=3D6.months |
> 	git patch-grep \
> 		--commit-names-only \
> 		--all-match \
> 		-e '+.*devm_request_threaded_irq(IRQF_SHARED)' \
>                 -e '-.*devm_request_threaded_irq(IRQF_ONESHOT)' |
> 	xargs git show --oneline -s
>
> As an implementor, you know that is not how your -G<pattern> thing
> works, but coming from the end-user side, I think it is a reasonable
> mental model to expect a tool to work more like so.  And I think the
> expectation from combining --oneline with -Ux was that the -U option
> would apply to step 1, not step 4 (as --oneline is a clear
> indication that the user wants a very concise final result).
>
> Personally, I think the _best_ match for the original wish would be
> to have that hypothetical "git patch-grep" read from "git log -L"
> that is limited to the C function in the source the user is
> interested in.
>
> And until "git patch-grep" becomes reality, I would probably have
> done
>
> 	git log -L<function of interest> -U<x> | less
>
> and asked "less" to skip to a match with
>
> 	/(IRQF_SHARED|IRQF_ONESHOT)
>
> and then kept hitting 'n' until I find what replaces them, as a
> stop-gap measure.
>
> By the way, I think your thing is interesting regardless, even if it
> does not match the use case in the original thread (it actually may
> match---I didn't think it through).

Yeah it's definitely a bit orthagonal, should have sent it in reply to
something else and actually read the E-Mail, but I think it's useful.

> Because in the context of diff/log family, however, the word "raw"
> has a specific connotation about the "--raw" format (as opposed to
> "--patch"), I would not call this "grep the patch output itself,
> instead of grepping the source (guided by the patch output to tell
> what lines are near the lines that got replaced)" feature anything
> "raw", by the way.

I agree, brainfarted on not thinking about "raw". Do you or anyone have
a suggestion for a better CLI option name?

Maybe --pickaxe-patch or --pickaxe-patch-format (to go with git-diff's
-u aka --patch (i.e. not --raw) default format)? Or
--pickaxe-G-with-context or --pickaxe-with-context or
--with-pickaxe-context or --pickaxe-context ? All of these suck, but I'm
coming up blank on a better one :)

Probably the least shitty of those shitty options is --pickaxe-patch,
since we have --patch which triggers the same format, and we can
document that the default is a -G search through --no-pickaxe-patch, and
you can just tweak the format.

It also leaves the door open (unlike having *-G-* in the option) to
support this for -S if anyone cared...
