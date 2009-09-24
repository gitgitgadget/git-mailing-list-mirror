From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] print_wrapped_text(): allow hard newlines
Date: Wed, 23 Sep 2009 17:00:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909231659010.3303@localhost.localdomain>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org> <1253655038-20335-1-git-send-email-heipei@hackvalue.de> <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Gilger <heipei@hackvalue.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 02:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqbn4-0006HQ-Ao
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 02:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbZIXABz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 20:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZIXABz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 20:01:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60317 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752753AbZIXABz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2009 20:01:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8O00w21016729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Sep 2009 17:00:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8O00wv6004599;
	Wed, 23 Sep 2009 17:00:58 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.961 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129014>



On Wed, 23 Sep 2009, Johannes Schindelin wrote:
> 
> print_wrapped_text() will insert its own newlines. Up until now, if the
> text passed to it contained newlines, they would not be handled properly
> (the wrapping got confused after that).
> 
> The strategy is to replace a single new-line with a space, but keep double
> new-lines so that already-wrapped text with empty lines between paragraphs
> will be handled properly.

May I suggest doing this _only_ if the newline is followed by an 
alphanumeric characer?

If the thing is indented ("newline + space") or quoted ("newline + ">" or 
whatever) then reflowing it is likely wrong and will result in an unholy 
mess.

			Linus
