From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Tue, 02 Oct 2012 10:01:10 -0700
Message-ID: <7vhaqcajvt.fsf@alter.siamese.dyndns.org>
References: <5064140E.50007@drmicha.warpmail.net>
 <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org>
 <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org>
 <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl>
 <7vr4piaryi.fsf@alter.siamese.dyndns.org> <506A0366.6030009@xs4all.nl>
 <7va9w5c31w.fsf@alter.siamese.dyndns.org>
 <506A99DE.7080503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Simon Oosthoek <soosthoek@nieuwland.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:01:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5qW-0004KI-G0
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab2JBRBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 13:01:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab2JBRBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 13:01:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DEE37AFE;
	Tue,  2 Oct 2012 13:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CChMpv/jeLGe/sEhrR9sPhFQZ8Q=; b=xxZTSB
	JL0FjSjkCOAZBS2uEHz0aqnMihyy52gWKVJCzArsC1kBf0U1oP0km/h3ocQ2kUok
	GD7vropL7ZHU/A8DIHHb3cr58x3ehx6nsUZvCPJUQTs5qTyrGv51w5wMpX4GBEse
	38/eQQdTg+D2aoVWxM+hXbtEWbQJHju+2UA4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVYQZnfN/ct4dfkqlURUN5UafaW2X5pr
	kohnsg2zEd0yztwi6Z8x28hy96lwrJyTg6Ejga6FORlnN8mZY4ayIh2kfu4q9+zw
	f/r9TnwfxRRNRh5dLubODZUtYYFOwWjHRqW4ixt66Gw3YPGcWuM/Sk5EyJ47fVS9
	J84tmj7Q2oI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AA407AFD;
	Tue,  2 Oct 2012 13:01:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81B657AFA; Tue,  2 Oct 2012
 13:01:12 -0400 (EDT)
In-Reply-To: <506A99DE.7080503@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 02 Oct 2012 09:38:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C51F337C-0CB2-11E2-8EDC-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206821>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 01.10.2012 23:09:
>
>> Confused....
>> 
>
> The "problem" (as far as I see) is only: What user interface do we want
> to expose to the user, or rather, do we want to expose the user to ;)
>
> So far, we say:
>
> #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
> #    2) Add the following line to your .bashrc/.zshrc:
> #        source ~/.git-prompt.sh
> #    3) Change your PS1 to also show the current branch:
> #         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> #         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
>
> (That's incomplete for zsh, but I'm digressing...). With the above, we
> would change the bash instruction to
>
> PROMPT_COMMAND='
> 	PS1=$(printf "\u \h \w %s$ " $(__git_ps1 "%s"))
>        '
>
> which may look more complicated to some. I think we can aim for
> something like
>
> PROMPT_COMMAND='__git_ps1_color "\u \h \w%s$ " " (%s)"'

If your goal is to use PROMPT_COMMAND and not PS1, then yes between
the two definitions of PROMPT_COMMAND above, the latter may look
simpler.  But that does not explain why you want to prefer it over
PS1 in the first place, which was the central point of my question
that still has not been answered.

Even more confused...
