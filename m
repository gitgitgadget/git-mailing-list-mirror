From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Sun, 16 Sep 2012 22:24:04 -0700
Message-ID: <7vtxuxw7bf.fsf@alter.siamese.dyndns.org>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Mischa POSLAWSKY <git@shiar.nl>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:24:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTof-0002ZY-7L
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab2IQFYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:24:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab2IQFYH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:24:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5FCF9F47;
	Mon, 17 Sep 2012 01:24:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5uxbZY/5budR53sDRVKDt5HtFLY=; b=Ivtc+N
	zYR/gvtYs3rGo0TXC232tOVW9b/K4OcEoXH9LHOewFAH1xBEvoh9PpegwTqb8hH1
	dRABr7J4TjPvKf1xw8sLPc9r7/ib3FZYiLaJhghp5KRbjyVUPt/2FCdLZF5wkfaR
	7ODhx+QJZtzZCQkidTk1VRo7ynY/pusUCHV+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cyr4ryyXImNW1Ag1EdIQnkDrXA/np/Ob
	Gox2yycK2aGYZXvpKhc+qHF4EVYcus80DHa7O4uKf3j21ZtLCTE5yhf/zUmi/274
	C/wzbNPVdFdDIhvcbGTUjNpliU6t4/BuqRxPcWzrskVb4GdmGGQbLb/ORYOECqqt
	Jfbcsnkm+5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C49849F46;
	Mon, 17 Sep 2012 01:24:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B8A29F45; Mon, 17 Sep 2012
 01:24:06 -0400 (EDT)
In-Reply-To: <1347844915-4130-1-git-send-email-git@shiar.nl> (Mischa
 POSLAWSKY's message of "Mon, 17 Sep 2012 03:21:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E679A390-0087-11E2-9B32-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205647>

Mischa POSLAWSKY <git@shiar.nl> writes:

> Matching the default file prefix b/ does not yield any results if config
> option diff.noprefix or diff.mnemonicprefix is enabled.
>
> Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
> ---
> Very useful script otherwise; thanks.
>
>  contrib/git-jump/git-jump | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git contrib/git-jump/git-jump contrib/git-jump/git-jump
> index a33674e..dc90cd6 100755
> --- contrib/git-jump/git-jump
> +++ contrib/git-jump/git-jump
> @@ -21,9 +21,9 @@ open_editor() {
>  }
>  
>  mode_diff() {
> -	git diff --relative "$@" |
> +	git diff --no-prefix --relative "$@" |
>  	perl -ne '
> -	if (m{^\+\+\+ b/(.*)}) { $file = $1; next }
> +	if (m{^\+\+\+ (.*)}) { $file = $1; next }
>  	defined($file) or next;
>  	if (m/^@@ .*\+(\d+)/) { $line = $1; next }
>  	defined($line) or next;

Makes sense to me.  Peff?
