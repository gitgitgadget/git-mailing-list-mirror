From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cumulative "git read-tree -m" rejected with overwriting warning
Date: Wed, 13 Feb 2013 15:40:24 -0800
Message-ID: <7v1ucj4wbb.fsf@alter.siamese.dyndns.org>
References: <20130213230213.GT20333@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Thu Feb 14 00:40:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5lwd-0001dd-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 00:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247Ab3BMXkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 18:40:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965136Ab3BMXkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 18:40:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9929D8ED5;
	Wed, 13 Feb 2013 18:40:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ktZqO/gS9xVsFywzeqcGCQ/wKnU=; b=xn1Dfn
	X01TWePVNmch/yEyrjxX/vYL2BRKcL0d7g+CMZLXaRH+Q/IaKZh8QJqLEjrHD9tN
	nAFlEdPkJssJXdk2n3ycQlJs9c0Hm4/sOffVbjJwcITeZILrwMG36DnuOBZ3Z24y
	5HcXXYMzmaTrpQ5UEL+Tki7ssSZXjJJLyre7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ei4vpbowElH30Mwc4VN6AibmsBoPGpNZ
	W+BXumIOnVGCqMRwnS6alofeiHJbFYRsqhaCUDpDf4eu0wNPrd+VIIN+mq4X+cwQ
	c5HmXqLpxefN6ASzCk0VV55mcadI6ULP+SRUZMSblP06aaBrrSplUjrIJVF+VASQ
	pWUXKJCrLnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B07AB8ECD;
	Wed, 13 Feb 2013 18:40:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D7048EA8; Wed, 13 Feb 2013
 18:40:27 -0500 (EST)
In-Reply-To: <20130213230213.GT20333@localhost> (Marcin Owsiany's message of
 "Wed, 13 Feb 2013 23:02:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF024A18-7636-11E2-8880-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216293>

Marcin Owsiany <marcin@owsiany.pl> writes:

>  "the index file saves and restores with all this information, so you
>  can merge things incrementally,"
>
> which I took to mean that I can read from multiple trees one by one
> before writing the tree.

That "incrementally" refers to "after a three-way merge stops with
conflicts in multiple files, you can start from file A, concentrate
only on that file, resolve it, and then go on to resolve conflicts
in the next file B, continue, until you resolve the conflicts in the
last file Z".  Until you resolve a single tree-way merge fully and
write the results out as a tree, you cannot merge in the next tree.

That is why N-way octopus is internally implemented as a series of
three-way merges.
