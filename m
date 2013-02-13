From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] shell prompt: add bash.showUntrackedFiles option
Date: Wed, 13 Feb 2013 08:12:18 -0800
Message-ID: <7va9r8b3bx.fsf@alter.siamese.dyndns.org>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ewv-0001T2-Qz
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 17:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934194Ab3BMQMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 11:12:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab3BMQMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 11:12:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF2A5C009;
	Wed, 13 Feb 2013 11:12:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NSWEgX+5RQBDyqp54X0KSE6/bsc=; b=f5HDXE
	OtUfaRR3m9YH2M8+vH9YI8W/dA3sGTMnTDzbBkiDnzeNnuw5bwG6gU0bfI0dnnWp
	Jw3YNa8d4Bbs/Q0+YmyUpv3sFep+G+VyR4vE/3PA9aQf3lPryy6mTZ8Yf8DhSb/l
	skD8Rh/y0EF9jlEm9l3mTuDV3UzU1ieW059KI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IMCHIb+i+P0Y5KKh4gcsh8pJAR+D8u77
	qbmopD7CpH5NQ9KXfOu61gMcr4F5iwl4CeXxCq+K86I00MgYJKFXTLHo1sl8oS/4
	muBuABfhkpQG0xWUPs7HxRY2d3w23k11h0It8XQdL73/Z1XbGK52cv9URp5QIZpJ
	78xQNVvqq14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D300AC008;
	Wed, 13 Feb 2013 11:12:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4185AC007; Wed, 13 Feb 2013
 11:12:20 -0500 (EST)
In-Reply-To: <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
 (Martin Erik Werner's message of "Wed, 13 Feb 2013 12:01:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24B5A470-75F8-11E2-B0E2-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216265>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> Add a config option 'bash.showUntrackedFiles' which allows enabling
> the prompt showing untracked files on a per-repository basis. This is
> useful for some repositories where the 'git ls-files ...' command may
> take a long time.
>
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---
>  contrib/completion/git-prompt.sh |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 9bef053..9b2eec2 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -43,7 +43,10 @@
>  #
>  # If you would like to see if there're untracked files, then you can set
>  # GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
> -# files, then a '%' will be shown next to the branch name.
> +# files, then a '%' will be shown next to the branch name.  You can
> +# configure this per-repository with the bash.showUntrackedFiles
> +# variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
> +# enabled.
>  #
>  # If you would like to see the difference between HEAD and its upstream,
>  # set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
> @@ -332,8 +335,10 @@ __git_ps1 ()
>  			fi
>  
>  			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
> -				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
> -					u="%"
> +				if [ "$(git config --bool bash.showUntrackedFiles)" != "false" ]; then
> +					if [ -n "$(git ls-files --others --exclude-standard)" ]; then
> +						u="%"
> +					fi
>  				fi
>  			fi

Somebody should simplify this deeply nested "if/then/if/then/fi/fi"
sequence to a single if/then/fi statement, i.e. something like:

	if test -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" &&
           test "$(git config --bool bash.showUntrackedFiles)" != false
        then
		u='%'
	fi

And do the same for the other one this patch copies the above from.

No need to re-roll this patch, though.  It is a separate clean-up to
be done on top, once this series is settles.

Thanks.
