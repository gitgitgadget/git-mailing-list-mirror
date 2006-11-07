X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Tue, 07 Nov 2006 14:18:08 -0800
Message-ID: <7v64dq3nq7.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200611062258.08320.jnareb@gmail.com>
	<7v8xiochw0.fsf@assigned-by-dhcp.cox.net>
	<200611072253.34291.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 22:18:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611072253.34291.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 7 Nov 2006 22:53:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31095>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhZGo-0008MT-Md for gcvg-git@gmane.org; Tue, 07 Nov
 2006 23:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752928AbWKGWSL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 17:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbWKGWSL
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 17:18:11 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:897 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1752928AbWKGWSJ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 17:18:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107221809.QTQP18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 17:18:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jyHl1V00r1kojtg0000000; Tue, 07 Nov 2006
 17:17:46 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I don't think it would be good idea to separate unquote correction with 
> esc_path work, because havin unquote which unquotes fully means that we 
> can have filenames which have for exampl newline characters in them, 
> hence the need of separate quoting subroutine, esc_path, and using it 
> for filename escaping.

Yeah, I think that makes sense.

No matter what escaping we would end up picking in the second
part, we should do the unquote plus esc_path anyway, so I think
a two patch series to replace to '?' first and then pretty-print
that '?' with whatever encoding and span.cntrl is a very
sensible way to go.

As to backslash, cute control pictures and just plain '?', I do
not have a strong preference among them.  Especially if you have
the span.cntrl around them, we can tell even a plain '?' from
the substitution of funny byte values, so it probably is just a
matter of taste and I'd leave that up to you and gitweb cabal on
the list ;-).

