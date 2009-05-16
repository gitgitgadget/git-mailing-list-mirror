From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix minor memory leak in init-db
Date: Sat, 16 May 2009 12:56:48 -0700
Message-ID: <7vzldclt33.fsf@alter.siamese.dyndns.org>
References: <cd3664ac0905141522s3ad78411o9f015d2e7720c8b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ammon Riley <ammon.riley@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 21:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Q0E-0002Ic-6D
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051AbZEPT4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756498AbZEPT4s
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:56:48 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42719 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444AbZEPT4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:56:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516195648.JYHW20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 May 2009 15:56:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id sKwo1b0084aMwMQ03Kwohx; Sat, 16 May 2009 15:56:48 -0400
X-Authority-Analysis: v=1.0 c=1 a=33oWOrx5OBEA:10 a=N3uJvN5w5gEA:10
 a=pGLkceISAAAA:8 a=3KVrHUDPmnZfMpGNwV4A:9 a=RhawZ23XEWOuHvXWMla37Q1lavwA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <cd3664ac0905141522s3ad78411o9f015d2e7720c8b5@mail.gmail.com> (Ammon Riley's message of "Thu\, 14 May 2009 15\:22\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119379>

Ammon Riley <ammon.riley@gmail.com> writes:

> There was an xmalloc() for path, but I didn't see a corresponding free().
> Does it happen somewhere else that I'm not expecting?

It implicitly happens in exit() in git.c:handle_internal_command()
after cmd_init_db() returns the control to it.
