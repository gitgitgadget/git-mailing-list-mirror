From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: new cgi parameter: option
Date: Thu, 12 Jul 2007 11:45:39 -0700
Message-ID: <7vy7hltq98.fsf@assigned-by-dhcp.cox.net>
References: <20070708013543.GD29994@genesis.frugalware.org>
	<f73hhc$uo1$1@sea.gmane.org>
	<20070711230038.GN19386@genesis.frugalware.org>
	<200707121211.32813.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:45:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93fc-0004X9-6u
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbXGLSpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbXGLSpm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:45:42 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33433 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXGLSpk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:45:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712184540.YISA1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 14:45:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nilf1X00L1kojtg0000000; Thu, 12 Jul 2007 14:45:40 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52316>

Jakub Narebski <jnareb@gmail.com> writes:

> [*1*] At least in gitweb. If I understand correctly, you can use
> "git diff --cc tree1 tree2 tree2 ..." to get combined diff of specified
> tree-ish; I'm not sure if git-diff-tree support this. And I know that
> gitweb does not support this... at least for now. Would this be useful,
> I wonder?

I would say that would only be useful to satisfy curiosity.
Luckily or unluckily I have not had real life use of that
multiple tree comparison feature that is supported by "git
diff" (multiple blob comparison is also available, which is
mildly useful).

>> +our $option = $cgi->param('option');
>> +if (defined $option) {
>> +	if (not grep(/^$option$/, keys %options)) {
>> +		die_error(undef, "Invalid option parameter");
>> +	}

"!exists $options{$option}" ?

> I'd rather make it possible to pass multiple additional options, for
> example both '--remove-empty' (to speed up) and '--no-merges' for the
> history view. So I'd use
>
>   +our @options = $cgi->param('option');
>
> instead.

Good point.

> I'm also not sure if invalid option parameter for action should return
> error, or be simply ignored.

I'm mildly against "simply ignoring".

> By the way, gitweb uses shortened names for paramaters. Perhaps 'opt'
> or 'op' instead of 'options' here and in href subroutine (below)?

Or even 'o' ;-).
