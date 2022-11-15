Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDEC4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 14:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiKOOAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiKOOAi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 09:00:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3949524F24
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668520824; bh=WR+sjlIPdVkZ10Mvd3MW4DRp6ylTTw1NUEh47+HF+CU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AYFrwTOBQwRDPK4j/6dHBn11Y5ygu90Zeny5TE3yn60SkoRtsxyd39m/IEsrNd+Rq
         hH1QxXcUVIx9CuEemsRWLLhxJx848av9TQBRveD3BXO/TIhwquDsmWSBqGJHyfWO3I
         p/3H3a8XSyWK0lsCreOP8vWQJNm6S5d2Le9aLSWDxrlIgDM6d3XmAWsfi7kE+5J5Am
         DV6+yUYbw/0g2naoUhr/U88pF2DznPo5Y6XltdprOyijcZPZuVmQoB14RwKsB4t/77
         KhG8M5fxgRIw8uWPUV+WVwRUnAiSYsaywOJg2/bipsxDoLsBz9PkNHrLOgvdH2S3KK
         +q5DqXEDA7A+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.115.3] ([213.196.213.188]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1p6j8M404L-013KVc; Tue, 15
 Nov 2022 15:00:24 +0100
Date:   Tue, 15 Nov 2022 15:00:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/1] Expose header information to git-send-email's
 sendemail-validate hook
In-Reply-To: <20221111194223.644845-2-michael.strawbridge@amd.com>
Message-ID: <36s0r4s9-n21r-pop9-o7rn-q0qrq487p831@tzk.qr>
References: <20221111194223.644845-1-michael.strawbridge@amd.com> <20221111194223.644845-2-michael.strawbridge@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T5PEDF4WYejknxuPWIDTAoa8TQu1D+HT8dUbOsQ3HEjaB85wdgw
 HX5GI2ZBj7srBG8SiZK6GvBB/8CRCdjYAu9WDjA3FbkhGD/Qs42fQsvycd0sRjKBD1L+fW8
 C5mSwGARSsyV0EAUh6oVsu4KaUJwEs5TQFFs1Eo0CuE1KWgbmfsoaqZZ2O0YQ1WV4u7jsxS
 GUmQ4Rfwd5MjNZopsDymw==
UI-OutboundReport: notjunk:1;M01:P0:/+GWSaJP/ZM=;IOTGT/Fc4lwX2s15YZb7+4CqTDY
 jg3rst42JqflSCxZNMAq6DEnA+QXVQzgxp1noTff1DQUtmtlOw9xv9nprW/EtKHuhGg5pggpW
 /Maypz75tyRU2lUsrq+c97GL8mHcZeLz0tKyx0CsY1C9+6M1V3rY+INeZVmP/R/vy8uPCZ1tX
 j5owVyEG8VvWOM+awlRbqXWa08Fco8d/LtySol/uohavKeCMYJMSV4wPMsPeUFgSCozwkfAJG
 ecoE681dgjEywAHKL/DmP2eCSnwyphCskLXKyj6L8SOFZTFU7UrP6bigCil3GtVO9Sk/vfktD
 GYNUCv03hweq2DjFGeJ2efalzJ4JCGQthh3qwLSmmlRYuGVujpbH5Q3o7e9WVaP5tugLVi+i1
 kstsEtV/D52Z/BOEFt2zJ6z+SDiz6vT51GsWThXTb+/Q46BVfNjU+g3tyJyG4+BMwiPRBZO4i
 Qq5M+rnzjskODJokGMXBwWfokBE0a+X82Zp2Ec635Hs8vM5rkvCnyPMTXEbwcZjjj2fpO2/zl
 qoSLsvYOi9W5hfgvKBiC5fsWFFTagwncw8SOjh4KWgrIsHNi8z1g0aY+AFzLq/1ziJRRzqAeC
 Wi1oIS2NWRqQYWsXogy8WzkHs9CsYQfoC9VY72wGkeJ5oML8Qhb2RS3QCWtW3CaMWtXdiToMo
 rx8mOyLVJhPOTBoNz5BZMp+tfsmnHfRw2Cj0KL6AlxLqxiSj8JcDc2oT5AUkhJssxIzKo0d7W
 Lhsvl8eotDryWita9ca1HIBYPlUI92vQ8VyglE4Q6jm1JHrWKxCLLD6ecdcfHAeXGmlWRZZ+2
 JMTHU29TXr/vgFPsC28HLgjOdslRZ9/SSiombnP4mFoD93S4+bA09zhkUyjRCqfnkzxLx/E5C
 q2vSEGz1Cey0Spx9ANjEHCkM32YstCWWYFxdF3ctHJVsrgEllGNKLzXJA7kjhEQLNiH57vHp8
 Rykd9al0ifGdifN5DDw31KRFuzk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Fri, 11 Nov 2022, Strawbridge, Michael wrote:

> To allow further flexibility in the git hook, the smtp header
> information of the email that git-send-email intends to send, is now
> passed as a 2nd argument to the sendemail-validate hook.  Docs are
> also updated.
>
> As an example, this can be useful for acting upon keywords in the
> subject or specific email addresses.

This patch seems to break t9001:

	Error: failed: t9001.9 Verify commandline
	failure: t9001.9 Verify commandline
	test_cmp expected commandline1

	+ test_cmp expected commandline1
	+ test 2 -ne 2
	+ eval diff -u "$@"
	+ diff -u expected commandline1
	--- expected	2022-11-12 01:49:23.477741140
	+0000
	+++ commandline1	2022-11-12 01:49:21.921718804
	+0000
	@@ -1,4 +1 @@
	!nobody@example.com!
	-!author@example.com!
	-!one@example.com!
	-!two@example.com!
	error: last command exited with $?=3D1
	not ok 9 - Verify commandline
	#
	#		test_cmp expected
	#		commandline1
	#

See
https://github.com/gitgitgadget/git/actions/runs/3448445848/jobs/575552950=
4#step:4:1791
for details.

If you need help with debugging this, I would like to point you to the
information I wrote up for the Git for Windows project (but it applies
here, too):
https://github.com/git-for-windows/git/wiki/Running-Git's-regression-tests=
#running-individual-tests

Ciao,
Johannes

>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  Documentation/githooks.txt |  8 +++---
>  git-send-email.perl        | 57 +++++++++++++++++++++++++-------------
>  2 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..346e536cbe 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,10 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single p=
arameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].  It takes two parame=
ters,
> +the name of a file that holds the patch and the name of a file that hol=
ds the
> +SMTP headers.  Exiting with a non-zero status causes `git send-email` t=
o abort
> +before sending any e-mails.
>
>  fsmonitor-watchman
>  ~~~~~~~~~~~~~~~~~~
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..3ce5b1aad3 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -787,14 +787,6 @@ sub is_format_patch_arg {
>
>  @files =3D handle_backup_files(@files);
>
> -if ($validate) {
> -	foreach my $f (@files) {
> -		unless (-p $f) {
> -			validate_patch($f, $target_xfer_encoding);
> -		}
> -	}
> -}
> -
>  if (@files) {
>  	unless ($quiet) {
>  		print $_,"\n" for (@files);
> @@ -1495,16 +1487,7 @@ sub file_name_is_absolute {
>  	return File::Spec::Functions::file_name_is_absolute($path);
>  }
>
> -# Prepares the email, then asks the user what to do.
> -#
> -# If the user chooses to send the email, it's sent and 1 is returned.
> -# If the user chooses not to send the email, 0 is returned.
> -# If the user decides they want to make further edits, -1 is returned a=
nd the
> -# caller is expected to call send_message again after the edits are per=
formed.
> -#
> -# If an error occurs sending the email, this just dies.
> -
> -sub send_message {
> +sub gen_header {
>  	my @recipients =3D unique_email_list(@to);
>  	@cc =3D (grep { my $cc =3D extract_valid_address_or_die($_);
>  		      not grep { $cc eq $_ || $_ =3D~ /<\Q${cc}\E>$/ } @recipients
> @@ -1546,6 +1529,22 @@ sub send_message {
>  	if (@xh) {
>  		$header .=3D join("\n", @xh) . "\n";
>  	}
> +	return $header;
> +}
> +
> +# Prepares the email, then asks the user what to do.
> +#
> +# If the user chooses to send the email, it's sent and 1 is returned.
> +# If the user chooses not to send the email, 0 is returned.
> +# If the user decides they want to make further edits, -1 is returned a=
nd the
> +# caller is expected to call send_message again after the edits are per=
formed.
> +#
> +# If an error occurs sending the email, this just dies.
> +
> +sub send_message {
> +	my @recipients =3D unique_email_list(@to);
> +
> +        my $header =3D gen_header();
>
>  	my @sendmail_parameters =3D ('-i', @recipients);
>  	my $raw_from =3D $sender;
> @@ -1955,6 +1954,15 @@ sub process_file {
>  		}
>  	}
>
> +
> +	if ($validate) {
> +		foreach my $f (@files) {
> +			unless (-p $f) {
> +				validate_patch($f, $target_xfer_encoding);
> +			}
> +		}
> +	}
> +
>  	my $message_was_sent =3D send_message();
>  	if ($message_was_sent =3D=3D -1) {
>  		do_edit($t);
> @@ -2088,11 +2096,20 @@ sub validate_patch {
>  			chdir($repo->wc_path() or $repo->repo_path())
>  				or die("chdir: $!");
>  			local $ENV{"GIT_DIR"} =3D $repo->repo_path();
> +
> +			my $header =3D gen_header();
> +
> +			require File::Temp;
> +			my ($header_filehandle, $header_filename) =3D File::Temp::tempfile(
> +                            ".gitsendemail.header.XXXXXX", DIR =3D> $re=
po->repo_path());
> +			print $header_filehandle $header;
> +
>  			my @cmd =3D ("git", "hook", "run", "--ignore-missing",
>  				    $hook_name, "--");
> -			my @cmd_msg =3D (@cmd, "<patch>");
> -			my @cmd_run =3D (@cmd, $target);
> +			my @cmd_msg =3D (@cmd, "<patch>", "<header>");
> +			my @cmd_run =3D (@cmd, $target, $header_filename);
>  			$hook_error =3D system_or_msg(\@cmd_run, undef, "@cmd_msg");
> +			unlink($header_filehandle);
>  			chdir($cwd_save) or die("chdir: $!");
>  		}
>  		if ($hook_error) {
> --
> 2.34.1
>
>
