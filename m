From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 04 Dec 2014 10:37:14 -0800
Message-ID: <xmqqtx1btg6d.fsf@gitster.dls.corp.google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
	<54809577.4080302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	jrnieder@gmail.com, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:37:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbHI-0002jB-U9
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbaLDShU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:37:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932215AbaLDShS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 13:37:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6612F222A9;
	Thu,  4 Dec 2014 13:37:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3Wv+bx/MyDtY5fvHEWvq2eziEM=; b=YPfJxj
	9EZRFHVQCi4nteA15AEZkPH5+UPPNEQp7ZqFyvIzb0OiwOuDvtEwijqIOpEfVnuq
	qA9s+1WuRxgN5jE8Bz1kzIzTgwzgMucJ4pYdbA+9CAcuhq7+fdYB4rB0Y8qVYmbx
	Lc81dAfm5cartvUFgqoeQNeF3jccODTDDUIco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1vOaEZ7BfsV0Z1jMhCnmamDGQ2FewpR
	Q/XGV+v/thUdczZxclDekkUvkWgSQA3uccqNKBaLNhFjL99YSrEvkWX5iQ/zX8Kh
	hwLqiYlW01ch8DqRXudsZFBqSmziLOdtC0CLlR8GKsfGyC1hSxceZeK5khYP8MCU
	tb2Bh2h3NsY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B7F9222A8;
	Thu,  4 Dec 2014 13:37:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5ADA222A5;
	Thu,  4 Dec 2014 13:37:15 -0500 (EST)
In-Reply-To: <54809577.4080302@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 04 Dec 2014 18:10:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91E2DEFC-7BE4-11E4-BE8C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260778>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ... an alternate proposal, to convert
> expire_reflogs() to take callback functions that decide *what* to
> expire, but which itself does the work of acquiring locks, iterating
> through the reflog entries, rewriting the file, and overwriting the old
> file with the new one. The goal is to move this function into refs.c and
> make builtin/reflog.c much simpler--it will only have to implement the
> callbacks that determine the expiration policy.

It sounds like a very sensible approach to me.
