Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9557C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 08:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiFTIh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiFTIh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 04:37:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C012ABC
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 01:37:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s12so19640908ejx.3
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yhFWvxA9+XrHBBDvd2j8mTSgM31shzje2mr/Os7HH+I=;
        b=D5WNCOHhg748iZtiVFudQkFSrgt+DlpM7Q2KCVXye5WhWftztHUg+0rUeIg3ar/ntP
         pZeVpTKdR5jW3cNO3eneG3f5BfxxcNA2CwzROOU2q7fudUYVeWTxS4OeHcw7CorFysR4
         ThLNuU/pyZE/hnGOwXV/BIwI26EwR3GshXlZgIjj2HeIGzUUAaqw4s39/S6jeR1kfKDz
         lw4Wnc885SR3xpK7B5QnXrUlKzRcIfZSrfxUBayjO431mBzrsWqyrXmvVdvy0MjZJ4du
         h3jQlU2F7aLJG+0t51Tdb809AVLwW7qUMvuZGG5BzDXR5HsDfa5MBGa+6oaMd69VGjhB
         in2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yhFWvxA9+XrHBBDvd2j8mTSgM31shzje2mr/Os7HH+I=;
        b=Mnh5ysD5ea8P5Rzes8DooVtk/+8pkimpMvWPaQzelV7DuxqdmuplLSqTxPEK0Fr4Ti
         MgGFrZfbSfy1CZPpfbKgcsKerQ6j2IOT3vre24j/egEjRF4rH3lHqGJkyxof6BrajXRK
         t3BLPKaf2LyxJ8e9CbaQIKZl7O6uUV3sonrXP61axrP2c+2pEXiPt1jaa41eS1LvK/92
         68uGrmOQfWcw7SYkdDXt9A1Z5Q7pxBcKqtb/Ou7anHAZgaENwYRz9hn9oYwfBL/jFZol
         NHdv/9KGvE3k7t4Rqc3vPhmKyldRPC3Z1pblC+7+1f6mU717snyd7I7y3dW5rEbTMVJ3
         syrw==
X-Gm-Message-State: AJIora8tIq0G4Ub1nJHf2kbx9wB54ptIAZ6jhT5pkOtWsLO6hi5JBV4O
        97BfN7qbKAACPTTsZ+C91NY=
X-Google-Smtp-Source: AGRyM1sTQPwzp3H0LWXlJ5Kr1xzFFBnGYoudWw7Q6EfCGka05lsyryefsQfiw4XF78NhQ3fOo3sj2g==
X-Received: by 2002:a17:906:33db:b0:70f:12c0:4ade with SMTP id w27-20020a17090633db00b0070f12c04ademr19855966eja.320.1655714244643;
        Mon, 20 Jun 2022 01:37:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z19-20020a056402275300b004319b12371asm10075143edd.47.2022.06.20.01.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:37:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3CuQ-001NBX-RM;
        Mon, 20 Jun 2022 10:37:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stewart Smith <trawets@amazon.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --no-validate-email option
Date:   Mon, 20 Jun 2022 10:28:58 +0200
References: <20220620004427.3586240-1-trawets@amazon.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220620004427.3586240-1-trawets@amazon.com>
Message-ID: <220620.867d5bwx19.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 19 2022, Stewart Smith wrote:

> The perl Email::Valid module gets things right, but this may not always
> be what you want, as can be seen in
> https://bugzilla.redhat.com/show_bug.cgi?id=2046203
>
> So, add a --validate-email (default, current behavior) and
> the inverse --no-validate-email option to be able to skip the check
> while still having the Email::Valid perl module installed.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2046203
> Suggested-by: Todd Zullinger <tmz@pobox.com>
> Signed-off-by: Stewart Smith <trawets@amazon.com>
> ---
>  git-send-email.perl   | 9 +++++++++
>  t/t9902-completion.sh | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..c75b08f9ce 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -103,6 +103,7 @@ sub usage {
>      --quiet                        * Output one line of info per email.
>      --dry-run                      * Don't actually send the emails.
>      --[no-]validate                * Perform patch sanity checks. Default on.
> +    --[no-]validate-email          * Perform email address sanity checks. Default on.
>      --[no-]format-patch            * understand any non optional arguments as
>                                       `git format-patch` ones.
>      --force                        * Send even if safety checks would prevent it.
> @@ -281,6 +282,7 @@ sub do_edit {
>  my $chain_reply_to = 0;
>  my $use_xmailer = 1;
>  my $validate = 1;
> +my $validate_email = 1;
>  my $target_xfer_encoding = 'auto';
>  my $forbid_sendmail_variables = 1;
>  
> @@ -293,6 +295,7 @@ sub do_edit {
>      "tocover" => \$cover_to,
>      "signedoffcc" => \$signed_off_by_cc,
>      "validate" => \$validate,
> +    "validateemail" => \$validate_email,
>      "multiedit" => \$multiedit,
>      "annotate" => \$annotate,
>      "xmailer" => \$use_xmailer,
> @@ -531,6 +534,8 @@ sub config_regexp {
>  		    "no-thread" => sub {$thread = 0},
>  		    "validate!" => \$validate,
>  		    "no-validate" => sub {$validate = 0},
> +		    "validate-email!" => \$validate_email,
> +		    "no-validate-email" => sub {$validate_email = 0},
>  		    "transfer-encoding=s" => \$target_xfer_encoding,
>  		    "format-patch!" => \$format_patch,
>  		    "no-format-patch" => sub {$format_patch = 0},
> @@ -1132,6 +1137,10 @@ sub extract_valid_address {
>  	# check for a local address:
>  	return $address if ($address =~ /^($local_part_regexp)$/);
>  
> +	# Email::Valid isn't always correct, so support a way to bypass
> +	# See https://bugzilla.redhat.com/show_bug.cgi?id=2046203
> +	return 1 if not $validate_email;
> +
>  	$address =~ s/^\s*<(.*)>\s*$/$1/;
>  	my $have_email_valid = eval { require Email::Valid; 1 };
>  	if ($have_email_valid) {
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 31526e6b64..6e363c46f3 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2302,6 +2302,7 @@ test_expect_success PERL 'send-email' '
>  	EOF
>  	test_completion "git send-email --val" <<-\EOF &&
>  	--validate Z
> +	--validate-email Z
>  	EOF
>  	test_completion "git send-email ma" "main "
>  '

I don't think this patch is what we want to fix this problem: The
git-send-email script should ultimately be trying to pass an address to
a MTA. If you look into its history of Email::Valid use you'll see that
we initially used it unconditionally, then later conditionally to get
rid of the dependency.

I think a better change is to simply get rid of the Email::Valid
dependency, but I'm not 100% sure if there aren't edge cases where our
parsing there isn't something we rely on in other cases.

But in the meantime a more narrow change that I believe solves the issue
for you is:
	
	diff --git a/git-send-email.perl b/git-send-email.perl
	index 5861e99a6eb..1168da43ef2 100755
	--- a/git-send-email.perl
	+++ b/git-send-email.perl
	@@ -1135,7 +1135,11 @@ sub extract_valid_address {
	 	$address =~ s/^\s*<(.*)>\s*$/$1/;
	 	my $have_email_valid = eval { require Email::Valid; 1 };
	 	if ($have_email_valid) {
	-		return scalar Email::Valid->address($address);
	+		my $email = Email::Valid->address(
	+			-address => $address,
	+			-localpart => 0,
	+		);
	+		return $email if $email;
	 	}
	 
	 	# less robust/correct than the monster regexp in Email::Valid,

Of that we just need that "-localpart => 1" part to fix this specific
problem, but I think having the "return $email if $email" is also more
correct, and would solve this bug even without the "-localpart => 0",
i.e. we'll always fall through to trying to parse the address with our
regex.

In any case I think this could really use a corresponding update to the
t/t9001-send-email.sh script, i.e. to test an address with a long local
part.
