From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] revision traversal: show full history with merge
 simplification
Date: Thu, 31 Jul 2008 15:30:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311526270.3277@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com> <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org> <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org> <7vej5b3ozz.fsf@gitster.siamese.dyndns.org> <7vhca6zcuy.fsf@gitster.siamese.dyndns.org>
 <7vd4kuzcst.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgjx-0000eP-8O
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbYGaWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 18:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbYGaWeU
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:34:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39139 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753951AbYGaWeT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 18:34:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VMXsVZ002568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 15:33:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VMXsDj016092;
	Thu, 31 Jul 2008 15:33:54 -0700
In-Reply-To: <7vd4kuzcst.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.906 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91010>



On Thu, 31 Jul 2008, Junio C Hamano wrote:
>
> If you look at the output from the "kernel/printk.c" with this patch, you
> would notice that there still are somewhat meaningless merges shown in the
> history (e.g. scroll down to 185a257f2f73bcd89050ad02da5bedbc28fc43fa).

They're not really meaningless.

Yes, they are pointless for the end result, but once you start showing 
that whole pointless branch they very much are needed for a complete view 
of the "shape" of history. The merges are real points on that branch where 
printk changed because it got updates from mainlines.

So either you should have the full simplification (which only shows stuff 
that is really meaningful for the end result), or you need for those 
"pointless" merges to remain (because you show the changes that happened 
on side branches).

I obviously believe that the full simplification is what you most often 
want, but the --post-simplify thing does make sense.

(And yes, I agree that the name should be something else, and that 
--simplify-merges makes more sense. The "post-simplify" thing is an 
implementation issue, and doesn't describe what the effect is. And with 
your incremental one, even that isn't true).

			Linus
