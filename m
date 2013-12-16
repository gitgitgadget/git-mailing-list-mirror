From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Mon, 16 Dec 2013 12:15:27 -0800
Message-ID: <xmqqk3f4o8m8.fsf@gitster.dls.corp.google.com>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
	<xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
	<7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
	<CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
	<beee32a53ece8b839578703deb851eaa@matos-sorge.com>
	<CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com>
	<3FFF08967D2E480FA6B0E0EE3A72A8D9@PhilipOakley>
	<7vmwk3gr39.fsf@alter.siamese.dyndns.org>
	<0172E9F1B5F945EB9294F1066C2FB72E@PhilipOakley>
	<B4E4F29CB20847DEB23F21255A040187@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Antoine Pelisse" <apelisse@gmail.com>,
	"Paulo Matos" <paulo@matos-sorge.com>, "git" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Dec 16 21:15:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VseZl-0001Me-F0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093Ab3LPUPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:15:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab3LPUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:15:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF1BD5B7D3;
	Mon, 16 Dec 2013 15:15:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KTz+EFfWAfgj3P3iXZ9RffjrCg4=; b=xUuNU8
	j/F+85VpnNxAKGieGT2lcuc7lHhYzGrcrQIx2ShRznw8CkSCKhyg4dol5XyJU5AE
	EEjlhfprbyNwpfJ3wGm0nrWBknlMNI8Zw0VXt2H48SzWxt9oSdOIFerNWTe1qLG6
	1G8gIX7UDuygSk1RVWOkyEysxYObAr6MggKig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FUjxlpIGk735sXH2OnxerZuhCi6B26nb
	Xm8iQQpt6JRIAWlm0SmkDpiKRKtTnoFuVwXe5aYuGLm+jSdzhWwsAPbgGe4sBoaP
	jHfCab59OzHPXkjWfVGHcAPk0BvqMw/FtPGHlXRXoCM+VTa1ltKSPQS9xaXoeqW2
	Ic9RBDjGf+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFAA45B7D1;
	Mon, 16 Dec 2013 15:15:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E45E35B7D0;
	Mon, 16 Dec 2013 15:15:30 -0500 (EST)
In-Reply-To: <B4E4F29CB20847DEB23F21255A040187@PhilipOakley> (Philip Oakley's
	message of "Mon, 16 Dec 2013 19:00:53 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CFD4A4E6-668E-11E3-A052-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239363>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Philip Oakley" <philipoakley@iee.org>
>> From: "Junio C Hamano" <gitster@pobox.com>, Saturday, December 14,
>> 2013 7:39 PM
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>> Would this be a good use of the
>>>>    * Magic pathspecs like ":(icase)
>>>> that was recently released (v1.8.5  2Dec13)  so that the merge
>>>> stages
>>>> can be named.
>>>
>>> Because the pathspec mechahism is for you to tell an operation that
>>> works on a collection of paths (e.g. "all the paths in the HEAD",
>>> "all the paths at stage #1 in the index") to narrow the set it
>>> operates on down to only those that match, I do not think it is a
>>> good match at all to what you are trying to do.
>>>
>>
>> My point was that the ":1:" syntax already was a "path at stage #1
>> in the index" indicator, and that it would be good to have a
>> memorable name for the :1:2:3: stages as per Antoine's  query.
>
> Could someone point me at where is this syntax decoded?

sha1_name.c (anything that turns name to object name goes there, I
think).  Look for this comment:

	/*
	 * sha1:path --> object name of path in ent sha1
	 * :path -> object name of absolute path in index
	 * :./path -> object name of path relative to cwd in index
	 * :[0-3]:path -> object name of path in index at stage
	 * :/foo -> recent commit matching foo
	 */

I do not think adding ":ours:path" as a synonym to ":2:path" adds
enough value to make it worthwhilte to worry about breaking the
expectation of those who thought "ours:path/name" will be something
they could track if they wanted to.



> My initial hunt around the code base didn't find the relevant location.
>
>>
>> It maybe that my referring to it as a 'magic pathspec' was a
>> mistake, but the difficulty of remembering which number is
>> ours:theirs:base still stands.
>>
>> (for general info; the :<stage>:  format is defined in 'git revision
>> (7)' as the last method for Specifying Revisions)
>>
>> Philip
>> --
> Philip
