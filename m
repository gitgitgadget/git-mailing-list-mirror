From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t7300: workaround ancient touch by rearranging
 arguments
Date: Wed, 15 Sep 2010 15:08:13 -0700
Message-ID: <7vocby64oi.fsf@alter.siamese.dyndns.org>
References: <i6Vnwbi85zvoD6Nzpw2lc1cAb4fZRJiU13x2r3wnIFnHDZWo9gkMwp9pRXJjgiXl4Ce-ERc-tvc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 16 00:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow09X-0006WC-Dd
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 00:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab0IOWIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 18:08:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0IOWIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 18:08:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4497AD6273;
	Wed, 15 Sep 2010 18:08:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=my/KKDhUCcYntM1qImO9LgFua08=; b=v2wl8O
	7GCAHsfY3f8bYuYesXT+xyOJf5MD1iNnxWssds7TeDBi4U1OXqfbM2VrcyNf290v
	xPQliVUHK8FxGMBLUAneViKSXjcAq8YPSTlYOQESY5fZgqrPtZErmmjXR7NpeGVn
	uW8r02VRxlzpkNz4h2vvj58wDDjWO89/6fKAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NyfEFTYKRpxLuWwD2EvSVrbhbMBq4fZ4
	wvr21FMw1aCbZriacQLg31fLgM1adh9ndkGwufSvM2H2acFZrw3jFVX66obT4Zfd
	1Nadskw7DA3Ocu/kXRZSdvwfUehUzCc5oq5y19v5xJ9kyv/sg29zBA8RzknykfsW
	2dM+1wmDI2E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE3B6D6271;
	Wed, 15 Sep 2010 18:08:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 130C9D626B; Wed, 15 Sep
 2010 18:08:14 -0400 (EDT)
In-Reply-To: <i6Vnwbi85zvoD6Nzpw2lc1cAb4fZRJiU13x2r3wnIFnHDZWo9gkMwp9pRXJjgiXl4Ce-ERc-tvc@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 15 Sep 2010 15\:58\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BFB98404-C115-11DF-93EF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156261>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> The ancient touch on Solaris 7 thinks that a decimal number supplied as
> the first argument specifies a date_time to give to the files specified by
> the remaining arguments.  In this case, it fails to parse '1' as a proper
> date_time and exits with a failure status.  Workaround this flaw by
> rearranging the arguments supplied to touch so that a non-digit appears
> first and touch will not be confused.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Yuck, there were other reasons why I tend to write ">file" in our tests,
just to create a new and empty file, but I didn't remember seeing this
one.  It's been a while since I touched Solaris the last time.

Thanks for catching.

>  t/t7300-clean.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 7dbbea1..6c776e9 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -443,7 +443,7 @@ test_expect_success 'git clean -e' '
>  	(
>  		cd repo &&
>  		git init &&
> -		touch 1 2 3 known &&
> +		touch known 1 2 3 &&
>  		git add known &&
>  		git clean -f -e 1 -e 2 &&
>  		test -e 1 &&
> -- 
> 1.7.2.1
