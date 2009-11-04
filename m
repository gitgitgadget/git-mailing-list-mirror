From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 0/3] use '--bisect-refs' as bisect rev machinery
 option
Date: Wed, 4 Nov 2009 10:32:53 -0800 (PST)
Message-ID: <alpine.LFD.2.01.0911041030080.31845@localhost.localdomain>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org> <7vljimgnaz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kfU-0003CU-0O
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769AbZKDSdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757759AbZKDSdE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:33:04 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37267 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757703AbZKDSdD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 13:33:03 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id nA4IWsYe028711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Nov 2009 10:32:55 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id nA4IWrhN031721;
	Wed, 4 Nov 2009 10:32:54 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vljimgnaz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.961 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132112>



On Wed, 4 Nov 2009, Junio C Hamano wrote:

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
> > So I suggest to use '--bisect-refs' instead of '--bisect' as the new
> > bisect revision machinery option, because otherwise I think we get a
> > regression when we call "git rev-list --bisect BAD --not GOOD" and we
> > are already bisecting with bisect refs different than BAD and GOOD.
> > This also simplifies the code a little bit.
> 
> Just to make sure that I read you correctly, do you mean that Linus now
> would say:
> 
>     $ git bisect ...
>     ... inside bisect session
>     $ gitk --bisect-refs arch/x86

I'd really rather prefer to keep '--bisect' for that, it doesn't make 
sense to export '--bisect-refs' to be the user-visible switch, and then 
have '--bisect' as some internal switch just for 'git rev-list'.

In fact, I'd argue that the ne wbehavior of 'git rev-list' is to some 
degree _better_ (ie the existing bad/good ones are implicit while doing 
bisection).

Yes, it is a behavioral change, but is it a bad one?

			Linus
