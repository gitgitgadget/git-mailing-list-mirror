Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF80F202BB
	for <e@80x24.org>; Mon, 25 Mar 2019 00:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfCYAGV (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 20:06:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40730 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfCYAGV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 20:06:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so5073798pfc.7
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2XdtfV9X1AXXwcohtWfLQHN+ap2SoLYRo02m2/5Ck3A=;
        b=nTbXtFMPIxckbxbORdTkPWWg4BAyhRZoKtvdGpl/PpuGIJZTeO89wLHyaCf0dMHMhF
         c4yttvq6RMb3yc0taSZLAulffe+5txJxbRerG4254InnsW2V9fBkx76sEghhXJEBsWki
         9NTU3d++NLlitL6p4Sq5TbCa5rlNcU9LCc5Sm1smKfSh7gOK3AikLURb/vrr6Xdt2GBB
         +FWhuOIW1+tFu6J15753NI+q9C15ziOAHLSd//5ICqhp3qnJx6Sz/u1OOQE7iHDIJNa0
         EGxXpE+5NRoiSZWD9NmF7D92VPTOOj6cI5hMGoQY+Pa0EFFJ/2KqIwieVfIXPzFysguO
         WpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XdtfV9X1AXXwcohtWfLQHN+ap2SoLYRo02m2/5Ck3A=;
        b=nQfI3QnRx+WONUInbqvsjVpapE2aUyY99PyMlwSI9TxTSiIvPuN8BD7P49EaRBo99A
         QLe6KdnTcSovx2aH9FKz3v0fz3YZN7Rzioah7c9Fjd5SdyF17ijQi6FbZZvdJ3caJt7x
         ExUYMM0p6yeaiP3Ak6y3hSzsrYC6GCifjE1SKLyarcxSKP+V4vYKyt3Cfxc6uywZTNXr
         ELM4wiQQhKVwjP+HukiqWbe92v2AYKXfDu9Je7JOE6oXXFEKnWknFawVzC3lrI7xKabT
         NcpMG7yXLH5m0rVH88390Yq/xMuTDdlvgskocEUEgl281i+10LxcmxThmTo6mjqfLz1H
         o7EA==
X-Gm-Message-State: APjAAAXH8ezpUjuKBY/Yd9QjWYoseZYjWYw5PAT92E2xg1XrBYioV+Zp
        IiK0+WHB3DzPoCC2Cs4xhXY=
X-Google-Smtp-Source: APXvYqzVJr4l0febjuGNl3014HUQi9cnNPXLmJyRdX0boc2liHfky4Ud0z4IWrgpr8JO5hlURo/WJQ==
X-Received: by 2002:a17:902:9a0b:: with SMTP id v11mr22145238plp.194.1553472380729;
        Sun, 24 Mar 2019 17:06:20 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 16sm22701745pfz.106.2019.03.24.17.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 17:06:20 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:06:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
Message-ID: <20190325000618.GB9384@archbookpro.localdomain>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
 <xmqqtvfso1cz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvfso1cz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Mar 24, 2019 at 10:20:28PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > A common scenario is if a user is working on a topic branch and they
> > wish to make some changes to intermediate commits or autosquashing, they
> > would run something such as
> >
> > 	git rebase -i --onto master... master
> >
> > in order to preserve the merge base. This prevents unnecessary commit
> > churning.
> >
> > Alternatively, a user wishing to test individual commits in a topic
> > branch without changing anything may run
> >
> > 	git rebase -x ./test.sh master... master
> >
> > Since rebasing onto the merge base of the branch and the upstream is
> > such a common case, introduce the --keep-base option as a shortcut.
> >
> > This allows us to rewrite the above as
> >
> > 	git rebase -i --keep-base master
> >
> > and
> >
> > 	git rebase -x ./test.sh --keep-base master
> >
> > respectively.
> 
> I never use the "feature" myself, but I recall that when "git
> rebase" is run on a branch appropriately prepared, you do not even
> have to say <upstream> (iow, you type "git rebase<RET>" and rebase
> on top of @{upstream}).  
> 
> Can this new "--keep-base" feature mesh well with it?  When the
> current branch has forked from origin/master, for example, it would
> be good if
> 
> 	$ git rebase -i --same-base
> 
> becomes a usable short-hand for
> 
> 	$ git rebase -i --same-base origin/master

By "--same-base", I am assuming you mistyped and meant to write
"--keep-base"? If that's the case, I can make it a shorthand.

Thanks,

Denton

> 
> aka
> 
> 	$ git rebase -i --onto $(git merge-base HEAD origin/master) origin/master
> 
