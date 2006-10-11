From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] separate .git from working directory
Date: Wed, 11 Oct 2006 15:22:31 -0700
Message-ID: <7vd58ysdaw.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
	<20061011181425.GA10922@admingilde.org>
	<fcaeb9bf0610111446i35251fc9i6517cc5b3b53fe84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 00:24:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXmTF-0001rP-Ta
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 00:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161569AbWJKWWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161571AbWJKWWe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 18:22:34 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7912 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161569AbWJKWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 18:22:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011222232.IRCF22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 18:22:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZANb1V00A1kojtg0000000
	Wed, 11 Oct 2006 18:22:35 -0400
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0610111446i35251fc9i6517cc5b3b53fe84@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Thu, 12 Oct 2006 04:46:51 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28758>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> I thought about symlinks. However find will follow symlinks and
> traverse .git directories again. My goal is to prevent looking into
> .git directories

I do not think the user (i.e. the developer working in his git
tree or git forest that hosts subprojects) should have to bend
and move .git directories away from the directory structure he
works in just to please the tool (i.e. find).  In this case the
tool has an easy way to bend itself to match what the user
wants, which is:

	find ... \( -type d -name .git -prune \) -o ...
