Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60BD71F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 09:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbcHNJvX (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 05:51:23 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35571 "EHLO
	mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcHNJvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 05:51:22 -0400
Received: by mail-ua0-f169.google.com with SMTP id n59so38484330uan.2
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 02:51:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftxLBTLtMcmpG9B1scWhBKA2sS+gYLjL2+nzztsGePM=;
        b=i3f05KakXt3R0viuJfBHw5eNp611n/CESUhpLJrXrUgRxy2NR7X+XaC7H/pMrPokhE
         p5ZUmk8bAYQMTNxxIkn+esAIFLJplZZtrsiAMRVjcNXpY7SGTn+uD+sxMzL2yTddUJ31
         RuRlZjBuBHeWVRTa2hj05ubcOAaLZ1yMdh03hH285CObC5dQdn0WcgyApl+96KESiQoU
         +81NcWHp/Or8a93E7NKUAsvV3k+pyEoUpIZTmFa8fwOJGnoqZsyd7sI0sbYmf8KZ81dH
         Jc4MYa6CTkf079rE4KwON8yIsBMQ1f+63DAeTQEV2JErTdYqlkEY/vxUfUATv1hqAleP
         8fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftxLBTLtMcmpG9B1scWhBKA2sS+gYLjL2+nzztsGePM=;
        b=O6AuC8W46Sc0NNYRYs2bSsmN9aW0b/jHye/ZO0FAgbSjUiSCuATZvCiCvV3jnqGHZI
         6+eZlNy8QKgJ5BA1Rl9yg1sp46DWZR2i/cZ2WTe0JBSyWLLMC/80S+exxfcyN51h3OMQ
         ynjlrOZbPHx6loUp13iuf6k1oUkpfcTgZW9giLXQduk8ytwsePTf8BwiED3y1InacED5
         Q4XXGry0sdgOxF3IZDSM6UKRavPmdRBWuW91jNRaxCZdDX6YfrPGYVbkP/AVooBl7MOF
         l+n5sMmWrngIv79AcNYWxCwGnF9PJz4vnDpkPqRFKod8r9EduxK4zlghaZnNtfXDgeGi
         tFPA==
X-Gm-Message-State: AEkooutw6QyjQ2AzYNxdpROf+ls38T8ATABxDor0AQN1XlA5p1KTKHZc0ogidJPT6DCCVw==
X-Received: by 10.31.76.130 with SMTP id z124mr11116107vka.107.1471129185777;
        Sat, 13 Aug 2016 15:59:45 -0700 (PDT)
Received: from gmail.com ([190.131.174.128])
        by smtp.gmail.com with ESMTPSA id 16sm3022670uaj.17.2016.08.13.15.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Aug 2016 15:59:44 -0700 (PDT)
Date:	Sat, 13 Aug 2016 15:59:39 -0700
From:	David Aguilar <davvid@gmail.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	"Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net>,
	git@vger.kernel.org
Subject: Re: [PATCH] difftool: always honor "command not found" exit code
Message-ID: <20160813225939.GA21057@gmail.com>
References: <57AD772501C207A400390148_0_15304@p057>
 <20160813103639.mxscvfyztee4hbvh@john.keeping.me.uk>
 <20160813113028.uwedje6fzuc3cuzr@john.keeping.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160813113028.uwedje6fzuc3cuzr@john.keeping.me.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 12:30:28PM +0100, John Keeping wrote:
> At the moment difftool's "trust exit code" logic always suppresses the
> exit status of the diff utility we invoke.  This is useful because we
> don't want to exit just because diff returned "1" because the files
> differ, but it's confusing if the shell returns an error because the
> selected diff utility is not found.
> 
> POSIX specifies 127 as the exit status for "command not found" and 126
> for "command found but is not executable" [1] and at least bash and dash
> follow this specification, while diff utilities generally use "1" for
> the exit status we want to ignore.
> 
> Handle 126 and 127 as special values, assuming that they always mean
> that the command could not be executed.
> 
> [1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_02
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>

Looks good to me, thanks.

Acked-by: David Aguilar <davvid@gmail.com>

> ---
> On Sat, Aug 13, 2016 at 11:36:39AM +0100, John Keeping wrote:
> > It would be nice if there was a way to differentiate between complete
> > failure and just the diff tool exiting with a non-zero return status
> > because the files differ, but I'm not sure whether we can do that
> > reliably.  POSIX uses 127 and 126 as errors that mean the command didn't
> > run [1] so it may be sensible to to treat those as special values.
> 
> Something like this perhaps?  I think this is probably safe, but it's
> always possible that some diff utility does use 126 or 127 as a "normal"
> exit status.  I'm not sure what we can do about that oaaaather than add a
> "really, really don't trust the exit status" option!


We can always add a mechanism for tool-specific error codes
later if we ever end up needing it, but this seems sufficient.

cheers,
-- 
David
