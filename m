From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: add space between branch name and
 status flags
Date: Fri, 20 Nov 2009 09:53:28 -0800
Message-ID: <7v4oopxeuf.fsf@alter.siamese.dyndns.org>
References: <200911201309.16193.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Roman Fietze <roman.fietze@telemotive.de>
X-From: git-owner@vger.kernel.org Fri Nov 20 18:53:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBXg0-0005Pi-S3
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 18:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbZKTRxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 12:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbZKTRxd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 12:53:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbZKTRxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 12:53:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29D3DA00AF;
	Fri, 20 Nov 2009 12:53:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2PejqMki+NVoDwVcezYEfVyRzaI=; b=M8M/Nt
	wUlHbwWJ4v+7BptPVPKJxEO8UJHJKloA9Nb0PHz1ivKKI1cgt4xd0y6GW/BaSxYM
	9sc8hYwRuXiGSr5jSLMKLCge0kqNonPaa6U+tFgy0EysBvNKDyefcdY+eWhH5QV9
	/5R7YbuzwdzBaPj6Q3pXLMpKxiQGT6AnYtWTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EQ/a2D0uWn1GbkS+aNVl5RCorH/n01Ly
	YtJSaPpNiwXIUYGu/bov3B0+hSMupCQw5GG4azRPTAMKT0uRe7AXvVRCjFMk0uu+
	7A1Jvjym6qWxnEXX4hYZlcb3A54EzDkY8R+JJIJdqxrXUv5+z5L+jRLqhEciE4ry
	/9OE/rVFocA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE88CA00AE;
	Fri, 20 Nov 2009 12:53:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8BB54A00AD; Fri, 20 Nov 2009
 12:53:30 -0500 (EST)
In-Reply-To: <200911201309.16193.roman.fietze@telemotive.de> (Roman Fietze's
 message of "Fri\, 20 Nov 2009 13\:09\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9FA21004-D5FD-11DE-A784-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133360>

Roman Fietze <roman.fietze@telemotive.de> writes:

> Hello Shawn, hello git list members,
>
> Wouldn't it improve the readability of the bash prompt, if there would
> be a space between the branch name and the status flags (dirty, stash,
> untracked)?

Perhaps.

> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
>  contrib/completion/git-completion.bash |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-
> completion.bash
> index bd66639..407176b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -169,10 +169,12 @@ __git_ps1 ()
>  			fi
>  		fi
>  
> +		local f="$w$i$s$u$r"

I think this line and the two changes to printf below is a big improvement
(unless we are using f for something else---I didn't look).  But I think
the next line is wrong.

> +		f=${f:+ $f}

The $r string is designed to be used as suffix from the beginning and
always has "|" in front of it as a delimiter, so if there is no w/i/s/u
(and I suspect many people do not use GIT_PS1_SHOWDIRTYSTATE and friends,
and these are _always_ empty for them) the above will begin with "|".
There is no need to steal one column from a typeable width from the
command line in such a case.

>  		if [ -n "${1-}" ]; then
> -			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
> +			printf "$1" "$c${b##refs/heads/}$f"
>  		else
> -			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
> +			printf " (%s)" "$c${b##refs/heads/}$f"
>  		fi
>  	fi
>  }

To implement your stated goal (dirty/stash/untracked), you probably want
to do this instead...

	local f="$w$i$s$u"
        f="${f:+ $f}$r"
