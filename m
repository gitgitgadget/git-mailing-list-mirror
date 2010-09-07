From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Mon, 06 Sep 2010 17:29:08 -0700
Message-ID: <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
 <20100904082509.GC10140@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 02:29:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osm44-0007kG-CQ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 02:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab0IGA32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 20:29:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab0IGA30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 20:29:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFB86D3A52;
	Mon,  6 Sep 2010 20:29:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUxa4gZcPui0I5ZZ45LC72H8yJ8=; b=lb8+j9
	59E8yyww8yCGBVNb1gRWShon+JT6fN8dbl4zmGmZUOu3+7SFWug9ozWWn9R0QSUj
	pRFwQjw7KqIpU/Bb1yHgmFXvXUbOUifNLLsKyJ7jNumeHVF+xjEoyR2njXWuwlCY
	rXCA+kpHhLLcoKsyITdTB2YhWrerAI1Jao4Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x+yImO1D9KXnHtmG4OLgNfNuYZY8TKjY
	p6XDBjJlzQVO5HvtCgKc0yhEQArgxifG/nRLS5N0rQAEihLlbgjnTIaAdHk4PMa+
	iWQsVZ8bnRORaftQSQKYv8Q/yZQ7Dd56RFyeeqWEHWgU8qTxcxyF4NTFKexNuIE5
	ZIwjdavST+Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DFB6D3A50;
	Mon,  6 Sep 2010 20:29:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 824FAD3A4F; Mon,  6 Sep
 2010 20:29:14 -0400 (EDT)
In-Reply-To: <20100904082509.GC10140@burratino> (Jonathan Nieder's message of
 "Sat\, 4 Sep 2010 03\:25\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4EBB1DE-BA16-11DF-A0C7-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155654>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If you try this:
>
>  1. Install Git for Windows (from the msysgit project)
>  2. Put
>
> 	[core]
> 		autocrlf = false
> 		eol = native
>
>     in your .gitconfig.
>  3. Clone a project with
>
> 	*.txt text
>
>     in its .gitattributes.
>
> Then with current git, any text files checked out have LF line
> endings, instead of the expected CRLF.
>
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> Cc: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Eyvind Bernhardsen wrote:
>
>> Introduce a new configuration variable, "core.eol", that allows the user
>> to set which line endings to use for end-of-line-normalized files in the
>> working directory.  It defaults to "native", which means CRLF on Windows
>> and LF everywhere else.
>
> The following fixup has been sitting in my tree (but not tested on
> Windows) for a couple of weeks.  Sensible?
>
> I don't know what the right choice for Cygwin is; probably LF unless
> there is some way to detect the systemwide setting at run time.

Has anybody in Windows land any input?  I don't think what I do before
1.7.3 in my tree would matter much, so I am not applying this myself.
