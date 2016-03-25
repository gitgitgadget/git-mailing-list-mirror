From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Fri, 25 Mar 2016 09:41:36 -0700
Message-ID: <xmqq37re5x33.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
	<1458775426-2215-1-git-send-email-gitster@pobox.com>
	<56F391A4.6090603@web.de>
	<xmqqmvpn91o2.fsf@gitster.mtv.corp.google.com> <56F50608.10606@web.de>
	<56F5477F.6090600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:41:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajUnw-0001UQ-0E
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbcCYQlk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 12:41:40 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753872AbcCYQlj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 12:41:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A88A4D922;
	Fri, 25 Mar 2016 12:41:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/o3tRfnOcHUE
	dl36mrkTNpBpOIs=; b=Aw0iltPrBP21Ks0pxmBb8zrEeMmmmxLXOmsjdwAWSr8G
	4CBjtR+GjMp5ctfLox+/nc7wW9Mk3kpQNP1xg8JnKA0rOwi1ak3c24qLgPjwzP5e
	uH6OsTihfc44fHyEVPf5s7yf6nucMD+bOInDfepdO71NJxS+9eAHzYNMSeUdMoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CcKzGV
	E2LVx8Kppe9wKhD9tcSHMxA2wUgr6ko+pjE7iIsIKdQjtmnSjNZqQYN+YdEZVtK1
	+UiSg0WT7FoZ2dv642zYvLMoYvpxQ+woKz18RrtSmM+xdz2ybMQctci6zr0YNP9i
	qjSfYNI/L4Ju2uMPkfDWoJNSj0NjXC5LEpseg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91EC34D920;
	Fri, 25 Mar 2016 12:41:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 101C54D91D;
	Fri, 25 Mar 2016 12:41:37 -0400 (EDT)
In-Reply-To: <56F5477F.6090600@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 25 Mar 2016 15:13:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71B557A4-F2A8-11E5-BE95-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289900>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> This is copy-paste replacement for the last commit.
> (Most probably it is white space damaged)
> I'm not sure, is it's worth it ?

Not if you are keeping "expand_tabs_in_log" boolean field.

I was expecting that the new "log-tab-width" thing extends the
expand_tabs_in_log as the concept--it used to be a boolean "do we or
do we not expand?" to "set it to 0 if we do not want to expand, set
it to N if we do want to expand to every N display spaces".  In
other words, if you introduce this new thing, the boolean should not
e necessary and it should go.  Did I misread your earlier message
that described your idea?

> +log.tabWidth::
> +	Sets the width of a TAB.  If 0, no TAB expansion is done.
> +	8 by default.

You need to make it clear where tabs are expanded.  The readers
would wonder if it expands tabs in "log -p" patch output, etc.


A related tangent. I suspect

	git format-patch --expand-tabs-in-log-message=3D4

might be a good feature to help people whose editors are configured
to move to next-multiple-of-4 column with a tab, and applying their
patch would show unaligned lines in "git log" output for others, by
expanding their tabs when sending the patch out.  We might even want
to add a related option

	git am --unexpand-tabs

that collapses a run of SP that fills to next-multiple-of-8 into a
tab on the receiving end.
