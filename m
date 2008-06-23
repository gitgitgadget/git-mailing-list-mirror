From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 15:38:11 -0700
Message-ID: <7vmylbg4ks.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
 <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <20080623183358.GA28941@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org>
 <20080623210935.GC13395@artemis.madism.org>
 <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
 <7v3an3hke8.fsf@gitster.siamese.dyndns.org>
 <20080623222404.GM13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuh2-0000mC-Fs
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbYFWWi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbYFWWiZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:38:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbYFWWiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:38:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FC4FBEB5;
	Mon, 23 Jun 2008 18:38:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 93900BEB4; Mon, 23 Jun 2008 18:38:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15D842D0-4175-11DD-B14E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85948>

Pierre Habouzit <madcoder@debian.org> writes:

> Though I didn't fixed the fact that parse_options clobbers argv[0],
> which can be easily fixed. The issue with that is that _some_ callers
> use the fact that the filtered argv is NULL terminated.

Isn't it just the matter of (1) leave argv[0] as is, (2) start copy dest
at argv[1] not argv[0], and (3) terminate argv[nargc] = NULL where nargc
is what you did not handle?

You have argc args in incoming argv[], you consume zero or more of them
starting from argv[1] up to potentially argv[argc-1] (and argv[argc] is
NULL).  So why is it an issue?  Sorry, I do not understand.
