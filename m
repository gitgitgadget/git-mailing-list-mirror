From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/githooks: Explain pre-rebase parameters
Date: Wed, 20 Feb 2013 09:23:57 -0800
Message-ID: <7vwqu2yk42.fsf@alter.siamese.dyndns.org>
References: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
 <7vk3q45dg2.fsf@alter.siamese.dyndns.org>
 <20130220163621.GI14102@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Feb 20 18:24:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8DP9-0000Ro-4j
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 18:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab3BTRYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 12:24:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756474Ab3BTRYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 12:24:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8435A1E3;
	Wed, 20 Feb 2013 12:23:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FcG1NMGoSUvgWiBgr9z55ysBWAM=; b=Qzpaog
	zxG2OBH9KifP7fVCizcc60FNGGgFQHeYf77WRmTN9Z5Y0J35mmFi7iYj97bV2ZAk
	q/0zKzaWI+QTxLlaxAVyy/qvkPhfEDi6zmReOHQXNCmXHs6c2zEpblOdKSDi98ks
	VUdb2PBwpRb+yd0/279JpnvxfCRnSTSe4VP0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xTqjLMzbBi+s36UyPikhMdqrUF/3w53T
	sZb+bLhSW6dSA+QP3w47bNDFj7B1XMD/4flxDU1DQQlvTnxiEaQa9+gh+Cnviclb
	4nzOtYD31eeM9o5SIykO9kChCn7AiC+Cfy5uPJIQOZ8EhWdTx0vYLAfUcijfoYMn
	92KEXCNqAQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCC70A1E2;
	Wed, 20 Feb 2013 12:23:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F188A1E0; Wed, 20 Feb 2013
 12:23:59 -0500 (EST)
In-Reply-To: <20130220163621.GI14102@odin.tremily.us> (W. Trevor King's
 message of "Wed, 20 Feb 2013 11:36:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FFFBE7E-7B82-11E2-847B-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216710>

"W. Trevor King" <wking@tremily.us> writes:

> Since $upstream_arg will always be set, would it make sense to change
> the `${1+"$@"}` syntax in run_pre_rebase_hook() to a plain "$@"?

I suspect that there no longer is a need for ${1+"$@"} in today's
world even when you do not have arguments, and it certainly is fine
if you want to update that particular instance in the function with
a single caller that calls it with 1 or 2 arguments, especially if
you are updating the code in the vicinity.

I however do not think it is worth blindly replacing them tree-wide
just for the sake of changing them.  The upside of helping beginning
shell programers by possibly better readability does not look great,
compared to the downside of possibly breaking somebody who is still
on a broken shell that the old idiom is still helping.
