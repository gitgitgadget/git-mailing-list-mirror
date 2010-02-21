Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 17037 invoked by uid 107); 21 Feb 2010 21:14:32 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 16:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab0BUVOK (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 16:14:10 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51120 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab0BUVOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 16:14:09 -0500
Received: by vws11 with SMTP id 11so759565vws.19
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 13:14:08 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AckPWzP3oDjDYoVYpm0RaNMGoRLHOepKTx+5+LD6Q2Y=;
        b=X+F4K9IUNfguwD6C+x7P6ARMW6lR9K+Xx+LBOY/Esb4KHjYNGIFOEas/hWkL+bnYEX
         fUl0cL7EqnaVW7IRS8f1LgKBGmUIWK1wZVCbLLgVkafwaPRglThoCb1wfiaqMLLoBqpK
         hnst92U/5Gz4QqSE9Um2M8j4mA7A5k8P69auk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HL4IzzR9bRnyDAjWUp/a+iJNzVY+Ikwp7hcTfpSxByMxzZffamWn1/fy7/DeRT+XBF
         1S8323PEkk4cCIPT/s9QvLT9t6/opylGEgWAeTdaC4fRysGXP23jUH7FBwDoGVPVnX//
         /HjBrhjYPWLighGmdCFQ9t5J9I6/zjZzZYksQ=
Received: by 10.220.88.170 with SMTP id a42mr2832866vcm.24.1266786847913;
        Sun, 21 Feb 2010 13:14:07 -0800 (PST)
Received: from vfb-9.home ([96.225.220.117])
        by mx.google.com with ESMTPS id 41sm25587354vws.10.2010.02.21.13.14.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 13:14:06 -0800 (PST)
Date:	Sun, 21 Feb 2010 13:14:02 -0800
From:	Jacob Helwig <jacob.helwig@gmail.com>
To:	Larry D'Anna <larry@elder-gods.org>
Cc:	Andrew Benton <b3nton@gmail.com>, git@vger.kernel.org
Subject: Re: Configuring git to for forget removed files
Message-ID: <20100221211402.GA1493@vfb-9.home>
References: <4B7FBB73.70004@gmail.com>
 <20100221203212.GA10876@cthulhu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100221203212.GA10876@cthulhu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 15:32 Sun 21 Feb     , Larry D'Anna wrote:
> * Andrew Benton (b3nton@gmail.com) [100220 05:37]:
> > Hello world
> > I have a project that I store in a git repository. It's a bunch of source tarballs and
> > some bash scripts to compile it all. Git makes it easy to distribute any changes I make
> > across the computers I run. The problem I have is that over time the repository gets ever
> > larger. When I update to a newer version of something I git rm the old tarball but git
> > still keeps a copy and the folder grows ever larger. At the moment the only solution I
> > have is to periodically rm -rf .git and start again. This works but is less than ideal
> > because I lose all the history for my build scripts.
> > What I would like is to be able to tell git to not keep a copy of anything that has been
> > git rm. The build scripts never get removed, only altered so their history would be
> > preserved. Is it possible to make git delete its backup copies of removed files?
> 
> This reminds me of a scenario I wish git had some way of supporting: I have a
> large collection of mp3s that I have duplicated across several computers.  I
> would love to be able to use git to sync changes between the copies, but there
> are several problems: 
> 
> 1) git is really slow when dealing with thousands of multi-megabyte blobs.
> 
> 2) commiting it to git is going to double the size of the directory, and I don't
> really have space for that on one of the computers that the directory lives on.
> 
> 3) there's no way to discard old history without breaking push and pull.
> 
> I'm not sure exactly what it would take to address 1, but 2 could be addressed
> pretty easily using btrfs file clones (once btrfs is stable), and 3 could be
> dealt with by improving support for shallow clones.
> 
>      --larry

In all seriousness: Why not use a tool that was actually designed for
what you're trying to do? (Sync a music collection across computers.)
Something like syrep[0]?

[0] http://0pointer.de/lennart/projects/syrep

-- 
Jacob Helwig
