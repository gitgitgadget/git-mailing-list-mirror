From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch --all --depth
Date: Thu, 21 Jul 2011 09:36:55 -0700
Message-ID: <7v1uxj4ml4.fsf@alter.siamese.dyndns.org>
References: <20110720223902.GA6675@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Neronskiy <zakmagnus@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Thu Jul 21 18:37:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjwFN-000502-BC
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 18:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab1GUQhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 12:37:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab1GUQg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 12:36:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980E23703;
	Thu, 21 Jul 2011 12:36:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/EOE3s7pHFEc9B5GxDirK9/BiyY=; b=o8+Ps9
	gmTU/q9mUeu2mU7lyNhkCmynXsBxXDNSLUdf9/euaQribFamVy+zoyMpwVnY8wWG
	8icLIZ/Bfvyg46wB7SP24WkmvT9ywoDp6xL+GZJlztNoUa9AFyaquK5X8t2dsHQh
	9wh+t4UZSNEFXBeA9ARzjOHU6p1OiurZzMYEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lM9qXHBEecfrJ4003pQSqh1Edf+bCADR
	cHuh+8WipE4tC+9o3CDnot4pii25r6cqjrDkxCBqSZnGjwtEM0y8cbEBVdnrfd8U
	8udKQ5F2M4RsUreZmf/cgIJyuaM2ZC/Itdqdm2bw9BeOaIMfQOGEYvDfgN9zTlC4
	MxP0mbGoJb0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F8303702;
	Thu, 21 Jul 2011 12:36:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 008973701; Thu, 21 Jul 2011
 12:36:56 -0400 (EDT)
In-Reply-To: <20110720223902.GA6675@camk.edu.pl> (Kacper Kornet's message of
 "Thu, 21 Jul 2011 00:39:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6371790-B3B7-11E0-B0C0-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177576>

Kacper Kornet <kornet@camk.edu.pl> writes:

> I have just discovered that when I use:
>
> git fetch --all --depth=<n> 
>
> the history is not deepened. Is the any specific reason for it or is it
> a bug?

The above is not specific enough to judge if you found a bug or if it is a
user error.

IIRC, --depth=<n> is not "deepen by <n>", but "make sure I have at least
<n> from the updated tip(s)".  The shallow-clone hack gives you quite
useless (even though it may be internally consistent) semantics if you
shallow-cloned way in the past and fetched with --depth after the other
side added many more commits than <n>, as you cannot guess what the right
value of <n> should be without actually fetching without --depth.
