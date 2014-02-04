From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Mon, 03 Feb 2014 16:00:09 -0800
Message-ID: <xmqq61ovbvcm.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 04 01:00:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WATRA-0001VJ-1u
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 01:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbaBDAAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 19:00:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535AbaBDAAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 19:00:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB3286989A;
	Mon,  3 Feb 2014 19:00:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EV4/fJ2+vbvzXMmsXksfnhIyNfo=; b=ygwe6/
	eeETDM818oz5MXBKXDzFyj4cuiX+foyQUoAZVDgIk1DwgCgKY0BbyW3innHsFJ+c
	DrfgfbBPl5HU8/uWp7mTErgc+i0XiV28gCIIrH/KbA9UWp7k6VU1vvIl3Twkwx6G
	04WP2X8My0xoWNFQXsn6Dm+QyQU714MLKA5UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nx6C0AnpsBgG1x+nSChC5UCcLnChptfs
	lDRVNbfyfJQgZJHAJT1+ZB2Z+02Gkf3DDqhzuXj1JK3sp+0woe6EjmZl/+Oymx8m
	djJxPRivK6vhUqypJxBjCJdfcyBUV4Z7VaGqM+st7bVCXVLX2L7qcy+8oTPQU/aN
	waP7LYMAeSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BEF069892;
	Mon,  3 Feb 2014 19:00:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BF676988C;
	Mon,  3 Feb 2014 19:00:12 -0500 (EST)
In-Reply-To: <c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 3 Feb 2014 16:47:21 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 51B70046-8D2F-11E3-A3CF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241499>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> +	parents_sha1 = xmalloc(nparent * sizeof(parents_sha1[0]));
> +	for (i = 0; i < nparent; i++)
> +		parents_sha1[i] = parents->sha1[i];
> +
> +	/* fake list head, so worker can assume it is non-NULL */
> +	struct combine_diff_path paths_head;

decl-after-statement; please fix.

> +	paths_head.next = NULL;
> +
> +	struct strbuf base;

likewise.
