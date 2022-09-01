Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D8ECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIAAaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIAAaE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC21D0D3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so20260253wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ZOcsp5p/DsGMowTf24vGQJhP/4vb/MNWyPi+xOhSNE4=;
        b=TszPlNen7X55y+GNhbFdf5DTjp0yAmqTcEIRT+8dZ+Vj0UIoW2ib14UYLsnETUwtVw
         sR5rHTsFRYoL1jWvEnKvudou+j8+pbglqMEn/IqL5Qq2tAla+RHdOSTw3ww2TvMqd5d6
         reuTC6vwtvIhz0ARvQ++pBdBPy0nHguYIE7xT+iQTrxeNj26OlD7fgfyz5J8x8Lil20q
         87ZCC64zbXtvGdVB6g5RIuFcrHNJAA9/hxIMrrpG40SrsO9mrhM+Gss7ODvnJ36k39EZ
         hek5D4ZJ7om8ve56HiRgygMFgt+bFoHWKGIwEAJ89H8oEYjL+0Bq3pqqyyqi0yrLUm7E
         Vw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ZOcsp5p/DsGMowTf24vGQJhP/4vb/MNWyPi+xOhSNE4=;
        b=ShzwT60Wmx+b3gYvL+mMC8ZzZcnk9FfUsVOP9LyWTZu5K3a+ZYHrmOEZQhzJ1dCO3S
         LkkJmWl/wkhR0qamxUiWgz1clBVOTZHNwkw3RFx1XszglNuEFZ8KNBWObZsbuOh/QU6q
         01fAheExFpAGnimJW5HUuBMfk+fNGHTp6dz3KUtzn/vjbJAfqtGn/S2UxKMW+e/zg9lF
         BFZY+ZrxqouWBJGx8MUAUQWdehGlnUg0Rkk1v7l3ds+Em9x63Url+3mh/jLr05FVNQOE
         f47HDHId3N3XgA9qyeHLNf6OspJTcUuDRM6WdOJ8CH3BWZ0YObdoe4LV87AYqKgkXcN7
         GYhQ==
X-Gm-Message-State: ACgBeo0dsEmg54oPqsoHbaxCNxp3OiUtgzMubZMG896497LmyZluZXfx
        EtS9dY0dWZuctSXVJJ9h+YZ5XURA/Y8=
X-Google-Smtp-Source: AA6agR6cc/GXzGnBO8DO8E/LWHncF/5rG+Qk1KrjWbNXdrhM1JU1FQ7gR9IZ/FnSJOOKupBVK3ipPg==
X-Received: by 2002:adf:ee50:0:b0:225:7508:9d88 with SMTP id w16-20020adfee50000000b0022575089d88mr13125194wro.320.1661992201025;
        Wed, 31 Aug 2022 17:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a31fd05e0fsm10048008wms.2.2022.08.31.17.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:00 -0700 (PDT)
Message-Id: <c1042b9bcd94b9ecb0bf73dfbd4334b9f30ba99a.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:40 +0000
Subject: [PATCH 02/18] chainlint.pl: add POSIX shell lexical analyzer
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

Begin fleshing out chainlint.pl by adding a lexical analyzer for the
POSIX shell command language. The sole entry point Lexer::scan_token()
returns the next token from the input. It will be called by the upcoming
shell language parser.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 177 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index e8ab95c7858..81ffbf28bf3 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -21,6 +21,183 @@ use Getopt::Long;
 my $show_stats;
 my $emit_all;
 
+# Lexer tokenizes POSIX shell scripts. It is roughly modeled after section 2.3
+# "Token Recognition" of POSIX chapter 2 "Shell Command Language". Although
+# similar to lexical analyzers for other languages, this one differs in a few
+# substantial ways due to quirks of the shell command language.
+#
+# For instance, in many languages, newline is just whitespace like space or
+# TAB, but in shell a newline is a command separator, thus a distinct lexical
+# token. A newline is significant and returned as a distinct token even at the
+# end of a shell comment.
+#
+# In other languages, `1+2` would typically be scanned as three tokens
+# (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
+# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
+# In shell, several characters with special meaning lose that meaning when not
+# surrounded by whitespace. For instance, the negation operator `!` is special
+# when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
+# just a plain character in the longer token "foo!uucp". In many other
+# languages, `"string"/foo:'string'` might be scanned as five tokens ("string",
+# `/`, `foo`, `:`, and 'string'), but in shell, it is just a single token.
+#
+# The lexical analyzer for the shell command language is also somewhat unusual
+# in that it recursively invokes the parser to handle the body of `$(...)`
+# expressions which can contain arbitrary shell code. Such expressions may be
+# encountered both inside and outside of double-quoted strings.
+#
+# The lexical analyzer is responsible for consuming shell here-doc bodies which
+# extend from the line following a `<<TAG` operator until a line consisting
+# solely of `TAG`. Here-doc consumption begins when a newline is encountered.
+# It is legal for multiple here-doc `<<TAG` operators to be present on a single
+# line, in which case their bodies must be present one following the next, and
+# are consumed in the (left-to-right) order the `<<TAG` operators appear on the
+# line. A special complication is that the bodies of all here-docs must be
+# consumed when the newline is encountered even if the parse context depth has
+# changed. For instance, in `cat <<A && x=$(cat <<B &&\n`, bodies of here-docs
+# "A" and "B" must be consumed even though "A" was introduced outside the
+# recursive parse context in which "B" was introduced and in which the newline
+# is encountered.
+package Lexer;
+
+sub new {
+	my ($class, $parser, $s) = @_;
+	bless {
+		parser => $parser,
+		buff => $s,
+		heretags => []
+	} => $class;
+}
+
+sub scan_heredoc_tag {
+	my $self = shift @_;
+	${$self->{buff}} =~ /\G(-?)/gc;
+	my $indented = $1;
+	my $tag = $self->scan_token();
+	$tag =~ s/['"\\]//g;
+	push(@{$self->{heretags}}, $indented ? "\t$tag" : "$tag");
+	return "<<$indented$tag";
+}
+
+sub scan_op {
+	my ($self, $c) = @_;
+	my $b = $self->{buff};
+	return $c unless $$b =~ /\G(.)/sgc;
+	my $cc = $c . $1;
+	return scan_heredoc_tag($self) if $cc eq '<<';
+	return $cc if $cc =~ /^(?:&&|\|\||>>|;;|<&|>&|<>|>\|)$/;
+	pos($$b)--;
+	return $c;
+}
+
+sub scan_sqstring {
+	my $self = shift @_;
+	${$self->{buff}} =~ /\G([^']*'|.*\z)/sgc;
+	return "'" . $1;
+}
+
+sub scan_dqstring {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	my $s = '"';
+	while (1) {
+		# slurp up non-special characters
+		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
+		# handle special characters
+		last unless $$b =~ /\G(.)/sgc;
+		my $c = $1;
+		$s .= '"', last if $c eq '"';
+		$s .= '$' . $self->scan_dollar(), next if $c eq '$';
+		if ($c eq '\\') {
+			$s .= '\\', last unless $$b =~ /\G(.)/sgc;
+			$c = $1;
+			next if $c eq "\n"; # line splice
+			# backslash escapes only $, `, ", \ in dq-string
+			$s .= '\\' unless $c =~ /^[\$`"\\]$/;
+			$s .= $c;
+			next;
+		}
+		die("internal error scanning dq-string '$c'\n");
+	}
+	return $s;
+}
+
+sub scan_balanced {
+	my ($self, $c1, $c2) = @_;
+	my $b = $self->{buff};
+	my $depth = 1;
+	my $s = $c1;
+	while ($$b =~ /\G([^\Q$c1$c2\E]*(?:[\Q$c1$c2\E]|\z))/gc) {
+		$s .= $1;
+		$depth++, next if $s =~ /\Q$c1\E$/;
+		$depth--;
+		last if $depth == 0;
+	}
+	return $s;
+}
+
+sub scan_subst {
+	my $self = shift @_;
+	my @tokens = $self->{parser}->parse(qr/^\)$/);
+	$self->{parser}->next_token(); # closing ")"
+	return @tokens;
+}
+
+sub scan_dollar {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	return $self->scan_balanced('(', ')') if $$b =~ /\G\((?=\()/gc; # $((...))
+	return '(' . join(' ', $self->scan_subst()) . ')' if $$b =~ /\G\(/gc; # $(...)
+	return $self->scan_balanced('{', '}') if $$b =~ /\G\{/gc; # ${...}
+	return $1 if $$b =~ /\G(\w+)/gc; # $var
+	return $1 if $$b =~ /\G([@*#?$!0-9-])/gc; # $*, $1, $$, etc.
+	return '';
+}
+
+sub swallow_heredocs {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	my $tags = $self->{heretags};
+	while (my $tag = shift @$tags) {
+		my $indent = $tag =~ s/^\t// ? '\\s*' : '';
+		$$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
+	}
+}
+
+sub scan_token {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	my $token = '';
+RESTART:
+	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
+	return "\n" if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
+	while (1) {
+		# slurp up non-special characters
+		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
+		# handle special characters
+		last unless $$b =~ /\G(.)/sgc;
+		my $c = $1;
+		last if $c =~ /^[ \t]$/; # whitespace ends token
+		pos($$b)--, last if length($token) && $c =~ /^[;&|<>(){}\n]$/;
+		$token .= $self->scan_sqstring(), next if $c eq "'";
+		$token .= $self->scan_dqstring(), next if $c eq '"';
+		$token .= $c . $self->scan_dollar(), next if $c eq '$';
+		$self->swallow_heredocs(), $token = $c, last if $c eq "\n";
+		$token = $self->scan_op($c), last if $c =~ /^[;&|<>]$/;
+		$token = $c, last if $c =~ /^[(){}]$/;
+		if ($c eq '\\') {
+			$token .= '\\', last unless $$b =~ /\G(.)/sgc;
+			$c = $1;
+			next if $c eq "\n" && length($token); # line splice
+			goto RESTART if $c eq "\n"; # line splice
+			$token .= '\\' . $c;
+			next;
+		}
+		die("internal error scanning character '$c'\n");
+	}
+	return length($token) ? $token : undef;
+}
+
 package ScriptParser;
 
 sub new {
-- 
gitgitgadget

