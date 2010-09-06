From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test-string-list.c
Date: Sun, 05 Sep 2010 23:12:31 -0700
Message-ID: <7v7hizwgc0.fsf@alter.siamese.dyndns.org>
References: <4f798daaf4631e00927b455b77919d5bb8fade03.1283653854.git.tfransosi@gmail.com>
 <20100905050254.GA6134@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 08:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsUwk-0005Fu-6A
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab0IFGMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:12:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab0IFGMm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 02:12:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33608D395A;
	Mon,  6 Sep 2010 02:12:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLK5fOtBIhrE5eyMFsth58TRsww=; b=ug01iY
	7b/Pt4K/6LT2b2JQBZRFWRYIRHIx5P3uqj3hdOfXAqGy+9uqnYJuMj3ZX8ZiTntm
	a7FW11x1oGYK5o9kE26A3UQUODY/ptU/SugGagI22a+egSuRDBwU+Tu8btxXapQf
	cISQm4LsqKouPhcuT6mEFPBufbTdMpyC4XeuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c6YQIkKXFl5AYiiv4NQjqM4caOS7g71U
	CPPgvtUYcfiWohmB8JtknC4oAXQmON6oguPCvnqDCQeawlBqP5Cm47C5y2R+jC0c
	MCjKMnDZAQd2j/swkYbyHBI1som96kmMCdZh917NO/cTvJBIuHkUINpQ6XPWgAif
	+abcAAI0ZoA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E780ED3959;
	Mon,  6 Sep 2010 02:12:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 226E9D3958; Mon,  6 Sep
 2010 02:12:32 -0400 (EDT)
In-Reply-To: <20100905050254.GA6134@burratino> (Jonathan Nieder's message of
 "Sun\, 5 Sep 2010 00\:02\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BEE5A638-B97D-11DF-B12D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155531>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Git programs tend to start with 
>
>  #include "cache.h"
>
> or
>
>  #include "git-compat-util.h"
>
> to get all the portability niceties.

Quote Documentation/CodingGuidelines here, too.  And use of these headers
is not merely "niceties"--some exotic platforms tend to want standard
system headers in particular inclusion order and what git-compat-util.h
does is the result of us painfully finding these rules out over years.

> Thoughts separate from the code:
>
>  * it is probably worth mentioning Documentation/technical/api-string-list.txt
>    for people who do not know about it.
>
>  * for this to be useful as a test I think one has to sort of believe
>    that it can break.  That is, a test of something this basic (which
>    is already demonstrated and exercised by code throughout git, after
>    all) would tend to be especially devious.
>
>  * api-string-list.txt does not mention the STRING_LIST_INIT macros
>    you introduced.  Maybe that would be worth improving.

 * this may be built but nothing exercises it.  Is it worth adding
   tNNNN-run-string-list-test.sh for some value of NNNN?  

I tend to agree with your second point and have a moderately negative
feeling against the patch.  An addition to API documentation like you
suggested would be more useful for people, and what Thiago did perhaps
might be useful in its sample code section, but then we already have
plenty of working samples in live code and they are single "git grep"
away, so...
