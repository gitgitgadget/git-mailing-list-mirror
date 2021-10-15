Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7909C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A073D610E8
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbhJORKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhJORKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:10:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF28C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:07:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r2so9126965pgl.10
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UcuFvg6VvbAihDylUDq69Rh9e9og+y7PFrfvNE9p91U=;
        b=DNmC7DCsFd69hvetIyVb+EPmFVPJ9Odk9SjT5vs71yur9UUjFwVRpQmP0fnDnyK2E3
         p0qY5jdtD4BEyfVztdLu/Y6Neg8/uE/xUN1hxvvW90YN7LdL2DF90NagHAgilPN+ubht
         NdLeWU6jfa/Kaf4HARjJWltFi+lI/sF1seJ/JJWwLLHy/20PxUw9z6gXNHwT0sGcEPEo
         br7dxiL32klbQBXpzdsn2vsaFNwMfx2ByTp4Ov8kiZrnCMATsYik+WxOLGduKZJqkNQ9
         JtiWwDP/MpLSdkbRnt1iG+6Fc8XYulQueBqHgG1bWnjxK4c6TPTheQz77nshFSgQPTuE
         wEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UcuFvg6VvbAihDylUDq69Rh9e9og+y7PFrfvNE9p91U=;
        b=uCtnkfemAWadtCKbOW/OZmDSSLTzV/DSgMuih5Uro3+XM0bN/9TU5Fbt3xbeh7BcXN
         88qDl5znNq+l3LqX+06xTH3OSrkd492JEz1hp3WPyKveUUlOcSBJ/uRa28NjN/6FqTAr
         brrXI5r+77Zfk9pDfixHrLOU1g53km+qKD1rQfI/F7wWyC7EHNl7Gl0BbAzLJHd6zb+2
         d6b+B3LfcRLN6R4SBMLc10AVlGvJQBoHMQrmqkUnxblpLEBbcsTHIMecS9uvjWo+3u3Q
         uyUbzGv61dC2c/MEn1iIJmVLgAluBBNtRi38sL1AefXlkOI8WgKs8JLJaf78jrsjEiLl
         H4SQ==
X-Gm-Message-State: AOAM5324kMfV25629g+HA4RJqDBLNe/qz1g/VYc5xsId1zO1UJ25AY7X
        GXajsPSKMH/O/GijnRzeCPQJ1Xk4Z43nAw==
X-Google-Smtp-Source: ABdhPJwdlcNdRAze/pyVeptj3SSnf7LUSRU/drHF4Trcsf4NXx3LTMjTyXRuruX+FbYUJ4C5EvNaYg==
X-Received: by 2002:a63:cf10:: with SMTP id j16mr10077161pgg.257.1634317675067;
        Fri, 15 Oct 2021 10:07:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id bp19sm5312785pjb.46.2021.10.15.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:07:54 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:07:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 08/13] send-email: use 'git hook run' for
 'sendemail-validate'
Message-ID: <YWm1ZdLJqQG8ywiH@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-08.13-6c4ebd68d56-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-08.13-6c4ebd68d56-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 11:43:36AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Change the "sendmail-validate" hook to be run via the "git hook run"
> wrapper instead of via a direct invocation.
> 
> This is the smallest possibly change to get "send-email" using "git
> hook run". We still check the hook itself with "-x", and set a
> "GIT_DIR" variable, both of which are asserted by our tests. We'll
> need to get rid of this special behavior if we start running N hooks,
> but for now let's be as close to bug-for-bug compatible as possible.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Someday we can delete a bunch more in there and on that day we can
celebrate. But the rationale for making the change minimal LGTM.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  git-send-email.perl   | 22 ++++++++++++++--------
>  t/t9001-send-email.sh |  4 ++--
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5262d88ee32..4c20c0bbb79 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -195,13 +195,13 @@ sub format_2822_time {
>  my $editor;
>  
>  sub system_or_msg {
> -	my ($args, $msg) = @_;
> +	my ($args, $msg, $cmd_name) = @_;
>  	system(@$args);
>  	my $signalled = $? & 127;
>  	my $exit_code = $? >> 8;
>  	return unless $signalled or $exit_code;
>  
> -	my @sprintf_args = ($args->[0], $exit_code);
> +	my @sprintf_args = ($cmd_name ? $cmd_name : $args->[0], $exit_code);
>  	if (defined $msg) {
>  		# Quiet the 'redundant' warning category, except we
>  		# need to support down to Perl 5.8, so we can't do a
> @@ -2039,10 +2039,10 @@ sub validate_patch {
>  	my ($fn, $xfer_encoding) = @_;
>  
>  	if ($repo) {
> +		my $hook_name = 'sendemail-validate';
>  		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
>  		require File::Spec;
> -		my $validate_hook = File::Spec->catfile($hooks_path,
> -					    'sendemail-validate');
> +		my $validate_hook = File::Spec->catfile($hooks_path, $hook_name);
>  		my $hook_error;
>  		if (-x $validate_hook) {
>  			require Cwd;
> @@ -2052,13 +2052,19 @@ sub validate_patch {
>  			chdir($repo->wc_path() or $repo->repo_path())
>  				or die("chdir: $!");
>  			local $ENV{"GIT_DIR"} = $repo->repo_path();
> -			$hook_error = system_or_msg([$validate_hook, $target]);
> +			my @cmd = ("git", "hook", "run", "--ignore-missing",
> +				    $hook_name, "--");
> +			my @cmd_msg = (@cmd, "<patch>");
> +			my @cmd_run = (@cmd, $target);
> +			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
>  			chdir($cwd_save) or die("chdir: $!");
>  		}
>  		if ($hook_error) {
> -			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
> -				       "%s\n" .
> -				       "warning: no patches were sent\n"), $fn, $hook_error);
> +			$hook_error = sprintf(__("fatal: %s: rejected by %s hook\n" .
> +						 $hook_error . "\n" .
> +						 "warning: no patches were sent\n"),
> +					      $fn, $hook_name);
> +			die $hook_error;
>  		}
>  	}
>  
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index aa0c20499ba..84d0f40d76a 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -539,7 +539,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
> @@ -558,7 +558,7 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
> -- 
> 2.33.1.1338.g20da966911a
> 
