Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1191F454
	for <e@80x24.org>; Fri,  8 Nov 2019 03:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfKHDYG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 22:24:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44679 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHDYG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 22:24:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so3720783pfn.11
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 19:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rJLK+CT3Jd6zGbrXm5AS/T23uu/hTXmBws3lbSFQcZc=;
        b=DQJ7mi/pxa9mwJGkteVtAkiuqhCqu14ssEbEjpiNHS2FcJYmFTTqKfx+cfviIF1Sam
         PT3vyXc9/L5xNFEQIw1O/Zv83kLCBQkQk5JIgZ7DU9f0zKX3gU8qD+O9NlF8RtWMT1nX
         F1t0wrWsszK2e7K3UW86p46UTQPErg++G0YNFgNTh/QD9VGS3uNgNuh42FifWMc9nQA8
         eRvkhF8oaEBotKqCKWpsPrHWckwFMN9am3LbbGtyydGuEmzxGRzcfCVSurbN3BUfqSkI
         5tQUlPZTIDIpAP731ArwklAPqegLVj1CwxL1qiPr1PzSMZhKYXKhwdQ5aouOyJk1Rzsa
         3Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rJLK+CT3Jd6zGbrXm5AS/T23uu/hTXmBws3lbSFQcZc=;
        b=iGsmPhmmTr3KoUif7tz+IZiKShGHHKB4W0YTMVXmRwbYcux6kUSplTQsTBYCPZYNwy
         pscI8fSq8MGy3LHrs06l/Yh+Y7JhsBYjlaGP3jo1cHPW2pnPHcoOYl6StbKgw4FuhyXu
         +g5RFH/6Sh44MFvh7SnRi9qqDKe0b1uX7jQwzwrf32cPQBcOyvA4L4IzuP2F2olQe6cW
         ndpgVLMsUC/Fq6e7qIme41dqx72Qp6kmDhc+NNUsisnpsPdqnFZD2mWuFxuR+bhf45PO
         /kLDiPMeTwyrcsD8hZQDFT0lUyRyCV2Xed79scDRyhNRrUsgjOlD3rCskhCzzRVRavKf
         1upA==
X-Gm-Message-State: APjAAAVedxJZampUV6vxMcLiXhvjGkEhSqJjU39OKVTszY6bENJCWASL
        3I6AsHI+WyWoNua+Q3a+Uhk=
X-Google-Smtp-Source: APXvYqw/uqNCHS/02VicJ3fw4TYIH8lbmqp98CI977BJmoJMLl4aOYc7r63BqGgVeCJyWpqql8axvg==
X-Received: by 2002:a63:fa0e:: with SMTP id y14mr8770158pgh.174.1573183445058;
        Thu, 07 Nov 2019 19:24:05 -0800 (PST)
Received: from helium ([125.252.103.164])
        by smtp.gmail.com with ESMTPSA id c21sm3861035pgh.25.2019.11.07.19.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 19:24:04 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:24:01 +0800
From:   "Eric N. Vander Weele" <ericvw@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: teach "status --short" to respect "--show-stash"
Message-ID: <20191108032401.GA1465@helium>
References: <20191104100334.60537-1-ericvw@gmail.com>
 <xmqq36f1wx6h.fsf@gitster-ct.c.googlers.com>
 <20191107103141.GA87008@helium>
 <xmqqimnwoscx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimnwoscx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 08:09:34PM +0900, Junio C Hamano wrote:
> "Eric N. Vander Weele" <ericvw@gmail.com> writes:
>
> >> Isn't this information available to scripts that want to read from
> >> porcelain v2 output format (which is meant to be extensible by
> >> allowing easy-to-parse optional headers, which this stash thing
> >> exactly is).
> >
> > It is not available in Porcelain Format v2... yet :).
> >
> >
> > I'm happy making '--show-stash' congruent with '--branch' in v1',
> > which is would be in line with documented behavior, displaying
> > something in v2 only, or both.  Let me know how you would like to
> > proceed and I'll rework the patch accordingly.
>
> Quite honestly, you do not want to ask _me_.  If you left it to
> me, I may say that, among the possible next step you listed, the
> best one is to do nothing, as I do not want to see the stash info in
> the "status --short" output ;-)
>
> It probably is the safest to make it available first only in v2
> format.  I do not know if that makes its utility too limited for the
> purpose of the application you have in mind.

The application I had in mind was to remind me of potentially stray
stashes I may have forgotten about when working on a project.  I was
hoping to add "--show-stash" to my alias for "status --short --branch".

The v2 format is a bit too verbose for what I need and having color
output is a nice bonus when using "--short".  I don't feel strongly for
pushing this through, but I am happy with what I have learned through
the process of trying :).
