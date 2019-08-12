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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9881F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 18:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHLS4Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 14:56:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33791 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfHLS4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 14:56:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so105613351wru.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DZMP5szIx5a4gVRMR79+7SHChrHPdHUs/NKxDWn9F7k=;
        b=CzAinY/Be4dwFy2keV3jO4qVSU73Jo/nBS3EGMDYVQNjKwNVTf5CiLGE/MthoegqfO
         FXYEh4oMCUrxflJniq3H/GF5ywDyLPlcku5tanw7mNg/LMyGBNOmbUrS8LHPVXxPaBeM
         KW49k7aLfuiOAziRNY0vq04Wdr5RAxZioLbCfIT+4N66pMgKW9A+03V2eWtfEfInl0+W
         GVCh5gC5v96VQPCYT+5Xa8FyBMW0fSr9S3vtR0CPdLxfxEVWvhFOWD5JG33uXT/ayhTm
         LDXkxQzpDIR2pogcJ9CoPFy/qH2zGrjedhkB3N/eNNupwvQJomybE0D+eOOOQTM1cCmH
         Ug6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DZMP5szIx5a4gVRMR79+7SHChrHPdHUs/NKxDWn9F7k=;
        b=teyKnlE6hdI2/woD7y7XTB9QWrGr1pfuoeidrGBCIzd4csmHWajT+cdXcBm1KQECqQ
         2Lv0mEE3lyM7RuQCYdNAD4yZwXbnkUAUxxksj5cjDBExyBzg/D+qsN6qL7ST6ndLIDDK
         c74/qqbzgPuPo/2yyXLQXeo4Z34xlXcB19BvB6EioFLGqPrHXkdXaBQKTtWvnTHq7B8V
         AWGq4FhougwurN//sE+4HCz8akpLtngEE7nkEY1iyq2z5FMSWvcDKKJWuz8yeiSU5CkN
         wMXi2OK3Gji/nH0Pn/z/KuopAYzjT4g5BOfvRrdAApfYrT0ftvWgpDEPSjkbwB7knkJP
         G9cQ==
X-Gm-Message-State: APjAAAVTGKemmdoEIkHWfSeD5pvHGcKG1FMf+/29sP66mzji/HY/TkB7
        Bn3oMWk7eQvfunFavOoU6dg=
X-Google-Smtp-Source: APXvYqxILyoXbXjWVjUT9RsjIUDB1AOmdr3Zow3cIGpDPe5qVmqvz3LNAAXNtA5Al1vH1yoD+abjig==
X-Received: by 2002:adf:d08e:: with SMTP id y14mr41584017wrh.309.1565636181584;
        Mon, 12 Aug 2019 11:56:21 -0700 (PDT)
Received: from szeder.dev (x4db63f8e.dyn.telefonica.de. [77.182.63.142])
        by smtp.gmail.com with ESMTPSA id x6sm114460332wrt.63.2019.08.12.11.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 11:56:20 -0700 (PDT)
Date:   Mon, 12 Aug 2019 20:56:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit
 while rewording
Message-ID: <20190812185618.GN20404@szeder.dev>
References: <20190812175046.GM20404@szeder.dev>
 <xmqqsgq69rky.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsgq69rky.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 11:17:01AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > ...
> > So far so good.
> > Save the updated commit message, and after the editor opens up the
> > third commit's log message, check again where HEAD is pointing to now:
> >
> >   ~/tmp/reword (master +|REBASE-i 2/3)$ head -n1 .git/COMMIT_EDITMSG 
> >   third
> >   ~/tmp/reword (master +|REBASE-i 2/3)$ git log --oneline -1
> >   c3db735 (HEAD) second - updated
> >
> > As you can see, HEAD still points to the (now rewritten) second
> > commit.
> >
> > It's only HEAD,...
> 
> Yuck.
> 
> That would still be annoying to some people and outright buggy to
> others, if their workflow relies on HEAD (e.g. compare with HEAD
> while reviewing the log messsage) and then now they instead need to
> adjust (e.g. compare with the index instead).

Well, it's caused by a 2.5 year old commit, so either all those people
have been lucky so far (or just don't do subsequent rewords?), or
those who stumbled upon it already adjusted without complaining to us.

> Perhaps you are one of them

No; during the second reword I ran 'git log -2' in the other terminal
(wanted to copy a sentence from the previous, just reworded commit),
and noticed that the two listed commits were "off by one".


BTW, rewriting the first commit appears to be important.  When doing
an edit-reword of two subsequent commits, then this issue only happens
if the edit actually rewrites the commit.  However, when, instead of
editing anything, I do a 'git rebase --continue' right away, then HEAD
points to where it should during the subsequent reword.

Anyway, Cc:-ing Dscho for his rebase expertise.

