From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: Clarify documentation of -A and -u
Date: Wed, 06 Mar 2013 09:10:57 -0800
Message-ID: <7vhakoqwri.fsf@alter.siamese.dyndns.org>
References: <20130306072610.GB15534@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Mar 06 18:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDHsI-0007oQ-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 18:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab3CFRLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 12:11:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3CFRLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 12:11:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61232AF05;
	Wed,  6 Mar 2013 12:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EwvK1PXbN1+b0NSMTglvhxdbWds=; b=xchp40
	hZyaHo7F9ai8IkBcWbs2OhXIsEcypQ8O3rv3TTVVxiyVaL/hxGEnJmwqWzlHB8X2
	1aYamFs8J6NM4iuJSwo6RMvh2VBADTTWadP9yAPASLbHqJL3/NjaHF6vLlSazZPT
	6sPBBMmyOXiFk5fYd7HoONTNokTKyC7Sk9faI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oNZO/8SOSB4teM/1x7jC1c9rE3sfT5MQ
	URjq4hAmkRNO4IDtKM6WVWModYiTkk0uCOkn3yJtsWSXefPsrGhO3mP1DtaBVtDN
	1U80SOTLJR8FAAA2uiHQR9kB1SNYFKFMTyPpdiaLwS+ZTaDaOSiGB6eZB5DN/CDc
	Q8xF9Wjc6rQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55ACEAF04;
	Wed,  6 Mar 2013 12:11:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 646F9AF02; Wed,  6 Mar 2013
 12:10:59 -0500 (EST)
In-Reply-To: <20130306072610.GB15534@biohazard-cafe.mit.edu> (Greg Price's
 message of "Wed, 6 Mar 2013 02:26:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0F4F69E-8680-11E2-961F-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217532>

Greg Price <price@MIT.EDU> writes:

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 388a225..f89d920 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -105,7 +105,9 @@ apply to the index. See EDITING PATCHES below.
>  	will never stage new files, but that it will stage modified
>  	new contents of tracked files and that it will remove files
>  	from the index if the corresponding files in the working tree
> -	have been removed.
> +	have been removed.  By contrast `-A` will add new files as
> +	well as updating and removing existing ones, and the default
> +	behavior will add new files and will not remove existing ones.
>  +
>  If no <pathspec> is given, the current version of Git defaults to
>  "."; in other words, update all tracked files in the current directory

I do not know if mentioning what -A does in the description for -u
(and vice versa) makes it easier to understand or more confusing
(not rhetorical: I suspect some may find it easier and others not).

But "and the default behaviour will..." here _is_ confusing.  After
reading this patch three times, I still cannot tell what "default"
you are trying to describe.  Is it "-u" without arguments?  Is it
"add" without "-u" nor "-A"?  Is it something else???

Exactly the same comment applies to the other hunk.

Having said that, I agree that the current description for "-u" is
way suboptimal.  It begins like this:

    -u::
    --update::
            Only match <pathspec> against already tracked files in
            the index rather than the working tree. That means that it
            will ...

Whenever you see an incomprehensible technobabble followed by "That
means", "In other words", etc., you (not limited to Greg-you but
figuratively "everybody") should see if it makes it easier to read
to remove everything up to that "That means" and adding a bit more
to the remainder.  In this particular case, the technobabble is not
even correct---"match"ing is only a small part of what "add -u" does
to find what to "add".

I would suggest rewriting the first part of "-u" perhaps like this:

	-u::
        --update::
		Update modified and/or removed paths in the index
		that match <pathspec> with the current state of the
		working tree files.  No new path is added because
		this considers only the paths that are already in
		the index.


The text for "-A" may look like this:

	-A::
        --all::
		Update the index to record the current state of the
		working tree files that match <pathspec>.  Note that
		new paths will be added to the index, in addition to
		modified and/or removed paths.

I agree with your patch that "If no <pathspec> is given" should be
repeated for both "-u" and "-A".

> @@ -114,10 +116,17 @@ of Git, hence the form without <pathspec> should not be used.
>  
>  -A::
>  --all::
> -	Like `-u`, but match <pathspec> against files in the
> -	working tree in addition to the index. That means that it
> -	will find new files as well as staging modified content and
> -	removing files that are no longer in the working tree.
> +	Update the index regarding all files that match <pathspec>,
> +	either in the index or the working tree.  That is, remove
> +	files that are only in the index, add files that are only in
> +	the working tree, and update files that differ between the
> +	two.  By contrast `-u` only removes and updates, and the
> +	default behavior only adds and updates.
> ++
> +If no <pathspec> is given, the current version of Git defaults to
> +"."; in other words, update all tracked files in the current directory
> +and its subdirectories. This default will change in a future version
> +of Git, hence the form without <pathspec> should not be used.
>  
>  -N::
>  --intent-to-add::
