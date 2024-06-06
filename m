Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155817839D
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667319; cv=none; b=dJH0PnRWRrhfHXyWSHH6MzGkHuJz1HoxpZcxg1Dy9htFm/X4sw9zO5sUth9nXp0CA6IBaqGD4Jz0E1OyrCu1tW4EJK2zUOHjP22NF6P1welDSw/xB4dgg9wmJZ3JWbTRxaBwf5S2LmYzTCHZMeHxTPxhEDUgaz6JC3v4pPzcm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667319; c=relaxed/simple;
	bh=93b0OcGeC4IPr4rJDCiCxCfkGsdrH8zQUXqlFP4oUxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbZi+qSVBESYaXs6A+otmQpIjZARPdiLwutJD4kNQ5B3YIkymLX/EuNebRb9LlH5ydKQRQGoXy75wVHe32vklANDGHo/uKmwZ5NKT4N4+gGIAZ0vZgE0rHQntKevI5vcoYWN1s4B2EH3FHyiiW0MqTTTm1o68bIi/HVZsXI/ptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxqZK+1g; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxqZK+1g"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so359061f8f.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667316; x=1718272116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+NpwT4PlLYVBoYqvgV8WcOGLUKe/vITE3SyOiR6cYqs=;
        b=TxqZK+1geLu4cUcWqkKnfb19GeQ92//A1ODh475YOSabSbWmfp+3akB866weqDnA5Q
         IKe2ofVgizRJiL2qUCb5kAUP6v/DDxVwimScvEyYQDCRDYe/OUc9+nb4yYouHO3vgSKB
         TxWxesmaBIlIk446SrSiqybBB4TQwTwi8AFffoRancwm577DivUIX9rXhWUwCfjJQ/mK
         WcucjgaLyeTZdOIRkaT/j+X9nBzyDy9B0A3WRPPZofeJAYGu/zYnpKr/KNaYaW/8Zvkd
         CzNDtsFkHTLzXmIgscVZhw5ai9JTO4gAgIKYUx/6s4W/2fF3FaEv68/lTGgVbLzCZnNh
         h17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667316; x=1718272116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NpwT4PlLYVBoYqvgV8WcOGLUKe/vITE3SyOiR6cYqs=;
        b=tWk2DoFe/+bGrESuSWvpXJQWfoaItVJPr0TED5oPcA62kxYfJ3zxX3ziuYRr7fhl4+
         O6tffWw20HbFfpmK992h7ypDyi/1yNUum808nTnmjjWtJZT9ypY/8ZQsEVw61eRm7Fc6
         8vcBsntPj0dNEoKYYxrdyZQj5qb4VjetsPMjtHmmKDErA7uZZw772X2cE2icklRZbhQ5
         uT7/IQklybfRihm/nkM6uv/tAqyJBpgnVEvd+AxBKaWODxnMarjBKZiz7jHyebmenPzz
         2ncnjJwQO3TKG1gxrRW+RtPabIGb55Jz8aEj8JH9EOLwjYG6w3oEoFptXpdN3/BHgMfa
         989g==
X-Forwarded-Encrypted: i=1; AJvYcCVCEHk8JQKXN+wcoMwly2ekFYKzA3ggO5Tdbl9AvJIs6kKMJjQOjntrOxp1G/g/4l6sOhkJCfKVCq2hriel9HPcc13B
X-Gm-Message-State: AOJu0Yx9igann/+9RXUFv+e+xOCeGp4pUjQ2SGzkF1N0vH9QSCiphWrR
	mDNTOtZ5v8Gi3MqOv9OyuMDisgFXn1a2VYyxdN+UPzDbe61I2XPa9IQGrA==
X-Google-Smtp-Source: AGHT+IHWdeZ70RttnI3ko81iJQOAAfolLfVfGc/4YbGFD0Zikx91H5anHkgegpdulpwdvJwgOjihhg==
X-Received: by 2002:adf:ce85:0:b0:35e:4d47:b5b8 with SMTP id ffacd0b85a97d-35ef0dc9b35mr1823044f8f.27.1717667315912;
        Thu, 06 Jun 2024 02:48:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1? ([2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35ef5d4a608sm1108578f8f.40.2024.06.06.02.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 02:48:35 -0700 (PDT)
Message-ID: <7ef4a566-6d55-4924-b02c-38137c15791a@gmail.com>
Date: Thu, 6 Jun 2024 10:48:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] diff: let external diffs report that changes are
 uninteresting
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Johannes Sixt <j6t@kdbg.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
 <99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 05/06/2024 09:38, René Scharfe wrote:
> The options --exit-code and --quiet instruct git diff to indicate
> whether it found any significant changes by exiting with code 1 if it
> did and 0 if there were none.  Currently this doesn't work if external
> diff programs are involved, as we have no way to learn what they found.
> 
> Add that ability in the form of the new configuration options
> diff.trustExitCode and diff.<driver>.trustExitCode and the environment
> variable GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE.  They pair with the config
> options diff.external and diff.<driver>.command and the environment
> variable GIT_EXTERNAL_DIFF, respectively.
> 
> The new options are off by default, keeping the old behavior.  Enabling
> them indicates that the external diff returns exit code 1 if it finds
> significant changes and 0 if it doesn't, like diff(1).
> 
> The name of the new options is taken from the git difftool and mergetool
> options of similar purpose.  (There they enable passing on the exit code
> of a diff tool and to infer whether a merge done by a merge tool is
> successful.)
> 
> The new feature sets the diff flag diff_from_contents in
> diff_setup_done() if we need the exit code and are allowed to call
> external diffs.  This disables the optimization that avoids calling the
> program with --quiet.  Add it back by skipping the call if the external
> diff is not able to report empty diffs.  We can only do that check after
> evaluating the file-specific attributes in run_external_diff().
> 
> I considered checking the output of the external diff to check whether
> its empty.  It was added as 11be65cfa4 (diff: fix --exit-code with
> external diff, 2024-05-05) and quickly reverted, as it does not work
> with external diffs that do not write to stdout.  There's no reason why
> a graphical diff tool would even need to write anything there at all.
> 
> I also considered using a non-zero exit code for empty diffs, which
> could be done without adding new configuration options.  We'd need to
> disable the optimization that allows git diff --quiet to skip calling
> external diffs, though -- that might be quite surprising if graphical
> diff programs are involved.  And assigning the opposite meaning of the
> exit codes compared to diff(1) and git diff --exit-code to the external
> diff can cause unnecessary confusion.

Thanks for the comprehensive commit message, I agree that it is much 
less confusing to follow the exit code convention of diff(1). This is 
looking good, I've left a couple of comments below.


> +diff.trustExitCode::
> +	If this boolean value is set to true then the `diff.external`
> +	command is expected to return exit code 1 if it finds
> +	significant changes and 0 if it doesn't, like diff(1).  If it's
> +	false then the `diff.external` command is expected to always
> +	return exit code 0.  Defaults to false.

I wonder if "significant changes" is a bit ambiguous and as Johannes 
said it would be good to mention that other exit codes are errors. Perhaps

	If this boolean value is set to true then the `diff.external`
	command is expected to return exit code 0 if it considers the
	input files to be equal and 1 if they are not, like diff(1).
	If it is false then the `diff.external` command is expected to
	always return exit code 0. In both cases any other exit code
	is considered to be an error. Defaults to false.


>   	strvec_push(&cmd.args, pgm->cmd);
>   	strvec_push(&cmd.args, name);
> @@ -4406,7 +4424,10 @@ static void run_external_diff(const struct external_diff *pgm,
>   	diff_free_filespec_data(one);
>   	diff_free_filespec_data(two);
>   	cmd.use_shell = 1;

Should we be redirecting stdout to /dev/null here when the user passes 
--quiet?

> -	if (run_command(&cmd))
> +	rc = run_command(&cmd);
> +	if ((!pgm->trust_exit_code && !rc) || (pgm->trust_exit_code && rc == 1))
> +		o->found_changes = 1;
> +	else if (!pgm->trust_exit_code || rc)
>   		die(_("external diff died, stopping at %s"), name);

This is a bit fiddly because we may, or may not trust the exit code but 
the logic here looks good.

> -check_external_exit_code   1 0 --exit-code
> -check_external_exit_code   1 0 --quiet
> -check_external_exit_code 128 1 --exit-code
> -check_external_exit_code   1 1 --quiet # we don't even call the program
> +check_external_exit_code   1 0 off --exit-code
> +check_external_exit_code   1 0 off --quiet
> +check_external_exit_code 128 1 off --exit-code
> +check_external_exit_code   1 1 off --quiet # we don't even call the program
> +
> +check_external_exit_code   0 0 on --exit-code
> +check_external_exit_code   0 0 on --quiet
> +check_external_exit_code   1 1 on --exit-code
> +check_external_exit_code   1 1 on --quiet
> +check_external_exit_code 128 2 on --exit-code
> +check_external_exit_code 128 2 on --quiet

It would be nice if the tests checked that --quiet does not produce any 
output on stdout.

Best Wishes

Phillip

