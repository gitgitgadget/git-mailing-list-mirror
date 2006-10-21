From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Syntax highlighting for combined diff
Date: Sat, 21 Oct 2006 02:41:35 -0700
Message-ID: <7vfydigg4w.fsf@assigned-by-dhcp.cox.net>
References: <ehbq0k$24l$1@sea.gmane.org>
	<7vslhigld7.fsf@assigned-by-dhcp.cox.net>
	<200610211049.56477.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 11:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbDMM-0002kt-8E
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 11:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992887AbWJUJlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 05:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992897AbWJUJlh
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 05:41:37 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:53997 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S2992887AbWJUJlg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 05:41:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021094135.LLAY2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Oct 2006 05:41:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cxhL1V00x1kojtg0000000
	Sat, 21 Oct 2006 05:41:21 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610211049.56477.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 21 Oct 2006 10:49:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29597>

Jakub Narebski <jnareb@gmail.com> writes:

> Do I understand code correctly, and the last '+' or '-'
> in the parents column means?
>
>         for (i = 0; i < ecbdata->nparents && len; i++) {
>                 if (line[i] == '-')
>                         color = DIFF_FILE_OLD;
>                 else if (line[i] == '+')
>                         color = DIFF_FILE_NEW;
>         }
>
> Anyone who wrote this code, could you answer me, please?

The "up to ecbdata->nparents" is Johannes in cd112ce.  But you
are looking at a wrong code, I am afraid, if your original
question was about the combined format (there is a comment about
the codepath dealing only with two-way diffs by Johannes, above
the part you quoted).  The output for combined diff is coming
from combine-diff.c:dump_sline().

Combined diff output logic pretty much guarantees that you never
will see plus and minus on the same line.
