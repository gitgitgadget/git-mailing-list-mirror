Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB49A1F51C
	for <e@80x24.org>; Fri, 25 May 2018 09:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965252AbeEYJmR (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 05:42:17 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:58966 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965197AbeEYJmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 05:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GzaP1xy1jbCigVDO2HV5skNHrFDT6OuTuZUa2NF4w4k=; b=cwqPtS5oOsGd2VTKpZv2kCOAC
        q6+MN4JLi5jHEDbYEfVSHpyM5YqfCg6LuWNCo6rQ1csBeNFf16hz3n1iLbFbbQigtwDOelZcpEGk7
        Q+nwfKI1AmPAXmHbXfokf6SdUqvQ8zwTnGGJ0p6+NNO18mstE+RnV3Hy8VVs2grx3pJeKNoY2nAKt
        1CsuW5h2CkTMS7EJADIppIRYXGrWCV9TDcTvI694qB14JOZdeop9MtYW8q64N9Ij5S376IvSBdZzM
        0RVR1OoiEK61DXwWYV5sjLp3rKu4qAR2YvDycnissTNbbFduM9Kq/PQsjPs4Yv/uoQgC0wnI1/8vf
        DYN52qlEw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:43425 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fM9Ej-0011DY-Th; Fri, 25 May 2018 05:42:15 -0400
Date:   Fri, 25 May 2018 05:40:22 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-tag" inconsistent about whether you can tag non-commit
 objects
In-Reply-To: <xmqqpo1kpl9i.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1805250539580.7109@localhost.localdomain>
References: <alpine.LFD.2.21.1805241040400.14773@localhost.localdomain> <xmqqpo1kpl9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 May 2018, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >   embarrassed to admit i had no idea that you could tag non-commit
> > objects, only realized that when i was reading the man page and saw:
> >
> >   SYNOPSIS
> >      git tag [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
> >            <tagname> [<commit> | <object>]
> >                                  ^^^^^^^^
> >
> > so i tried it and, sure enough, i could tag a blob object. but if you
> > read further into DESCRIPTION, about halfway through, you read:
> >
> >   "Otherwise just a tag reference for the SHA-1 object name of the
> >    commit object is created (i.e. a lightweight tag)."
> >    ^^^^^^
> >
> > which suggests only commit objects. finally, much further down, under
> > OPTIONS:
> >
> >   "<commit>, <object>
> >      The object that the new tag will refer to, usually a commit.
> >                                                 ^^^^^^^^^^^^^^^^
> >
> > so to clean this up, is it sufficient to just change that middle line
> > to say "object" rather than "commit object"? or is there more in the
> > man page that needs tweaking?
>
> As that sentence talks about a lightweight tag (i.e. a reference in
> refs/tags/ hierarchy that directly points at an object of any kind),
> another possibility would be to say
>
> 	Otherwise a tag reference that directly points at the given
> 	object (i.e. lightweight tag) is created.

  yup, that would resolve the issue. patch coming shortly.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
