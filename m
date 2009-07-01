From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] grep: move context hunk mark handling into show_line()
Date: Wed, 01 Jul 2009 15:55:19 -0700
Message-ID: <7vzlbodne0.fsf@alter.siamese.dyndns.org>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDCFE.3050808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:55:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM8i9-0003Th-1I
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbZGAWzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2009 18:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZGAWzS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:55:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63730 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbZGAWzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:55:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701225520.OAWH17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Jul 2009 18:55:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id AmvK1c00L4aMwMQ04mvKi6; Wed, 01 Jul 2009 18:55:20 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=OgmuE65XyGQA:10 a=v6yO08Rf7k42Y96wfBoA:9
 a=yX1g3PSwjzfczPxLzrQdRYF1AikA:4
X-CM-Score: 0.00
In-Reply-To: <4A4BDCFE.3050808@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu\, 02 Jul 2009 00\:02\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122612>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Move last_shown into struct grep_opt, to make it available in
> show_line(), and then make the function handle the printing of hunk
> marks for context lines in a central place.

Makes sense.  But now "are we showing from a separate block of text" ch=
eck
is in show_line() and relieves the caller of show_line() from doing so,=
=2E..

>  		else if (last_hit &&
>  			 lno <=3D last_hit + opt->post_context) {
>  			/* If the last hit is within the post context,
>  			 * we need to show this line.
>  			 */
> -			if (last_shown && lno !=3D last_shown + 1)
> -				fputs(hunk_mark, stdout);
>  			show_line(opt, bol, eol, name, lno, '-');
> -			last_shown =3D lno;

=2E.. the comment in this context should go, no?
