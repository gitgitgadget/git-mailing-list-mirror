Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43AD71FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbdFPV3a (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:29:30 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34650 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFPV3a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:29:30 -0400
Received: by mail-pf0-f177.google.com with SMTP id s66so27658209pfs.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Qul1nLQ0G+KvOtDkuAgAoue1RbUsvkr5dfZGRQI4mHk=;
        b=bXdLtOPhn99IrkaRsujXG8nL4v3oW/s5loIE77ym99/Rrh78kCNWUA2hRb9dDyRHxg
         md1AY3ta4NW2x1QQX2fAF1ipvCH+AzAV33ajD7elnGrYFrW3wu8498wv6Fc8ZjKR66I6
         MMB6xfmpZ9wVNw+UR1Dko+pTMcrYjLHsLi6Ml4tOJSMvQ/lVn1a5IPuQtijoVtRmDWps
         H+lVV+gIWOlVvt3EZoLFNVVE+lSfaiaWP9OxX1XjBkf9mCZs9y6L4w9TlcCwQTZJA5sq
         47vTQCXV3BSYiMFOI7Sy0kd/HvKcbEFb1L2T59JRLAykWQqPPXLW70JYNT2HHpo00H+f
         KpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Qul1nLQ0G+KvOtDkuAgAoue1RbUsvkr5dfZGRQI4mHk=;
        b=Dc5F6TMKkzHpH+HxXvW5JjAgtIbTEfGQeb+q/kL9J615VSGF13GG3QdkirhbBtfWoq
         rF2xZHdXTT0YIrAXe/hPD4Dewe/C7t9R4B8VDFW8FEJi+NCaRVoUr9tnAUBGTqqifjhc
         abSVZFXlh82uO8uwNwGmSIIyDshiBR70uT7eEsSUihqOHquSIHFTc5O9hhP9BIfUR3q3
         OP5HJFHysNY1WYQYmKuJoSnmrxJMYAbUGYSki48BzjbbaCL+mOxvJmLolUDYcCqGW+Xl
         qpwmjlmwqb4Of5hP2ugiovLZmdpkgcdwYQcXDMZ4aST8GosGWKXHVC7nOKeFpYg6fMdb
         GZ9g==
X-Gm-Message-State: AKS2vOy+lpfGwdqTBx+nhUEnBJUUoxHRxBb7j4EcELHf2iCrIFTT9bSd
        4a9j9zLhub82Nw==
X-Received: by 10.84.143.100 with SMTP id 91mr15429153ply.186.1497648564465;
        Fri, 16 Jun 2017 14:29:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id 72sm6908241pfl.66.2017.06.16.14.29.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 14:29:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        houstonfortney@gmail.com, kostix+git@007spb.ru, sxlijin@gmail.com
Subject: Re: [PATCH 2/3] wt-status: add optional stash status information
References: <20170616043050.29192-1-liambeguin@gmail.com>
        <20170616043050.29192-3-liambeguin@gmail.com>
        <20170616121423.smdtmcmbktuit2qb@sigill.intra.peff.net>
Date:   Fri, 16 Jun 2017 14:29:23 -0700
In-Reply-To: <20170616121423.smdtmcmbktuit2qb@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 16 Jun 2017 08:14:23 -0400")
Message-ID: <xmqqinjvwrik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 16, 2017 at 12:30:49AM -0400, Liam Beguin wrote:
>
>> @@ -1642,6 +1664,8 @@ static void wt_longstatus_print(struct wt_status *s)
>>  		} else
>>  			printf(_("nothing to commit, working tree clean\n"));
>>  	}
>> +	if (!git_config_get_bool("status.showStash", &show_stash) && show_stash)
>> +		wt_longstatus_print_stash_summary(s);
>>  }
>
> This feels like a funny place to look up the config. How would you
> override it if were to have a "--no-stash" command line option?

Good suggestion.

This is a common mistake we saw in submissions by many new
contributors, and a good practice to avoid it is to start from a
command line option without a configuration variable.  I.e. make
sure that

    $ git status --show-stash
    $ git status --show-stash --no-show-stash

work well.  After that, add support for status.showStash and make
these also work well:

    $ git -c status.showStash=false status --show-stash
    $ git -c status.showStash=true status --no-show-stash

These two new ones need to result in command line options overriding
the configured default.

And have these four getting tested in test scripts.
