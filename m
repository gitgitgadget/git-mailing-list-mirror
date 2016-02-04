From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] Add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Thu, 04 Feb 2016 13:53:25 -0800
Message-ID: <xmqq8u30gn1m.fsf@gitster.mtv.corp.google.com>
References: <1454577160-24484-1-git-send-email-alonid@gmail.com>
	<1454577160-24484-3-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:53:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRRqJ-0002wv-Az
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 22:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbcBDVxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 16:53:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753143AbcBDVx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 16:53:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A4781426F2;
	Thu,  4 Feb 2016 16:53:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qM27RjwyPVYajixFRINJDVJxvUU=; b=a8LGuz
	HK6+hh2BSHW2EbpGfm7qoXn2vDJn3r3W8kscZLxEjfJPz+MQcLqCfmxyrXk2Wq1+
	3f0kQOa5DNFcOU0H4pF16mbg1v9DCOE3OdR3EeL8ypuUbDv2bPbrTIRA1wOXFEYl
	dn7NyrnIjpDH/hftCjifp+wNtalPJbb3XHnSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gb69c+0dSunv+9OAKG2Zgp2bWJ/QT1DZ
	wtL3dKG0ld40+G8NZIngVZYFyKplAZzmHSuL0RoClTxTpJaomXI2NeNQWtkaNxwg
	3WUcn9mBXwKle4YwFMP0UYs6Dy4oCMx9SCQ/5xGexb6M+45vb2rPrHnay9sn68a5
	6X+xSM6YSQM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BDBA426F0;
	Thu,  4 Feb 2016 16:53:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0BE80426EF;
	Thu,  4 Feb 2016 16:53:26 -0500 (EST)
In-Reply-To: <1454577160-24484-3-git-send-email-alonid@gmail.com> (Dan Aloni's
	message of "Thu, 4 Feb 2016 11:12:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B879C5D0-CB89-11E5-BBB6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285497>

Dan Aloni <alonid@gmail.com> writes:

> Previously, before 5498c57cdd63, many people did the following:
>
>    git config --global user.email "(none)"
>
> This was helpful for people with more than one email address,
> targeting different email addresses for different clones.
> as it barred git from creating commit unless the user.email
> config was set in the per-repo config to the correct email
> address.
>
> This commit provides the same functionality by adding a new
> configuration variable.

Thanks.  I'd rather cite an individual commit, not a merge of a
topic, without forcing people to run "git show" only to see the
title of the commit.  Also I'd avoid "was it that really that many
people did so?" discussion by not saying "many people" altogether.

"by adding a new configuration variable" is a bit weak.  Help the
reader by mentioning what it is called and what it does in the same
sentence.

Perhaps like this?

-- >8 --
    ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
    
    It used to be that:
    
       git config --global user.email "(none)"
    
    was a viable way for people to force themselves to set user.email in
    each repository.  This was helpful for people with more than one
    email address, targeting different email addresses for different
    clones, as it barred git from creating commit unless the user.email
    config was set in the per-repo config to the correct email address.
    
    A recent change, 19ce497c (ident: keep a flag for bogus
    default_email, 2015-12-10), however declared that an explicitly
    configured user.email is not bogus, no matter what its value is, so
    this hack no longer works.
    
    Provide the same functionality by adding a new configuration
    variable user.useConfigOnly; when this variable is set, the
    user must explicitly set user.email configuration.
    
    Signed-off-by: Dan Aloni <alonid@gmail.com>
    Helped-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
-- 8< --

The logic in the patch is very cleanly written, partly thanks to the
previous step that was a real clean-up.

> @@ -354,6 +357,9 @@ const char *fmt_ident(const char *name, const char *email,
>  				fputs(env_hint, stderr);
>  				die("unable to auto-detect name (got '%s')", name);
>  			}
> +			if (strict && ident_use_config_only &&
> +			    !(ident_config_given & IDENT_NAME_GIVEN))
> +				die("user.useConfigOnly set but no name given");
>  		}
>  		if (!*name) {
>  			struct passwd *pw;
> @@ -373,6 +379,8 @@ const char *fmt_ident(const char *name, const char *email,
>  			fputs(env_hint, stderr);
>  			die("unable to auto-detect email address (got '%s')", email);
>  		}
> +		if (strict && ident_use_config_only && !(ident_config_given & IDENT_MAIL_GIVEN))
> +			die("user.useConfigOnly set but no mail given");
>  	}

By folding the line just like you did for "name" above, you do not
have to worry about an overlong line here.

> diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
> new file mode 100755
> index 000000000000..9522a640951b
> --- /dev/null
> +++ b/t/t9904-per-repo-email.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Dan Aloni
> +#
> +
> +test_description='per-repo forced setting of email address'
> +
> +. ./test-lib.sh
> +
> +prepare () {
> +        # Have a non-empty repository
> +        rm -fr .git
> +        git init
> +	echo "Initial" >foo &&

By attempting to reply to a patch, one discovers that the patch has
mixed indentation style ;-)  Indent with tabs.

> +        git add foo &&
> +        EDITOR=: VISUAL=: git commit -m foo &&

What is the point of these one-shot assignments to the environment
variables?

"git commit -m <msg>" does not invoke the editor unless given "-e",
and EDITOR=: is done early in test-lib.sh already, so I am puzzled.

Besides, if you are worried about some stray environment variable,
overriding EDITOR and VISUAL would not guard you against a stray
GIT_EDITOR, which takes the precedence, I think.

> +	# Setup a likely user.useConfigOnly use case
> +	unset GIT_AUTHOR_NAME &&
> +	unset GIT_AUTHOR_EMAIL &&

Doesn't unset fail when the variable is not set (we have sane_unset
helper for that)?

> +	test_unconfig --global user.name &&
> +	test_unconfig --global user.email &&
> +	test_config user.name "test" &&
> +	test_unconfig user.email &&
> +	test_config_global user.useConfigOnly true
> +}
> +
> +about_to_commit () {
> +	echo "Second" >>foo &&
> +	git add foo
> +}
> +
> +test_expect_success 'fails committing if clone email is not set' '
> +        prepare && about_to_commit &&
> +
> +	EDITOR=: VISUAL=: test_must_fail git commit -m msg

test_must_fail, being a shell function, does not follow the usual
"With 'VAR1=VAL2 VAR2=VAL2 thing', $VAR1 and $VAR2 get temporary
values only during the execution of the thing".  If you really need
to, you would need to do this like so

	test_must_fail env EDITOR=: git commit -m msg

But again, I do not think you need to override EDITOR/VISUAL here,
so...

> +test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
> +        prepare && about_to_commit &&
> +
> +	EMAIL=test@fail.com EDITOR=: VISUAL=: test_must_fail git commit -m msg

This is a good place to use the "test_must_fail env" pattern, i.e.

	test_must_fail env EMAIL=test@fail.com git commit -m msg

I would think.

Thanks.
