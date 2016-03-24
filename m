From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] api-parse-options.txt: document OPT_CMDMODE()
Date: Thu, 24 Mar 2016 09:07:09 -0700
Message-ID: <xmqqtwjvamhe.fsf@gitster.mtv.corp.google.com>
References: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:07:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj7n6-0000hA-D3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbcCXQHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 12:07:15 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755222AbcCXQHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 12:07:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F0A74AE1F;
	Thu, 24 Mar 2016 12:07:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6zqI5xJn2UFRRWxevzKgYeGU/dQ=; b=LfzRmk
	lm+5Fox6Fdnvr4dOrWi79gE9lktwepSDWj2m0yWS0acSXD69D7A7/xr94AxPqT7e
	Ksyx6EyIB4kseOw7yxioWuKZKGqgQXB3vXxG0DLKgpXw5KCUsz6X7S+lpNrCK7CK
	FXzc2SueKshpwxqiOPeLbwNFGUzYSlvfBgXhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bx00a6sgb3Y0eKbY4L/q3/580IN289PJ
	/g6zUahQtl4As3PRnDDjJ7xil39lJZM0Ngg26ViFYaBzh9creemiFBc9z3xEqbWk
	BVjmTyc7gYs2vFNUL/UHDQT/vQi12GxseL1RZXmaazipDM0IP/Qtxr7QBvoP9iEu
	seuw/Q5mYO0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 767CE4AE1E;
	Thu, 24 Mar 2016 12:07:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFC234AE1D;
	Thu, 24 Mar 2016 12:07:10 -0400 (EDT)
In-Reply-To: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Thu, 24 Mar 2016 09:07:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 772DEF80-F1DA-11E5-B960-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289754>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> OPT_CMDMODE() was introduced in the release of 1.8.5 which makes the use
> of subcommands in the form of arguments a lot cleaner and easier.
> ---

Sign-off?

>  Documentation/technical/api-parse-options.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 5f0757d..8130d26 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -231,6 +231,12 @@ There are some macros to easily define options:
>  	pass the command-line option, which can be specified multiple times,
>  	to another command.
>  
> +`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
> +	Introduce an option for subcommands. It is useful when you want to use
> +	the command with a particular sub command only and ignore other sub
> +	commands it has. It will set `int_var` to enum_val if the argument is
> +	invoked.
> +

Sorry, but I do not get what "when you want to... ignore other sub
command it has" wants to say.

CMDMODE is a mechanism to actively notice when multiple "operation
mode" options that specify mutually incompatible operation modes are
given and error out without the user of parse_options() to implement
that mutual exclusion herself.  That is, if you have 'add', 'remove'
and 'edit' operation modes, with OPT_BOOL(), you would have to say:

	options[] = {
                OPT_BOOL('a', "add", &add, ...),
                OPT_BOOL('r', "remove", &remove, ...),
                OPT_BOOL('e', "edit", &edit, ...),
                ...
	};
        parse_options(ac, av, prefix, options, ...);

	if (!!add + !!remove + !!edit > 1)
        	die("at most one add/remove/edit can be used at a time");

	if (add)
        	do_add();
	if (remove)
        	do_remove();
	if (edit)
        	do_edit();

but with CMDMODE, you can do:

	options[] = {
                OPT_BOOL('a', "add", &mode, ...),
                OPT_BOOL('r', "remove", &mode, ...),
                OPT_BOOL('e', "edit", &mode, ...),
                ...
	};
        parse_options(ac, av, prefix, options, ...);

        switch (mode) {
        case 'a': do_add(); break;
        case 'r': do_remove(); break;
        case 'e': do_edit(); break;
		...
	}

and parse_options notices that "mode" is shared across these three
options, and implements the mutual-exclusion itself.
