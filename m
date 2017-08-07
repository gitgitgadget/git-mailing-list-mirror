Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0DE2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdHGSIV (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:08:21 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36392 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdHGSIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:08:20 -0400
Received: by mail-pg0-f42.google.com with SMTP id v77so4495006pgb.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4k/VuD93jzHuFXJUiw18XvD1J70aRzAcImZQF0X6rXw=;
        b=sA3+0ylCnhzBa3Fo0FT0uex6oDUYO1WjAkH3jkmc9CeU1Lt8LCHrST9O4Z/2u6V9Bl
         1NW9VW95ROiS1EX+gpuEQNOR+9mfputzPcIJozAM3zAGN+dA5AL99GCNfSAG/YCemEEp
         KdSAd4m/pdPgt70ONpuUTqQUhVCTYeKcrR2dMXsRSzIm1Ap17CWBKQb0tLx0PYDOBEXv
         wo9k2qiXoMTyL1gszS4vB8UkMo1WdfgkE1xrl1MuYH9JrSNDwSaN1VGQrg+KPHsHriuW
         r3riSUDUOPa7D3H02O6KsmmoZHWo3mOqj1RtWAi3eCoB0xR1LhRbzcc1fFaMXWzxwXWw
         jWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4k/VuD93jzHuFXJUiw18XvD1J70aRzAcImZQF0X6rXw=;
        b=WpyBUQNL+V9IP6Bsl1OpRUW+0oDsKakxUEQAySC+w63zXoVim4hgM999UUfuJUKwKV
         ourQ7EOvYeVS69Bmc2nW6yQwu4YCq8nhI88KztfQrkl5taGc8EeU+DcY9Gs68nmXA7nF
         myioepCtFzhVmuUiBC6IQTGFokXKlC02UYX1p9A7i/AnR+q0iLseBzk2AUfnRrZTovKb
         R+/55mvP+IAQFPhsGzqZpOOBoDDoViovcOsnS4K63jZ3O95cRz3FXr2nOv+o0j0oLTSX
         Odph9+VIJk/8740pMv+m3r2jX0zv3dxL/lcOFhLti7+4vCX/RRTJ2kfBomIg5abxSNpj
         NsGg==
X-Gm-Message-State: AHYfb5iSDHOr45ZCZ/bvr77ekZxt2NJx8l4zR5glctmRiZanSko3zSuZ
        KNFHjZ1oZugTNbeh
X-Received: by 10.98.157.83 with SMTP id i80mr1487052pfd.266.1502129299942;
        Mon, 07 Aug 2017 11:08:19 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a0fe:8dcf:c61c:f231])
        by smtp.gmail.com with ESMTPSA id b7sm13641752pgr.11.2017.08.07.11.08.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:08:19 -0700 (PDT)
Date:   Mon, 7 Aug 2017 11:08:17 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1] am: fix signoff when other trailers are present
Message-ID: <20170807110817.3cf7d8ff@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqfud3qndj.fsf@gitster.mtv.corp.google.com>
References: <20170807102929.25151-1-phillip.wood@talktalk.net>
        <xmqqfud3qndj.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 07 Aug 2017 10:49:28 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > If there was no 'Signed-off-by:' trailer but another trailer such as
> > 'Reported-by:' then 'git am --signoff' would add a blank line between
> > the existing trailers and the added 'Signed-off-by:' line. e.g.
> >
> >     Rebase accepts '--rerere-autoupdate' as an option but only honors
> >     it if '-m' is also given. Fix it for a non-interactive rebase by
> >     passing on the option to 'git am' and 'git cherry-pick'.
> >
> >     Reported-by: Junio C Hamano <gitster@pobox.com>
> >
> >     Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > Fix by using the code provided for this purpose in sequencer.c.
> > Change the tests so that they check the formatting of the
> > 'Signed-off-by:' lines rather than just grepping for them.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> > I'm not sure if this should be calling ignore_non_trailer() or not -
> > git commit does but git cherry-pick does not. This follows commit and
> > cherry-pick in ignoring the value of trailer.ifExists for the signoff.
> > I'm a bit surprised they do that - is it correct?
> 
> These built-in "sign-off" machinery long predates the "trailer"
> thing, so I am not surprised if they do not behave the same.  I
> vaguely recall having discussions on this earlier this year, but
> details escape me.  
> 
> Asking Jonathan, who did a series that ends at 44dc738a ("sequencer:
> add newline before adding footers", 2017-04-26), and Christian, who
> is the original contirbutor to the "trailer" machinery, for input.

Regarding ignore_non_trailer(), I believe that's because "git commit"
wants to tolerate blank lines and comments after the "real" commit
message, whereas "git cherry-pick" doesn't need to. As far as I can
tell, this "git am" case is similar to "git cherry-pick".

Regarding trailer.ifExists, the then existing behavior was to refrain
from writing a new sign-off line only if it would be a duplicate of the
last one, regardless of trailer.ifExists (as Junio says, back then, the
sign-off mechanism and the trailer mechanism were independent). I
preserved that behavior.
