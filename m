From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Read cvsimport options from repo-config
Date: Mon, 05 Feb 2007 20:26:17 -0800
Message-ID: <7vireflxna.fsf@assigned-by-dhcp.cox.net>
References: <3f80363f0702051722x1812228fp1cd7a41dd32b31f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "James Bowes" <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 05:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEHub-0003wP-J8
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 05:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXBFE0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 23:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbXBFE0T
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 23:26:19 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:56550 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751400AbXBFE0S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 23:26:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206042618.EPOQ1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Feb 2007 23:26:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L4SH1W00k1kojtg0000000; Mon, 05 Feb 2007 23:26:18 -0500
In-Reply-To: <3f80363f0702051722x1812228fp1cd7a41dd32b31f3@mail.gmail.com>
	(James Bowes's message of "Mon, 5 Feb 2007 20:22:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38808>

I find what your patch does quite sensible, although the
split(/ *(?!:)/) magic might be a bit hard to read for the
uninitiated.

> +		my $arg = 'git-repo-config';
> +		$arg .= ' --bool' if ($o !~ /:$/);
> +
> +        chomp(my $tmp = `$arg --get cvsimport.$key`);
> +		if ($tmp && !($arg =~ / --bool / && $tmp eq 'false')) {

Can this =~ / --bool / ever match (note the SP after 'l')?
