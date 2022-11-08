Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00CAC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKHTIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKHTIi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:08:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52A10B7D
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:08:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bk15so22472920wrb.13
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEdMNo5xrErM+92B5lltAImx4U1/dLm7u8dY9DJZdmg=;
        b=CpnA9cZZ/1KW3kyjwyiIP5Cqguvx4zAgR9kHinCY7o5sUowLJiG49/lvheK58LDeK/
         L+I00gOQ5z/oyW3VNodDXG7o6ntksLPl0UTDEWELk08UhP680KYwWnm9Z78GLlkEDsgz
         nNI4UXP5uDYya5l/zbuDbK0WALgGzIwpdDQeMIs2Lslyb/gm3C2XsGMMBVoTNbWvA9R1
         QWAcg9vm9SVuk+sYXVwzBzuuMaTg6fWuAY96Z9oUgSZS/td6ncdd50S/yIrWf6EqFalH
         GXkMER2dT/9WF4QZmy44Z0gZhITO4kiMn6xEX8kZwn1IctRCsFlx9FeHBf7E+8OqDO4Z
         Yqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEdMNo5xrErM+92B5lltAImx4U1/dLm7u8dY9DJZdmg=;
        b=5SfkrgsH7DIahUaOGXpU1KhMT9snm7MYbzGAZQDcK5h4QMyUfmkEfCYofuF0nlE0RP
         7wZgCHCp4fvTiP/D14Um5hQqun8zcq6cNyJlliq5sH4MSbnzwrXDh3fjBgjKkiVFFr/U
         rUeLbcIhcLSGt1OXYIZ5tIlQKAO/M3ZHHuXhTkVhXXjwZXBO2ZKyYKOA5b9xazMb5/h9
         TN2lOIwKrLO/LsfRaD2xOisXXf/x/+GF5LA7C3lxWuZ49GTY2AVBZ5x+HIMcu0rTaeEM
         n2Ba7H+9mIIYBWIquS3C0fFXTVG6EGCA7TC/K9xdAUL7LHkwEJPE/1H4zBpKRT2BkrEw
         la/w==
X-Gm-Message-State: ACrzQf1yNhK9K1iADGuVggcSIikzG/N/+g9WnoBF0sHDjW1auVk8eMZz
        cJEbRzHbUIR+TLYHjEMpGOf8S/xa6Uk=
X-Google-Smtp-Source: AMsMyM5UGEQ3Okkt3nagpY/VB7vACGJ3t7CV8o7YEmgRnjQklORXJ1QHgeSSdfh22Dk0I0QOqvr51A==
X-Received: by 2002:a05:6000:1241:b0:236:8a38:6744 with SMTP id j1-20020a056000124100b002368a386744mr38078565wrx.270.1667934513946;
        Tue, 08 Nov 2022 11:08:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c168800b003cf47fdead5sm11851856wmn.30.2022.11.08.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:08:33 -0800 (PST)
Message-Id: <fa56128c37280ccc87f8f8f6fd586db221b13ea4.1667934510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 19:08:29 +0000
Subject: [PATCH 3/4] chainlint: latch start/end position of each token
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

When chainlint detects problems in a test, such as a broken &&-chain, it
prints out the test with "?!FOO?!" annotations inserted at each problem
location. However, rather than annotating the original test definition,
it instead dumps out a parsed token representation of the test. Since it
lacks comments, indentations, here-doc bodies, and so forth, this
tokenized representation can be difficult for the test author to digest
and relate back to the original test definition.

To address this shortcoming, an upcoming change will make it print out
an annotated copy of the original test definition rather than the
tokenized representation. In order to do so, it will need to know the
start and end positions of each token in the original test definition.
As preparation, upgrade TestParser::scan_token() to latch the start and
end position of the token being scanned, and return that information
along with the token itself. A subsequent change will take advantage of
this positional information.

In terms of implementation, TestParser::scan_token() is retrofitted to
return a tuple consisting of the token's lexeme and its start and end
positions, rather than returning just the lexeme. However, an
alternative would be to define a class which represents a token:

    package Token;

    sub new {
        my ($class, $lexeme, $start, $end) = @_;
        bless [$lexeme, $start, $end] => $class;
    }

    sub as_string {
        my $self = shift @_;
        return $self->[0];
    }

    sub compare {
        my ($x, $y) = @_;
        if (UNIVERSAL::isa($y, 'Token')) {
            return $x->[0] cmp $y->[0];
        }
        return $x->[0] cmp $y;
    }

    use overload (
        '""' => 'as_string',
        'cmp' => 'compare'
    );

The major benefit of the class-based approach is that it is entirely
non-invasive; it requires no additional changes to the rest of the
script since a Token converts automatically to a string, which is what
scan_token() historically returned.

The big downside to the Token approach, however, is that it is _slow_;
on this developer's (old) machine, it increases user-time by an
unacceptable seven seconds when scanning all test scripts in the
project. Hence, the simple tuple approach is employed instead since it
adds only a fraction of a second user-time.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 80 +++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 1f66c03c593..59aa79babc2 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -75,7 +75,9 @@ sub scan_heredoc_tag {
 	my $self = shift @_;
 	${$self->{buff}} =~ /\G(-?)/gc;
 	my $indented = $1;
-	my $tag = $self->scan_token();
+	my $token = $self->scan_token();
+	return "<<$indented" unless $token;
+	my $tag = $token->[0];
 	$tag =~ s/['"\\]//g;
 	push(@{$self->{heretags}}, $indented ? "\t$tag" : "$tag");
 	return "<<$indented$tag";
@@ -149,7 +151,7 @@ sub scan_dollar {
 	my $self = shift @_;
 	my $b = $self->{buff};
 	return $self->scan_balanced('(', ')') if $$b =~ /\G\((?=\()/gc; # $((...))
-	return '(' . join(' ', $self->scan_subst()) . ')' if $$b =~ /\G\(/gc; # $(...)
+	return '(' . join(' ', map {$_->[0]} $self->scan_subst()) . ')' if $$b =~ /\G\(/gc; # $(...)
 	return $self->scan_balanced('{', '}') if $$b =~ /\G\{/gc; # ${...}
 	return $1 if $$b =~ /\G(\w+)/gc; # $var
 	return $1 if $$b =~ /\G([@*#?$!0-9-])/gc; # $*, $1, $$, etc.
@@ -170,9 +172,11 @@ sub scan_token {
 	my $self = shift @_;
 	my $b = $self->{buff};
 	my $token = '';
+	my $start;
 RESTART:
 	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
-	return "\n" if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
+	$start = pos($$b) || 0;
+	return ["\n", $start, pos($$b)] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
 	while (1) {
 		# slurp up non-special characters
 		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
@@ -197,7 +201,7 @@ RESTART:
 		}
 		die("internal error scanning character '$c'\n");
 	}
-	return length($token) ? $token : undef;
+	return length($token) ? [$token, $start, pos($$b)] : undef;
 }
 
 # ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
@@ -239,14 +243,14 @@ sub stop_at {
 	my ($self, $token) = @_;
 	return 1 unless defined($token);
 	my $stop = ${$self->{stop}}[-1] if @{$self->{stop}};
-	return defined($stop) && $token =~ $stop;
+	return defined($stop) && $token->[0] =~ $stop;
 }
 
 sub expect {
 	my ($self, $expect) = @_;
 	my $token = $self->next_token();
-	return $token if defined($token) && $token eq $expect;
-	push(@{$self->{output}}, "?!ERR?! expected '$expect' but found '" . (defined($token) ? $token : "<end-of-input>") . "'\n");
+	return $token if defined($token) && $token->[0] eq $expect;
+	push(@{$self->{output}}, "?!ERR?! expected '$expect' but found '" . (defined($token) ? $token->[0] : "<end-of-input>") . "'\n");
 	$self->untoken($token) if defined($token);
 	return ();
 }
@@ -255,7 +259,7 @@ sub optional_newlines {
 	my $self = shift @_;
 	my @tokens;
 	while (my $token = $self->peek()) {
-		last unless $token eq "\n";
+		last unless $token->[0] eq "\n";
 		push(@tokens, $self->next_token());
 	}
 	return @tokens;
@@ -278,7 +282,7 @@ sub parse_case_pattern {
 	my @tokens;
 	while (defined(my $token = $self->next_token())) {
 		push(@tokens, $token);
-		last if $token eq ')';
+		last if $token->[0] eq ')';
 	}
 	return @tokens;
 }
@@ -293,13 +297,13 @@ sub parse_case {
 	     $self->optional_newlines());
 	while (1) {
 		my $token = $self->peek();
-		last unless defined($token) && $token ne 'esac';
+		last unless defined($token) && $token->[0] ne 'esac';
 		push(@tokens,
 		     $self->parse_case_pattern(),
 		     $self->optional_newlines(),
 		     $self->parse(qr/^(?:;;|esac)$/)); # item body
 		$token = $self->peek();
-		last unless defined($token) && $token ne 'esac';
+		last unless defined($token) && $token->[0] ne 'esac';
 		push(@tokens,
 		     $self->expect(';;'),
 		     $self->optional_newlines());
@@ -315,7 +319,7 @@ sub parse_for {
 	     $self->next_token(), # variable
 	     $self->optional_newlines());
 	my $token = $self->peek();
-	if (defined($token) && $token eq 'in') {
+	if (defined($token) && $token->[0] eq 'in') {
 		push(@tokens,
 		     $self->expect('in'),
 		     $self->optional_newlines());
@@ -339,11 +343,11 @@ sub parse_if {
 		     $self->optional_newlines(),
 		     $self->parse(qr/^(?:elif|else|fi)$/)); # if/elif body
 		my $token = $self->peek();
-		last unless defined($token) && $token eq 'elif';
+		last unless defined($token) && $token->[0] eq 'elif';
 		push(@tokens, $self->expect('elif'));
 	}
 	my $token = $self->peek();
-	if (defined($token) && $token eq 'else') {
+	if (defined($token) && $token->[0] eq 'else') {
 		push(@tokens,
 		     $self->expect('else'),
 		     $self->optional_newlines(),
@@ -380,7 +384,7 @@ sub parse_bash_array_assignment {
 	my @tokens = $self->expect('(');
 	while (defined(my $token = $self->next_token())) {
 		push(@tokens, $token);
-		last if $token eq ')';
+		last if $token->[0] eq ')';
 	}
 	return @tokens;
 }
@@ -398,29 +402,31 @@ sub parse_cmd {
 	my $self = shift @_;
 	my $cmd = $self->next_token();
 	return () unless defined($cmd);
-	return $cmd if $cmd eq "\n";
+	return $cmd if $cmd->[0] eq "\n";
 
 	my $token;
 	my @tokens = $cmd;
-	if ($cmd eq '!') {
+	if ($cmd->[0] eq '!') {
 		push(@tokens, $self->parse_cmd());
 		return @tokens;
-	} elsif (my $f = $compound{$cmd}) {
+	} elsif (my $f = $compound{$cmd->[0]}) {
 		push(@tokens, $self->$f());
-	} elsif (defined($token = $self->peek()) && $token eq '(') {
-		if ($cmd !~ /\w=$/) {
+	} elsif (defined($token = $self->peek()) && $token->[0] eq '(') {
+		if ($cmd->[0] !~ /\w=$/) {
 			push(@tokens, $self->parse_func());
 			return @tokens;
 		}
-		$tokens[-1] .= join(' ', $self->parse_bash_array_assignment());
+		my @array = $self->parse_bash_array_assignment();
+		$tokens[-1]->[0] .= join(' ', map {$_->[0]} @array);
+		$tokens[-1]->[2] = $array[$#array][2] if @array;
 	}
 
 	while (defined(my $token = $self->next_token())) {
 		$self->untoken($token), last if $self->stop_at($token);
 		push(@tokens, $token);
-		last if $token =~ /^(?:[;&\n|]|&&|\|\|)$/;
+		last if $token->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
 	}
-	push(@tokens, $self->next_token()) if $tokens[-1] ne "\n" && defined($token = $self->peek()) && $token eq "\n";
+	push(@tokens, $self->next_token()) if $tokens[-1]->[0] ne "\n" && defined($token = $self->peek()) && $token->[0] eq "\n";
 	return @tokens;
 }
 
@@ -457,7 +463,7 @@ sub find_non_nl {
 	my $tokens = shift @_;
 	my $n = shift @_;
 	$n = $#$tokens if !defined($n);
-	$n-- while $n >= 0 && $$tokens[$n] eq "\n";
+	$n-- while $n >= 0 && $$tokens[$n]->[0] eq "\n";
 	return $n;
 }
 
@@ -467,7 +473,7 @@ sub ends_with {
 	for my $needle (reverse(@$needles)) {
 		return undef if $n < 0;
 		$n = find_non_nl($tokens, $n), next if $needle eq "\n";
-		return undef if $$tokens[$n] !~ $needle;
+		return undef if $$tokens[$n]->[0] !~ $needle;
 		$n--;
 	}
 	return 1;
@@ -486,13 +492,13 @@ sub parse_loop_body {
 	my $self = shift @_;
 	my @tokens = $self->SUPER::parse_loop_body(@_);
 	# did loop signal failure via "|| return" or "|| exit"?
-	return @tokens if !@tokens || grep(/^(?:return|exit|\$\?)$/, @tokens);
+	return @tokens if !@tokens || grep {$_->[0] =~ /^(?:return|exit|\$\?)$/} @tokens;
 	# did loop upstream of a pipe signal failure via "|| echo 'impossible
 	# text'" as the final command in the loop body?
 	return @tokens if ends_with(\@tokens, [qr/^\|\|$/, "\n", qr/^echo$/, qr/^.+$/]);
 	# flag missing "return/exit" handling explicit failure in loop body
 	my $n = find_non_nl(\@tokens);
-	splice(@tokens, $n + 1, 0, '?!LOOP?!');
+	splice(@tokens, $n + 1, 0, ['?!LOOP?!', $tokens[$n]->[1], $tokens[$n]->[2]]);
 	return @tokens;
 }
 
@@ -510,7 +516,7 @@ sub accumulate {
 	goto DONE unless @$tokens;
 
 	# new command is empty line; can't yet check if previous is missing "&&"
-	goto DONE if @$cmd == 1 && $$cmd[0] eq "\n";
+	goto DONE if @$cmd == 1 && $$cmd[0]->[0] eq "\n";
 
 	# did previous command end with "&&", "|", "|| return" or similar?
 	goto DONE if match_ending($tokens, \@safe_endings);
@@ -518,20 +524,20 @@ sub accumulate {
 	# if this command handles "$?" specially, then okay for previous
 	# command to be missing "&&"
 	for my $token (@$cmd) {
-		goto DONE if $token =~ /\$\?/;
+		goto DONE if $token->[0] =~ /\$\?/;
 	}
 
 	# if this command is "false", "return 1", or "exit 1" (which signal
 	# failure explicitly), then okay for all preceding commands to be
 	# missing "&&"
-	if ($$cmd[0] =~ /^(?:false|return|exit)$/) {
-		@$tokens = grep(!/^\?!AMP\?!$/, @$tokens);
+	if ($$cmd[0]->[0] =~ /^(?:false|return|exit)$/) {
+		@$tokens = grep {$_->[0] !~ /^\?!AMP\?!$/} @$tokens;
 		goto DONE;
 	}
 
 	# flag missing "&&" at end of previous command
 	my $n = find_non_nl($tokens);
-	splice(@$tokens, $n + 1, 0, '?!AMP?!') unless $n < 0;
+	splice(@$tokens, $n + 1, 0, ['?!AMP?!', $$tokens[$n]->[1], $$tokens[$n]->[2]]) unless $n < 0;
 
 DONE:
 	$self->SUPER::accumulate($tokens, $cmd);
@@ -557,7 +563,7 @@ sub new {
 # composition of multiple strings and non-string character runs; for instance,
 # `"test body"` unwraps to `test body`; `word"a b"42'c d'` to `worda b42c d`
 sub unwrap {
-	my $token = @_ ? shift @_ : $_;
+	my $token = (@_ ? shift @_ : $_)->[0];
 	# simple case: 'sqstring' or "dqstring"
 	return $token if $token =~ s/^'([^']*)'$/$1/;
 	return $token if $token =~ s/^"([^"]*)"$/$1/;
@@ -588,9 +594,9 @@ sub check_test {
 	$self->{ntests}++;
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
-	return unless $emit_all || grep(/\?![^?]+\?!/, @tokens);
+	return unless $emit_all || grep {$_->[0] =~ /\?![^?]+\?!/} @tokens;
 	my $c = main::fd_colors(1);
-	my $checked = join(' ', @tokens);
+	my $checked = join(' ', map {$_->[0]} @tokens);
 	$checked =~ s/^\n//;
 	$checked =~ s/^ //mg;
 	$checked =~ s/ $//mg;
@@ -602,9 +608,9 @@ sub check_test {
 sub parse_cmd {
 	my $self = shift @_;
 	my @tokens = $self->SUPER::parse_cmd();
-	return @tokens unless @tokens && $tokens[0] =~ /^test_expect_(?:success|failure)$/;
+	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
 	my $n = $#tokens;
-	$n-- while $n >= 0 && $tokens[$n] =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
 	$self->check_test($tokens[1], $tokens[2]) if $n == 2; # title body
 	$self->check_test($tokens[2], $tokens[3]) if $n > 2;  # prereq title body
 	return @tokens;
-- 
gitgitgadget

