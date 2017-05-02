Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4741F790
	for <e@80x24.org>; Tue,  2 May 2017 19:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbdEBTON (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:14:13 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32881 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdEBTOK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:14:10 -0400
Received: by mail-pg0-f41.google.com with SMTP id y4so60705925pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dANoYN13yx16/d4L6IO6F9Vuqd9lIgZY646WSgRbB34=;
        b=wBDkPcnEBi0zkDVPf2OW0PXWLH+7Vm8BaRR5V0FIBXv9Z6Z++4N66c9273FDhCStZM
         RsXhYIrGNzVxDSOqbWmgcFh9FGpQm2yBlxbUyISOcDaW2DRetQEUrAzfPUHaKf0Su1zD
         kk1wAHBG+iirm1Lgh0paLg35fWlnYrYUpA9hEzoRGQ4ChyOFVxeU9f6pntZWJzmFOnIh
         QMjqty0BI3vRmAqacXtHzF/G7Gft/71PgvTFSukqDSwhbz5ayY7AmQHJrVEFLBqO4ZXi
         dcrhXDB4mjYh6mRL2XvHqpC+xL9HbLy2MzLTpTT7/++sNV8lf2XxCC7nkYoZjLIhSZR+
         GUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dANoYN13yx16/d4L6IO6F9Vuqd9lIgZY646WSgRbB34=;
        b=LC6g8mQYEToF2i2Ld1mcxhYc9lWxYaNhscyunAceqvE+KngU3lCpWg6LYCpynTtSlE
         wmkyVuPxga62m9mynlNZPnerQdmz73E+CPYjTNe7o7FwY7KQI4/W5cQZhg9TeiahzD++
         amIzF6HydiRQr1lRlGdoUviblUQup8K7i70jDH1RRJcbooDQVih5SyIW05T3OclzSYAF
         sZNBLprqrPKHUos86h6eJGX3f47T4KDv6tRFBTzVZTkvoMI+pJpgY40VTNh0NMC99RqY
         9IVaWpva49+fBeskqTw3G7xVTo2WiA0dPJD2SG5gp1BewlKClE9P90mBiAQCMHu6ZMGn
         pD3w==
X-Gm-Message-State: AN3rC/7s3VLg+SivvlpyyJBW9ZcsRmjbSAIxVXuX0v/4u/gFCqRVz0EL
        Y1Z1bkSNyNUfqGTr
X-Received: by 10.84.204.8 with SMTP id a8mr43693436ple.4.1493752449489;
        Tue, 02 May 2017 12:14:09 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:bc40:7b3a:46b3:66f2])
        by smtp.gmail.com with ESMTPSA id d3sm390843pfg.30.2017.05.02.12.14.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:14:08 -0700 (PDT)
Date:   Tue, 2 May 2017 12:14:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] submodule: improve submodule_has_commits
Message-ID: <20170502191407.GF181268@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
 <20170502010239.179369-6-bmwill@google.com>
 <CAGZ79kbbz3AAjbg_dV9RVS8kgLs-zWZxt5tsFbQczCm78LcTVw@mail.gmail.com>
 <20170502172555.GA181268@google.com>
 <CAGZ79kZxYCr+H3PLdnxJp7_aG=JmeMTGry51ppCe3=R2xLrP1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kZxYCr+H3PLdnxJp7_aG=JmeMTGry51ppCe3=R2xLrP1w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/02, Stefan Beller wrote:
> On Tue, May 2, 2017 at 10:25 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 05/01, Stefan Beller wrote:
> >> On Mon, May 1, 2017 at 6:02 PM, Brandon Williams <bmwill@google.com> wrote:
> >> > +
> >> > +               if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1) || out.len)
> >>
> >> eh, I gave too much and self-contradicting feedback here earlier,
> >> ideally I'd like to review this to be similar as:
> >>
> >>     if (capture_command(&cp, &out, GIT_MAX_HEXSZ + 1)
> >>         die("cannot capture git-rev-list in submodule '%s', sub->path);
> >
> > This wouldn't really work because if you provide a SHA1 to rev-list
> > which it isn't able to find then it returns a non-zero exit code which
> > would cause this to die, which isn't the desired behavior.
> 
> Oh. In that case, why do we even check for its stdout?
> (from rev-lists man page)
>        --quiet
>            Don’t print anything to standard output. This form is primarily
>            meant to allow the caller to test the exit status to see if a range
>            of objects is fully connected (or not). It is faster than
>            redirecting stdout to /dev/null as the output does not have to be
>            formatted.
> 

Sounds good, Let me take a look at using --quiet

> >
> > I feel like you're making this a little too complicated, as all I'm
> > doing is shuffling around already existing logic.  I understand the want
> > to make things more robust but this seems unnecessarily complex.
> 
> ok. I was just giving my thoughts on how I would approach it.
> 
> Thanks,
> Stefan

-- 
Brandon Williams
