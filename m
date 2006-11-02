X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: weird strncmp usage?
Date: Thu, 2 Nov 2006 01:51:27 -0500
Message-ID: <20061102065127.GA23105@coredump.intra.peff.net>
References: <eibhga$tpg$1@sea.gmane.org> <45494D84.2060402@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 06:51:40 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45494D84.2060402@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30689>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfWQI-0007xH-Ie for gcvg-git@gmane.org; Thu, 02 Nov
 2006 07:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752656AbWKBGvb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 01:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbWKBGvb
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 01:51:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:14251
 "HELO peff.net") by vger.kernel.org with SMTP id S1752656AbWKBGva (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 01:51:30 -0500
Received: (qmail 22712 invoked from network); 2 Nov 2006 01:50:37 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 2 Nov 2006 01:50:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Nov
 2006 01:51:27 -0500
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

On Thu, Nov 02, 2006 at 01:44:36AM +0000, Andy Whitcroft wrote:

> That said if you know its constant you can also use sizeof("foo") and
> that is done at compile time.  Something like:
> 
> #define strxcmp(x, y)	strncmp((x), (y), sizeof((y))

You would, of course, need to use sizeof(y)-1 to avoid comparing the NUL
termination. :)

This is a slightly dangerous macro, because it _only_ works for string
literals, but not pointers (which is fine in this case, but its
limitations need to be documented).

