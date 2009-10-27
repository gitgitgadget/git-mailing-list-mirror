From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git vs hg commit counts?
Date: Mon, 26 Oct 2009 17:18:33 -0700
Message-ID: <7v8wexd6zq.fsf@alter.siamese.dyndns.org>
References: <1256602127.29938.8.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
	mercurial@selenic.com, Marti Raudsepp <marti@juffo.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:19:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Zm9-0006Oh-T3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 01:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbZJ0ASn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 20:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbZJ0ASm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 20:18:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbZJ0ASl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 20:18:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D6FF68ACC;
	Mon, 26 Oct 2009 20:18:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1LnVFN6QdFRjcux9AIuqbR15H6o=; b=tn+MKn
	ZeRk4DcQEBl7er0HFFQB9eYh2zxYWVOcbiD1psXhsUoBfGQEtYRQTQzpWtiOJMP8
	x4vSzQajG1BKK2/wQyn3hUPLylJ6xWjO4tmDOxIAoq6fPf3p9+ReMMuEBa/d7Kb6
	vySfnVka403RH/7IRLxvvghDgUMXNaU+6Sf/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Da6EfboV6UhKQahDGrhPzNKndW0D7zHc
	pbXL+6v8oN2XSF04c/sBxQxs6P4Qxkq34k0HqCO9T70Htfs8Chf6BgpXjLI12vJW
	WdstD51b7O5jfBT5DXuLZE+l1T5w4V7NF2UngfkX2S3xmycci0++9YaDg87ZlcOU
	bGleXUiGwJ0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECF6868ACB;
	Mon, 26 Oct 2009 20:18:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D50768ACA; Mon, 26 Oct
 2009 20:18:34 -0400 (EDT)
In-Reply-To: <1256602127.29938.8.camel@Joe-Laptop.home> (Joe Perches's
 message of "Mon\, 26 Oct 2009 17\:08\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 478F9C56-C28E-11DE-9D37-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131290>

Joe Perches <joe@perches.com> writes:

> I'm comparing linux-kernel git vs hg repositories.
>
> While testing some changes to scripts/get_maintainer.pl,
> I noticed that git and hg have different commit counts
> for the same files.
>
> For instance:
>
> $ git log --since=1-year-ago -- MAINTAINERS | \
> 	grep -P "^commit [0-9a-f]{40,40}$"  | wc -l
> 514
>
> $ hg log --template="commit {node}\n" --date -365 -- MAINTAINERS  | \
> 	grep -P "^commit [0-9a-f]{40,40}$" | wc -l
> 601
>
> Anyone have any understanding why?

We simplify a merge history by discarding one branch when the merge result
matches one of the parents.  Does "hg" know how to do that as well?
