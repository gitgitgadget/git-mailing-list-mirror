Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE2D20193
	for <e@80x24.org>; Thu,  1 Sep 2016 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934388AbcIAQTN (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 12:19:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33928 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934355AbcIAQTM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 12:19:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id v143so2707508wmv.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjBqMh+zC8v3xXOetg3/u+wfrOza0tfXb52W0WU37wE=;
        b=YheOxqgzZhWXrqKpRFF3Fyw3n4jYJWe49UzF1f6CM5P+eIwwHWI5Ym2z3yWpst6qIa
         bBe85e6waCXEd9jfCSGWO9DRftO3dj4GnYu2zJRml6E5LyMLt4vl/ej/kditxj/E5lnb
         MZxDba5UBw3Zt7wS5x5NYwRVZIxQ7VDJ4vCUG8iZYNhqZu2L7zEsQ6PrwvnaAHIjByYU
         2HH2wEw85DWG4+h/q3kZ8WbhTd+4cvjYwjmT1e0Lur4xxujitJw5sHIWoXsuJAZlWXY/
         FR10BG22p4OVAjXMIXKFrVuVVTuPSWOcqqNHBUcLuM9f37Yj054GHhZzd4OtIh1faHCc
         4NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjBqMh+zC8v3xXOetg3/u+wfrOza0tfXb52W0WU37wE=;
        b=UQDufJvjMhPmDBe8BGj7FdwZTHTlkYf5JNpvFtAkyi1B9NLZYJ5UoCGUYCfG89WNY8
         tDB5xOxzI+8PNcPmVaj5dfqyB8iPWCOFcDDITsoH4Z9peU60FBODdLMLoLCBIV32p253
         KDulJz4CPzaQOsKynaoi1YtKlJAVDPmFRJX7nDQALTTjFaet/JBYgGrp1ed2yUq/ICW0
         f8HXFS5MvnvAikmWftKIYlvCEALcMZzAv7pZJufwCG4/bX+FutUU48BwRHguiLMceRaZ
         rscqpAcEgG8DcRQbUccyBjigsprDCqJXm3xZaBK4PCxAz2g0FQsGf3ZUFxwNFZjuP8xs
         E10Q==
X-Gm-Message-State: AE9vXwM3u79O+qdie+PJe9IZWvipby3mvEqJZ8vM1aqYG5oPYLN1/zI1BpKIhhc6q+L0Gw==
X-Received: by 10.195.13.18 with SMTP id eu18mr15126424wjd.121.1472746750618;
        Thu, 01 Sep 2016 09:19:10 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id wc3sm6017585wjc.47.2016.09.01.09.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 09:19:10 -0700 (PDT)
Message-ID: <1472746749.4680.33.camel@kaarsemaker.net>
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Date:   Thu, 01 Sep 2016 18:19:09 +0200
In-Reply-To: <alpine.DEB.2.20.1609011658300.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
          <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>
         <1472718808.4680.19.camel@kaarsemaker.net>
         <alpine.DEB.2.20.1609011658300.129229@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On do, 2016-09-01 at 17:17 +0200, Johannes Schindelin wrote:
> Hi Dennis,
> 
> On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:
> 
> > 
> > On wo, 2016-08-31 at 10:54 +0200, Johannes Schindelin wrote:
> > 
> > > 
> > > +static int is_fixup(enum todo_command command)
> > > +{
> > > +	return command == TODO_FIXUP || command == TODO_SQUASH;
> > > +}
> > It sounds wrong to have a function named is_fixup return true when
> > the
> > command isn't a fixup but a squash. Maybe name it
> > changes_previous_commit or something?
> I can see how that may sound confusing, unless you understand that a
> squash is a fixup that lets the user edit the commit message, too. So
> essentially squash = fixup + edit, if you will.
> 
> Maybe the name is more appropriate in that light?

Kinda makes sense. It's not how I use fixup/squash as a user of rebase
-i though. But we can't go there, that's bikeshed country :)

> > > +static const char *nth_for_number(int n)
> > > +{
> > > +	int n1 = n % 10, n10 = n % 100;
> > > +
> > > +	if (n1 == 1 && n10 != 11)
> > > +		return "st";
> > > +	if (n1 == 2 && n10 != 12)
> > > +		return "nd";
> > > +	if (n1 == 3 && n10 != 13)
> > > +		return "rd";
> > > +	return "th";
> > > +}
> > > 
> > > 8---
> > > 
> > > +	if (command == TODO_SQUASH) {
> > > +		unlink(rebase_path_fixup_msg());
> > > +		strbuf_addf(&buf, "\n%c This is the %d%s commit
> > > message:\n\n%s",
> > > +			comment_line_char,
> > > +			count, nth_for_number(count), body);
> > > +	}
> > > +	else if (command == TODO_FIXUP) {
> > > +		strbuf_addf(&buf,
> > > +			"\n%c The %d%s commit message will be
> > > skipped:\n\n",
> > > +			comment_line_char, count,
> > > nth_for_number(count));
> > > +		strbuf_add_commented_lines(&buf, body,
> > > strlen(body));
> > > +	}
> > This way of handling numbers is not translatable, and I really
> > think we
> > should mark these strings for translation, like they are in the .sh
> > version.
> Ah, this is the risk of working on something as big as rebase
> --helper.
> Back when I started with it, the relevant code in git-rebase
> --interactive
> read like this:
> 
> 	nth_string () {
> 		case "$1" in
> 		*1[0-9]|*[04-9]) echo "$1"th;;
> 		*1) echo "$1"st;;
> 		*2) echo "$1"nd;;
> 		*3) echo "$1"rd;;
> 		esac
> 	}
> 
> I merely did a faithful translation of that...
> 
> Now, I see that git-rebase--interactive was switched to use
> eval_gettext,
> which in turn is handled in git-sh-i18n whose code is quite
> convoluted. In
> the absence of gettext, it uses git-sh-i18n--envsubst, which has no C
> API
> whatsoever.
> 
> And I see that the beautiful ordinal computation was given up in
> favor of
> a lousy "#1", "#2", "#3", etc (it used to be "1st", "2nd", "3rd"
> etc).
> 
> In any case, translation is not my main concern until v2.10.0, so
> I'll
> take care of this after that release.

Hmm, not sure if I agree with that. I'd see it as a regression to lose
the i18n there.

D.
