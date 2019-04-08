Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2DE20248
	for <e@80x24.org>; Mon,  8 Apr 2019 23:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDHXNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 19:13:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46405 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDHXNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 19:13:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so8484917pfj.13
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWjED30vddoc/iBOmc4SvjC2ME38oTsdlScSHqHKA5Y=;
        b=a6ZnixiczaJo3HbmEpSpJ6m5P4Ze3GjRfEgByjFd9oT5VACuPuRvPmeARZ5SIlKmtc
         TjZ5AQfNThC2NO2BDP+hZK0K0SRMz2ny/6QUvdsmK1L1uhK0s3Y6GCPZgvVrx5SPl9AX
         EPob+aT0XYca7bD1vgnEcfMd66zBFjL54nT//48QwA39k+AAG6KZIVvl29Jjr8SN9l/C
         L6Qo4lK+2fD8RGto+Nm36mPgULhIil+QFYF8Yy7qLNmaaylQGDC+RIKkgfgCnsav1xX5
         12zPCuDMrUrk6cs5jAHWib5czwcF+2jQMBiU1Np58GKZaD1moPDyD0xBSTPb+mHsybCs
         sxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kWjED30vddoc/iBOmc4SvjC2ME38oTsdlScSHqHKA5Y=;
        b=dVBUlMyNEHbQ8uGYnhDoXdWeID+izU5Mq0Iug/knA3qmUVnI5ZhaqOUL0AUuO1p/OZ
         Vu+aeFUXr/CxLd567aQbYYpxAAHxfae1KkBlbvbXviqFF4/zjtT2AJAGxQFHmu9Gq33V
         tuqatmI4SpnKNlE8RWlUEtyuBBSuqVb/ev5mgQwhT8JGo4LoXvFJYIzKBGYISIz46Sa7
         8nqaTN5WKz45RuGglXCpu8fEmUhO8QGW0Me6XCY+aVUxL5kz8dMcHg4gJrvyRwbTUWwS
         jZs8gOe0t81SQ70wQG2cm4qBCrIYfXH4UtHwY9/4N+6E3MknBw3gcdcQXEOMT/h3FjoV
         KINw==
X-Gm-Message-State: APjAAAUYL2GZH2Y5/c7KWFvm6jmEHE+UIiYXxKnGT8oEnzT0V/BimjeM
        28zZHQ6cICw6c7Ip45SClmOCqA==
X-Google-Smtp-Source: APXvYqyPLZOELMlEVWlziE+buQICJALGJHxFHVJG+tGFl8lTs981Pazl3FEzrRewReDhBVtcI8283Q==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr31000056pgc.8.1554765183030;
        Mon, 08 Apr 2019 16:13:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id p14sm15559147pfa.26.2019.04.08.16.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 16:13:02 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:12:56 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190408231256.GK60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
 <CAP8UFD3fWi=3rYY1LAzn8XWvHQswDZmkWj7TNicTE+qbnOGkJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3fWi=3rYY1LAzn8XWvHQswDZmkWj7TNicTE+qbnOGkJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.09 00:23, Christian Couder wrote:
> On Mon, Apr 8, 2019 at 11:46 PM Josh Steadmon <steadmon@google.com> wrote:
> >
> > Helped-By: Jonathan Tan <jonathantanmy@google.com>
> > Helped-By: Jeff King <peff@peff.net>
> > Helped-By: Jonathan Nieder <jrnieder@gmail.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> 
> Your S-o-B is duplicated an there is a spurious line between the
> duplicated lines. Do you use an automated script/hook to add your
> S-o-B?

I only use the --signoff flag to git-format-patch. It looks like the
cause is that I have a hook to add a Gerrit Change-Id to my commit
messages, and that hook added a blank line followed by Change-Id:blah
after my original Signed-off-by line. Then git-format-patch added
another Signed-off-by after the Change-Id. The Change-Id line was then
stripped out by a wrapper around git-send-email.
