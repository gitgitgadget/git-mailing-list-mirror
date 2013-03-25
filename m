From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] contrib/subtree: stop explicitly using a bash shell
Date: Mon, 25 Mar 2013 10:57:05 -0700
Message-ID: <7vy5dbxszy.fsf@alter.siamese.dyndns.org>
References: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
 <1364153863-27437-2-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, greened@obbligato.org,
	"Avery Pennarun" <apenwarr@gmail.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 18:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBeU-0004B1-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 18:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849Ab3CYR5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 13:57:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758327Ab3CYR5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 13:57:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E266B09C;
	Mon, 25 Mar 2013 13:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GOtJCxC//Yl6/0oTYPtBc55bLn4=; b=RLtY6u
	/HuyFu02VZ8coDVZiaI8RcvT/De46ZAwjL4cveOqTXuw4c+mG0MFEC11WMNxEpnn
	llWswZfA2oaoWsErNv4ynZG7O9feFVsi42Ah6nk1G7LbrJZwekOmR/BcA7TeGfhg
	kUCKF36EW6GbKp/qAe6sNEuTv54u2fcPtPYDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K0dU9g0dYmdM8jdaKlfw2GozCgYPgzUN
	UgSadW4RqkREGm7EjEa4A9l4osQVTc4VqhGM5cfHHPK23lcURzIfzwO+dE/B/ni9
	oSov4+xC5OLyK3LlbajuIrPKee7x9O9TdhLqRJPjBPKmIlRzCrG82GtNkylnP5np
	T/yMFQro5rE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62F28B09B;
	Mon, 25 Mar 2013 13:57:07 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6D37B09A; Mon, 25 Mar 2013
 13:57:06 -0400 (EDT)
In-Reply-To: <1364153863-27437-2-git-send-email-pcampbell@kemitix.net> (Paul
 Campbell's message of "Sun, 24 Mar 2013 19:37:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 684E7670-9575-11E2-B17A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219051>

Paul Campbell <pcampbell@kemitix.net> writes:

> Don't explicitly use the Bash shell but allow the system to provide a
> hopefully POSIX compatible shell at /bin/sh.
>
> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
> ---
>
> Only the system's I was able to test this on (Debian squeeze) /bin/sh is
> the dash shell.
>
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 8a23f58..5701376 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/bin/sh
>  #
>  # git-subtree.sh: split/join git repositories in subdirectories of this one
>  #

Interesting. I'll leave the final "yeah, this is safe" declaration
to David and Avery, but I've always assumed without checking that
this script relied on bash-isms like local variable semantics,
arrays, regexp/substring variable substitutions, etc.

With a quick scan, however, I do not seem to find anythning
glaringly unportable.
