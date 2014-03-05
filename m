From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Wed, 05 Mar 2014 09:57:10 -0800
Message-ID: <xmqqeh2gil55.fsf@gitster.dls.corp.google.com>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq8uspk72g.fsf@gitster.dls.corp.google.com>
	<531652B9.4000001@alum.mit.edu>
	<xmqqr46himd1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:57:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLG4K-0004Ai-2H
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbaCER5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:57:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbaCER5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 12:57:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FF7A6F4EF;
	Wed,  5 Mar 2014 12:57:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aPU5QpT9+7yxWOYXAaMzPcjjLIE=; b=xyj+FW
	xoocD3MNObH397OuwizgtaxW3Iw2NLuhULkX/yfLEiAN9w3n2k4L31bbzRf0S2mY
	ng4JBbJeHYNaFiPSLyxxg9Ut5KK//5cZ9oMY0WZHNonmoQWI/zWoTLD1AWIejL/H
	yYR6sjnru3Coy7EsBQp1erUNmEPv+sFNcSVhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QjtBWxuLk4TJSjEAh6fCNY9spjCFeWuU
	0zU0PMDnB1Q0a4mkr4GM7Ydxc8DRGSY/h1q135jIuhzhUbYcVM0vTxiafbbHeBCz
	JCB4nzAAfwWZmWxHB1XKRJUte/xRhzWCRCdt/5y8qxVZPzhzAeXfgGW7wJRlkTnh
	f7IKBfyJIj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6921A6F4EE;
	Wed,  5 Mar 2014 12:57:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 341046F4E4;
	Wed,  5 Mar 2014 12:57:13 -0500 (EST)
In-Reply-To: <xmqqr46himd1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Mar 2014 15:18:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 94A2E97A-A48F-11E3-9A4E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243453>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I really wish we could mix declarations with statements because I think
>> it is a big help to readability.
> ...
> Unfortunately, I think we are in violent disagreement.

After re-reading the above, I realize that my statement may have
sounded a lot stronger than I intended it to.  If our codebase
allowed decl-after-stmt, that would change the equation and a
different style might help readability somewhat.

If decl-after-stmt were allowed, the group of lines that declare
variables at the beginning before the real logic begins do not even
have to be there, and "if some variables have initialization that
involve program logic that need to be read carefully, the
declaration at the beginning no longer can be coasted over as
boilerplate" complaint disappears.  The entire block can become the
logic, declaring variables as necessary at the point they are
required, without having to have a separate decl at the beginning.

Note that I am not advocating to allow decl-after-stmt; I do not
think the imagined readability benefit is worth it.
