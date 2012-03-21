From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/9] difftool: do not allow mix of '--prompt' with
 '--no-prompt'
Date: Wed, 21 Mar 2012 13:14:19 -0700
Message-ID: <7vehsl1zl0.fsf@alter.siamese.dyndns.org>
References: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
 <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARvT-0003iM-EP
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759010Ab2CUUOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:14:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758439Ab2CUUOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:14:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5602A6C7D;
	Wed, 21 Mar 2012 16:14:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aYWND8WXMXnuiSBvJTUhQJoy6Kg=; b=RI2SUr
	+Yk8DAEU3mC1F+A5QunRMzSgr4K1el9wtK1N8TnPnMTXbYHd/tmrMwoMOp5b262X
	YhJwn1eirrdi0BIntQGxQoIWDL/DnSgddPTUTgEAuVaiSWBCeseXSZlD6iORotis
	l7BlIy+YIGHvvMmr9F8rmyPe5VkWAO6z1u7xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BT1ZkrY0bOsyMhRSYIvWd/Lms5S8kCpr
	7el8ihqvsAN55C2RbNJ2lrmjP4xog057B2wIe3DV6HvfYzbAJBC8P+jM5qzECkUm
	IgZBffRiOcjCEc4mNPZaRQDy3K30UAeP0W8KwpJxnCZsEO0fmd6mw0IRm37q2ecQ
	5slkf2J6opA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F19EB6C7C;
	Wed, 21 Mar 2012 16:14:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 911826C7B; Wed, 21 Mar 2012
 16:14:22 -0400 (EDT)
In-Reply-To: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Wed, 21 Mar 2012 15:35:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72C9B66A-7392-11E1-AF43-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193611>

Tim Henigan <tim.henigan@gmail.com> writes:

> When difftool was changed to use Getopt::Long, it changed the way that
> the '--prompt' and '--no-prompt' options are handled. Prior to the change,
> if both options were given, then the last option was used.  After the
> change, if both were given, then '--prompt' was always used.
>
> This commit teaches difftool to exit with an error if both options are
> given at the command line. t7800 was updated to match.

Hrm, people with "[alias] mdt = difftool --prompt" have every right to
expect their

	$ git mdt --no-prompt

to keep working, no?
