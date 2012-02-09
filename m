From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in
 fill_project_list_info
Date: Thu, 09 Feb 2012 15:18:16 -0800
Message-ID: <7v4nuzvbnr.fsf@alter.siamese.dyndns.org>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
 <1328359648-29511-2-git-send-email-jnareb@gmail.com>
 <7vhayzvf38.fsf@alter.siamese.dyndns.org>
 <201202092336.48772.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 00:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvdFx-0004HX-F0
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758668Ab2BIXSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 18:18:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758658Ab2BIXST convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 18:18:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C621A6A3B;
	Thu,  9 Feb 2012 18:18:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XX7CHuR6jtDI
	WJmsiiBv4P7GjFA=; b=TtbefkxrK2NOX4UDehCpyU17vWd7oTWk4J0EbKtrWc2z
	nLN+k/O0zefAn+1suW7rMkWlh5aa9OERwK268KU0nDIgxeKrYik/b82Mm621lMEb
	mx+Mv+o4Lc8GhS58RUDd970WzZiqkSgVNr6pEvNOk1H9MIXMMZ/9WQ8JpNADQMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=umSb0o
	QA7+zmZcRPn7YbE8w8m/y/txgCjJ3Qnsi1aCy3EymRhwDeeHInyBhKcapmNaiXoY
	2e/k23RzARcSq9jtn81mAXGxlvYTss/9wCtuoV1+/bFnvP1Gya+8GObrERR5zWc6
	XfUGIywc/6Cea//7biIqDZwovZ5xAwZq6IAMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC1C6A3A;
	Thu,  9 Feb 2012 18:18:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B5716A39; Thu,  9 Feb 2012
 18:18:18 -0500 (EST)
In-Reply-To: <201202092336.48772.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu, 9 Feb 2012 23:36:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59A60EBA-5374-11E1-BF1F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190340>

Jakub Narebski <jnareb@gmail.com> writes:

>> The lack of any real use of @fill_only in this patch also makes it h=
ard to
>> judge if the new API gives a useful semantics.  I would, without loo=
king
>> at the real usage in 2/5 patch, na=C3=AFvely expect that such a lazy=
 filling
>> scheme would say "I am going to use A, B and C; I want to know if an=
y of
>> them is missing, because I need values for all of them and I am goin=
g to
>> call a helper function to fill them if any of them is missing. Havin=
g A
>> and B is not enough for the purpose of this query, because I still n=
eed to
>> know C and I would call the helper function that computes all of the=
m in
>> such a case. Even though it might be wasteful to recompute A and B,
>> computing all three at once is the only helper function available to=
 me".
>>=20
>> So for a person who does not have access to the real usage of the ne=
w API,
>> being able to give only a single $key *appears* make no sense at all=
, and
>> also the meaning of the @fill_only parameter is unclear, especially =
the
>> part that checks if that single $key appears in @fill_only.
>
> ...
> information that is not already present.  If @fill_only is nonempty, =
it
> fills only selected information, again only if it is not already pres=
ent.
> @fill_only empty means no restrictions... which probably is not very =
obvious,
> but is documented.
>
> project_info_needs_filling() returns true if $key is not filled and i=
s
> interesting.

That still does not answer the fundamental issues I had with the presen=
ted
API: why does it take only a single $key (please re-read my "A, B and C=
"
example), and what does that single $key intersecting with @fill_only h=
ave
anything to do with "needs-filling"?

After all, that 'age' check actually wants to fill 'age' and 'age_strin=
g'
in the project. Even if some other codepath starts filling 'age' in the
project with a later change, the current callers of fill_project_list_i=
nfo
expects _both_ to be filled. So "I know the current implementation fill=
s
both at the same time, so checking 'age' alone is sufficient" is not an
answer that shows good taste in the API design.
