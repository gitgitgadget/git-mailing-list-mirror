From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-status producing incorrect results
Date: Thu, 14 Feb 2008 09:04:59 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802140902470.6110@woody.linux-foundation.org>
References: <20080214164505.GA21932@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhXb-0004k4-Qg
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYBNRF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYBNRF5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:05:57 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55719 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358AbYBNRF4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2008 12:05:56 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1EH501I018049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Feb 2008 09:05:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1EH4xfA025675;
	Thu, 14 Feb 2008 09:05:00 -0800
In-Reply-To: <20080214164505.GA21932@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73893>



On Thu, 14 Feb 2008, Jeff King wrote:
> 
> The patch below fixes it by discarding and re-reading the index if we
> are doing a partial commit

ACK. The partial commit case really should discard the index.

>                            but I suspect it may just be papering over
> the problem again. We probably need to have two separate index_states,
> and pass in the correct one to wt-status (rather than giving it the
> filename and having it read into the_index).

ACK again, that's almost certainly the right long-term fix, but it 
essentially requires a "copy_index()" thing that creates a new index from 
an existing copy (so that we don't need to re-read it) etc infrastructure 
changes, so I think your patch is the correct one for now.

		Linus
