From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] doc: Generate a list of valid merge tools
Date: Sun, 27 Jan 2013 14:36:56 -0800
Message-ID: <7vmwvutfqv.fsf@alter.siamese.dyndns.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-5-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzaqn-0003zi-Hp
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab3A0Wg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:36:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab3A0Wg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:36:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 279A5CB4E;
	Sun, 27 Jan 2013 17:36:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=36CUAYH4I/gxsDhqQJbdEw2k5AE=; b=ofDBho
	zc5TEC/rz9NalhUP1y/5GpxMPBGe3Vc6sO+jU/0JuQvWh9Hrosxtf8mhZH5EqkBG
	8wyo7o/KmVEWq6ECEYKsuMYR8RFefqS/IunZtT3AIFuWffgQTKx4OHfGl3ec8L7a
	5OqWoWboKFhKgm2KqwcR72s2g8fqx2Eszpr7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nVf33orTi3+yLGPGiZi/Pfctni7hnSra
	/ShH2AAG9wAgcApDn0Ux2cEclol53R3Uc4Bgd7GNUVP9CYdgWr+RbJQsmgwz8yqO
	ZhNuqmF6w9zT7dyEkQq2dyc6zG+me4yJGE5BU2L80qSIZNujlC9kCZH4nb7PCkaz
	ghj19wRO3d8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D558CB4D;
	Sun, 27 Jan 2013 17:36:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96722CB4C; Sun, 27 Jan 2013
 17:36:57 -0500 (EST)
In-Reply-To: <1359321886-80523-5-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 13:24:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EDBDA26-68D2-11E2-988B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214744>

David Aguilar <davvid@gmail.com> writes:

> +mergetools_txt = mergetools-diff.txt mergetools-merge.txt
> +
> +$(mergetools_txt): mergetools-list.made
> +
> +mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
> +	$(QUIET_GEN)$(RM) $@ && \
> +	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
> +		. ../git-mergetool--lib.sh && \
> +		filter_tools can_diff "* "' > mergetools-diff.txt && \
> +	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
> +		. ../git-mergetool--lib.sh && \
> +		filter_tools can_merge "* "' > mergetools-merge.txt && \
> +	date > $@

Nicely done.

By omitting is_available check and only checking can_*, we would get
the same result on all platforms and I'd see tortoise appear in the
output even I do not do Windows.

Thanks.
