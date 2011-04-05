From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 05 Apr 2011 13:56:02 -0700
Message-ID: <7vfwpwmn8d.fsf@alter.siamese.dyndns.org>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 22:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7DIS-0001iQ-7h
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 22:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1DEU4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 16:56:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab1DEU4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 16:56:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 129784637;
	Tue,  5 Apr 2011 16:58:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hs6Rbj4830J1JlWFb4WmPUm9g8k=; b=Y+WM/P
	fTPd69OY89nsuf4e//2LdDG7IGTUazQKqfsQ0WPma5fmlvcfgk2hsR+kQFtHmXy9
	iW0yeP3qKABISy5SockjINWedFrBXGt0grFrfE5bV8DnXGd6cODe/6LtFuNXO9a5
	+4vzmvGLXiMe8yASZrib3sTy/behV/VhE9ewA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pkXXZ3V2NfolxAPfVXprKIB1bInuUTtH
	ZGTON+dN0eZo2WG1bY82xOJ9eKcpo69YKSYKS6YzgedMo6cKFdTcZeQxnrlhIPSM
	h7l0CPo61KeuROz+Ls73L0tdZ3cN4v/nlSYfDrZom8jcUuR9+GYQHex1t8/NVc9T
	7mP6ZA8wed8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CFDB44636;
	Tue,  5 Apr 2011 16:58:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 938BD4634; Tue,  5 Apr 2011
 16:57:56 -0400 (EDT)
In-Reply-To: <1302032214-11438-1-git-send-email-eblake@redhat.com> (Eric
 Blake's message of "Tue, 5 Apr 2011 13:36:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6454A3F4-5FC7-11E0-A85C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170911>

Eric Blake <eblake@redhat.com> writes:

> I was trying to whitelist a single file pattern in a directory
> that I was otherwise content to ignore, but when I tried:
>
> /m4/
> !/m4/virt-*.m4

Please always indent displayed examples in commit log messages for
readability.

> then 'git add' kept warning me that I had to use -f.  I finally
> figured out that ignoring a directory is much different than ignoring
> all files in a directory, when it comes to later negation patterns:
>
> /m4/*
> !/m4/virt-*.m4
>
> Improving the documentation will help others learn from my mistake.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  Documentation/gitignore.txt |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 2e7328b..2f49989 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -70,7 +70,9 @@ PATTERN FORMAT
>   - An optional prefix '!' which negates the pattern; any
>     matching file excluded by a previous pattern will become
>     included again.  If a negated pattern matches, this will
> -   override lower precedence patterns sources.
> +   override lower precedence patterns sources.  However, a
> +   file negation does not override a path that has already
> +   been excluded by a directory match.

It may be better to say "However X doesn't do Y" than not saying anything,
but can't we phrase this more like "If you want to do Y, you need to do Z
also/instead"?  It would be much more useful for people who are looking
for a way to do Y if you didn't stop at saying "X is not the way to do
it", and said "Do X and Z if you want to achieve Y", no?

On the other hand, if you are trying to explain why X doesn't do Y, the
above would need a bit more explanation (e.g. "when a directory matches an
ignore pattern, it tells git not to descend into the directory to find
ignored or unignored paths in it" or something like that).

> @@ -125,6 +131,10 @@ EXAMPLES
>      $ cat .git/info/exclude
>      # ignore objects and archives, anywhere in the tree.
>      *.[oa]
> +    # ignore files in the immediate child directory build,
> +    /build/*
> +    # except for the log.
> +    !/build/log

In the patch form it is clear these two lines go together, but the
correspondence does not stand out in the text after the patch is applied.

Perhaps doing it like this would make it clearer?

> +    # ignore files in the immediate child directory build, ...
> +    /build/*
> +    # ... except for the log.
> +    !/build/log
