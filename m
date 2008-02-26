From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Tue, 26 Feb 2008 07:59:53 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20080226065953.GA25073@informatik.uni-freiburg.de>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch> <87skznhqk6.fsf@rho.meyering.net> <7vzlts9ag8.fsf@gitster.siamese.dyndns.org> <87ir0gx5bn.fsf@rho.meyering.net> <7vskzk99fd.fsf@gitster.siamese.dyndns.org> <87tzk0tzjz.fsf@rho.meyering.net> <7vd4qo7fsc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, Jean-Luc Herren <jlh@gmx.ch>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 08:01:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTtoV-0002vW-6l
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 08:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759081AbYBZHA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2008 02:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbYBZHA0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 02:00:26 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:50634 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758759AbYBZHAZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2008 02:00:25 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1JTtnb-0000HC-Rq; Tue, 26 Feb 2008 08:00:23 +0100
Received: from zeisberg by login.informatik.uni-freiburg.de with local (Exim 4.63)
	(envelope-from <zeisberg@login.informatik.uni-freiburg.de>)
	id 1JTtn7-0006dK-RG; Tue, 26 Feb 2008 07:59:53 +0100
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>, Jim Meyering <jim@meyering.net>,
	Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vd4qo7fsc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75106>

Hello Junio,

> I am not interested in automating useless "if (x) free(x)"
> tests, but one thing I recently wanted but did not know a handy
> tool for was to find all the calls to free() that free a pointer
> to an object of a particular type.  More specifically, we seem
> to allocate and free many "struct commit_list", and I wanted to
> introduce a custom bulk allocator.  Allocate many of them in a
> block, hand out one by one, and tell callers to hand them back
> not to free() but to the allocator so that it can keep the
> returned ones on a linked list and hand them back again when the
> next call wanted to allocate one without actually calling
> xmalloc()).  But in order to do so, missed conversion from
> malloc() to the custom allocator is not fatal (just wasteful),
> but forgetting to convert free() really is.
Maybe http://www.emn.fr/x-info/coccinelle/ can help you?

I think it could automate if (x) free(x), too.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig
