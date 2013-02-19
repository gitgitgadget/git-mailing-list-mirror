From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t0008: document test_expect_success_multi
Date: Tue, 19 Feb 2013 09:37:32 -0800
Message-ID: <7v621o6w83.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:37:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7r8h-0002h8-HB
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 18:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758700Ab3BSRhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 12:37:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab3BSRhf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 12:37:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B620A4A6;
	Tue, 19 Feb 2013 12:37:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n3sOI3vlRO/YVM+zHij99a483yo=; b=QQyvuG
	Zv/bwWjzlti9Z1rEq6xAj4n+sU6xXi5yTkQbsPg8G12fVcZ9yNQAddXETwMxC3ry
	egLDvykfMVgPM6SrLeY3kehAroS64Q5c8nWPNsz3TutGBmOJoUZwZSBywqMDOxUE
	ugGWLPJO5cUPufNXLMozS8k9bfJdWMlVFJOQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EjP7n9ukqLVTVtxyFsiOv50i+AMNo+sK
	KUbBzymWeP5AMK5D4yNoUaZA1uZOjfgj0BIUkkIsIrOFa2TEK776qPfhuhhUKxGU
	uUpeHO6H4AcnWWdgHPPfXoL6O1rHtB7vT2hA3oIPTvjh8HooAL3xZh2iMKVmdwZz
	g2yxFcxiWX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 403E8A4A5;
	Tue, 19 Feb 2013 12:37:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A01B6A49F; Tue, 19 Feb 2013
 12:37:33 -0500 (EST)
In-Reply-To: <1361282783-1413-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Tue, 19 Feb 2013 14:06:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B01779E-7ABB-11E2-A706-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216638>

Adam Spiers <git@adamspiers.org> writes:

> test_expect_success_multi() helper function warrants some explanation,
> since at first sight it may seem like generic test framework plumbing,
> but is in fact specific to testing check-ignore, and allows more
> thorough testing of the various output formats without significantly
> increase the size of t0008.
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---

Good.  I vaguely recall saying why I hate these mini-frameworks
invented in individual tests, but with comments like this, they
become much more palatable.

Thanks.

>  t/t0008-ignores.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index d7df719..ebe7c70 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -75,6 +75,16 @@ test_check_ignore () {
>  	stderr_empty_on_success "$expect_code"
>  }
>  
> +# Runs the same code with 3 different levels of output verbosity,
> +# expecting success each time.  Takes advantage of the fact that
> +# check-ignore --verbose output is the same as normal output except
> +# for the extra first column.
> +#
> +# Arguments:
> +#   - (optional) prereqs for this test, e.g. 'SYMLINKS'
> +#   - test name
> +#   - output to expect from -v / --verbose mode
> +#   - code to run (should invoke test_check_ignore)
>  test_expect_success_multi () {
>  	prereq=
>  	if test $# -eq 4
