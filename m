Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90C9C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83501613BE
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhEDVrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 17:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhEDVrt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 17:47:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505BC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 14:46:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a4so15461219ejk.1
        for <git@vger.kernel.org>; Tue, 04 May 2021 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXSTGAMB8/37eKSysMrpqvd9mosUiZF48ThUt62OAYo=;
        b=kChVHKqN+P/pv/IyYKNdfIyQfH78CTOiZCP7Ob4ba6wgleVIijrAtDqqle64/zyxUc
         oBEj1wVfImvC5DJIdzehIx4fzKVBthfriAAsOj6bp3Hk7gp6hAS4vWM9tHJk2p0oTl+N
         ChTmgz7XO1IUwrMZAPl9OBcfLc9lQpYjyOfBJkMF14/sK0AWLD21Q3X2A0t+eqMUXipn
         PfQ+DUw1ur77yfXIx7eF4qmtI+DRCd4Qi6E0xKz+husb+m9yKVxp8x1k9dSG+sbkfc+t
         yDTTrWe6tr0tqaHCU9gLgXir6/uF9XlbV/UMwsjgzRsGlGezQYPOhEYevZMzmXHX1g29
         XUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXSTGAMB8/37eKSysMrpqvd9mosUiZF48ThUt62OAYo=;
        b=AzVqbhyJk7DEbj1Cuz89ATrINMjJJIvd6EnzXl7FQtXeKbaf+g+olmig9etMWE/2xS
         FwwuimTCbEaL07t2uC3cX9jfZntS2vtzXbqYwMen6WsygQTlu0GM5vSaLdlL5WPN90Dn
         QZRbm4YGyNir+hFf93wTVyyToK2lNMIjyE6RrXn9zjIJb+u+SM9EVpSSAHNyrRd3scX7
         /7RSaawgkxNPvVfZIvvtzi0Q5OhZ428NQa9mrTMfRkZulHCNZbXTBp/6xQEclZXIl6vi
         Ld2VGaI+e3m2/IXRLrqEugKXr/zjZMSSN6o3krvpttOkEeKuFOpijKOF+mIQlLdcLsS7
         MHkg==
X-Gm-Message-State: AOAM533v9l70rSl91eLcISmJhmdyHzrGB6Y03b3ECYLqCmVewVGU/rNd
        XD6KJC6XkSBBJkGXF9VfSMoehpS4ukSKWanPEOU=
X-Google-Smtp-Source: ABdhPJwFzkLZ7Xn2LcZkYKO1/dOm5pWLRd5Y7BMKJOnJvPZG+3drTSaHrfSvv2S81Oca0AFlUoFFcwEN2fQfCTKfQB8=
X-Received: by 2002:a17:906:364d:: with SMTP id r13mr24926564ejb.250.1620164811878;
 Tue, 04 May 2021 14:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085251.51475-1-andrew@adoakley.name> <20210412085251.51475-3-andrew@adoakley.name>
 <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
 <20210430095342.58134e4e@ado-tr> <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
 <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com> <20210504220153.1d9f0cb2@ado-tr>
In-Reply-To: <20210504220153.1d9f0cb2@ado-tr>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Tue, 4 May 2021 14:46:40 -0700
Message-ID: <CAKu1iLXOFiUGmQUeoW-YkiiJ8P2+LznXWz4YabEiGktv=nUYjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
To:     Andrew Oakley <andrew@adoakley.name>
Cc:     Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>,
        Feiyang Xue <me@feiyangxue.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 2:01 PM Andrew Oakley <andrew@adoakley.name> wrote:
> The key thing that I'm trying to point out here is that the encoding is
> not necessarily consistent between different commits.  The changes that
> you have proposed force you to pick one encoding that will be used for
> every commit.  If it's wrong then data will be corrupted, and there is
> no option provided to avoid that.  The only way I can see to avoid this
> issue is to not attempt to re-encode the data - just pass it directly
> to git.

No, my "fallbackEndocing" setting is just that... a fallback.  My proposal
*always* tries to decode in UTF-8 first!  Only if that throws an exception
will my "fallbackEncoding" come into play, and it only comes into play
for the single changeset description that was invalid UTF-8.  After that,
subsequent descriptions will again be tried in UTF-8 first.

The design of the UTF-8 format makes it very unlikely that non UTF-8 text
will pass undetected through a UTF-8 decoder, so by attempting to decode
in UTF-8 first, there is very little risk of a lossy conversion.

As for passing data through "raw", that will *guarantee* bad encoding on
any descriptions that are not UTF-8, because git will interpret the data
as UTF-8 once it has been put into the commit (unless the encoding header
is used, as you mentioned) .  If that header is not used, and it was not in
UTF-8 in Perforce, it has zero chance of being correct in git unless
it is decoded.
At least "fallbackEncoding" gives it SOME chance of decoding it correctly.

> I think another way to solve the issue you have is the encoding header
> on git commits.  We can pass the bytes through git-p4 unmodified, but
> mark the commit message as being encoded using something that isn't
> UTF-8.  That avoids any potentially lossy conversions when cloning the
> repository, but should allow the data to be displayed correctly in git.

Yes, that could be a solution.  I will try that out.

> > In any event, if you look at my patch (v6 is the latest...
> > https://lore.kernel.org/git/20210429073905.837-1-tzadik.vanderhoof@gmail.com/
> > ), you will see I have written tests that pass under both Linux and
> > Windows. (If you want to run them yourself, you need to base my patch
> > off of "master", not "seen").  The tests make clear what the
> > different behavior is and also show that p4d is not set to Unicode
> > (since the tests do not change the default setting).
>
> I don't think the tests are doing anything interesting on Linux - you
> stick valid UTF-8 in, and valid UTF-8 data comes out.

Totally agree.... I only did that to get them to pass the Gitlab CI.
I submitted an earlier
patch that simply skipped the test file on Linux, but I got pushback
on that, so I
made them pass on Linux, even though they aren't useful.

> I suspect the tests will fail on Windows if the relevant code page is set to a value
> that you're not expecting.

It depends.  If the code page is set to UTF-8 (65001) I think the
tests would still work,
because as I said above, my code always tries to decode with UTF-8
first, no matter what
the "fallbackEncoding" setting is.

If the code page is set to something other than UTF-8 or the default,
then one of my tests would
fail, because it uses a hard-coded "fallbackEncoding" of "cp1252".

But the code would work for the user!  All they would need to do is
set "fallbackEncoding" to
the code page they're actually using, instead of "cp1252".

(More sophisticated tests could be developed that explicitly set the
code page and use the
corresponding "fallbackEncoding" setting.)

> For the purposes of writing tests that work the same everywhere we can
> use `p4 submit -i`.  The data written on stdin isn't reencoded, even on
> Windows.

I already have gone down the `p4 submit -i` road.  It behaves exactly
the same as
passing the description on the command line.

(One of several dead-ends I went down that I haven't mentioned in my emails)
