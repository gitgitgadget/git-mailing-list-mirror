From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rm and add, but not rename, of identical files
Date: Wed, 10 Oct 2012 14:47:26 -0700
Message-ID: <7v1uh6atjl.fsf@alter.siamese.dyndns.org>
References: <1349894347.32696.10.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:47:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM47x-0001Wt-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 23:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab2JJVrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 17:47:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2JJVra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 17:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 303DD8CD0;
	Wed, 10 Oct 2012 17:47:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUFpPCus6njDMCPPzCxRySeGq7A=; b=LdsvDW
	UVIJROlr7YFvheRygZjCOxtyf/ky4JMP8s5CGCqfktYQT58uzEELq+og+0gJg3fE
	BE7dqWXXZe9wFX3VyFnlzJv89VudEoc/garXwhlOsYPD+mGlIUuT/0t3DXkTA66b
	qwWPpZyrhbdPjJaKUqOw+L0tiBwZjJdC5P7ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6vanrmXXJvB/uEZgB3U69u9GMOfNbiT
	0Noioh+U2lsfxUFR4PqEYZQP7+pxb7bpZ9ePpo1PHMK+ygBGZR9lnJvNzwZPqkSC
	KVS0aNHG0bo4D8MFvQEOWCHo/76J/iaftkAd4Y6PthMfvD0pfbuO2grKd05RjjFP
	J86BVYzLiFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E7988CCF;
	Wed, 10 Oct 2012 17:47:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 879FF8CCD; Wed, 10 Oct 2012
 17:47:28 -0400 (EDT)
In-Reply-To: <1349894347.32696.10.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Wed, 10 Oct 2012 14:39:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16224A12-1324-11E2-ADB2-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207446>

Drew Northup <drew.northup@maine.edu> writes:

> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       rc.d/rc2.d/S08iptables
> #       rc.d/rc3.d/S08iptables
> #       rc.d/rc4.d/S08iptables
> ...
> no changes added to commit (use "git add" and/or "git commit -a")
>
> It detects the changes as renames however―which in this case isn't
> appropriate:
>
> [root@drew-northup ~]# etckeeper vcs status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       renamed:    rc.d/rc2.d/K92iptables -> rc.d/rc2.d/S08iptables
> #       renamed:    rc.d/rc3.d/K92iptables -> rc.d/rc3.d/S08iptables
> #       renamed:    rc.d/rc4.d/K92iptables -> rc.d/rc4.d/S08iptables
> #...

Given that all of these six files have the same contents, I actually
am slightly impressed how well Git matched them up ;-).

But more seriously, why do you have rc.d/rc2.d/S08iptables untracked
in the working tree but in the index to be committed?
