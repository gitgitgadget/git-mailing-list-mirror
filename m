From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 08 Feb 2013 16:05:14 -0800
Message-ID: <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Haller <thom311@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:05:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3xww-0001oa-94
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947487Ab3BIAFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:05:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947483Ab3BIAFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:05:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8519DBB19;
	Fri,  8 Feb 2013 19:05:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:mime-version:content-type:subject:references:date:in-reply-to
	:message-id; s=sasl; bh=gpqrKn5HeNi5UqVxBROqc28SIS8=; b=ALNY1GnR
	UzQ0WUx3kna9yp88eLVXz45iOO4ZdYqxUyMmzFmionqEybBFuqtJCgLgNk4SBnHL
	xHgY+H/ndOsWCa8TAncc5YYoFLdBIxfSJXSTW4p9TY7AOZ+SPDeyOfPfT0txeEs4
	HBxVl0ZjG8LEAggFVabHQtbb7r7nKqOSWbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:mime-version:content-type:subject:references:date:in-reply-to
	:message-id; q=dns; s=sasl; b=vejQoyJenzpthJymWFIIWDqqB8DO7Fs5io
	O4Q6cAqs5JjHcgaTzw/x/tq2JVL3OwT9vmQFsPxRFSRu/iEsS2dBjdFas+vcVa7C
	tPQD05WP/F0t/eGwM5bfhfdcOrC+Hl+2Jt4LEBWW/wnc+rLWb06L6ARZnCxGn5Ey
	EY37dWHYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DA4BB18;
	Fri,  8 Feb 2013 19:05:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02D31BB17; Fri,  8 Feb 2013
 19:05:15 -0500 (EST)
In-Reply-To: <201302090052.22053.thom311@gmail.com> (Thomas Haller's message
 of "Sat, 9 Feb 2013 00:52:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61E7C54E-724C-11E2-B8F6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215829>

Thomas Haller <thom311@gmail.com> writes:

> it happens in file revision.c:2306 because "commit->buffer" is zero:
>
>                 retval = grep_buffer(&opt->grep_filter,
>                                      commit->buffer, strlen(commit->buffer));

I think this has been fixed at be5c9fb9049e (logmsg_reencode: lazily
load missing commit buffers, 2013-01-26); I haven't merged it to any
of the maintenance releases, but the tip of 'master' should have it
already.
