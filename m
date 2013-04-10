From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Wed, 10 Apr 2013 09:25:53 -0700
Message-ID: <7v8v4qnyi6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
 <7vmwt7si6z.fsf@alter.siamese.dyndns.org>
 <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
 <7vzjx7phti.fsf@alter.siamese.dyndns.org>
 <CALkWK0k9nLhr_JTDvJq=7YXX8DoqXy850zC__Ux1kJxkY0BJhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 18:26:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPxqg-00029V-I1
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 18:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008Ab3DJQ0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 12:26:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935053Ab3DJQ0C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 12:26:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF5451244D;
	Wed, 10 Apr 2013 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCmvrAcj36rDeaq9nvblgEXCoPs=; b=W63oxw
	zuz3rLhSDM0Z241PYFMxukSnLJzsnrt7YkPlW4yq5SqkZoVt8A4DDLa+YWbBY8m8
	vrOjYHoW/4CXmr25SYgGOWyDPII4xDkXf4FMv6441yWU8pUwFRNBH0Vhh5IvS5J6
	KrnXXJwjSqgmb9wWg9RepSu6ePQ5ExJoJog8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6R1QkbamfI1aBGuZ3IwuEN4ookWYOTo
	eZwxoE/SyEtuWIz2IjywU0k3Y4GmKXfkDLBm3S7HWgegIf38zaJYSt78CFCBRbdi
	iQwgR8WihyNI0scGLDHTaZJC1I9gFApNQiHknby6fa5FYIM/UO2MmP94eufbVAzN
	KDV13wLGr/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B61FD1244C;
	Wed, 10 Apr 2013 16:25:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E74412449; Wed, 10 Apr
 2013 16:25:55 +0000 (UTC)
In-Reply-To: <CALkWK0k9nLhr_JTDvJq=7YXX8DoqXy850zC__Ux1kJxkY0BJhA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 10 Apr 2013 18:55:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51891B4C-A1FB-11E2-A298-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220701>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Exactly.  Yeah, I don't think you patch makes sense as a standalone
> anyway.

Yes, it was purely a preparatory step.
