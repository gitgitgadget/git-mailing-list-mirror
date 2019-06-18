Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389001F462
	for <e@80x24.org>; Tue, 18 Jun 2019 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfFRWIo (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 18:08:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34244 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRWIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 18:08:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so8443021pfc.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M/L2z33ocnW/j4Ih0kAMTSzUfSLNJg7C57zd6n2ThNw=;
        b=fLXk+P+S2gvAk32SOl0v6IAUogVQLMXTXOZBLZ7LdPgHpF1zHvOA/2K6XPa2pwvlB/
         iqlgLMmph3PKuPrqidhSiK7de1L41wd0C2ZHbZPM+V+OBPW6v5X65/0U201bb+/Dy1nM
         UXji6ddubrm/dl1ADWH3d4oOZAc7KJxdcoWvTO3inO4pbaXp0261zGLMg51cUjtu9GFC
         X/+18DIGSIihdd1C0iTvkt6Bg+pSsH50AxLaB+Z25d67KUDB3RcOF1N1RaIL7nLwEtII
         HynSEBHisFtulf43WosXqAisTXptOTwRv8rVU6agCcIq+Jaxt6k9Md6xgmhndu58liVc
         7Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/L2z33ocnW/j4Ih0kAMTSzUfSLNJg7C57zd6n2ThNw=;
        b=s+yDhF30KXvbrduXyMzmLMDAsywG3DsQd2DZRgLZsI4j7CSihIOkTKk2GBXo97pXjN
         WL3ePoMiEhWZCZOk6H5Nn37d5SsuRYW1tjY8cCfAlYpaDPB9vubKuthgnMT0SKZhF91i
         um1xIt3ybnYinlQXGahyqQDNd2aHOd3qa63wbYswYnLuDD9xUgwYrNmglO8iUtcroF6X
         aPvTl9ZqbVSKTtuxNuJB6ULNJSEpywTJLwA6rkUWNSiMNPOtdde5uzTTWKC9S2IhL3x8
         IttPqAE/PzT8AlkxWPQ00AKoBTaVYjJtpWjWqTMNCHlYXFDJOR9F29DrGBxeqJtiffnP
         t2EA==
X-Gm-Message-State: APjAAAUIjO3xPjjZuaQRz/fDf2T5nbX7a5YeI9ibTnUO5eK4zCUe25EJ
        XlXS90/B6fHcHuxH8fR2khxZ2Q==
X-Google-Smtp-Source: APXvYqydO8Jjt8haJr2eD6+tSGd3s/2bKwCTrn0lEPm+GxIf9UcbkVQATuzepBJ9fy6TuD/O4xI4Og==
X-Received: by 2002:a63:c20e:: with SMTP id b14mr4484058pgd.96.1560895723221;
        Tue, 18 Jun 2019 15:08:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id 128sm16743707pff.16.2019.06.18.15.08.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 15:08:42 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:08:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] rev-list: teach --no-object-names to enable piping
Message-ID: <20190618220837.GE100487@google.com>
References: <20190614234855.257318-1-emilyshaffer@google.com>
 <xmqqk1djsv0d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1djsv0d.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 17, 2019 at 03:32:34PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Allow easier parsing by cat-file by giving rev-list an option to print
> > only the OID of a non-commit object without any additional information.
> > This is a short-term shim; later on, rev-list should be taught how to
> > print the types of objects it finds in a format similar to cat-file's.
> >
> > Before this commit, the output from rev-list needed to be massaged
> > before being piped to cat-file, like so:
> >
> >   git rev-list --objects HEAD | cut -f 1 -d ' ' \
> >     | git cat-file --batch-check
> 
> Write this with '|' at the end of the first line; that way the shell
> knows you haven't finished your sentence without any backslash.

Oh cool. Will do.

> 
> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index 660172b014..7e2598fd22 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -49,6 +49,7 @@ static const char rev_list_usage[] =
> >  "    --objects | --objects-edge\n"
> >  "    --unpacked\n"
> >  "    --header | --pretty\n"
> > +"    --no-object-names\n"
> 
> Ideally, this should be "--[no-]object-names", i.e. --object-names
> which may be the default when using --objects could be tweaked with
> --no-object-names and then again turned on with a --object-names
> later on the command line, following the usual "last one wins".

Sure, good point. Will fix.

> 
> > @@ -75,6 +76,9 @@ enum missing_action {
> >  };
> >  static enum missing_action arg_missing_action;
> >  
> > +/* display only the oid of each object encountered */
> > +static int arg_no_object_names;
> 
> And this would become
> 
>     static int show_object_names = 1;
> 
> that can be turned off via --no-object-names (and --object-names
> would flip it on).  It would reduce the double negation brain
> twister, hopefully.
> 

I'll send a new patch today. Thanks.

 - Emily
