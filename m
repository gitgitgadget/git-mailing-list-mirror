From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score for rename detection
Date: Wed, 27 Jun 2007 21:29:45 -0700
Message-ID: <7vtzssog5i.fsf@assigned-by-dhcp.pobox.com>
References: <46831F70.2060403@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 06:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3ldm-0002bT-1Z
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 06:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbXF1E3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 00:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbXF1E3s
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 00:29:48 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52621 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbXF1E3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 00:29:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070628042947.SFNO6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 00:29:47 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GsVm1X00A1kojtg0000000; Thu, 28 Jun 2007 00:29:46 -0400
In-Reply-To: <46831F70.2060403@midwinter.com> (Steven Grimm's message of "Wed,
	27 Jun 2007 19:39:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51079>

I wonder if we have a path or the attribute cue at this point of
the operation.  Your patch may solve that special case of CRLF
mangled files, but diffcore-delta works both on text and binary
and I am not sure what damange/side-effect you are causing.

And you are not ignoring "\r\n vs \n difference" as the comment
claims, but are discarding '\r' unconditionally.  When we start
doing something like that, I would feel much better if we _know_
we are operating on a text file at least.
