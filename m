Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1706A1F453
	for <e@80x24.org>; Wed,  1 May 2019 23:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfEAXQp (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 19:16:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37672 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfEAXQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 19:16:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id k23so594272wrd.4
        for <git@vger.kernel.org>; Wed, 01 May 2019 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aIv2POI4h+vrN1yP2//zZ0NVbNkrGsxO/McWBtX5BuE=;
        b=fGl3wcFfg5J5EK5N8vC/SUDJUvCvXs4b0H+uPaM7lH+bEGv/m7kdaX7oZJyfqILvRk
         QKhdFAxUXozlqs2xrGPLiTaeHiHI9+SxGUplOye2731FkjMPnzzHEAfhE4EqdRulfrib
         HU8ZdTMy0YG90azCvnUJ78dbpgxH2rsiO3TGNShIkNqGlVh3R3QjAbU7c7nslIUd0Ni7
         orPVqQ+SqHjAlUvO1WbId8lOnBtvqI00t7dLvcd8hlKAeyxXA//jTzhCvsHRI2lWHDzs
         WSeHlMiHgTnC4vCVt9yrXnHtXYKzoFgpXgLrey3PlFCwDVOBzHlb8b6ia659hsD3BBQm
         hCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aIv2POI4h+vrN1yP2//zZ0NVbNkrGsxO/McWBtX5BuE=;
        b=GfZQq6S4Emp9xQdsorJ+/puN3CM/JvrgmkKnfYqX/h11H2cmMMpSNOwVtnJXwuA5po
         d03xoyCamppNLGt85x1+yvM+65DUOc7gFY5xQmNZQOVrMpb/C2JPVnLoDLM8C6kj005d
         tXjEMjaABrP6giVVdLafkqLPbfm38f6L7OtrayPjhGW+k0l5c5kHqNK2m24zcknkMw3V
         znTZ5FilYowm9p1v96zd4YRCuI3LPCTer34I8YIpLaL7aw/+AmtJYxfpzSu+2Ajh8iTx
         JT/YGMeXwU0wwLx9Aa9m1JWXHnxjXeVUlzHJyx9bo6CWgoTuwlbZ86mtX/InAhU32Q6t
         ugHg==
X-Gm-Message-State: APjAAAVEZBlcSbfORQbukO1n1hIcYOQmmXB49VYt3DBPXJtEryZC5d8D
        bFdNg+ur6n7NhoJRqsLC2HRYJeQr
X-Google-Smtp-Source: APXvYqzwBf2l04/eWofEDIMmFUSly8P4/RstMFp3a7Hjymh1erZu2p1XN4gpjHqSmJzm8soQ+nFGyQ==
X-Received: by 2002:adf:ead2:: with SMTP id o18mr402009wrn.156.1556752603737;
        Wed, 01 May 2019 16:16:43 -0700 (PDT)
Received: from szeder.dev (x4db31769.dyn.telefonica.de. [77.179.23.105])
        by smtp.gmail.com with ESMTPSA id k67sm6677473wmb.34.2019.05.01.16.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:16:42 -0700 (PDT)
Date:   Thu, 2 May 2019 01:16:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase: fix garbled progress display with '-x'
Message-ID: <20190501231640.GD14763@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1904301819540.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1904301819540.45@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 06:25:35PM -0400, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 30 Apr 2019, SZEDER Gábor wrote:
> 
> > When running a command with the 'exec' instruction during an
> > interactive rebase session, or for a range of commits using 'git
> > rebase -x', the output can be a bit garbled when the name of the
> > command is short enough:
> >
> >   $ git rebase -x true HEAD~5
> >   Executing: true
> >   Executing: true
> >   Executing: true
> >   Executing: true
> >   Executing: true)
> >   Successfully rebased and updated refs/heads/master.
> >
> > Note the ')' at the end of the last line.  It gets more garbled as the
> > range of commits increases:
> >
> >   $ git rebase -x true HEAD~50
> >   Executing: true)
> >   [ repeated 3 more times ]
> >   Executing: true0)
> >   [ repeated 44 more times ]
> >   Executing: true00)
> >   Successfully rebased and updated refs/heads/master.
> >
> > Those extra numbers and ')' are remnants of the previously displayed
> > "Rebasing (N/M)" progress lines that are usually completely
> > overwritten by the "Executing: <cmd>" lines, unless 'cmd' is short and
> > the "N/M" part is long.
> >
> > Make sure that the previously displayed "Rebasing (N/M)" line is
> > completely covered up by printing a terminal width worth of space
> > characters.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> 
> Makes sense.
> 
> > This issue has already been present in the scripted rebase as well.
> >
> > As far as I could tell, if any other rebase instruction prints a
> > message, then that tends to be so long (including abbreviated commit
> > OIDs and whatnot) that they practically always overwrite that
> > "Rebasing (N/M)" progress line (well, except, perhaps, when rebasing
> > billions of commits at a time?).
> >
> >  sequencer.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 546f281898..c2e4baa90e 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3631,6 +3631,12 @@ static int pick_commits(struct repository *r,
> >  			int saved = *end_of_arg;
> >  			struct stat st;
> >
> > +			if (!opts->verbose)
> > +				/*
> > +				 * Fully cover the previous "Rebasing (n/m)"
> > +				 * progress line.
> > +				 */
> > +				fprintf(stderr, "%*s\r", term_columns(), "");
> 
> IIRC there are terminals (`cmd.exe`?) that would advance to the next row
> automatically when printing the exact number of columns in a row. So this
> would not work.

Hrm, I though about using 'term_columns()-1', or moving the '\r' from
the format string to the string to be printed, but in the end didn't
do either, because it seemed to work well as it is in the two
terminals that I tried (on Linux).

> But isn't there an ANSI sequence that we can use?
> 
> *clicketyclick*
> 
> Yes: https://github.com/git/git/blob/v2.21.0/editor.c#L101 (introduced in
> https://github.com/git/git/commit/abfb04d0c7#diff-cdeec438beb851e450b94a11db9ab7edR89)
> 
> So maybe we should do the same here, i.e.
> 
> 	fputs("\r\033[K", stderr);

Oh, that would be nice (and not only here, but it could have made the
changes in 'sg/overlong-progress-fix' a bit simpler as well).
Unfortunately, however, it only works on non-dumb terminals (note the
'!is_terminal_dumb()' call in the preceeding condition), while rebase
hasn't had such a limitation on the terminal yet.

> Ciao,
> Dscho
> 
> >  			*end_of_arg = '\0';
> >  			res = do_exec(r, arg);
> >  			*end_of_arg = saved;
> > --
> > 2.21.0.1181.g24122a4251
> >
> >

