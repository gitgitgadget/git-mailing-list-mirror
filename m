From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 11:04:23 +0200
Message-ID: <20080827090423.GA484@cuci.nl>
References: <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org> <7vabez2yac.fsf@gitster.siamese.dyndns.org> <7v3akr2xa3.fsf@gitster.siamese.dyndns.org> <quack.20080826T2005.lthzlmz2m4g@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 11:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGy2-0001Ke-G2
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 11:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbYH0JEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 05:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbYH0JEZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 05:04:25 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:45882 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbYH0JEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 05:04:24 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A083E5465; Wed, 27 Aug 2008 11:04:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <quack.20080826T2005.lthzlmz2m4g@roar.cs.berkeley.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93879>

Karl Chen wrote:
>Yes, I can work around this issue with sh -c 'git fetch
>0</dev/null', and maybe it shouldn't close(0) in the first place.
>But I don't see the harm in being safe.  It's one less potential
>surprise for users.  This is the first program I've encountered
>that broke due to stdin being closed, and it took debugging to
>figure out that was the reason.

I understand the reasoning, and there sure is a valid point in here
(principle of least surprise), but there is also the case of hiding
problems.
It's a bit unclear which should prevail here.
The point is that if you actually make git detect and correct
closed descriptors which should have been open, then you are merely
passing the buck to all other programs the user is starting which might
or might not break.

Maybe the breakage of other programs is only in conjunction with
full-moon and FD 0 closed, in that case you make the problems/bugs even
*harder* to find for the user by making git "fix it for you".
-- 
Sincerely,
           Stephen R. van den Berg.
"First, God created idiots.  That was just for practice.
 Then he created school boards."  --  Mark Twain
