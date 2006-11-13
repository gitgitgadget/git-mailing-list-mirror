X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Mon, 13 Nov 2006 14:58:33 +0100
Message-ID: <45587A09.3020605@b-i-t.de>
References: <45530CEE.6030008@b-i-t.de> <7vvelnjd4p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 13:58:55 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <7vvelnjd4p.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31299>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjcKk-0006GY-LF for gcvg-git@gmane.org; Mon, 13 Nov
 2006 14:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754660AbWKMN6n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 08:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbWKMN6n
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 08:58:43 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:58529 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S1754660AbWKMN6m
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 08:58:42 -0500
Received: (qmail 20365 invoked by uid 1011); 13 Nov 2006 13:58:40 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.199895 secs); 13 Nov 2006 13:58:40 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 13 Nov 2006 13:58:40
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id 7557F15826; Mon, 13 Nov 2006 14:58:35
 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> sf <sf@b-i-t.de> writes:
> 
>> I want to access a git repository via git-cvsserver. The problem is
>> that the repository contains paths with umlauts. These paths come out
>> quoted and escaped when checked out with cvs.
> 
> I think this is because the cvsserver invokes diff-tree and
> ls-tree without -z and the output from these command quote
> non-ascii letters as unsafe.

I knew I had seen that kind of quoting before but right then I thought 
it was related to Perl or SQLite.

> Martin's sqlite may probably be needed as well, but regardless
> of that something like this patch is needed -- otherwise what 
> populates sqlite database will be quoted to begin with so it
> would not help much.

Martin, are you sure your patch is needed? (see below)

> I've tested with your reproduction recipe, but otherwise not
> tested this patch.

Thanks, Junio. Paths with umlauts are returned correctly now both in 
UTF-8 and ISO-8859-1. I guess git-cvsserver is now as encoding agnostic 
as git core.

Regards

