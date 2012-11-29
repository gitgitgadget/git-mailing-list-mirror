From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-fast-import.txt: improve documentation for
 quoted paths
Date: Thu, 29 Nov 2012 11:15:56 -0800
Message-ID: <7vvccop6dv.fsf@alter.siamese.dyndns.org>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
 <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
 <20121129181141.GA17309@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9ao-0003Y8-QC
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab2K2TP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:15:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107Ab2K2TP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:15:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B78DA9866;
	Thu, 29 Nov 2012 14:15:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q+rQKprsXaZg2pfQYhIZf/kz4QI=; b=nlNijr
	dh60Z54R7bHDJQFr05tIoqyt3a6qrktTNUcMCh2l0gemPuY2wQ4wHruaXvc20FTm
	5n+DYwfBVsiuOE3ss4UF1F1PNMQ2xUS+HM3CEwbIvlDL7/OgdGzGGDBr3/g023s3
	C+Dh17c97vQwAGFVJ5OrPigW7MDqKBJXXgyc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xiJljh0J6LK6FKSDPF5u7bM98+WKdoGI
	8gKLGOiHNLyriOwEJNbFosBDeJcU9prOz0LJkBGFa+HDsZqTVubY/VPkHB38joNk
	T+7PZLf1bkTtGHOUh/L8QScRGhLanJ8E1YP9WJrUMr/afTIIL3+JyoU6rExhLpl7
	VJdUDvhLjSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A475F9865;
	Thu, 29 Nov 2012 14:15:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21B809864; Thu, 29 Nov 2012
 14:15:58 -0500 (EST)
In-Reply-To: <20121129181141.GA17309@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 29 Nov 2012 13:11:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 347A373E-3A59-11E2-BD5B-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210869>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 29, 2012 at 06:00:54PM +0100, Matthieu Moy wrote:
>
>> The documentation mentionned only newlines and double quotes as
>
> s/nn/n/
>
>> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
>> index 6603a7a..35b909c 100644
>> --- a/Documentation/git-fast-import.txt
>> +++ b/Documentation/git-fast-import.txt
>> @@ -558,8 +558,9 @@ A `<path>` string must use UNIX-style directory separators (forward
>>  slash `/`), may contain any byte other than `LF`, and must not
>>  start with double quote (`"`).
>>  
>> -If an `LF` or double quote must be encoded into `<path>` shell-style
>> -quoting should be used, e.g. `"path/with\n and \" in it"`.
>> +If an `LF`, backslash or double quote must be encoded into `<path>`
>> +shell-style quoting should be used, and the complete name should be
>> +surrounded with double quotes e.g. `"path/with\n, \\ and \" in it"`.

That "shell-style" contradicts with what fast-import.c says, though.
It claims to grok \octal and described as C-style.
