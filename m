Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E21B87DF
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630857; cv=none; b=tl1v+BYu1hENPx9hFglINq3Mky8Sfnsq2vK9DpsbH54iiqI1dS0MgP9zhYONYNN5UD6QxW1LYpYEcxQEPMEYAxNSROPo48K6TOF4LzpwAj+RGvz8amDnnnpC77R+0QPBMrTsCjYxl3mL+RMpXbzBq6pYIE2AYs7EzlOBZdNBxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630857; c=relaxed/simple;
	bh=hR8dM9Vq3KtZgp3OLptjMopfie3/tv6OIG38pJa7JjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shmeOaPEVcjdjtE6WqZ+SjYm1dlk90atdE2J1R6jrnWwLuVIQ5rFD57nAnEvVVP9ivY5uHIlZjhLlaKBNhCK9vpN20Lxr9w6wX5H733KWymX4oS9BVpH4K0urkWBfs4VCuIjUVrHhW+VH6HfvjpHhilqpxJO3fToAe8Tf1pUEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoenJSRK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoenJSRK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso641713566b.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2025 13:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736630853; x=1737235653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcR0uqDz6VglYpKEyJ1EO7bv+koFBLTwf6Vs4Uaba0w=;
        b=YoenJSRK+x6Lz1RE2VwzJZR9XFsoAFk/2/TN9vyAxMp2FKMEk0qYQDG3fOrd2XTHcs
         7X+kVaOqMWbUM2Wx+WdSNAGYTXZDy96lsQBC6Y5Gvy9r4EhOwtloRp/dQiAWaTqc7Ia6
         i9bg5AzsiLRr5+j6fsU1y+njt35dbtSmK7XdsdicHNWwFtdVTJiWmeEmXjQy1tCydKdP
         OwEjZPzso8TmIyC2sUsNAjJ5324+UxsiBtQMvTiNbg5iM/2ceP/gHaN2z90ZkC9RnxqE
         0o+HJkT/NSvsYT6OADT6BtUZYEgLEuq+5zmEY9Dj49TPVQU9av+uePvumJmxgNsrgNrY
         bLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736630853; x=1737235653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcR0uqDz6VglYpKEyJ1EO7bv+koFBLTwf6Vs4Uaba0w=;
        b=uKsqD+luhKxycHmvU7no7k8wxYA+mPC3a4/IlWKvAPqVZMKKJiSEYPrPb6iEc8VO9I
         gtKto7ki9dzev58bt/aLH4Jgdpyel2ZdylQxsnhbP8Uatq1tirnJSa5KKXIl2SU/7meo
         Hr+xnc9N0B6rFh6PfSQH2Pw0azXt2PAk191xMv+E7j6aIFhtdNJ9lZsmLO0Ky9Z/x/fK
         Flbh9mrsGieKekkedkpuudvPVid7Pdc6WB7EWG0OFWGNZ5fXLrCwS8EoCPBdHBiFwccV
         WQ5XoPypd9Gfe6ZJFI38X8TWOI5Tk6UjQq07p2JqiCdCD1bccxL1w+DVQTdr0FjN9sa8
         paSQ==
X-Gm-Message-State: AOJu0YxyFEj9np8ltERHrQ++NXzQ0MHFihiPnXTFVZ3hvUpu4OS26dMH
	Z2agXCQ7SvawdXDcF7j8zqO/JdB+zcGwPmyJ4EcLBQFeBM2IPH88
X-Gm-Gg: ASbGncskL04CsEIRBlaRlQPuQKaxOe2Si8NfjIW0aXnJWlZNUXL2kmQ8byupSdtm0Yh
	6AXh+nsRFdnOFwcIrxIy3WM8rAYPB/CYLVn58FerXxGA92h1dla4aqJUE4iGKfXyzyOMU0XtJs0
	7GkCQigw+j4pwJnskyzwLq7fhlJbZSOlM/007Foik9TO/qOhPKoWxjDSwcO4WV1Id9f/Pb9G6Du
	w8pu+c11t4TlOoOCs2luHMIi2a+DyPjHhBFR9uQo3WjwVVWv/BBgN728Almp/oLRaDFXd7HXcC0
	4W+bgME=
X-Google-Smtp-Source: AGHT+IFqFTP69i5Z4TkBGVeFi116SauNYw5WHtC+/62lKpgf09aypIyHu8Ee2xJ6lvVWbNTfRm5Nnw==
X-Received: by 2002:a17:907:2d94:b0:aa6:66eb:9c06 with SMTP id a640c23a62f3a-ab2ab6a8e01mr1428703366b.5.1736630852452;
        Sat, 11 Jan 2025 13:27:32 -0800 (PST)
Received: from steeple.tail39f0bb.ts.net ([217.156.233.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b72ebsm302850766b.165.2025.01.11.13.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 13:27:32 -0800 (PST)
From: M Hickford <mirth.hickford@gmail.com>
To: julian@swagemakers.org
Cc: git@vger.kernel.org,
	wiagn233@outlook.com,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
Date: Sat, 11 Jan 2025 21:27:01 +0000
Message-ID: <20250111212701.723710-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.48.0.rc2.32.gda862abb60
In-Reply-To: 20240225103413.9845-1-julian@swagemakers.org
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
> This is necessary since they are currently not supported by the Perls
> Authen::SASL module.
> 
> The bearer token needs to be passed in as the password. This can be done

Please add documentation to git-send-email.txt

> with git-credential-oauth[0] after minor modifications[1]. Which will
> allow using git send-email with Gmail and oauth2 authentication:
> 
> ```
> [credential]
> 	helper = cache --timeout 7200	# two hours
> 	helper = oauth
> [sendemail]
>     smtpEncryption = tls
>     smtpServer = smtp.gmail.com
>     smtpUser = example@gmail.com
>     smtpServerPort = 587
>     smtpauth = OAUTHBEARER
> ```
> 
> As well as Office 365 accounts:
> 
> ```
> [credential]
> 	helper = cache --timeout 7200	# two hours
> 	helper = oauth
> [sendemail]
>     smtpEncryption = tls
>     smtpServer = smtp.office365.com
>     smtpUser = example@example.com
>     smtpServerPort = 587
>     smtpauth = XOAUTH2
> ```
> 
> [0] https://github.com/hickford/git-credential-oauth
> [1] https://github.com/hickford/git-credential-oauth/issues/48
> 
> Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
> ---
>  git-send-email.perl | 65 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 821b2b3a13..72d378f6fd 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1359,6 +1359,63 @@ sub smtp_host_string {
>  	}
>  }
>  
> +sub generate_oauthbearer_string {
> +	# This will generate the oauthbearer string used for authentication.
> +	#
> +	# "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
> +	#
> +	# The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
> +	# * gs2-cb-flag `n` -> client does not support CB
> +	# * gs2-authzid `a=" {User} "`
> +	#
> +	# The second part are key value pairs containing host, port and auth as
> +	# described in RFC7628.
> +	#
> +	# https://datatracker.ietf.org/doc/html/rfc5801
> +	# https://datatracker.ietf.org/doc/html/rfc7628
> +	my $username = shift;
> +	my $token = shift;
> +	return "n,a=$username,\001port=$smtp_server_port\001auth=Bearer $token\001\001";
> +}
> +
> +sub generate_xoauth2_string {
> +	# "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
> +	# https://developers.google.com/gmail/imap/xoauth2-protocol#initial_client_response
> +	my $username = shift;
> +	my $token = shift;
> +	return "user=$username\001auth=Bearer $token\001\001";
> +}
> +
> +sub smtp_bearer_auth {
> +	my $username = shift;
> +	my $token = shift;
> +	my $auth_string;
> +	if ($smtp_encryption ne "tls") {
> +		# As described in RFC7628 TLS is required and will be will
> +		# be enforced at this point.
> +		#
> +		# https://datatracker.ietf.org/doc/html/rfc7628#section-3
> +		die __("For $smtp_auth TLS is required.")
> +	}
> +	if ($smtp_auth eq "OAUTHBEARER") {
> +		$auth_string = generate_oauthbearer_string($username, $token);
> +	} elsif ($smtp_auth eq "XOAUTH2") {
> +		$auth_string = generate_xoauth2_string($username, $token);
> +	}
> +	my $encoded_auth_string = MIME::Base64::encode($auth_string, "");
> +	$smtp->command("AUTH $smtp_auth $encoded_auth_string\r\n");
> +	use Net::Cmd qw(CMD_OK);
> +	if ($smtp->response() == CMD_OK){
> +		return 1;
> +	} else {
> +		# Send dummy request on authentication failure according to rfc7628.
> +		# https://datatracker.ietf.org/doc/html/rfc7628#section-3.2.3
> +		$smtp->command(MIME::Base64::encode("\001"));
> +		$smtp->response();
> +		return 0;
> +	}
> +}
> +
>  # Returns 1 if authentication succeeded or was not necessary
>  # (smtp_user was not specified), and 0 otherwise.
>  
> @@ -1392,8 +1449,12 @@ sub smtp_auth_maybe {
>  		'password' => $smtp_authpass
>  	}, sub {
>  		my $cred = shift;
> -
> -		if ($smtp_auth) {
> +		if ($smtp_auth eq "OAUTHBEARER" or $smtp_auth eq "XOAUTH2") {

Be careful to check that $smtp_auth is initialized to avoid warnings:

Use of uninitialized value $smtp_auth in string eq at /home/matt/libexec/git-core/git-send-email line 1493.
Use of uninitialized value $smtp_auth in string eq at /home/matt/libexec/git-core/git-send-email line 1493.

> +			# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
> +			# manuall authenticate for tese types. The password field should
> +			# contain the auth token at this point.
> +			return smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
> +		} elsif ($smtp_auth) {
>  			my $sasl = Authen::SASL->new(
>  				mechanism => $smtp_auth,
>  				callback => {
