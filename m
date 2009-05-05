From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix sloppy Getopt::Long.
Date: Tue, 05 May 2009 12:37:34 -0700
Message-ID: <7vfxfj1gu9.fsf@alter.siamese.dyndns.org>
References: <1241547374-6737-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue May 05 21:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1QSW-00087o-ET
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 21:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbZEEThf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 15:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZEEThf
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 15:37:35 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36313 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZEEThe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 15:37:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090505193733.RHJD20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 May 2009 15:37:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id nvda1b0074aMwMQ04vday8; Tue, 05 May 2009 15:37:34 -0400
X-Authority-Analysis: v=1.0 c=1 a=uHxVNUnCMDAA:10 a=uXjSJhdlV4cA:10
 a=7mOBRU54AAAA:8 a=M8IKG3P2SXykLJnDW1kA:9 a=pj-UKjVIzJsYP7rHUeZPqro1HHkA:4
 a=WeOa-AV5lc8A:10
X-CM-Score: 0.00
In-Reply-To: <1241547374-6737-1-git-send-email-robbat2@gentoo.org> (Robin H. Johnson's message of "Tue\,  5 May 2009 11\:16\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118310>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Getopt-Long v2.38 is much stricter about sloppy getopt usage. The
> trailing pipe causes git-svn testcases to fail for all of the --stdin
> argument calls.

I am not objecting at all; just asking for clarification.

> -			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
> +			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],

Is this "pipe" supposed to be followed by an alternative spelling of the
option, as in

	'stdin|standard-input' => \$_stdin, ...

and is the sloppyness that it would be crazy to accept either --stdin or
just -- (without actual option name) for this option?

Could an older version of Getopt::Long() have accepted

	$ command --foo --bar - other args

to set $_stdin to true with that "sloppy" syntax?  If so people could have
relied on such a behaviour, which is a bit worrying.
