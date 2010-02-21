From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 06/12] notes: implement 'git notes copy --stdin'
Date: Sat, 20 Feb 2010 19:31:15 -0800
Message-ID: <7v8wan464c.fsf@alter.siamese.dyndns.org>
References: <cover.1266703765.git.trast@student.ethz.ch>
 <3559e59dd81bd3fb94196c399e1640681a323147.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:40:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2Xn-0005r5-UA
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab0BUDbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:31:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181Ab0BUDba (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:31:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 634A19BD96;
	Sat, 20 Feb 2010 22:31:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rhSdeUqtJkCfvSRJ5MBSMbFsx+o=; b=qn3XZ/
	Mkps6uhHiu8QfV8euzqI82GeK+GvPOkIfo1zy8B8z5f8CNN4Kkl04MxvdtcCYDTi
	StrbHhVqcI+7Du7F42g3UbCgm0qCt1k9BQmmQo2W8pBbea+tvkYcO0MlQBxq9AqQ
	R37QFeyPs3tjXW8fZcXMOA8rPbJlsuqDZyVU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jKbmZO6u4cazdA69F2O05WxHwZse8qRE
	IQnd0iEnVwqRNGVXBlGdTECf9haficjBlCFMhY0P3xK4FwnzAuBeYx1Syv9sYHmg
	I9urPFdpzO17RL0THbGMv7ZqDrN5UGl6w8CG+OrwEFw+hDjNeHhEOP4CDyNU01cW
	nJwBfZT4yOM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13B219BD95;
	Sat, 20 Feb 2010 22:31:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F0D39BD94; Sat, 20 Feb
 2010 22:31:18 -0500 (EST)
In-Reply-To: <3559e59dd81bd3fb94196c399e1640681a323147.1266703765.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 20 Feb 2010 23\:16\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9694028A-1E99-11DF-BF00-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140586>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 0dfff82..634d213 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -683,4 +683,36 @@ test_expect_success 'cannot copy note from object without notes' '
> ...
> +test_expect_success 'git notes copy --stdin' '
> +	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
> +	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
> +	git notes copy --stdin &&
> +	git log -2 > output &&
> +	strip_then_cmp expect output &&

Huh?
