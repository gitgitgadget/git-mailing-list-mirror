From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Add tests for "git diff --check" with core.whitespace options
Date: Thu, 13 Dec 2007 16:55:47 -0800
Message-ID: <7vsl26xffw.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
	<1197552751-53480-2-git-send-email-win@wincent.com>
	<1197552751-53480-3-git-send-email-win@wincent.com>
	<1197552751-53480-4-git-send-email-win@wincent.com>
	<1197552751-53480-5-git-send-email-win@wincent.com>
	<1197552751-53480-6-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 01:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2yqq-0003Ra-Er
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 01:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935374AbXLNA4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 19:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935366AbXLNA4D
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 19:56:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935337AbXLNA4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 19:56:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 520DE4DE2;
	Thu, 13 Dec 2007 19:55:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E4B44DE0;
	Thu, 13 Dec 2007 19:55:49 -0500 (EST)
In-Reply-To: <1197552751-53480-6-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Thu, 13 Dec 2007 14:32:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68206>

Wincent Colaiuta <win@wincent.com> writes:

> +test_expect_success 'check spaces as indentation (indent-with-non-tab: off)' '
> +
> +	git config core.whitespace "-indent-with-non-tab"
> +	echo "                foo ();" > x &&
> +	git diff --check
> +
> +'
> +
> +test_expect_failure 'check spaces as indentation (indent-with-non-tab: on)' '
> +
> +	git config core.whitespace "indent-with-non-tab" &&
> +	echo "                foo ();" > x &&
> +	git diff --check
> +
> +'
> +
>  test_done

It is good to check both positive and negative cases, but I would prefer
avoiding test_expect_failure.  You cannot tell if the "git config"
before the real test failed or "git diff --check" correctly reported
whitespace breakage --- both would cause the test to pass.
