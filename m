From: Junio C Hamano <gitster@pobox.com>
Subject: Re: asciidoc problem, and a possible fix
Date: Wed, 24 Mar 2010 17:51:44 -0700
Message-ID: <7vljdhjk9r.fsf@alter.siamese.dyndns.org>
References: <4ABB29E2-6DB1-4712-A3E8-CD524983FB0B@kuiki.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hachi <hachi@kuiki.net>
X-From: git-owner@vger.kernel.org Thu Mar 25 01:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NubIn-0001oo-EK
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 01:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab0CYAvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 20:51:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab0CYAvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 20:51:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07DCBA45E6;
	Wed, 24 Mar 2010 20:51:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4S7CcbVhs6eK7W/+mkd8+vOkZbg=; b=TR4E6Z
	luLH6EEtNfJfTF4oyr/iLdqeqSGUMlgOvzjZW33Z9Y6qe8bvzgiGlr5JK2Naw6mN
	1YXtSO0YjV7l98CbTX+JNSzVLaBhpmIOite1RfKHLNRDzGyCVJNG+z2ZrzTI559b
	+kTy2woOl8YHJ7BqUWMstlhhXTV7/v0mubyao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QfmP76rAqA0uFmR/ObCqCrnAPRlHMTUL
	cPtZ2hkd2yW656sBMmliJrh7buZPiTCCHnRSzFBfKgu/bozrushAl1ie1LFqcoPq
	1B6sithOGWOJRDpVSQxdVXLkCX+UcLBKwimvktCdPSKCFHEw7TYshcayt+4PCsYQ
	4VAf/l6XpLg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BACBA45DF;
	Wed, 24 Mar 2010 20:51:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55250A45D9; Wed, 24 Mar
 2010 20:51:45 -0400 (EDT)
In-Reply-To: <4ABB29E2-6DB1-4712-A3E8-CD524983FB0B@kuiki.net>
 (hachi@kuiki.net's message of "Wed\, 24 Mar 2010 16\:34\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97C2CAE2-37A8-11DF-9012-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143139>

hachi <hachi@kuiki.net> writes:

> I had an issue building git on some centos 5 machines today, and in trying to interpret the error message I formed the attached patch.
>
> The errors were:
> xmlto: input does not validate (status 1)
> /home/hachi/rpm/BUILD/git-1.7.0.3/Documentation/git-filter-branch.xml:463: parser error : PCDATA invalid Char value 7
> Clone it with <literal>git clone +++0+++</literal>.  The clone
>                                     ^

A shot in the dark without sufficient information I could try to make is
that you are trying to use an ancient AsciiDoc, perhaps pre-7.1.2?

I am guessing that the following entry from their ChangeLog:

    Version 7.1.2 (2006-03-07)
    --------------------------
    .Additions and changes
     ...
    - An 'inline passthrough' mechanism has been implemented.

refers to this "triple-plus" passthrough, documented in:

    http://www.methods.co.nz/asciidoc/userguide.html#X77

As the use of feature is isolated to only the documentation for filter-branch,
I am personally Ok with replacing that passthru with a simpler formatting
element that is supported by an ancient version of AsciiDoc (but I didn't
look at your patch in the attachment).
