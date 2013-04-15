From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Mon, 15 Apr 2013 14:00:34 -0700
Message-ID: <7v4nf7qzkd.fsf@alter.siamese.dyndns.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
 <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 23:00:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URqW2-000518-0k
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 23:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933147Ab3DOVAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 17:00:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab3DOVAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 17:00:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B4B41621E;
	Mon, 15 Apr 2013 21:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q2+YBr0mrPIQAm0vyUNKMBpoDQw=; b=yPSwCq
	Wf5FDOWW+BxY4sy/nFr2B9ci7WuZTCGXPpFTTn5afFSMYeiyyQAfxlRHjH6/T/Pn
	2XDYYKvvv+VxQTHIoaJ0T5oeqj21/zObc+aFOuu+OnJqI07EdO2TREza3XsxPxdo
	hgzukrRwT0nfxiqrrPCqaueNTw7dm+nUTfNnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZEEfRzYjlXUHmeZ+PIKIiz4bkDqwOFe
	po9iqvfY3w414ouyirVcndAOMO+nbBvqDVDwxUUgV7RYwFDB/NJq0cwmCbtnLj+t
	KYfpl4kBK/783IlkojV7aDRdy8EJ5RqcqOhnWZ/BP5mqR98KqkZbh8Qg+Tmn9oY9
	yCKNlrnsRTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41FA81621D;
	Mon, 15 Apr 2013 21:00:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B71AD1621C; Mon, 15 Apr
 2013 21:00:35 +0000 (UTC)
In-Reply-To: <7vbp8aqtuz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 06 Sep 2010 17:29:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84DDC2AA-A60F-11E2-A819-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221316>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> If you try this:
>>
>>  1. Install Git for Windows (from the msysgit project)
>>  2. Put
>>
>> 	[core]
>> 		autocrlf = false
>> 		eol = native
>>
>>     in your .gitconfig.
>>  3. Clone a project with
>>
>> 	*.txt text
>>
>>     in its .gitattributes.
>>
>> Then with current git, any text files checked out have LF line
>> endings, instead of the expected CRLF.
>>
>> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Cc: Johannes Sixt <j6t@kdbg.org>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> Eyvind Bernhardsen wrote:
>>
>>> Introduce a new configuration variable, "core.eol", that allows the user
>>> to set which line endings to use for end-of-line-normalized files in the
>>> working directory.  It defaults to "native", which means CRLF on Windows
>>> and LF everywhere else.
>>
>> The following fixup has been sitting in my tree (but not tested on
>> Windows) for a couple of weeks.  Sensible?
>>
>> I don't know what the right choice for Cygwin is; probably LF unless
>> there is some way to detect the systemwide setting at run time.
>
> Has anybody in Windows land any input?  I don't think what I do before
> 1.7.3 in my tree would matter much, so I am not applying this myself.

Pinging MsysGit folk again ...
