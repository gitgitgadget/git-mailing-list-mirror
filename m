From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Fri, 24 May 2013 10:46:13 -0700
Message-ID: <7vsj1c9spm.fsf@alter.siamese.dyndns.org>
References: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
	<1369381324-10206-3-git-send-email-artagnon@gmail.com>
	<7vd2sgb9r8.fsf@alter.siamese.dyndns.org>
	<CALkWK0moMOBUZqqSe521qfa7q8xe0Z5sN10ZRQpPaTu8EuxuDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 19:46:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufw4K-0007b4-W1
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 19:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450Ab3EXRqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 13:46:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223Ab3EXRqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 13:46:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18E952094B;
	Fri, 24 May 2013 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mOhH8UjmJBAskunKmRQmWGbjEzs=; b=kE+8LE
	9e5i5Xe7+w3Tbi9HU1xbJhmVj/L8i8fR++Mxjp8dNzyg8llMcyqF0C/6NswQMFR/
	lIiXBit6Hi2PcQOntYGtR/e7/L+Sa+xgudxfrEPR+RivkKk2ArbwdqZWTlTXULa9
	CrYiXPHa36r1l0jHdGOHdmpiG83rSxh1C3rnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2rvYtF7wMuYvwidFj+IM19zwhQ9xG8w
	oWLPX40ArOOwLfr9ZPalSADRA9cGOMt8YlQGe8HgBDM01jqKw8zzNfZ4ijCa/oCp
	4YbNcjBzxOi85w8L5VYaMWTacyDd8bDK7914HY0dgEkB6opO0Ppc3/8CHzkOyO94
	DdsMKG0S1ac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E0A22094A;
	Fri, 24 May 2013 17:46:16 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1854C20942;
	Fri, 24 May 2013 17:46:15 +0000 (UTC)
In-Reply-To: <CALkWK0moMOBUZqqSe521qfa7q8xe0Z5sN10ZRQpPaTu8EuxuDw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 24 May 2013 22:54:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4A3813C-C499-11E2-8E12-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225386>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> What is this meant to update?  I recall rewriting this part on
>> purpose.
>
> I was being verbose to show that I handle the detached HEAD case too,
> which I missed last time.
>
>> Even though it appears unusual and invites confusion, it is very
>> consistent to say '' when the user asks for @... as we say 'master'
>> when the user asks for master@...; "inconsistent" is a very bad
>> label for it.
>
> The inconsistency refers to these two:
>
>>>   # on branch master
>>>   $ git show @{10000}
>>>   fatal: Log for '' only has 7 entries.
>
>>>   # detached HEAD case
>>>   $ git show @{10000}
>>>   fatal: Log for '' only has 2005 entries.
>
> Is the commit message unclear?

Very unclear.  You said

    The empty string '' is ugly, inconsistent, and fails to convey
    information...

I was reacting to "inconsistent" by pointing out that showing an
empty string is very consistent.

I was _not_ saying that "'' must be kept because it is consistent",
of course; that is a consistency that is not useful.  Which means
inconsistency that does not exist is a reason to rewrite it, nor the
rewrite is to gain consistency.  It is to make the result more useful.

That is why I rewrote it like so:

    The empty string '' is confusing and does not convey information
    about whose logs we are inspecting.  Change this so that...
