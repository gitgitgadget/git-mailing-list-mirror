From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase -i: fix core.commentchar regression
Date: Sun, 18 Aug 2013 14:14:47 -0700
Message-ID: <7vr4dqn1ko.fsf@alter.siamese.dyndns.org>
References: <1376845970-31204-1-git-send-email-sunshine@sunshineco.com>
	<1376845970-31204-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 23:15:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBAJL-00075P-5z
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 23:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab3HRVOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 17:14:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754777Ab3HRVOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 17:14:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 519243A47E;
	Sun, 18 Aug 2013 21:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3tDdbmniFRF4RByoI06RI6t1LSc=; b=SjiEX1
	qdmFC+9HiYpZFeOtyAH5Ffh5WRUD+1BvY+w4hqwwI9Rfdhb5gcd/WXnpybQp2x2J
	+HJ5iqURsqWBCC0IvtmWmTZvnuk4frFo0SRTYudIRX9tQoXQp4M+p2tg4utk+euK
	9MItRuPvsnYreMIGYb+lT86SqLwvFvK6y9F8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WnIK6jH4qWpsr5sTRPgrnaeJ8lE1zqLn
	/Dk5wOCNT0rEVo1czX60u/Fr4I01S3TtcWvjygWFFkJSadmF5d2p/QZpcBysdl1q
	0MyLVAFU4oq2pK8l3MWLIZkwgf+aeSVZ1GSpVEm+n/TXJG39lIelFrTa/UDehmbJ
	r1QtCJutj2w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451E63A47D;
	Sun, 18 Aug 2013 21:14:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EB813A47C;
	Sun, 18 Aug 2013 21:14:49 +0000 (UTC)
In-Reply-To: <1376845970-31204-3-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 18 Aug 2013 13:12:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37452850-084B-11E3-9268-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232520>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Intended for 'next'.

Thanks.

Will queue on top of es/rebase-i-no-abbrev, but we have a chance to
rebuild 'next' after 1.8.4 release, so we may want to squash this
into the problematic commit when it happens.


>
>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 3733312..f246810 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -693,7 +693,7 @@ transform_todo_ids () {
>  	while read -r command rest
>  	do
>  		case "$command" in
> -		'#'* | exec)
> +		"$comment_char"* | exec)
>  			# Be careful for oddball commands like 'exec'
>  			# that do not have a SHA-1 at the beginning of $rest.
>  			;;
