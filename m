From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] bisect: write about `bisect next` in documentation
Date: Sat, 27 Feb 2016 10:03:39 -0800
Message-ID: <xmqqk2lqghdw.fsf@gitster.mtv.corp.google.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-2-git-send-email-s-beyer@gmx.net>
	<xmqqoab3jokp.fsf@gitster.mtv.corp.google.com>
	<56D1A873.1090709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjDW-0007Fu-GC
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697AbcB0SDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 13:03:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756590AbcB0SDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:03:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55F9945F62;
	Sat, 27 Feb 2016 13:03:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eNYyqDO8R80a8YMx0p9DMQNgC7U=; b=rHbA8N
	yVxYRI0c7bvbJpUVv2ZY7jLZCalySmgP3xCB9cqkT7cAof5ClE7eFk1faUEA8Tcy
	ixiXyum0HRICTFkX3BTOMaaXfIPL4n8l5lFNot5GB9EWHDCw0IrkedyPX+oHpDXZ
	t6n7ZJzY3s9smSQkjdf5OnSSnsFelydxWxgb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOPqodS2Z7qgoFHBIhQ6/hDDUwy2pnN4
	MDSSD0WRhBi4A1O8BTzbcnhudepfGkuZdqE8DcXg4/Lb9HmtGalyhlKGm6X+dj3j
	HWvlp+/D0LAfzP0mQqVLi52ss+ZPpG7tUuQt43E3BaYQNVAaEyJfH/1nxQ8IJ5la
	lYc8G1dC9SA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D6C845F61;
	Sat, 27 Feb 2016 13:03:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C1EBB45F60;
	Sat, 27 Feb 2016 13:03:40 -0500 (EST)
In-Reply-To: <56D1A873.1090709@gmx.net> (Stephan Beyer's message of "Sat, 27
	Feb 2016 14:45:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EBA83EE-DD7C-11E5-8022-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287714>

Stephan Beyer <s-beyer@gmx.net> writes:

> I rephrase it as follows to not encourage checking out another branch
> (or commit ;]) but to mention that it works to get back if someone
> accidentally did it.
>
> --8<--8<--8<--
>
> Bisect next
> ~~~~~~~~~~~
>
> In case you have marked a commit as bad but you do not know a good
> commit, you do not have to crawl through the commit history yourself to
> find a good commit. Simply issue the command:
>
> ------------
> $ git bisect next
> ------------
>
> This command is also handy when you accidentally checked out another
> commit during a bisection. It computes the commit for the bisection
> and checks it out again.
>
> -->8-->8-->8--
>
> Is that better?

Thanks, I think it is definitely better than the original patch.

I cannot say it is better than not having that extra paragraph,
though.  An immediate recovery after an accidental checkout can be
done with "git checkout -", and the only case "bisect next" is safe
and better is somebody accidentally checked multiple random commits
out without doing anything else (in which case you'd need to ask
reflog where the HEAD was in order to use "checkout" to go back).

But if they are doing more than just a single "checkout" immediately
followed by "oops that wasn't what I intended--now I want to go
back", they need more than "bisect next" or "checkout $somewhere"
anyway, so...
