From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 11:34:04 -0800
Message-ID: <xmqqsihl37bn.fsf@gitster.dls.corp.google.com>
References: <1415984885-59073-1-git-send-email-blume.mike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpMdI-0004GY-NT
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 20:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161696AbaKNTeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 14:34:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161286AbaKNTeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 14:34:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D4A71D708;
	Fri, 14 Nov 2014 14:34:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0BIG9Ynd5ql61t7Y90Cx7EepqKY=; b=e+QkrW
	6ICxOXhE3O8n/JRnAmR8QjA3ktMU0W8TFyyb3mo/QY8pXCX+iMAD5RDTKuS+tPM9
	2uZ7OQdvowXcSnf4p6VwvZYycpijqTD3Rq0H7ShANSnbvllVSGu8r47iiWWX9iRT
	fqmCICsvyqLt7GMz/EMCIM5KUH7ebQsgn9gEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=idYzvBXllT/WOBQtipxRkHnojpVhbbGu
	3z1Rq2JCLo620w12MWNdZbrxDnEl0ade0V/jRq3KcW6SaG7saDz7vUCZyLFzDns7
	HF7DPkB0MSQXscL5MHIEWD1muMbc2oaDGzg3QzwkMfNC5f6nUtNHkTaeLxkhS3U1
	dypf5twXI34=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71DE01D707;
	Fri, 14 Nov 2014 14:34:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F21181D706;
	Fri, 14 Nov 2014 14:34:04 -0500 (EST)
In-Reply-To: <1415984885-59073-1-git-send-email-blume.mike@gmail.com> (Mike
	Blume's message of "Fri, 14 Nov 2014 09:08:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31A60AB4-6C35-11E4-85C7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Blume <blume.mike@gmail.com> writes:

> listed bug doesn't reproduce on Mac OS Yosemite or Mavericks. For now,
> just enable TTY on Mavericks and higher

What is "listed bug" that begins a sentence in lowercase?
End the description in full-stop, s/higher/&./;

>
> Signed-off-by: Mike Blume <blume.mike@gmail.com>
> Improved-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Improved-by: John Szakmeister <john@szakmeister.net>
> ---
>  t/lib-terminal.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index 5184549..7348f7e 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -29,7 +29,10 @@ test_lazy_prereq TTY '
>  	# After 2000 iterations or so it hangs.
>  	# https://rt.cpan.org/Ticket/Display.html?id=65692
>  	#
> -	test "$(uname -s)" != Darwin &&
> +	# Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
> +	# appears to be gone.
> +	#
> +	test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1)" -ge 13 &&

Is that "13" you have here consistent with "10.10.1" above in the
comment?  I am not a Mac person, but I vaguely recall that they are
usually off by four.

>  
>  	perl "$TEST_DIRECTORY"/test-terminal.perl \
>  		sh -c "test -t 1 && test -t 2"
