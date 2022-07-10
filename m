Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC87C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 22:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGJWNR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 10 Jul 2022 18:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGJWNR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 18:13:17 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224B4BE03
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 15:13:16 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26AMD8ZF040604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Jul 2022 18:13:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
In-Reply-To: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
Subject: RE: Automatic code formatting
Date:   Sun, 10 Jul 2022 18:13:01 -0400
Organization: Nexbridge Inc.
Message-ID: <006c01d894aa$3b9f33b0$b2dd9b10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJx/GmjE7b2KfIXtW66dZbrqQtAvaxFWZ6w
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 10, 2022 5:50 PM, brian m. carlson wrote:
>In the past, we've discussed the possibility of using an automatic code formatter
>for Git.  That discussion has, as we've seen, not led to us using one.  I'd like to
>reopen the discussion and provide a couple reasons why I think it's a good idea.
>
>We've spent a lot of work encouraging newcomers to contribute to Git.
>It's demoralizing when your code comes back with many code style nits to fix, and
>it leads to a barrier to contribution.  I also find that I am likely to take longer to
>reroll a series if there are many nits to be fixed, and I find that code style
>comments are a frequent discussion topic on my series (even though I generally
>try to be cognizant of them).
>
>Having a code formatting tool means that the work for a contributor to format the
>file properly consists of about two keystrokes.  This substantially reduces the
>amount of time that contributors must spend thinking about code formatting and
>simplifies it to an automatic process that, if we choose, can even be verified in CI.
>
>Most projects written in languages like Rust or Go use an automatic formatter.  In
>Go's case, the formatter is specifically stated to be a fixed style that is nobody's
>favourite, but because there's an automatic formatter, everybody just uses it.
>Personally, I don't love our coding style now (I'm a 4-space person in C), but I
>would love it a lot more if I didn't have to think about it.  I am substantially less
>picky about what the style is than that we have an automated tool to tidy our
>code, and I'm okay with us producing the occasional slightly suboptimal style for
>the improved efficiency we get.
>
>The impetus for me bringing this up is that I'm rebasing the
>SHA-1/SHA-256 interop work to continue work on it and I find myself spending a
>lot of time cleaning up formatting that I could instead be spending on debugging
>why my tests are failing or writing new code.  I would like to spend less time on
>boring scut work and more time solving interesting problems, as I'm sure we all
>would.
>
>I should point out that most platforms (and all major platforms) have clang and
>therefore I think clang-format should be a fine choice.  It's highly configurable and
>will let us pick a style that most resembles the one we have now. However, I'm
>not picky and if we like something else better, great.  As long as the option we pick
>is shipped in Debian, I'm for it.
>
>I should note that we already have a .clang-format file, so we can already use
>clang-format.  However, we cannot blindly apply it because it produces output
>that is not always conformant with our style.  My proposal here is to define our
>style in terms of the formatter to avoid this problem.
>
>Hopefully we can move forward with this discussion and come to some productive
>resolution.

Being one of the platforms that will be specifically excluded from this proposal, I would like to offer an alternative. Before that, please remember that not everything is Linux. My suggestion is to create infrastructure to automatically format on add/commit. This could be pluggable relatively simply with clean filter that is language specific - perhaps with a helper option that installs the formatter easily (because clean filters are notoriously painful to install for newbies from my observations). It would be nice to have something in perl that is more portable and pervasive than clang - although perl could launch clang where available. I think having infrastructure for code formatting that is built into git is actually highly desirable - assuming that it is not unduly difficult to install those. It would extend beyond git contributions, but the contributors could be told (Contributor's Guide) that then need to follow standard X, which may very well be clang format. There are java formatters, php and perl formatters, even COBOL and TAL formatters. My position is that having a standard way to plug these in is a more general plan that would reach a larger community. Git contributions could then just leverage standard git functionality.

--Randall

