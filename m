From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-lib: allow using split index in the test suite
Date: Fri, 20 Mar 2015 14:55:19 -0700
Message-ID: <xmqqvbhvcp14.fsf@gitster.dls.corp.google.com>
References: <20150320195943.GB6545@hank>
	<1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
	<1426887794-9655-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 22:55:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ4t6-0001cX-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 22:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbbCTVzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 17:55:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751222AbbCTVzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 17:55:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1527428EE;
	Fri, 20 Mar 2015 17:55:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUMIapdfL0UUTT+N4M6pyew069E=; b=oGRYKy
	vNzpzf6SAT8ccNBxhMc9CLve6835egxDFFJ8LriR2qELlLKDBq588I1re0qUhDrb
	AKfvhyJgi07VHMFhIAkjA6PffTmfcOHJtpg3zM3Il0uukJ9av8czvvaq/pp5Xgrx
	lGcoPsGJ0VRm39OF/AUmQ5GVJ34K2Jmb/a7Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4qWzCcLui9NFu5PU24fuvDiKCbbYdDi
	yiXRba7ifzTLPrUSLrZJdKoBGBuWAW7veJ+kPVtCtmiKWcJc/E3ax/juI8kCiAMZ
	WzPhDqWE6CzpHmnhFmoQCUsTRsCP2Sc7eXRTVBztUZw8JirSZXXOBzRvPwmmGZPe
	ttS/ES0dTY4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7624428ED;
	Fri, 20 Mar 2015 17:55:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A30F428E7;
	Fri, 20 Mar 2015 17:55:20 -0400 (EDT)
In-Reply-To: <1426887794-9655-2-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Fri, 20 Mar 2015 22:43:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CD61F9A8-CF4B-11E4-B438-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265970>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Allow adding a TEST_GIT_TEST_SPLIT_INDEX variable to config.mak to run
> the test suite with split index enabled.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

> ---

Hmm, it is not wrong per-se, but would it be too much trouble to do

    GIT_TEST_SPLIT_INDEX=YesPlease make test

or is this doing something a lot more than that?

>  Makefile      | 6 ++++++
>  t/test-lib.sh | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 44f1dd1..55e558a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -339,6 +339,9 @@ all::
>  # with a different indexfile format version.  If it isn't set the index
>  # file format used is index-v[23].
>  #
> +# Define TEST_GIT_TEST_SPLIT_INDEX to 1 to run the test suite with split
> +# index enabled.
> +#
>  # Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
>  # return NULL when it receives a bogus time_t.
>  #
> @@ -2129,6 +2132,9 @@ endif
>  ifdef TEST_GIT_INDEX_VERSION
>  	@echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@
>  endif
> +ifdef TEST_GIT_TEST_SPLIT_INDEX
> +	@echo TEST_GIT_TEST_SPLIT_INDEX=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_TEST_SPLIT_INDEX)))'\' >>$@
> +endif
>  
>  ### Detect Python interpreter path changes
>  ifndef NO_PYTHON
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c096778..477f253 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -119,6 +119,12 @@ then
>  	export GIT_INDEX_VERSION
>  fi
>  
> +if test -n "${TEST_GIT_TEST_SPLIT_INDEX:+isset}"
> +then
> +	GIT_TEST_SPLIT_INDEX="$TEST_GIT_TEST_SPLIT_INDEX"
> +	export GIT_TEST_SPLIT_INDEX
> +fi
> +
>  # Add libc MALLOC and MALLOC_PERTURB test
>  # only if we are not executing the test with valgrind
>  if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
