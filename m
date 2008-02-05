From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-daemon breakage in 1.5.4
Date: Tue, 05 Feb 2008 12:02:36 -0800
Message-ID: <7vr6fr9noj.fsf@gitster.siamese.dyndns.org>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>, srp@srparish.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMU1J-0006Xh-0G
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758843AbYBEUDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759880AbYBEUC7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:02:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759871AbYBEUC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:02:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D12C16418;
	Tue,  5 Feb 2008 15:02:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DDEE86414;
	Tue,  5 Feb 2008 15:02:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72686>

Wincent Colaiuta <win@wincent.com> writes:

> I just noticed that my copy of git-daemon running from xinetd on Red
> Hat Enterprise Linux 3 has been broken since upgrading to 1.5.4.
>
> On the client side this is what you see ("git clone" used in the
> example but you get the same issue with "git ls-remote"):
>
>   git clone git://git.wincent.com/wikitext.git
>   Initialized empty Git repository in /tmp/wikitext/.git/
>   fatal: The remote end hung up unexpectedly
>   fetch-pack from 'git://git.wincent.com/wikitext.git' failed.
>
> Nothing printed to the logs on the server side: it simply hangs up. By
> connecting via telnet I've confirmed that git-daemon is running and
> does accept the initial connection.
>
> The verdict according to "git bisect" is that
> 511707d42b3b3e57d9623493092590546ffeae80 is first bad commit:
>
> commit 511707d42b3b3e57d9623493092590546ffeae80
> Author: Scott R Parish <srp@srparish.net>
> Date:   Sun Oct 28 04:17:20 2007 -0700
>
>     use only the $PATH for exec'ing git commands

Perhaps you did not install git on the PATH processes launched
by your inetd implementation would use?
