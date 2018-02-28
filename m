Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF7A1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933108AbeB1TJV (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:09:21 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34012 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932240AbeB1TJU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:09:20 -0500
Received: by mail-pf0-f194.google.com with SMTP id j20so1392536pfi.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1wLdxxnJE3vJfjyithqfvbDOyGKmo1htfYtPWGxaBmg=;
        b=TN/OjrAQoeIpH6k0CVLtafskOrayrwTziwpzoH7QnPzrIHp+5jp7n+BcqettMu2Z6R
         G2PRDp5M9VuoQ1nEUdp02ny9awTJtaEP+KBVqaEQQrV5f/er5L4AOQ+m8ojAKbwc1ym+
         ZWcrVOInuqIi6umuj/cXQ8mvxwNKRu5pcNotl4ZWDWhQVOS4M1mcbAA/ViJXBHmI0byE
         gU1PLmukWICPYD6ID7WWfdgX/t1wk3yyt64iozYvvKx9HXcuMiuq1rqD/JadlHCRUEL6
         fqQrjU6aPDi3N7hMUv5FfeLdKHtp7S/saiMD3HL8Lc7WcrlRanrKW9he/gQXx6i7qKsR
         KoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1wLdxxnJE3vJfjyithqfvbDOyGKmo1htfYtPWGxaBmg=;
        b=daE9n22t2lbEBvw1DHhz4tEJ3368ypMmCC4uiqyhFDngVFLYgOC2hNHSCrFYct8ema
         CeF1WavNjJ2No7v3Ndz6F4tjzW0DjXmQVyqUdxoGOKdplXoUS+avsxvN9cPZ401rceQX
         al99AfBBIvkuIOt+9JpERIpNa3A9RT/g/pIJyXSBUpNSxl04IlTfpksNdS48QobSY3Fs
         7mJaxdRCQpNOKKzLKB9OWPfD674fY2rjh1jiEWZaI4dEDRETRpnF8YMiYpOX/Ty588h6
         rvune+Q1TplC9T+M9XHZjwu8r5yQEmwnCRmXljxSt6XpZI4dmEXyHdXYYP36YAWuWz01
         kf2w==
X-Gm-Message-State: APf1xPDcu2rZPxRdRrVHP1vJoRwbG0mDQapu7EPBnm+Bt3zTK3RDvVBu
        wLMX5CCbENI9Ha848fu9aZuJ1Q==
X-Google-Smtp-Source: AH8x224U/udLnc4w0w/O66VJev4rcOUM8ZpZvqKQ1gsrsVyvWZgWUeta4rDzCtdftQhnR/OJzhDOUw==
X-Received: by 10.98.223.143 with SMTP id d15mr18809040pfl.208.1519844959481;
        Wed, 28 Feb 2018 11:09:19 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q13sm4210188pgr.15.2018.02.28.11.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 11:09:18 -0800 (PST)
Date:   Wed, 28 Feb 2018 11:09:17 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 28/35] transport-helper: introduce stateless-connect
Message-ID: <20180228190917.GB87122@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-29-bmwill@google.com>
 <20180227233025.GH174036@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227233025.GH174036@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > Introduce the transport-helper capability 'stateless-connect'.  This
> > capability indicates that the transport-helper can be requested to run
> > the 'stateless-connect' command which should attempt to make a
> > stateless connection with a remote end.  Once established, the
> > connection can be used by the git client to communicate with
> > the remote end natively in a stateless-rpc manner as supported by
> > protocol v2.  This means that the client must send everything the server
> > needs in a single request as the client must not assume any
> > state-storing on the part of the server or transport.
> >
> > If a stateless connection cannot be established then the remote-helper
> > will respond in the same manner as the 'connect' command indicating that
> > the client should fallback to using the dumb remote-helper commands.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  transport-helper.c | 8 ++++++++
> >  transport.c        | 1 +
> >  transport.h        | 6 ++++++
> >  3 files changed, 15 insertions(+)
> 
> Please add documentation for this command to
> Documentation/gitremote-helpers.txt.
> 
> That helps reviewers, since it means reviewers can get a sense of what
> the interface is meant to be.  It helps remote helper implementers as
> well: it tells them what they can rely on and what can't rely on in
> this interface.  For the same reason it helpers remote helper callers
> as well.
> 
> Thanks,
> Jonathan

Thanks for reminding me.  I had intended to at some point but had
forgotten to do so.  I'm going to mark this it as experimental and for
internal use only so that we can still tweak the interface if we want
before it becomes stable.

-- 
Brandon Williams
