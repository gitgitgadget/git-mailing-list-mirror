From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/19] branch.c: use ref transaction for all ref updates
Date: Tue, 29 Apr 2014 10:15:22 -0700
Message-ID: <xmqqr44gkqfp.fsf@gitster.dls.corp.google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-17-git-send-email-sahlberg@google.com>
	<535AECC5.3090100@alum.mit.edu>
	<CAL=YDWkJKOM7eo7cknMH4MAAYJ=Ds9PVjUvufHzrBu=neucf4g@mail.gmail.com>
	<535F725B.5000102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfBcx-0000EB-Op
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 19:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278AbaD2RP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 13:15:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758248AbaD2RP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 13:15:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56CFE81489;
	Tue, 29 Apr 2014 13:15:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCPLP441NGFnxhQNuh0zBhk06G0=; b=W2F2KX
	0Jm6nbBRE2Rrjf4MbkPH/E6N0pcI+6IQqudoEiTWTWpUDAj+/y/vo2w0wqDhUkQ2
	MIbXIEJFw+14cvxEoEesVpfESh+a291z2Wy+io2HlHW2C5vMp9gx87twgOV6eVyn
	o2mYygipQXXdOeZeQyd4w7cn9N+OSv+kvRoTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fXqdWCZYiHXNHIj547UGCF7G+KNEGok2
	A6vD+lr5ATxoRuDWOwp8mkrodjAEG9Bai5pSVZLjnQHj2vJPjD3s36JhsnO0kJOj
	vZ8XWnh1oOJx0cedX84bAPFRkY7B3blOyjWsALf5iI5cdbdzL+CVE3vmxksnJT0N
	TdLnR9N0zsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4001581488;
	Tue, 29 Apr 2014 13:15:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2662381487;
	Tue, 29 Apr 2014 13:15:24 -0400 (EDT)
In-Reply-To: <535F725B.5000102@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 29 Apr 2014 11:35:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9D95E40-CFC1-11E3-9192-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247593>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I have no compunctions about using update() to create or delete a
> reference.  My point of view is that update() is the general case, and
> create() and delete() are special-cases that exist only for the
> convenience of callers.  For example, our future pluggable backends
> might only have to implement update(), and the other two functions could
> delegate to it at the abstract layer.

Sounds like a sensible position.

Thanks for commenting, Michael, and thanks for working on this,
Ronnie.
