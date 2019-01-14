Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A572C211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 15:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfANPUA (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 10:20:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42963 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfANPUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 10:20:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id 68so10688097qke.9
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 07:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDKnH7RRJPS5yPkmzOCUiKw5gvVZ1k9F5n135w4kJxg=;
        b=svsybxO7cLpc4Bh9S9IrN0FxEFm4g9lO4UnEJB5/Zid8M9L8PoGWP61wZWmriDxHJM
         Fc8Ob/Igpu6b+YcMs5szmxzvo+KE7y5owGrg3hImXhevs7qhOM5RWYLgqkvklyDvsJqI
         fXGuVYhpEyh71wOXCGulg++eLBKlKreaGp0HVONIayNf158MixtljH/HoSFtSscqSJS4
         9Pz88V52/UsvzKzIrqFSPJWf+Eaq0mcgK3DC9aPsvTItdAfvzOFDRwmNjQe/hMt+2SCG
         TXtqetbYQN2R/QmHijvurKRTRnpAJscp9491C0ZSzlunN8eb0pzNAGNzJot2bAmpG5Jm
         80AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDKnH7RRJPS5yPkmzOCUiKw5gvVZ1k9F5n135w4kJxg=;
        b=ZLkFdbLQfE4pRZuUPXPdZvz8m/PSiFbb6YCPxBVftagIHTWVMYDAVXWLksmrAje1BL
         3Ew2T90yHiQOfRWemGxQ6J0qoSS1DJlhxM2wbNB8zd90x44DZlkEGpG/iuGw2r/J4Q1Y
         IoYA19yB7kXPHxqwqqYWZ9PP8+5kq1oLswGEd88xg9l46SgInOM0t29T2SCzFDsRwjS6
         bvdbxSrFVCgyj7ry8t+UrzVfIe7CjUfOZGax7ZNc64hiNEtCynk6AHMEsvzemKuOnBF2
         PPU7cH90hEhCnjKY3bvj24z26LlNKYF5YTbYIK6S15wG7E2v1+9aj6Z+3HysI2iydS4s
         4j2Q==
X-Gm-Message-State: AJcUukcYPFqNtEYFsW5Nw1R4qnkfs7lMSsdTQ/3rtULOMou6efn+h29i
        h5MI89HG+HhQjj94bJOAxcYX2vB7ICrkyQ==
X-Google-Smtp-Source: ALg8bN4b3hedgOEm0v2nurz70uiHJ21G63FFkY9M2dJ9C8NlKdeLIAksI3tYZ31aZqZ7Nka4dAjOhQ==
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr22859989qkg.147.1547479198799;
        Mon, 14 Jan 2019 07:19:58 -0800 (PST)
Received: from brho.roam.corp.google.com ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id g19sm17065003qke.2.2019.01.14.07.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 07:19:58 -0800 (PST)
Date:   Mon, 14 Jan 2019 10:19:56 -0500
From:   Barret Rhoden <brho@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
Message-ID: <20190114101956.2b899d0e@brho.roam.corp.google.com>
In-Reply-To: <xmqq1s5k16zj.fsf@gitster-ct.c.googlers.com>
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
        <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
        <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com>
        <xmqq1s5k16zj.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-10 at 14:29 Junio C Hamano <gitster@pobox.com> wrote:
> > For instance, commit X does this:
> >
> > -foo(x,y);
> > +foo(x,y,z);
> >
> > Then commit Y comes along to reformat it:
> >
> > -foo(x,y,z);
> > +foo(x, y, z);
> >
> > And the history / rev-list for the file looks like:
> >
> > ---O---A---X---B---C---D---Y---E---F
> >
> > I want to ignore/skip Y and see X in the blame output.    
> 
> If you skip Y, the altered history would have "foo(x, y, z)" in E,
> "foo(x,y,z)" in X, and "foo(x,y)" in A.  If you start blaming from
> F, you'd get E as the commit that explains the latest state.  If you
> do not skip Y, you'd get Y.  I am not sure how you'd get X in either
> case.  

The way to do it is to let the blames get passed to Y - don't yank it
from the graph.  Then when trying to pass the blames from Y to its
parent, when we get a diff chunk that Y is responsible for, instead of
keeping it on Y's suspect list, we hand the blame_entry to D.  That
blame_entry will get passed all the way back to X, which also has a
diff that touches that line.

Basically we do the same blame processing as usual, but just don't let
any blames stick to Y.

Barret

