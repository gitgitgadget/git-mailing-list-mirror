From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: unify documentation of test function args
Date: Mon, 25 Apr 2011 09:07:50 -0700
Message-ID: <7v62q2l3ft.fsf@alter.siamese.dyndns.org>
References: <4DB4010B.6080804@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:08:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEOKU-0003x0-FQ
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 18:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab1DYQIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 12:08:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1DYQIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 12:08:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69D12419E;
	Mon, 25 Apr 2011 12:10:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pgCwf8kRcJ/qAZvIg3khTu4/3sg=; b=KzB2nueebKheoFou/rnf
	mnjc9HwxcAU1JLQnBPN3gtUKq3YWZ2T8oizQkRegK/jP2fJVK2sW/GalWYl2I/7k
	YGvHx7+aJk4DjMzKgczoTa22S+J6xc+X9pm4T8dT0yN6T79DmpPBhcFZ0yUnOoE5
	ffzdrFOxYm3o9dK1R0li0fs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jjVV5dZ+fBw/kLKcpObnGdoZDn4uqUisXRsMsesFHkJgko
	qakKSvXGZaClVByhQ42LflAHfeGZAzmezICJbn39XH/VOJVhgoAT8kRltheKP93A
	jax5QbK96Tgb1xolWEHMGP/+sjAMmdQS8/fo2DMd+Po/i+hKqFXLM9XAbCGuQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D711419C;
	Mon, 25 Apr 2011 12:09:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CA1E419B; Mon, 25 Apr 2011
 12:09:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 773E8BF8-6F56-11E0-AF59-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172029>

Mathias Lafeldt <misfire@debugon.org> writes:

> Document all test function arguments in the same way.
>
> While at it, correct some grammatical errors.
>
> Signed-off-by: Mathias Lafeldt <misfire@debugon.org>

Thanks.

> diff --git a/t/README b/t/README
> index 428ee05..e8372d7 100644
> --- a/t/README
> +++ b/t/README

Everything before this hunk looks sensible.

> @@ -503,18 +503,18 @@ library for your script to use.
>  		test_expect_code 1 git merge "merge msg" B master
>  	'
>  
> - - test_must_fail <git-command>
> + - test_must_fail <command>
> ...  
> +   Run a command and ensure it fails in a controlled way.  Use this
> +   instead of "! <command>".  When the command dies due to a segfault,
> +   test_must_fail diagnoses it as an error; "! <command>" treats it as
> +   just another expected failure, which would let such a bug go
> +   unnoticed.
>  
> - - test_might_fail <git-command>
> + - test_might_fail <command>
>  
>     Similar to test_must_fail, but tolerate success, too...

But the above two deliberately say "git-command" to clarify that these are
special cases and meant to be used only to run a git command.  If we
expect a failure from a command that is not "git", say "date", we would
want to say "! date", not "test_must_fail date".

> @@ -530,7 +530,7 @@ library for your script to use.
>     test_path_is_dir <dir> [<diagnosis>]
>     test_path_is_missing <path> [<diagnosis>]
>  
> -   Check whether a file/directory exists or doesn't. <diagnosis> will
> +   Check whether a file/directory exists or not. <diagnosis> will

Is the original really a grammo, or is this change just your personal
taste?  If I were rewriting this, I would probably say something like:

	- test_path_is_file <path> [<diagnosis>]
          test_path_is_dir <path> [<diagnosis>]
          test_path_is_missing <path> [<diagnosis>]

	  Check if the named path is a file, if the named path is a
          directory, or if the named path does not exist, respectively,
          and fail otherwise, showing the <diagnosis> text.
