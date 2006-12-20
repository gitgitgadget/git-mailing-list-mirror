X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using  commit hooks
Date: 20 Dec 2006 07:42:05 -0800
Message-ID: <86y7p21smq.fsf@blue.stonehenge.com>
References: <200612201309.02119.andyparkins@gmail.com>
	<200612201347.13805.andyparkins@gmail.com>
	<458949C4.1020207@dawes.za.net>
	<200612201440.41784.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 15:48:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <200612201440.41784.andyparkins@gmail.com>
Original-Lines: 21
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34940>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx3gB-0002RD-Dg for gcvg-git@gmane.org; Wed, 20 Dec
 2006 16:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964958AbWLTPsX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 10:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbWLTPsX
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 10:48:23 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:18773 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754810AbWLTPsW (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 10:48:22 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 2B3918F08B; Wed, 20 Dec 2006 07:48:07 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 28486-01-69; Wed, 20 Dec 2006 07:47:33 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 3521D8F9F2;
 Wed, 20 Dec 2006 07:42:05 -0800 (PST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

>>>>> "Andy" == Andy Parkins <andyparkins@gmail.com> writes:

Andy>  fd_old = open( "someexistingfile" );
Andy>  unlink( "someexistingfile" );
Andy>  fd_new = open( "someexistingfile" );

This is dangerous if the process aborts suddenly.

Might be better to do this:

mumble_command < thefile > thefile.$$
mv thefile.$$ thefile

The second move will be atomic.  The only problem will be if the process
aborts, which will leave stale temp files around.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
