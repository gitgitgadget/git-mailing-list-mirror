X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Apply obvious numerical cast for stupid C compilers.
Date: Sun, 5 Nov 2006 02:18:05 -0500
Message-ID: <20061105071805.GA4506@spearce.org>
References: <20061105053544.GA4193@spearce.org> <7v3b8ywewj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 07:18:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b8ywewj.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30953>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgcGl-00062B-NQ for gcvg-git@gmane.org; Sun, 05 Nov
 2006 08:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161200AbWKEHSL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 02:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWKEHSL
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 02:18:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47057 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161200AbWKEHSK
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 02:18:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgcGd-0001tu-6G; Sun, 05 Nov 2006 02:18:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2009920E491; Sun,  5 Nov 2006 02:18:06 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > At least one (older) version of the Solaris C compiler won't allow
> > 'unsigned long x = -1' without explicitly casting -1 to a type of
> > unsigned long.  As annoying as it may be to explicitly perform the
> > cast the compiler is right; -1 is not an unsigned value.
> 
> Is the compiler really _right_?  The usual integral promotion
> rules should apply if it claims to be a C compiler, I would
> think.

I'm rusty on my C; but I would expect an error if I tried to assign
a clearly negative value into an unsigned value, especially in a
case like this.  It could be compiler is wrong, but as a programmer
I'd want to know I wrote something stupid like that, because maybe
the variable should have been signed.  :-)
 
> But I think the code actually wants ULONG_MAX there.  Is that
> symbolic constant available at the point of offending
> initialization with the header files we already include, I
> wonder.

Yes, I agree.  I almost changed it to ULONG_MAX but didn't since
the original author felt -1 was the better choice here.  *shrug*

For what its worth ULONG_MAX works on my Mac OS X system.

Tomorrow when I have access to that "broken" platform again I'll
try ULONG_MAX and see if it compiles there.

-- 
