From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/H] "git diff --submodule" showing submodule work tree dirtiness
Date: Mon, 25 Jan 2010 10:05:23 -0800
Message-ID: <7vwrz62h7g.fsf_-_@alter.siamese.dyndns.org>
References: <7vtyudfqju.fsf@alter.siamese.dyndns.org> <4B5B25C6.70604@web.de>
 <7v7hr8d1xg.fsf@alter.siamese.dyndns.org> <4B5C547C.7000604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZTJf-0004cu-Si
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 19:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab0AYSFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002Ab0AYSFb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 13:05:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0AYSFa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 13:05:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A581894E3C;
	Mon, 25 Jan 2010 13:05:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kSXwAfyDbfsUHac8voO0N8+4UKE=; b=ucwBQZ
	knvT+jYVELenmxIDrQTE5sPJj0rGQ4vFoggB90laONCjW7MLfYLQUKP8PfF7vbP4
	J3zBFZpv3/M7J+pXV/i+CpwkxJKf5ScusaGf0T7k4Cqdr0hwDISSJfUqS3tCxjVQ
	N8wji5GGJZQ3HwhS2HZRdo5wM/vNBCWSLXeSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzP+VxxpC9zgAdcv5JuDNXkZA0tL1o2O
	Js5ybiG/xgwxpP30vyfiz0DigfzMdvSLIiORVcFXTuxlRMXv5J4kNCj/kowELMSg
	LFWfqeG1ZRl2JGo5Se/fwCEfk2OCwPxmks60fZTcsajQnTmjz7hA0nbhuDLud6Vq
	ieZeAjlMnKs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83C5294E3B;
	Mon, 25 Jan 2010 13:05:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E911A94E39; Mon, 25 Jan
 2010 13:05:24 -0500 (EST)
In-Reply-To: <4B5C547C.7000604@web.de> (Jens Lehmann's message of "Sun\, 24
 Jan 2010 15\:09\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37A06830-09DC-11DF-8E85-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137974>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Right now "git diff --submodule" doesn't show the dirty status of a
> submodule at all (like it does when using it without that option and
> having paid the cost to get the necessary information). So IMHO something
> like the patch below should go into 1.7.0 to fix that. When applied the
> output looks like this:
>
> Submodule sub 3f35670..3f35670-dirty:
>
> which is now consistent with the output of "git diff" without that option:
>
> diff --git a/sub b/sub
> --- a/sub
> +++ b/sub
> @@ -1 +1 @@
> -Subproject commit 3f356705649b5d566d97ff843cf193359229a453
> +Subproject commit 3f356705649b5d566d97ff843cf193359229a453-dirty

I think this is sensible; I queued it to 'pu' to give chance to submodule
users comment on it, but I am inclined to say it should be part of 1.7.0
for consistency.
