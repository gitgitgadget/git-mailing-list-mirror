From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: escape '~' in git revert
Date: Thu, 02 Dec 2010 10:05:44 -0800
Message-ID: <7v8w08rqx3.fsf@alter.siamese.dyndns.org>
References: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain.rabot@f-secure.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:06:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODXc-0006MW-Ir
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757161Ab0LBSFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 13:05:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab0LBSFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 13:05:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A6D523D7C;
	Thu,  2 Dec 2010 13:06:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dBlS1OoHk50puJdbkNOV2AMKVDY=; b=GXfbOz
	6ZjGaqx4iwJWM2OWNSdwzAXzSnkYAH+rGzie/zDMDbd4F4ARYi0O6i4JKW95RBFp
	gLWvBjEXGA6K6gGvu6NUwEi9FJSsPtopsDBdudqw9j/8YCju5cPIm60PbhcQ2dUC
	fhS+tqyNFg+hvY4BKr1jjn5jq7pZHkpMNM1F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FUjvXqh33iNzRK2R1nSccfnoaIqlF5rj
	NxCMR0yMSmS4V9DxJME9GOV+rSA+LSWuKnKkf4eQ4vsIrGyoSWJpHgkrK3HF3I5t
	Egn+3LpgHNTadQdyoTnVQDMecNkSVnGujk/oelzePrjms+YjdBClU0jb9Mr6Vli6
	RhduxUlYfBY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 852723D7B;
	Thu,  2 Dec 2010 13:06:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6EC993D79; Thu,  2 Dec 2010
 13:06:07 -0500 (EST)
In-Reply-To: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
 (Sylvain Rabot's message of "Thu\,  2 Dec 2010 18\:36\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7B89D0E-FE3E-11DF-9182-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162722>

Sylvain Rabot <sylvain.rabot@f-secure.com> writes:

> backslashing '~' characters do not have any effect, quoting with +++ has.

I vaguely recall that we tried to avoid using '+++' because versions of
AsciiDoc that were widely used back when the bulk of documentation was
written either did not handle the construct correctly, or did not know
about it at all.  So I would be very hesitant to take this patch as-is.

Giving a cursory look at:

    http://www.kernel.org/pub/software/scm/git/docs/git-revert.html

the first instance (HEAD~3) seems to be formatted Ok there (they run
AsciiDoc 8.4.5 with xmlto 0.0.23 on F13), but it seems that we do need to
do something with the second one (~5..master~2).

I think the problem is that AsciiDoc takes ~something~ as a mark-up for
something.  Does it work to drop the backslash before ~5 and replace ~
with {tilde}, which was invented to deal with problems like this?

> Signed-off-by: Sylvain Rabot <sylvain.rabot@f-secure.com>
> ---
>  Documentation/git-revert.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index f40984d..9368892 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -82,12 +82,12 @@ effect to your index in a row.
>  
>  EXAMPLES
>  --------
> -git revert HEAD~3::
> +git revert HEAD+++~+++3::
>  
>  	Revert the changes specified by the fourth last commit in HEAD
>  	and create a new commit with the reverted changes.
>  
> -git revert -n master\~5..master~2::
> +git revert -n master+++~+++5..master+++~+++2::
>  
>  	Revert the changes done by commits from the fifth last commit
>  	in master (included) to the third last commit in master
> -- 
> 1.7.3.2
