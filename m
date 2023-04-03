Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45578C761A6
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 14:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjDCOKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjDCOKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 10:10:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF75255
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 07:09:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so14489483wms.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530975;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PAkDVBR3Y8bdKvHL++zRWMIk0xaK0j1HmPw+PjJsqoU=;
        b=AhSb5MuFMy0iJ7K+rZmDSBkgZLj1K+kkw9uarqUZlnYtKBgXzMW0IU8F0RyNuMbnz5
         Rw3gwnbolj6+Y+Ctp6c2eJ4EI8HZxf6sX2ZlVtM1tv0UEW900ujsVjSqhzDvffoP09fi
         I075UnGkXB54VtiziaL3T5SQwTW/p5CUse93+oSccv1kWrnptEruNlAJgrGok5TLxXQI
         33jP0mqreQnDlno7lPSJ4dTSOVdX5rYqaIZY0GfCP1DB0qX+DwzOk+dAZTtsW5VdXQo8
         k7LdLFHFoXCbuk9L0BFhS9sKZgElkDQjbaG1D9Hy2hsiBHXMEipaf8cnTnqHCfTBKjzl
         nkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530975;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAkDVBR3Y8bdKvHL++zRWMIk0xaK0j1HmPw+PjJsqoU=;
        b=r55/Evb+0HqGr1rv8LK+OYqvVioWi0w/O6npbOwzlD0mlAOH+emtOD90jZxO0EU0qt
         +2Zi9+VP5RlVX1fWt7w/fmzMGtiJvm4un0HBjiB0h+zuBU4Kiip9hbA+3G8Mr1CRKkSK
         Jjbl2ZYCwPOQeuRxUi7+0bqBnD2728oVWmXTUU30nJSjNinda7EAY4QIK6rKssg30jd8
         TaDAPkOQTyZQt+/jkh3Cxu8STPI34YLKP6SXJKbeGCrC8WPIHYcwy37NTRW2kC5C6Anr
         1Kq5N1QqKSzGfMfYweVQMQW/6DGzPOVouVwTlKbls0du2eK5Pz1bCpTOxjirrOghz1qb
         RZnQ==
X-Gm-Message-State: AO0yUKWtID+TsqUdRlcmkuq0aBBsqvtg/ZPJA1qLT1sgusalLUB6lloI
        uJHhblYMJCk7vMZovyMydXY=
X-Google-Smtp-Source: AK7set/Z4l+1frX4cmuyP8CbBeCyBEu/fzpEnhMBnB7y2WAvGVgPezqcwU7cXrL5GdQrFLIdIsGH6Q==
X-Received: by 2002:a7b:cd99:0:b0:3ee:4dc0:d4f6 with SMTP id y25-20020a7bcd99000000b003ee4dc0d4f6mr25309755wmj.17.1680530974985;
        Mon, 03 Apr 2023 07:09:34 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b003ef6bc71cccsm19964865wmq.27.2023.04.03.07.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:09:34 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
Date:   Mon, 3 Apr 2023 15:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
Content-Language: en-US
To:     Robin Jarry <robin@jarry.cc>, git@vger.kernel.org
Cc:     Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20230402185635.302653-1-robin@jarry.cc>
In-Reply-To: <20230402185635.302653-1-robin@jarry.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robin

On 02/04/2023 19:56, Robin Jarry wrote:
> When sending patch series (with a cover-letter or not)
> sendemail-validate is called with every email/patch file independently
> from the others. When one of the patches depends on a previous one, it
> may not be possible to use this hook in a meaningful way.
> 
> Changing sendemail-validate to take all patches as arguments would break
> backward compatibility.
> 
> Add a new hook to allow validating patch series instead of patch by
> patch. The patch files are provided in the hook script standard input.
> 
> git hook run cannot be used since it closes the hook standard input. Run
> the hook directly.

I've left some comments about this lower down as "git hook run" now has 
a --to-stdin option.

> Signed-off-by: Robin Jarry <robin@jarry.cc>
> ---

> +sendemail-validate-series
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by linkgit:git-send-email[1].  It allows performing
> +validation on a complete patch series at once, instead of patch by patch with
> +`sendemail-validate`.
> +
> +`sendemail-validate-series` takes no arguments, but for each e-mail to be sent
> +it receives on standard input a line of the format:
> +
> +  <patch-file> LF

Usually git commands that produce or consume paths either use quoted 
paths terminated by LF or unquoted paths terminated by NUL. That way 
there is no ambiguity when a path contains LF.

> +where `<patch-file>` is a name of a file that holds an e-mail to be sent,
> +
> +If the hook exits with non-zero status, `git send-email` will abort before
> +sending any e-mails.
> +
>   fsmonitor-watchman
>   ~~~~~~~~~~~~~~~~~~
>   
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 07f2a0cbeaad..bec4d0f4ab47 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -800,6 +800,7 @@ sub is_format_patch_arg {
>   			validate_patch($f, $target_xfer_encoding);
>   		}
>   	}
> +	validate_patch_series(@files)

This happens fairly early, before the user has had a chance to edit the 
patches and before we have added all the recipient and in-reply-to 
headers to the patch files. Would it be more useful to validate what 
will actually be sent?

>   }
>   
>   if (@files) {
> @@ -2125,6 +2126,47 @@ sub validate_patch {
>   	return;
>   }
>   
> +sub validate_patch_series {
> +	my @files = @_;
> +
> +	unless ($repo) {
> +		return;
> +	}
> +
> +	my $hook_name = 'sendemail-validate-series';
> +	my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');

$hooks_path maybe a relative path, this is problematic because we change 
directory before executing the hook (using "git hook run" would avoid this).

> +	require File::Spec;
> +	my $validate_hook = File::Spec->catfile($hooks_path, $hook_name);
> +	my $hook_error;
> +	unless (-x $validate_hook) {
> +		return;
> +	}
> +
> +	# The hook needs a correct cwd and GIT_DIR.
> +	require Cwd;
> +	my $cwd_save = Cwd::getcwd();
> +	chdir($repo->wc_path() or $repo->repo_path()) or die("chdir: $!");
> +	local $ENV{"GIT_DIR"} = $repo->repo_path();

This looks like it is copied from the existing code but why do we need 
to do this? I'm struggling to come up with a scenario where "git 
send-email" can find the repository but the hook cannot.

> +	# cannot use git hook run, it closes stdin before forking the hook
> +	open(my $stdin, "|-", $validate_hook) or die("fork: $!");

This passes $validate_hook to the shell to execute which is not what we 
want as it will split the hook path on whitespace etc. I think it would 
be better to use "git hook run --to-stdin" (see 0414b3891c (hook: 
support a --to-stdin=<path> option, 2023-02-08))

Best Wishes

Phillip

> +	chdir($cwd_save) or die("chdir: $!");
> +	for my $fn (@files) {
> +		unless (-p $fn) {
> +			$fn = Cwd::abs_path($fn);
> +			$stdin->print("$fn\n");
> +		}
> +	}
> +	close($stdin); # calls waitpid
> +	if ($? & 0x7f) {
> +		my $sig = $? & 0x7f;
> +		die("fatal: hook $hook_name killed by signal $sig");
> +	} elsif ($? >> 8) {
> +		my $err = $? >> 8;
> +		die("fatal: hook $hook_name rejected patch series (exit code $err)");
> +	}
> +	return;
> +}
> +
>   sub handle_backup {
>   	my ($last, $lastlen, $file, $known_suffix) = @_;
>   	my ($suffix, $skip);
