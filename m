Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112251F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfHVQ1C (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:27:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37727 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbfHVQ1B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:27:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so6024057wrt.4
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BUEygVy9s5hHE4bykvubOjRt1lUNc/0LHT4htv2Xstw=;
        b=mi7VDCT9vRuLt2WUs/9V76e9XPRauxFowGwlH+Js0calaBS5WKoKOkSNtWxSeUPnMW
         rEOAHEzD3pAyyXoPg5//it7cdDmLiQ4uy0+lqVqfcMTT27EIqIpnBbegL+W97zeNZyRA
         31Ex0I8qqzSwtgc0g0wNoUdeQQcxdbKGF8NIdBiS0sn+/drdscdwjeOas/gvB+GMRnl7
         AZ0xYQkr611fBTnYTVjb17YFxRX7Lf+fLLPGuT3gicwZKELCPcXSXwN8fE5p2Xl3vmNW
         mewjkk9jYgtDTchSuOGffbRbCWHZWxgp1BP7SGw6q6KNewgnF7MJW01UOZpfBPBJVW3G
         PKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BUEygVy9s5hHE4bykvubOjRt1lUNc/0LHT4htv2Xstw=;
        b=dcQOsQqQQjSISd7f/rFB7V4ac+zlIKb1lu30dUN+s1X8UJSgdaZm+jsKjpf4T4oXfj
         tk/qvVLDvQGV5UQWVL0TgsjEraJJZ1e9Q2KfBWesFa0hXtZsO6Hs5N1Ryf0qsCkVkt2N
         bXErZdzEjBp4Iymy3LsYAMFTjhVD7Xw9olv4tFNawPN+e4OT+mrWkDGzJ/ZWtBKxqh3j
         Lu2YD7Qkl1R6J+jaQ7IweLiJdCk329UIQFagLIVTAkbZUGrHvECNdd/3PWj5RFGDQqhY
         lyNCVCtKiQrcFuam15+F2G30M/9qG21HGfLap5VfaYMLDvr+iJlaVoxOJHsWFp5N2HWn
         KNPQ==
X-Gm-Message-State: APjAAAVntqSVf0IxXwm7YlqqJOrGxjtMFi7hdjfpG4E83xXzuGX6sCUy
        1ZOHF02dxoDXfGF/whPDG7I=
X-Google-Smtp-Source: APXvYqyBnWESOZajgbBJdPzey6qtxaTryiLiaWuiWjvITdu/S+Q5V0CU/+arTlRe+ukoVj9yzmxtdg==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr47023023wrn.54.1566491219760;
        Thu, 22 Aug 2019 09:26:59 -0700 (PDT)
Received: from szeder.dev (x4d0c08c4.dyn.telefonica.de. [77.12.8.196])
        by smtp.gmail.com with ESMTPSA id i5sm135908wrn.48.2019.08.22.09.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:26:58 -0700 (PDT)
Date:   Thu, 22 Aug 2019 18:26:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
Message-ID: <20190822162656.GE20404@szeder.dev>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
 <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
 <20190821173515.GY20404@szeder.dev>
 <20190822084158.GC20404@szeder.dev>
 <xmqq7e75qjdj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7e75qjdj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 09:01:44AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Well, that fruit hung much lower than I though, just look at the size
> > of the WIP patch below.  I just hope that there are no unexpected
> > surprises, but FWIW it produces the exact same output for all files up
> > to 't/t5515' in v2.23.0 as the previous patch.
> >
> > Can't wait to see how it fares with that evil Windows path :)
> >
> >   --- >8 ---
> >
> > Subject: [PATCH 3/2] WIP line-log: stop diff-ing after first TREESAME merge parent
> 
> A quick question.  That we need "stop diffing after first treesame"
> patch in the first place means we have always been attempting to
> follow all the parents of a merge?

To follow, no.

But there are two subsequent loops: the first loop computed the diffs
between the merge and each of its parents, while the second processed
those diffs, and returned as soon as it found a treesame parent,
without following the others.

This patch unified those two loops so it computes the diff with the
first parent, and then processes that diff right away, and returns if
treesame, thereby avoding diffing the remaining parents.

>  I'd expect that to happen when
> "--full-history" was given to "git log -L..." invocation.

Oh, right, I didn't consider '--full-history'.  In that case it should
not stop at the first parent.

Hmm, looking into this, it seems that line-level log doesn't work with
'--full-history' to begin with:

  # Each commit does what the subject says.
  $ git log --oneline --graph
  *   f9bf557 (HEAD -> master) Merge branch 'branch'
  |\  
  | * 1b573fb (branch) Revert "Modify file"
  | * 3634cf3 Modify file
  |/  
  * 8842c18 Add file
  $ git log --oneline file
  8842c18 Add file
  $ git log --oneline --full-history file
  1b573fb (branch) Revert "Modify file"
  3634cf3 Modify file
  8842c18 Add file
  $ ~/src/git/BUILDS/v2.23.0/bin/git log -L1:file --oneline --no-patch
  8842c18 Add file
  $ ~/src/git/BUILDS/v2.23.0/bin/git log -L1:file --oneline --no-patch --full-history
  8842c18 Add file

