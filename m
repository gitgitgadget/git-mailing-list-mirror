From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] Add log.abbrevCommit config variable
Date: Wed, 18 May 2011 12:05:50 -0700
Message-ID: <7vwrhnbzht.fsf@alter.siamese.dyndns.org>
References: <1305741364-28286-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 21:06:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMm4J-0003TV-Ku
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 21:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933610Ab1ERTF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 15:05:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933500Ab1ERTF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 15:05:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E4435E58;
	Wed, 18 May 2011 15:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vrQWKh1R5SdRJZ/SID+AMUQkmlk=; b=ZKxiyr
	KH43j57YzjDNtNnAkOLpQ+YA2r9pkE1y596GEmob49vb1l0JwaAm5WLwz4On6V8Z
	fV1QNSI1ii82Tii0t2cvZr/JMn9l9jSq2ex1E5cuR3EsbdC9M6UhWe7hMkoUfWE1
	DZQxarJ+9RPO/oOIEwuMsX1JeZ7gAayqXeXPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qK2/3iRAbv8OwSnXSPy+rj3RVB6XnsuI
	pfVGaf16pQRKDOLGQthb6twF0GO64lIIIBEQ1xLi74EL50wkfjq8R36o7RYYnM30
	af0DDN6MtJZnJok/0D/gNJvRY2rTsshfP7No/ijYW0iRQtlg23ULjbLIUdUw9qeh
	PXOui0qYpHI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF3C35E52;
	Wed, 18 May 2011 15:08:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA19B5E51; Wed, 18 May 2011
 15:07:58 -0400 (EDT)
In-Reply-To: <1305741364-28286-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed, 18 May 2011 13:56:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26DCBE08-8182-11E0-9577-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173896>

Jay Soffian <jaysoffian@gmail.com> writes:

> +test_expect_success 'log.abbrevCommit configuration' '
> +	test_when_finished "git config --unset log.abbrevCommit" &&

Now, when this test begins, what is the value of log.abbrevCommit?

I'd add an explicit

	test_might_fail git config --unset log.abbrevCommit &&

here.

> +	git log --abbrev-commit >expect.log.abbrev &&
> +...
> +	test_cmp expect.reflog.full actual

Break in && chain here.

> +	git whatchanged >actual &&
> +	test_cmp expect.whatchanged.abbrev actual

Ditto.

> +	git whatchanged --no-abbrev-commit >actual &&
> +	test_cmp expect.whatchanged.full actual
>  '
>  
>  test_expect_success 'show added path under "--follow -M"' '

I've squashed these in before queuing, so unless you found other issues,
no need to resend.

Thanks.
