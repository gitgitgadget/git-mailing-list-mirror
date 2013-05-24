From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Fri, 24 May 2013 09:52:43 -0700
Message-ID: <7vd2sgb9r8.fsf@alter.siamese.dyndns.org>
References: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
	<1369381324-10206-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:52:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfvEZ-0000a4-98
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab3EXQwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:52:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809Ab3EXQwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C111F0F1;
	Fri, 24 May 2013 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hlg9rjg1TItuzs9KVvQnIWAH5/E=; b=bJ7McX
	JMUEFsFCnpLA14mqkoOP/BkZnfcfb8v/2zEksQ/fyUl5eW9nN4V8rgZh42I0Lr+i
	CU66LtVWekc/sW/vkE/DsBTZfdbalHo9d9SpR37/wvwKaTnNp2JpIRjgwzo367oL
	rt90ovyWxWcYtcUTjEF6sg0qUPg8InJR5MxCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uDASxppheD8G9QGC/jAX4J00QAV/OQiw
	Z2oxU8mrvY0b5UcfhWJOhM/d8r5O73SCDJHdNjv4Z5NrlgEJBJAvLJuPrcXMcOqJ
	JDIE2HXAOrACyZCU9YzZHZ+rKKp8M1J8wBNyIAeo9iX8moFgzqoIywvrGpR4kmQL
	eIpnSTSUwEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 079271F0EF;
	Fri, 24 May 2013 16:52:46 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DA791F0EC;
	Fri, 24 May 2013 16:52:45 +0000 (UTC)
In-Reply-To: <1369381324-10206-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 24 May 2013 13:12:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B763E78-C492-11E2-8671-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225380>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, when we try to resolve @{<N>} or @{<date>} when the reflog
> doesn't go back far enough, we get errors like:
>
>   # on branch master
>   $ git show @{10000}
>   fatal: Log for '' only has 7 entries.
>
>   $ git show @{10000.days.ago}
>   warning: Log for '' only goes back to Tue, 21 May 2013 14:14:45 +0530.
>   ...
>
>   # detached HEAD case
>   $ git show @{10000}
>   fatal: Log for '' only has 2005 entries.
>
>   $ git show master@{10000}
>   fatal: Log for 'master' only has 7 entries.
>
> The empty string '' is ugly, inconsistent, and fails to convey
> information about whose logs we are inspecting.  Change this so that we

What is this meant to update?  I recall rewriting this part on
purpose.

Even though it appears unusual and invites confusion, it is very
consistent to say '' when the user asks for @... as we say 'master'
when the user asks for master@...; "inconsistent" is a very bad
label for it.
