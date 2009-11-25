From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 14:16:09 +0100
Message-ID: <4B0D2E19.6020100@drmicha.warpmail.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 14:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDHkH-0002Ji-Qn
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 14:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934648AbZKYNRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 08:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934612AbZKYNRI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 08:17:08 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:60011 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934598AbZKYNRH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 08:17:07 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 634E3C17F9;
	Wed, 25 Nov 2009 08:17:14 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 25 Nov 2009 08:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=p/v+fpwE/BHsATNQiR0JskYcpvo=; b=eoQ06RPgkaFcKyAoLXm5XZ6fPEEB4ZHVijIdIpda7gF5q387JgjstCrkZ/Q3nIo61bNq+P3Yen/bZYJvOjIxIfXVdGvdIMYQmgnUwPpendxn3bTIuSzGkJONlbfaKyO4mZJ57ON92JQyUoFrlrLlw8CB6cgrvkwk+UbElsNntzg=
X-Sasl-enc: CovdXRwOH+JAdx8bNZefGMWAz0013Xm9kjhbWxuHMvne 1259155034
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D2A282D7E5;
	Wed, 25 Nov 2009 08:17:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133638>

Junio C Hamano venit, vidit, dixit 24.11.2009 09:56:
> While working inside a deep subdirectory, it sometimes is necessary to
> find a string you see in a file you are working on from the files in the
> entire project.  This is especially true when you are dipping your toe
> into an unfamiliar project.
> 
> By default, "git grep" limits its search space to the current directory
> and below (i.e. as if "-r ." is specified), and it is rather cumbersome to
> repeat ../ as many times as necessary.  This new option tells "git grep"
> not to limit the search space to the current directory.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * In http://article.gmane.org/gmane.comp.version-control.git/111717, I
>    once argued in the opposite way, but I think it is Ok to aim for making
>    the default --full-tree in the longer run (cf. $gmane/127885).  This is
>    the first step in that direction.
> 
>    I am not sure if there can be a sane way to flip the default without
>    hurting existing scripts and users.  Backward compatibility always is
>    a pain.

On a related note, I had planned for a while now to go through the
commands and check for inconsistencies w.r.t. to subdir default. For
example, ls-files behaves like grep, whereas status is different. We
already had discussions about the commit:path notation from a subdir. (I
don't remember the outcome.) Of course, defaulting status differently
could be dangerous. Having --full-tree as default for all commands and
requiring an explicit "." sounds safer for all commands and not overly
inconvenient. (I remember once wondering where my committed files are,
looking at git ls-files output from a subdir.)

I think we should make this behavior as uniform across commands as
possible. Do we have a time frame for 1.7.0 within which one should
achieve such incompatible changes?

Michael
