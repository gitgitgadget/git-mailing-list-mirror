Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C587BECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiIAAaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiIAAaG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A669B32D8C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w5so4092571wrn.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=GuSd5IyRy70lw70LBC+oyW8iHa8Qji6Pv61pMWXCrpM=;
        b=dFx2ehS7EP1ZJqGOxV5lfGgMgVti928+UnXMwT9EE0pd0R5K8QYoeMQ3D3bi9jA9VS
         /R+cjyL0HoxMjUl3h/dle6A7xul93GrewcBgRAN9F0E/YvnJ/Op1oZh5yW2ej9OFjKzt
         QfxIPX8rFzxX60Chu48ajas2bZTOwQtfiZSvaUVk+yMp1eTmoZpjL9MZTbYzAiQYHaOG
         1z8UO0KVFq6uvNzhxvI/L1NWNyszRM1N0JBr39dhqXYrVPpJnpdebkLIUuDgfUdj07bq
         r7dPCvMD54slao+CJahQM900eIKvkqwFZH7csqjWqXR08vuXocnEYBd1QmfuPzHZMvmc
         CaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=GuSd5IyRy70lw70LBC+oyW8iHa8Qji6Pv61pMWXCrpM=;
        b=8ELb5SeIJpFBcsTL1OdtNjDTRSK73J3ditqhkhrEH5P9i7PhyHJtOeNyzYFOdlSyHK
         FhMp+E0pvQGhbbpCS+JrVefOEWseWj9aG4IXv0PN/90OYatt0322I71q0OD/sqsyySkG
         HL+H63khDul6lrXMSCu0+2XkL+JDpj7oPcWPoexWjL0LWB67vhpJsB6wSJ7jTdktvYbW
         zYd1xEiqmoVAQQOZGF7ZdGjifRh7ybgsXBfEiQhVw3m47P9Ue6J8S6xaN/WDCmiPZ0gZ
         58W1Zzrbq9mrQaLsATJOr+O1UgMGxAXc2R1Gdq2qU7OHYTT8UNXae8enSEjDRkY4rlY1
         kE7g==
X-Gm-Message-State: ACgBeo2D2zx/+GsAXoNBWfY9HiFUVZTBTYPzVAgjRLiVwZ7MfbtY3LrL
        fDSFGQ2zXGJiaAeDA57EB04l0466Rps=
X-Google-Smtp-Source: AA6agR6QjDCSdbsGmwbMeX/MdgB8Bk1wQfqenR9Jd0mnuud/1LH9ZBhbNxr7Fo62kdaBKecJe7r5eA==
X-Received: by 2002:adf:ec49:0:b0:225:4a49:1f9f with SMTP id w9-20020adfec49000000b002254a491f9fmr13007549wrn.502.1661992202582;
        Wed, 31 Aug 2022 17:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020adfa397000000b002254b912727sm13254906wrb.26.2022.08.31.17.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:01 -0700 (PDT)
Message-Id: <a71bb11185bc5890964639b7a2ee002fde325d20.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:41 +0000
Subject: [PATCH 03/18] chainlint.pl: add POSIX shell parser
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Continue fleshing out chainlint.pl by adding a general purpose recursive
descent parser for the POSIX shell command language. Although never
invoked directly, upcoming parser subclasses will extend its
functionality for specific purposes, such as plucking test definitions
from input scripts and applying domain-specific knowledge to perform
test validation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 243 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 81ffbf28bf3..cdf136896be 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -198,6 +198,249 @@ RESTART:
 	return length($token) ? $token : undef;
 }
 
+# ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
+# is a recursive descent parser very roughly modeled after section 2.10 "Shell
+# Grammar" of POSIX chapter 2 "Shell Command Language".
+package ShellParser;
+
+sub new {
+	my ($class, $s) = @_;
+	my $self = bless {
+		buff => [],
+		stop => [],
+		output => []
+	} => $class;
+	$self->{lexer} = Lexer->new($self, $s);
+	return $self;
+}
+
+sub next_token {
+	my $self = shift @_;
+	return pop(@{$self->{buff}}) if @{$self->{buff}};
+	return $self->{lexer}->scan_token();
+}
+
+sub untoken {
+	my $self = shift @_;
+	push(@{$self->{buff}}, @_);
+}
+
+sub peek {
+	my $self = shift @_;
+	my $token = $self->next_token();
+	return undef unless defined($token);
+	$self->untoken($token);
+	return $token;
+}
+
+sub stop_at {
+	my ($self, $token) = @_;
+	return 1 unless defined($token);
+	my $stop = ${$self->{stop}}[-1] if @{$self->{stop}};
+	return defined($stop) && $token =~ $stop;
+}
+
+sub expect {
+	my ($self, $expect) = @_;
+	my $token = $self->next_token();
+	return $token if defined($token) && $token eq $expect;
+	push(@{$self->{output}}, "?!ERR?! expected '$expect' but found '" . (defined($token) ? $token : "<end-of-input>") . "'\n");
+	$self->untoken($token) if defined($token);
+	return ();
+}
+
+sub optional_newlines {
+	my $self = shift @_;
+	my @tokens;
+	while (my $token = $self->peek()) {
+		last unless $token eq "\n";
+		push(@tokens, $self->next_token());
+	}
+	return @tokens;
+}
+
+sub parse_group {
+	my $self = shift @_;
+	return ($self->parse(qr/^}$/),
+		$self->expect('}'));
+}
+
+sub parse_subshell {
+	my $self = shift @_;
+	return ($self->parse(qr/^\)$/),
+		$self->expect(')'));
+}
+
+sub parse_case_pattern {
+	my $self = shift @_;
+	my @tokens;
+	while (defined(my $token = $self->next_token())) {
+		push(@tokens, $token);
+		last if $token eq ')';
+	}
+	return @tokens;
+}
+
+sub parse_case {
+	my $self = shift @_;
+	my @tokens;
+	push(@tokens,
+	     $self->next_token(), # subject
+	     $self->optional_newlines(),
+	     $self->expect('in'),
+	     $self->optional_newlines());
+	while (1) {
+		my $token = $self->peek();
+		last unless defined($token) && $token ne 'esac';
+		push(@tokens,
+		     $self->parse_case_pattern(),
+		     $self->optional_newlines(),
+		     $self->parse(qr/^(?:;;|esac)$/)); # item body
+		$token = $self->peek();
+		last unless defined($token) && $token ne 'esac';
+		push(@tokens,
+		     $self->expect(';;'),
+		     $self->optional_newlines());
+	}
+	push(@tokens, $self->expect('esac'));
+	return @tokens;
+}
+
+sub parse_for {
+	my $self = shift @_;
+	my @tokens;
+	push(@tokens,
+	     $self->next_token(), # variable
+	     $self->optional_newlines());
+	my $token = $self->peek();
+	if (defined($token) && $token eq 'in') {
+		push(@tokens,
+		     $self->expect('in'),
+		     $self->optional_newlines());
+	}
+	push(@tokens,
+	     $self->parse(qr/^do$/), # items
+	     $self->expect('do'),
+	     $self->optional_newlines(),
+	     $self->parse_loop_body(),
+	     $self->expect('done'));
+	return @tokens;
+}
+
+sub parse_if {
+	my $self = shift @_;
+	my @tokens;
+	while (1) {
+		push(@tokens,
+		     $self->parse(qr/^then$/), # if/elif condition
+		     $self->expect('then'),
+		     $self->optional_newlines(),
+		     $self->parse(qr/^(?:elif|else|fi)$/)); # if/elif body
+		my $token = $self->peek();
+		last unless defined($token) && $token eq 'elif';
+		push(@tokens, $self->expect('elif'));
+	}
+	my $token = $self->peek();
+	if (defined($token) && $token eq 'else') {
+		push(@tokens,
+		     $self->expect('else'),
+		     $self->optional_newlines(),
+		     $self->parse(qr/^fi$/)); # else body
+	}
+	push(@tokens, $self->expect('fi'));
+	return @tokens;
+}
+
+sub parse_loop_body {
+	my $self = shift @_;
+	return $self->parse(qr/^done$/);
+}
+
+sub parse_loop {
+	my $self = shift @_;
+	return ($self->parse(qr/^do$/), # condition
+		$self->expect('do'),
+		$self->optional_newlines(),
+		$self->parse_loop_body(),
+		$self->expect('done'));
+}
+
+sub parse_func {
+	my $self = shift @_;
+	return ($self->expect('('),
+		$self->expect(')'),
+		$self->optional_newlines(),
+		$self->parse_cmd()); # body
+}
+
+sub parse_bash_array_assignment {
+	my $self = shift @_;
+	my @tokens = $self->expect('(');
+	while (defined(my $token = $self->next_token())) {
+		push(@tokens, $token);
+		last if $token eq ')';
+	}
+	return @tokens;
+}
+
+my %compound = (
+	'{' => \&parse_group,
+	'(' => \&parse_subshell,
+	'case' => \&parse_case,
+	'for' => \&parse_for,
+	'if' => \&parse_if,
+	'until' => \&parse_loop,
+	'while' => \&parse_loop);
+
+sub parse_cmd {
+	my $self = shift @_;
+	my $cmd = $self->next_token();
+	return () unless defined($cmd);
+	return $cmd if $cmd eq "\n";
+
+	my $token;
+	my @tokens = $cmd;
+	if ($cmd eq '!') {
+		push(@tokens, $self->parse_cmd());
+		return @tokens;
+	} elsif (my $f = $compound{$cmd}) {
+		push(@tokens, $self->$f());
+	} elsif (defined($token = $self->peek()) && $token eq '(') {
+		if ($cmd !~ /\w=$/) {
+			push(@tokens, $self->parse_func());
+			return @tokens;
+		}
+		$tokens[-1] .= join(' ', $self->parse_bash_array_assignment());
+	}
+
+	while (defined(my $token = $self->next_token())) {
+		$self->untoken($token), last if $self->stop_at($token);
+		push(@tokens, $token);
+		last if $token =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	}
+	push(@tokens, $self->next_token()) if $tokens[-1] ne "\n" && defined($token = $self->peek()) && $token eq "\n";
+	return @tokens;
+}
+
+sub accumulate {
+	my ($self, $tokens, $cmd) = @_;
+	push(@$tokens, @$cmd);
+}
+
+sub parse {
+	my ($self, $stop) = @_;
+	push(@{$self->{stop}}, $stop);
+	goto DONE if $self->stop_at($self->peek());
+	my @tokens;
+	while (my @cmd = $self->parse_cmd()) {
+		$self->accumulate(\@tokens, \@cmd);
+		last if $self->stop_at($self->peek());
+	}
+DONE:
+	pop(@{$self->{stop}});
+	return @tokens;
+}
+
 package ScriptParser;
 
 sub new {
-- 
gitgitgadget

