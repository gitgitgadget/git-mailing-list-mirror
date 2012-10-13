From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A design for subrepositories
Date: Sat, 13 Oct 2012 10:30:00 -0700
Message-ID: <7vd30m2sbr.fsf@alter.siamese.dyndns.org>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lauri Alanko" <la@iki.fi>
X-From: git-owner@vger.kernel.org Sat Oct 13 19:30:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN5XY-0003Od-Ip
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 19:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab2JMRaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 13:30:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857Ab2JMRaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 13:30:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88ACC840B;
	Sat, 13 Oct 2012 13:30:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l4PTFRuxW4OlscGS/GHOHCnKHdA=; b=FyCVkN
	zivKd51mQyBf3q8fBku3ilYzTDL5BRBhYdi6lRcUodr1iPkt2XC0JQh+L7zvu0Fo
	BpcxTMBwFBQEvavs0cLyJiYwnRuwMcZ/+dkMlFAng2NlUrZGHet0OTScBCS4aC7I
	+CfRlTs6oyvQh7Fkmu6JcKgmxC5eqq+CAyAi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L08ToX43iu+B1g6Kit28F+X1QNyEkB2s
	WEDV4ICEe7sluWxtBCpiLxGzLv8qK9h/nudoPYtsB4dEwdo/0rQNR1556v5yh1iY
	nP6SA1dkBmjAWr8q9Q3WKVQjlZJYDyySSadg18dA430/PdFmuh8RRmDGMk2/iph9
	Yf37/NUhOiE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B1158400;
	Sat, 13 Oct 2012 13:30:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8427383FF; Sat, 13 Oct 2012
 13:30:02 -0400 (EDT)
In-Reply-To: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
 (Lauri Alanko's message of "Sat, 13 Oct 2012 16:33:22 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9ED4D04E-155B-11E2-A944-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207574>

"Lauri Alanko" <la@iki.fi> writes:

> I intend to work on a "subrepository" tool for git, but before I
> embark on the actual programming, I thought to first invite comments
> on the general design.
>
> Some background first. I know that there are several existing
> approaches already for managing nested repositories, but none of them
> quite seems to fit my purposes. My primary goal is to use git for home
> directory backup and mirroring, while the home directory itself may of
> course contain repositories.
> ...
> Submodules are a bit closer to what I want, but they have clearly been
> designed for a different purpose: a repository with submodules is only
> supposed to collate existing repositories, not act as a source for
> them.

I have a repository that covers my home directory and some of its
subdirectories have their own repositories.

I had my home directory and its subdirectories before Git ever
existed, and I made my home directory and these subdirectories into
separate, nested Git repositories fairly early after I started
managing them with Git---way before submodules were invented.  Now
the subdirectory repositories are bound as submodules of the top
level directory just fine.

I push these out for safekeeping purposes, all of my machines get
their copies from here, and some submodules are not cloned to work
machines (they house data of private nature).  They are used just
like you are expected to use submodules. In fact, this is pretty
much vanilla use case of submodules, I think.

They _all_ originate from under my home directory, not "collating
existing repositories" at all.

Have you considered how you can _extend_ submodules support to
support your use case better?  I think that would be a much more
useful approach, as you are likely to get help from other people who
do use submodules.
