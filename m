From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (take 3)] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 13:13:01 -0700
Message-ID: <7vejue2omq.fsf@assigned-by-dhcp.cox.net>
References: <200609140839.56181.jnareb@gmail.com>
	<200609142134.33725.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 22:13:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxa9-0007mt-EP
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 22:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWINUNG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 16:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWINUNG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 16:13:06 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56253 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751120AbWINUND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 16:13:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914201302.TCJM13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 16:13:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NLCr1V0051kojtg0000000
	Thu, 14 Sep 2006 16:12:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609142134.33725.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 14 Sep 2006 21:34:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27037>

Jakub Narebski <jnareb@gmail.com> writes:

> +			wanted => sub {
> +				# skip current directory
> +				return if (m!^/|.|..$!);

Huh?

 (1) Did you mean to say "\." (not any single character but
     literally dot)?

 (2) how does the alternatives within m{} construct bind (iow,
     please be gentle to the readers)?  Do you mean

	return if (/^\/(?:\.|\.\.)$/)

     in other words,

     	return if (/^\/\.$/ || /^\/\.\.$/)

     in other words,

        return if (/^\/\.{1,2}/)

     ???
