Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E701C43217
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 00:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1772160555
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 00:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhJZA7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 20:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhJZA7h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 20:59:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA8C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 17:57:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so1176739wme.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6RIKP3mN9E8p8gZow8VApFK5K+j1MFWwFOEMNoEkeB0=;
        b=UdL+Ie/hE8YSDVHsHSzpMROifUmehXBpAuUi8VZqbcr49QfoTNuCKo+gN4QOJjJy5Q
         V4l73xcptXEZ9jI0efIjxpZUzT6JKd9Ea4BSYjEnYFrUJEGCeiduxFJC3RmQmiXPBR2v
         J4gLaesIYIyOx7Bk3sn2UBIDC86JDwVXkyxCNUfolF5usMIBgV/O+dRC0unQSpGjvWkU
         50EKlMZ2/wjt/9zL5ArPhTD30XYMT6rPq48fdm3HO6hzTVXbYAnQuBWc5h+medz9CGrD
         ePT8+AuSKxSSCbnurFHWhkGGezZcpDqqUQouVDFckmYjyIeg/uVw+wjZ+NQXet1lEypW
         mZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6RIKP3mN9E8p8gZow8VApFK5K+j1MFWwFOEMNoEkeB0=;
        b=Rdg1Evzmk51VApleZgOKgj/VAkBhgYNd98JnwFO0Ynt0GIhaQN+UYj1JAGiReG6e5w
         v1dfeRIbcTqa6MnWQjJ0RlID1OyDA5H/EE7F2ENAjyPuK8R3DFVkTf+89doYPGaNt6KP
         hTYjXfHvWVcxfjm7oxK4UC71Vaol5cqF9A2Vwxesdk3VVznPMkp7QD8yz+YVSir8o994
         VVsT+cH+NVjfhI6Cn+0SOC9LhwuRJcIp4zolLRbhURf4ZGe8d+wtN8rDOTnGnTTsTkPh
         m24b2pKARFHU+so5kiJAjN1dDY23bBdzrzdRWJ/RP9Uz2AMqo3VVKHiqzijhizq5YKVl
         ucQw==
X-Gm-Message-State: AOAM530plQ4irJpniczXbtyJtjTDofVrvihUH/mLtMQ+CaWJR2hUwrav
        U/J3zA+nOd6IxT9j+j6f/9Y+DDLArl0IIw==
X-Google-Smtp-Source: ABdhPJyBYmc6CWK13rUTdpJIBhJEoLiOwZTOIITkX9Bz3iB94PwSG7JX9Iw3GZOZhaRfM440t9VLhg==
X-Received: by 2002:a05:600c:3508:: with SMTP id h8mr53953553wmq.122.1635209831945;
        Mon, 25 Oct 2021 17:57:11 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f10sm19218250wri.84.2021.10.25.17.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:57:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfAm7-001jX1-1w;
        Tue, 26 Oct 2021 02:57:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     git@vger.kernel.org, carenas@gmail.com, gitster@pobox.com,
        bagasdotme@gmail.com
Subject: Re: [PATCH v8 0/2] send-email: shell completion improvements
Date:   Tue, 26 Oct 2021 02:48:02 +0200
References: <87fst7lkjx.fsf@evledraar.gmail.com>
 <20211025212707.188151-1-tbperrotta@gmail.com>
 <211026.86o87c1zry.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <211026.86o87c1zry.gmgdl@evledraar.gmail.com>
Message-ID: <211026.86k0i01u3c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Oct 25 2021, Thiago Perrotta wrote:
>
>>> ...I think that re-indentation is better left alone for the patch
>>> readability.
>>
>> Reverted the `GetOptions` indentation. Noise is now gone :-)
>
> Thanks.
>
>>> First, in your 1/3 you're adding a \n, but in 2/3 we end up with \n\n. I
>>> think you can just skip 1/3, maybe mention "how it also has a "\n" in
>>> the commit message.
>>
>> I don't quite see how this would fit into the commit message. A comment =
in the
>> code seems to fit better to account for this detail. That's what I did, =
but if
>> you still disagree, please elaborate where in the commit message this se=
ntence
>> should be added.
>
> Makes sense I think, will take a look.
>
>>> You then strip out "--" arguments from the combined list, but isn't this
>>> something we do need to emit? I.e. it's used as syntax by the bash
>>> completion isn't it? (I just skimmed the relevant C code in
>>> parse-options.c).
>>
>> I interpreted that standalone `--` as an extraneous / useless token. If =
it's
>> there intentionally, then I am reverting my stripping of it. At the end =
of the
>> day whether to include it or not is a small detail, but FYI, when I do:
>>
>>   $ git clone -<TAB>
>>
>> in bash, nothing happens. I would have expected it to be expanded to "--"
>> because of the explicit "--", but it doesn't. Therefore my conclusion is=
 that
>> "--" in the output of "--git-completion-helper" is useless. Am I missing
>> something? What would be the function of the standalone "--" then?
>>
>> From my local testing, whether the options are sorted or not, whether
>> they are repeated or not, whether they follow a specific order with
>> respect to "--" or not, all of those details seem not to matter. Bash
>> completion seems to handle all of those cases just fine interactively.
>
> Digging a bit more: It's for folding away options that are negated, not
> for completing "-<TAB>". See the examples at b221b5ab9b9 (completion:
> collapse extra --no-.. options, 2018-06-06).
>
>> In fact, here's another example:
>>
>> $ git init --git-completion-helper | tr ' ' '\n'  | grep -C1 '^--$'
>> --no-template
>> --
>> --no-bare
>>
>> ...there are --no-* options both _before_ and _after_ the --. I really
>> cannot see the point of the -- in the output, it seems to be just noise.
>
> Right, because some --no-whatever we define because we've got a
> --whatever and it's boolean, but for others we've got a --no-whatever as
> the primary, as in th case of --no-template..
>
>> I readded -- to the output anyway since you requested it, but if it
>> needs to follow a certain spec w.r.t. ordering, we should have tests for
>> it. This specific part (the -- and the --no- order thing) of the commit
>> is something I am not keen to doing though, at least not in this patch
>> series; sorry, it already goes far beyond the scope of my original
>> intent. Anything else you ask for that is inline with the original
>> intent (like generating options programatically instead of hard-coding
>> them) I am fine with though, and in fact I believe I have addressed all
>> comments so far, if there's anything else I may have missed let me know.
>
> Yeah sorry about the confusion so far, it's also been a voyage of
> discovery for me :)
>
> This time around I tested with:
>
> diff --git a/parse-options.c b/parse-options.c
> index 6e0535bdaad..d659309c5e7 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -515,8 +515,6 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
>  static void show_negated_gitcomp(const struct option *opts, int show_all,
>                                  int nr_noopts)
>  {
> -       int printed_dashdash =3D 0;
> -
>         for (; opts->type !=3D OPTION_END; opts++) {
>                 int has_unset_form =3D 0;
>                 const char *name;
> @@ -551,10 +549,6 @@ static void show_negated_gitcomp(const struct option=
 *opts, int show_all,
>                         if (nr_noopts < 0)
>                                 printf(" --%s", name);
>                 } else if (nr_noopts >=3D 0) {
> -                       if (nr_noopts && !printed_dashdash) {
> -                               printf(" --");
> -                               printed_dashdash =3D 1;
> -                       }
>                         printf(" --no-%s", opts->long_name);
>                         nr_noopts++;
>                 }
>
> Which will fail a test in t/t9902-completion.sh showing this specific
> behavior.

FWIW I came up with the below on top while testing this. I think your
patch series is fine and we should just take it as-is.

This edge case of "--no" behavior isn't something we support in any
sensible way already, so it can just be left for later.

But since I think I gave you some bad advice and WIP code (sorry!) early
on I think this is closer to a 1=3D1 mapping to parse-options.c behavior,
i.e. we split up "no" and "non-no" options, put them on either side of
the "--", but are careful to put /some/ "--no" options on the RHS.

This has at least one bug: A few options have e.g. --no-to=3D and --no-to,
so both "=3D" and "" forms.

There's also some unrelated fixes there, e.g. the existing
--dump-aliases behavior was kind of dumb for what it was trying to do,
and I changed it since it got in the way of hacking this up.

diff --git a/git-send-email.perl b/git-send-email.perl
index 04087221aa7..9d6cdf52cc3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -120,32 +120,87 @@ sub uniq {
 }
=20
 sub completion_helper {
-	my ($original_opts) =3D @_;
-	my %not_for_completion =3D (
-		"git-completion-helper" =3D> undef,
-		"h" =3D> undef,
+	my ($options, $no_opt) =3D @_;
+
+	my %fp_opt_types;
+	my (@fp_pos_opt, @fp_neg_opt);
+	my $saw_dashdash =3D 0;
+	my $fp_gch =3D Git::command('format-patch', '--git-completion-helper');
+	for my $opt (split ' ', $fp_gch) {
+		if ($opt eq '--') {
+			$saw_dashdash =3D 1;
+			next;
+		}
+		$opt =3D~ s/^--//;
+		my $str =3D $opt =3D~ s/=3D$//;
+		if ($saw_dashdash) {
+			push @fp_neg_opt =3D> $opt;
+		} else {
+			push @fp_pos_opt =3D> $opt;
+		}
+		$fp_opt_types{$opt} =3D $str ? '=3D' : '';
+	}
+
+	## Parse options according to Getopt::Long specifications. See
+	## "perldoc Getopt::Long".
+	my %se_opt_types;
+	my (@se_pos_opt, @se_neg_opt);
+	for my $item ([$options, \@se_pos_opt], [$no_opt, \@se_neg_opt]) {
+		my ($orig, $new) =3D @$item;
+		@$new =3D map {
+			my $type;
+			$type =3D '' if !$type && s/\!$//;
+			$type =3D '=3D' if !$type && s/[=3D:][sid]$//;
+			$type =3D '' if !$type; # the default
+			# We don't handle all possible Getopt::Long argument specifications
+			die "BUG: unknown argument specification for $_" if /[=3D:+]/;
+			$se_opt_types{$_} =3D $type for split /\|/;
+			split /\|/;
+		} keys %$orig;
+	}
+
+	## Sanity check that format-patch options and send-email
+	## options don't clash. We have existing conflicts, but should
+	## not be adding more.
+	my %conflicting;
+	my @conflicting =3D qw(
+		cc
+		from
+		in-reply-to
+		no-cc
+		no-thread
+		no-to
+		quiet
+		thread
+		to
 	);
-	my @send_email_opts =3D ();
-
-	foreach my $key (keys %$original_opts) {
-		unless (exists $not_for_completion{$key}) {
-			$key =3D~ s/!$//;
+	@conflicting{@conflicting} =3D ();
+	for my $opt (@fp_neg_opt, @fp_pos_opt) {
+		next unless exists $se_opt_types{$opt};
+		next if exists $conflicting{$opt};
+		warn "BUG: have a format-patch option '$opt' clashing with send-email";
+	}
=20
-			if ($key =3D~ /[:=3D][si]$/) {
-				$key =3D~ s/[:=3D][si]$//;
-				push (@send_email_opts, "--$_=3D") foreach (split (/\|/, $key));
-			} else {
-				push (@send_email_opts, "--$_") foreach (split (/\|/, $key));
-			}
-		}
+	## Sanity check that for a --no-foo we have a positive --foo
+	my @se_bool_neg_opt =3D grep { /^no-/ and $se_opt_types{$_} eq '' } keys =
%se_opt_types;
+	for my $opt (sort @se_bool_neg_opt) {
+		my $pos =3D $opt; $pos =3D~ s/^no-//;
+		next if exists $se_opt_types{$pos};
+		die "BUG: Should have a '$pos' corresponding to '$opt'";
 	}
=20
-	my @format_patch_opts =3D split(/ /, Git::command('format-patch', '--git-=
completion-helper'));
-	my @opts =3D (@send_email_opts, @format_patch_opts);
-	@opts =3D uniq (grep !/^$/, @opts);
-	# There's an implicit '\n' here already, no need to add an explicit one.
-	print "@opts";
-	exit(0);
+	my @pos_opts =3D sort(
+		map({ "--$_$fp_opt_types{$_}" } @fp_pos_opt),
+		map({ "--$_$se_opt_types{$_}" } @se_pos_opt),
+	);
+	my @neg_opts =3D sort(
+		map({ "--$_$fp_opt_types{$_}" } @fp_neg_opt),
+		map({ "--$_$se_opt_types{$_}" } @se_neg_opt),
+	);
+	my @all_opts =3D (uniq(@pos_opts), "--", uniq(@neg_opts));
+
+	print "@all_opts\n";
+	exit;
 }
=20
 # most mail servers generate the Date: header, but not all...
@@ -470,20 +525,14 @@ sub config_regexp {
     read_config(\%known_config_keys, \%configured, "sendemail");
 }
=20
-# Begin by accumulating all the variables (defined above), that we will en=
d up
-# needing, first, from the command line:
-
-my $help;
-my $git_completion_helper;
-my %dump_aliases_options =3D (
-	"h" =3D> \$help,
-	"dump-aliases" =3D> \$dump_aliases,
+my $help =3D 0;
+my $git_completion_helper =3D 0;
+my %options_no_completion =3D (
+		    "h" =3D> \$help,
+		    "git-completion-helper" =3D> \$git_completion_helper,
 );
-$rc =3D GetOptions(%dump_aliases_options);
-usage() unless $rc;
-die __("--dump-aliases incompatible with other options\n")
-    if !$help and $dump_aliases and @ARGV;
 my %options =3D (
+		    "dump-aliases" =3D> \$dump_aliases,
 		    "sender|from=3Ds" =3D> \$sender,
 		    "in-reply-to=3Ds" =3D> \$initial_in_reply_to,
 		    "reply-to=3Ds" =3D> \$reply_to,
@@ -528,9 +577,7 @@ sub config_regexp {
 		    "dry-run" =3D> \$dry_run,
 		    "envelope-sender=3Ds" =3D> \$envelope_sender,
 		    "thread!" =3D> \$thread,
-		    "no-thread" =3D> sub {$thread =3D 0},
 		    "validate!" =3D> \$validate,
-		    "no-validate" =3D> sub {$validate =3D 0},
 		    "transfer-encoding=3Ds" =3D> \$target_xfer_encoding,
 		    "format-patch!" =3D> \$format_patch,
 		    "no-format-patch" =3D> sub {$format_patch =3D 0},
@@ -538,12 +585,23 @@ sub config_regexp {
 		    "compose-encoding=3Ds" =3D> \$compose_encoding,
 		    "force" =3D> \$force,
 		    "xmailer!" =3D> \$use_xmailer,
-		    "no-xmailer" =3D> sub {$use_xmailer =3D 0},
 		    "batch-size=3Di" =3D> \$batch_size,
 		    "relogin-delay=3Di" =3D> \$relogin_delay,
-		    "git-completion-helper" =3D> \$git_completion_helper,
 );
-$rc =3D GetOptions(%options);
+# --no-* options that disable a default that's otherwise enabled by
+# default. Matters for --git-completion-helper.
+my %no_options =3D (
+		    "no-thread" =3D> sub {$thread =3D 0},
+		    "no-validate" =3D> sub {$validate =3D 0},
+		    "no-xmailer" =3D> sub {$use_xmailer =3D 0},
+);
+my @ORIG_ARGV =3D @ARGV;
+$rc =3D GetOptions(%options_no_completion, %options);
+usage() unless $rc;
+
+# Option compatibility
+die __("--dump-aliases incompatible with other options\n")
+    if $dump_aliases and @ORIG_ARGV > 1;
=20
 # Munge any "either config or getopt, not both" variables
 my @initial_to =3D @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
@@ -551,11 +609,7 @@ sub config_regexp {
 my @initial_bcc =3D @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bc=
c);
=20
 usage() if $help;
-my %all_options =3D (%options, %dump_aliases_options, %identity_options);
-completion_helper(\%all_options) if $git_completion_helper;
-unless ($rc) {
-    usage();
-}
+completion_helper({%options, %identity_options}, \%no_options) if $git_com=
pletion_helper;
=20
 if ($forbid_sendmail_variables && grep { /^sendmail/s } keys %known_config=
_keys) {
 	die __("fatal: found configuration options for 'sendmail'\n" .
