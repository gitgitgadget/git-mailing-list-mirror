Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E929D1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeG3WYa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:24:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50298 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG3WYa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:24:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so760523wmc.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=58fzpBNk+BAFd6wiA1IcgC7r+9CEv5TsiTXNl1l4EJc=;
        b=qLF0vS7L7qIBVeLt22cTOAFo/0Wdn8+OVtqCf0MHCWoNjs/HKpVCJ2J4SYmomjk9tf
         DH5KrCgOAicBctZusnSx+KmXdsZdt8Itvj6NyVCI3DIFhThcrd0z7DVLOu8Q876Y+qGu
         NiZ0QPzV70IkDV8DHfWrSOESisRjC/ZVp3sNs95RA07ccFvIamDX3+Mo/fy78cYnLYg8
         iaRBFIc8xVSfyufsBM6KYHeyfrsYGLd1Agl10DBZRpAP+qXOGNtPlzOi7T9b4EtXLC+g
         CuXFVdBghXwmlmkiUcp83Sjoo9CBLu0cJcq3hu1g9Wk4HuldR7R6E3DUp1VK8aypG+cz
         DQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=58fzpBNk+BAFd6wiA1IcgC7r+9CEv5TsiTXNl1l4EJc=;
        b=gMJekb7XKuVNB1mO71w/jZyuToOc92itj0J2ihG7T+xHpHwwVYtvTzser3AAaS4ERO
         gSIza2HtaIscLKJfFY2k9ZrV9duplwkJj6ZUDo1slO3SN1sXqkKNAGzNfv13pnMGVRmN
         bp2dtqk20OPNsG1ou9Gr+KZrG/OZTUBQYOvrn2aHeIeWmOqXPZHPuwkPokLbjBPzYcDx
         t+iQ+WbVAsKvrY2QSBbU4tAxA6MkG3PjimnYAaid4Cw3q0Gd92M3bCruZL9OVAyyUhvm
         HP8arDugktCmKf7x/qd2lHaCi3sMBB+AgseB5/C/5+iVFYGRNOjvj91TdiFiwftrRR1w
         ob7g==
X-Gm-Message-State: AOUpUlHFZD2LKA/J3vRVYaPT5xX+EwRxyGH66qid/Y7PVrq1sGMMffO1
        D6kjXz2a0qR0/2+JZOJhqAvsuPuH
X-Google-Smtp-Source: AAOMgpeidT6pZeEF6znw0VIWZ9ZmHvWbGs0+q3R770BRmlik9armHUyIlOqhDZ7ndNxoHTrcf7oFxw==
X-Received: by 2002:a1c:1a02:: with SMTP id a2-v6mr548363wma.52.1532983664392;
        Mon, 30 Jul 2018 13:47:44 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id r12-v6sm8988059wmh.0.2018.07.30.13.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:47:43 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:47:43 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 07/11] rerere: only return whether a path has
 conflicts or not
Message-ID: <20180730204743.GI9955@hank.intra.tgummerer.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180714214443.7184-8-t.gummerer@gmail.com>
 <xmqq4lgghatc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lgghatc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > We currently return the exact number of conflict hunks a certain path
> > has from the 'handle_paths' function.  However all of its callers only
> > care whether there are conflicts or not or if there is an error.
> > Return only that information, and document that only that information
> > is returned.  This will simplify the code in the subsequent steps.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  rerere.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> I do recall writing this code without knowing if the actual number
> of conflicts would be useful by callers, but it is apparent that it
> wasn't.  I won't mind losing that bit of info at all.  Besides, we
> won't risk mistaking a file with 2 billion conflicts with a file
> whose conflicts cannot be parsed ;-).

Hah, I would love to see someone actually achieve that ;)

> The patch looks good.  Thanks.
