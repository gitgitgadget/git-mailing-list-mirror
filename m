Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE701F405
	for <e@80x24.org>; Tue, 18 Dec 2018 21:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLRVF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 16:05:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37438 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLRVF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 16:05:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so8391689plr.4
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 13:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/904uiQ0Sd4a7j5itkmTCOjjlhnxTkSW0oAZ2/ffcwg=;
        b=JJHhXNAS6XxGL4sg+B5erCJ3gDJsN721Llxv02wlFvq3EJSlatRO76N0U4ADoK3LE/
         JOLKA79jx/frxtMEmPnXkthrIRohBqXc1FsKkGXctG/SCgOl9mbHxOcdJ1xhIwVi78XO
         v1Q88TK9amdc/+K+I1v5JHhEiEn0pMRj30ffL8YEetwMQxXvTpurFwsKSOwt/ZWTKjG3
         OwBMbprc+oZDMUGXXw9V1CziR8iaSPJ3187K2KkzqPNCZFTuVvyqLLRu5F9m38I3/h6f
         KPMThN9afPQPp/JfFhL2wN3v/HItx9q8b38nsCoyQxokJ01sWWPjqG0d+UhR2Tf6iBrj
         sPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/904uiQ0Sd4a7j5itkmTCOjjlhnxTkSW0oAZ2/ffcwg=;
        b=c6ya9ZrLuR4bwUHvKmdcXm0Ozw+UqL4Vw56xlu+4r2j1ZIpOiaG8sX03WWVq3PszsN
         otbO9AoldcTGctbt6GIT7/sAG6YBujdnV07aYHte/IpSuGqNWd4WlyERR4MdZVSYyfn2
         bAQVdlEbzqVyoP9vR7KRuFbOeBd2cY2+Uc19cZBNWAxPdlqOI8Y7CQ8in6qO4VQhtHaP
         iLzL3juPXoSDiV0nN6hiMjVG8Q3e/pK0EeLHTbvNvhFHbnsZqv/z959nDyZnPk5hfZN+
         cE1rCw9609MynXXrhqvV+EiDGUYfQaYcSPsTOuIHlGgiNXXOrs7eYL7CytNZRwZF4X1Y
         jRSw==
X-Gm-Message-State: AA+aEWZkaKu+mwZbbds0jV33DrOW+8V6XsKiQSBWx4aDzRayLc8IK66e
        qb/rG+5GnJjzXXB4NjNu7/r0Eg==
X-Google-Smtp-Source: AFSGD/UejHDeA26dthOgAYmV1X3g+wYtBiU1g6AHLat4ktsXcrwAlWiGkarUJOsqa4QKHhzza0uf6Q==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr9056639pla.131.1545167157412;
        Tue, 18 Dec 2018 13:05:57 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id d18sm22099548pfj.47.2018.12.18.13.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 13:05:56 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:05:51 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/3] Add commit-graph fuzzer and fix buffer overflow
Message-ID: <20181218210551.GG37614@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
        gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        szeder.dev@gmail.com
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544729841.git.steadmon@google.com>
 <20181218173539.GA31070@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218173539.GA31070@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.18 12:35, Jeff King wrote:
> On Thu, Dec 13, 2018 at 11:43:55AM -0800, Josh Steadmon wrote:
> 
> > Add a new fuzz test for the commit graph and fix a buffer read-overflow
> > that it discovered. Additionally, fix the Makefile instructions for
> > building fuzzers.
> > 
> > Changes since V3:
> >   * Improve portability of the new test functionality.
> 
> I thought there was some question about /dev/zero, which I think is
> in this version (I don't actually know whether there are portability
> issues or not, but somebody did mention it).
> 
> -Peff

I've only found one reference [1] (from 1999) of OS X Server not having
a /dev/zero. It appears to be present as of 2010 though [2].

[1]: https://macosx-admin.omnigroup.narkive.com/sAxj0XeP/dev-zero-equivalent-in-mac-os-x
[2]: https://serverfault.com/questions/143248/zeroing-a-disk-with-dd-vs-disk-utility
