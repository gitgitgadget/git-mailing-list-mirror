Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D721F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 23:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfJKXdu (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 19:33:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34194 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJKXdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 19:33:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so6971809pfa.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vvkRaU9WsosAB6ztC9OlHc/nmF8AUD7jNU6tafaQX00=;
        b=s1+51FxGRn170FxjtfuCIJtz7WOWOqx+2Pl+7BWAK14a5szJZIkLi2aAmXXwTtPN51
         S1t7c9kk5h0N1X5SWG8QBbQdeZHk01bsiTJKlEG943O+drAE8yUSFITgaLjY4iiG/G/C
         ffRKBoVMk8ntb8No4mtgzc4WkJTAluy6lczvHYhA7O0YiMSaQGLDUxeXq+Ezv607V1EV
         sqIOwPeb5GCg3xUMuev51BzcAwugzMMDFGMWo9Cv1N0fYbDt3Q41NF/CaSktnZNlWZ+q
         lmfs3lXiT3A82K7BVgzRe4ao5AnA3XqJ6CfOuHlT/QI+pYU8ayYKn2qm4cjQPEkdBkFm
         Q5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vvkRaU9WsosAB6ztC9OlHc/nmF8AUD7jNU6tafaQX00=;
        b=Ey2XW+jwSrHeHRqi9bdoENbP3I5+YvR7KHfz+eu45pWx/kOsAQrEPiErMtZcLSz66X
         kckJxBgBCYQ7PPnZ0oLI+q2ey7bF0W10mfxUq8CZjFBt/uoxAxlCDlcOc9ZBSRDJ+/g4
         7yISuK8F/ZqEefb2DF2l3PStDg1KvxsW06/j2aVZH74IqM0QJLO/FFmATYgZXREcA75H
         D3odMXSVsL4DQagjSvcaQDPFUCV8gmVsw8fFxl+VZ+MJKUbS791EkcFZKYl+6jfzGmwa
         wqfP/S8Yh3fyp5+h0aQd8jd8OzNsC3HvD2H0rBWxu9YgJE0wGnAfByStpDSPPpJ+2byo
         5mVg==
X-Gm-Message-State: APjAAAXiAxwQxoUD5XLCIAa4pffGQFn60Ae1ymvRvlUn5J1NAzbptag7
        4i11LCfQB56XfvOMFOmkX93jcA==
X-Google-Smtp-Source: APXvYqxgwmfWCPnKa3t/ikfn1VsXSRhm9CK7daoi1o2r2sOpzpnqL3Ll5/Qw9PiDThWs8ttZEhGa/A==
X-Received: by 2002:a17:90a:1b49:: with SMTP id q67mr21311657pjq.115.1570836829402;
        Fri, 11 Oct 2019 16:33:49 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 18sm10286485pfp.100.2019.10.11.16.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:33:48 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:33:44 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v5] documentation: add tutorial for object walking
Message-ID: <20191011233344.GC20450@google.com>
References: <20190806231952.39155-1-emilyshaffer@google.com>
 <20191010151932.2716-1-emilyshaffer@google.com>
 <20191011175010.GO29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191011175010.GO29845@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 07:50:10PM +0200, SZEDER Gábor wrote:
> On Thu, Oct 10, 2019 at 08:19:32AM -0700, Emily Shaffer wrote:
> > diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> > new file mode 100644
> > index 0000000000..7085f17072
> > --- /dev/null
> > +++ b/Documentation/MyFirstObjectWalk.txt
> > @@ -0,0 +1,905 @@
> > +My First Object Walk
> > +======================
> 
> In our CI builds [1] Asciidoctor complains about the above line like
> this:
> 
>   asciidoctor: WARNING: MyFirstObjectWalk.txt: line 2: unterminated example block
> 
> I have no idea what it is trying to say, but I suspect that it
> complains about the length of that '=====' line not matching the
> length of the previous title line.  I kicked off a build with the
> '====' line shortened, and it did silence that warning, and the build
> succeeded.

Oh, I'm sure it's a consequence of changing it from "Revision" to
"Object" in the title.

> 
> Note, however, that we recently had a patch [2] that argued that a
> different header notation is better, at least for the Git User Manual.
> I'm not sure whether that applies for this tutorial as well; just
> mentioning it for consideration.

Interesting read! It looks like we actually do use the format that that
patch suggests is better, except for the title. I'll change the title to
come into line with everything else, since I'm sending a reroll anyways.

Thanks!
 - Emily
