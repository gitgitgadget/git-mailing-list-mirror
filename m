From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Clarify pre-push hook documentation
Date: Tue, 25 Mar 2014 10:11:09 -0700
Message-ID: <xmqqmwgemceq.fsf@gitster.dls.corp.google.com>
References: <1395704609-81957-1-git-send-email-dcow90@gmail.com>
	<1395705088-82216-1-git-send-email-dcow90@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, sunshine@sunshineco.com
To: David Cowden <dcow90@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:11:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUsf-0007lH-SG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbaCYRLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:11:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbaCYRLM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:11:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5572F7786B;
	Tue, 25 Mar 2014 13:11:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S6QHOIt+ut3cyY7NPqMmFxyeFwk=; b=GVkAtu
	oJ5xTYZLHuMJHY6qUlzhibDCqKnPELGv4OBL1k6ZsGODwLBs/qLFYeST5/LtwoXq
	WzTVCxYvbxj/3Uxe3HVQCSQfTTfifRnDgJyDZ8/Nt1xPB6JMpzl8+ydJK7KWhpFV
	vqO0dxNiJ0mG7l+Pqf5ColT4uG+wdOBh0hbjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NyXBE9D0Zf5oTR+2OFrMjfvK2mk1LQL0
	VcvI9YmWXy1JMmnbQo0w1++Qz2X5xeEoOXrr42kbVDJrXKEHx4G6UJBC0dTnWvTw
	Mh+djn8i+CnI4lhY0iWiAOkOk2wRL96tI9Dem29Ne5PYrN6n9E3mOUvFRWirMRsf
	uDaOpRJ403s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A1E77786A;
	Tue, 25 Mar 2014 13:11:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52DFE77865;
	Tue, 25 Mar 2014 13:11:11 -0400 (EDT)
In-Reply-To: <1395705088-82216-1-git-send-email-dcow90@gmail.com> (David
	Cowden's message of "Mon, 24 Mar 2014 16:51:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76B186FE-B440-11E3-A3BE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245050>

David Cowden <dcow90@gmail.com> writes:

> The documentation as-is does not mention that the pre-push hook is
> executed even when there is nothing to push.  This can lead a new
> reader to believe there will always be lines fed to the script's
> standard input and cause minor confusion as to what is happening
> when there are no lines provided to the pre-push script.
>
> Signed-off-by: David Cowden <dcow90@gmail.com>
> ---
>
> Notes:
>     I'm not sure if I've covered every case here.  If there are more cases to
>     consider, please let me know and I can update to include them.

I do not think of any offhand, but a more important point that I was
trying to get at was that we should not give an incorrect impression
to the readers that the scenario that is described is the only case
they need to be worried about by pretending to be exhaustive.

The "may" in your wording "This may happen when" may be good enough
to hint that these may not be the only cases.

>     c.f. http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin
>
>  Documentation/githooks.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index d954bf6..1fd6da9 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -203,6 +203,15 @@ SHA-1>` will be 40 `0`.  If the local commit was specified by something other
>  than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
>  supplied as it was originally given.
>  
> +The hook is executed regardless of whether changes will actually be pushed or
> +not.  This may happen when 'git push' is called and:
> +
> + - the remote ref is already up to date, or
> + - pushing to the remote ref cannot be handled by a simple fast-forward
> +
> +In other words, the script is called for every push.  In the event that nothing
> +is to be pushed, no data will be provided on the script's standard input.

When two things are to be pushed, the script will see the two
things.  When one thing is to be pushed, the script will see the one
thing.  When no thing is to be pushed, the script will see no thing
on its standard input.

But isn't that obvious?  I still wonder if we really need to single
out that "nothing" case.  The more important thing is that it is
invoked even in the "0-thing pushed" case, and "the list of things
pushed that is given to the hook happens to be empty" is an obvious
natural fallout.

>  If this hook exits with a non-zero status, 'git push' will abort without
>  pushing anything.  Information about why the push is rejected may be sent
>  to the user by writing to standard error.
