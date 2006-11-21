X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 01:43:28 -0500
Message-ID: <20061121064328.GB3332@spearce.org>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com> <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com> <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 06:43:39 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31974>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmPM0-00063t-9b for gcvg-git@gmane.org; Tue, 21 Nov
 2006 07:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030539AbWKUGnc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 01:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWKUGnc
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 01:43:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42453 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1030539AbWKUGnc
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 01:43:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmPLt-0005Es-D2; Tue, 21 Nov 2006 01:43:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 76CDB20FB09; Tue, 21 Nov 2006 01:43:28 -0500 (EST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Eventually the Moz crowd will outgrow SVN - perhaps we should be
> parsing the SVN dump format instead ;-)

Its a mess.  :)

Jon and I considered using the SVN dump format to feed git-fastimport
but chose against it.  Its a pretty horrible format.  Especially with
how it handles branches and tags, and file data.

Fortunately SVN has a C library which parses the file for you.
Which means that probably the best way to read the SVN dump format is
to write a program which links against the SVN library and translates
it into the datastructures used internally by git-fastimport to
generate an initial pack file, then repack that after the import
to get good compression.

-- 
