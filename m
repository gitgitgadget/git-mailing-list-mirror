Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9D3DDDBF
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559167; cv=none; b=mCkvOtz1eCE/ceqczdLJWnQ3wLhGvv9gJUaUSVhcJF3X+pldlUSnHFWZ2Gg3Eh24sF1Zrx87gflcpFaKtfb+dEV1gXcggsEsMgzCdigA0aQEerTNrpT8ckuuBRvmXmSefFEa0C9CO6TXgeewGhXEx98gAtLaxmmAgAwtExh/N+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559167; c=relaxed/simple;
	bh=nuFiibqdlOUDpjbE9Mo5n0guEMoWtI2NxDmNrEB0KLA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f1lhC8di4tExJkXstjT8OsFMV6m8m54Ld/x0Fy3Nu2inj1LI9CjnRnBKsKi3Qom3jUN1coHkmBHfMg+Gwu8qrFSGsVquAF6v8WKQucYGcV/RKORuVpC08LQOpqcPW5TPWVDZGM3Oa8N5P/bIE14c18ueoGP6CosX7ngkQioA944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpkS+s9k; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpkS+s9k"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cce87d7995so4428606d6.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559164; x=1781163964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9mOlWEht9KTVC6P2FgHy+3tdGpTyWBj1Q2b1bOK+hw=;
        b=FpkS+s9kwQklVdHMvp9clAEo4zf4l9W/YPtyzah7npUDTFJMA/pdR8KEgJhq3Tsesp
         yDGEnM9RvAXrowWuJwZb8kHWajJTTvrgUjAgGX73eQ02LCjKL+Jxew4qkWqx2ajKuys9
         Itca+/IKdroUJJUe2sqEYuYq0GQwGTPO5N68NmVsSH8oEkFksq54SRMwTzIJwTBHEwHn
         8aKhqeNuLHcQPnRjNawCQohLcaneI2YKqkZeW5JI7uZ0uLmeaqGkk7uPO4604SPPyymi
         VpuSGUjOxXZLoqLdDX+jnilka+q2n1sR0Vyz1WYlMLDcIUvwHHieEpxUv/x6G5RcUOg3
         qYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559164; x=1781163964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9mOlWEht9KTVC6P2FgHy+3tdGpTyWBj1Q2b1bOK+hw=;
        b=sq3M3xdKhWlhZlWHln31+SODx/N2yenrNseFDI/weagnC1jpbEdc4m85lzLiWsBJpu
         F6rGpxfKkknjG2NPSdn9+k5yELSCsslcy4XAyH+lmy3w3+i6upwVU3X65RJnjQ/4vsxY
         LwZvDisgIHXoLtMtOKFtErakdx6fpLam2wmyYVMKLl6lYhMIi9aM6eUdakf/aSRstgBV
         oIhaJefxakUoaMkZEG1PeH7J24yswiG0HNv5qiGB8vFK/6viTMY4UAqA5KoaCALjtHsn
         PoHTNzqpoQKDK34MwHFawGDglGXOkfufokfRO2yFAzjzf+OW/TdxF1lN5IoTEIsziCc6
         HsxQ==
X-Gm-Message-State: AOJu0YyYzQtCiQ7hBeqIvjjhAzPbKRhbj0A0tw9L7m2vdnJLF+CYKaAs
	i9z4/kZM1V8iQNsKgLj3OptQC52sQ8w9MqDNLZ6zjqYB6UaKcsoVz4NC5foifapD
X-Gm-Gg: Acq92OGG+AuZRdYWmQluEdf5KoIvUcxtdE5JxTpWc2ClaaMOnDUvTkHdaAVZcwJAzik
	cTJI3Edoah4cmMo/A1k92PS4I7xP+K8ByvEYnIy6dWqOm+cWCa4wpSZABt+dVmbQbD6ALVlnGCI
	wE0dsgDATezkT2M/5x+cKWyFYoRDg3bqB+OkNv0dTOVveDL0a38JrEvMLXx7Yu8APjsHKbHQpqW
	FGl355G9zFcHc4k210P7IApFRljQ+pqLVPdGNYXlMoolmqGVHd1kDZMPPMHfKKs9ZUaGrsTV2hb
	a1ESaL002xbwl/kUeJdqNAy+b/3cM4IiBjWNcLlW9Xu7AOY5vEakoLzUwEaKGhwAqGIWdaQMFRm
	5WwogQ0fuNO83k9pjZpW46hWTIZgBUJhJTt69NqrwcReC/auxgows4ZCeVfPbZYrz44hS04xRlU
	X+/MPKF7N751yb9Mg1WAZXiAPRhGuUspiPekSn
X-Received: by 2002:a05:6214:4283:b0:8cc:ea7f:d3c6 with SMTP id 6a1803df08f44-8cece155526mr94998286d6.43.1780559163631;
        Thu, 04 Jun 2026 00:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06e4d6sm45275436d6.36.2026.06.04.00.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:46:02 -0700 (PDT)
Message-Id: <a1069efa8fafe17b88f701168e7fe7c4ac663304.1780559158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 07:45:54 +0000
Subject: [PATCH 2/6] t: extract chainlint's parser into shared module
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Move the Lexer, ShellParser, and ScriptParser packages from
chainlint.pl into t/lib-shell-parser.pl so they can be reused by
other tools.  ScriptParser's check_test() is a no-op in the shared
module; callers subclass ScriptParser and override it.

chainlint.pl defines TestParser (&&-chain detection) and
ChainlintParser (a ScriptParser subclass whose check_test runs
TestParser and formats the results).  The shared module is loaded
via do() for portability with minimal Perl installations.

A subsequent commit introduces lint-style.pl which needs the same
shell parser to properly tokenize test scripts.  Sharing the parser
avoids reimplementing heredoc handling, $(...) nesting, pipe
tracking, quoting, and test body extraction.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/chainlint.pl        | 521 ++----------------------------------------
 t/lib-shell-parser.pl | 517 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 530 insertions(+), 508 deletions(-)
 create mode 100644 t/lib-shell-parser.pl

diff --git a/t/chainlint.pl b/t/chainlint.pl
index f0598e3934..49b7cc6cb8 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -23,458 +23,10 @@ my $jobs = -1;
 my $show_stats;
 my $emit_all;
 
-# Lexer tokenizes POSIX shell scripts. It is roughly modeled after section 2.3
-# "Token Recognition" of POSIX chapter 2 "Shell Command Language". Although
-# similar to lexical analyzers for other languages, this one differs in a few
-# substantial ways due to quirks of the shell command language.
-#
-# For instance, in many languages, newline is just whitespace like space or
-# TAB, but in shell a newline is a command separator, thus a distinct lexical
-# token. A newline is significant and returned as a distinct token even at the
-# end of a shell comment.
-#
-# In other languages, `1+2` would typically be scanned as three tokens
-# (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
-# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
-# In shell, several characters with special meaning lose that meaning when not
-# surrounded by whitespace. For instance, the negation operator `!` is special
-# when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
-# just a plain character in the longer token "foo!uucp". In many other
-# languages, `"string"/foo:'string'` might be scanned as five tokens ("string",
-# `/`, `foo`, `:`, and 'string'), but in shell, it is just a single token.
-#
-# The lexical analyzer for the shell command language is also somewhat unusual
-# in that it recursively invokes the parser to handle the body of `$(...)`
-# expressions which can contain arbitrary shell code. Such expressions may be
-# encountered both inside and outside of double-quoted strings.
-#
-# The lexical analyzer is responsible for consuming shell here-doc bodies which
-# extend from the line following a `<<TAG` operator until a line consisting
-# solely of `TAG`. Here-doc consumption begins when a newline is encountered.
-# It is legal for multiple here-doc `<<TAG` operators to be present on a single
-# line, in which case their bodies must be present one following the next, and
-# are consumed in the (left-to-right) order the `<<TAG` operators appear on the
-# line. A special complication is that the bodies of all here-docs must be
-# consumed when the newline is encountered even if the parse context depth has
-# changed. For instance, in `cat <<A && x=$(cat <<B &&\n`, bodies of here-docs
-# "A" and "B" must be consumed even though "A" was introduced outside the
-# recursive parse context in which "B" was introduced and in which the newline
-# is encountered.
-package Lexer;
-
-sub new {
-	my ($class, $parser, $s) = @_;
-	bless {
-		parser => $parser,
-		buff => $s,
-		lineno => 1,
-		heretags => []
-	} => $class;
-}
-
-sub scan_heredoc_tag {
-	my $self = shift @_;
-	${$self->{buff}} =~ /\G(-?)/gc;
-	my $indented = $1;
-	my $token = $self->scan_token();
-	return "<<$indented" unless $token;
-	my $tag = $token->[0];
-	$tag =~ s/['"\\]//g;
-	$$token[0] = $indented ? "\t$tag" : "$tag";
-	push(@{$self->{heretags}}, $token);
-	return "<<$indented$tag";
-}
-
-sub scan_op {
-	my ($self, $c) = @_;
-	my $b = $self->{buff};
-	return $c unless $$b =~ /\G(.)/sgc;
-	my $cc = $c . $1;
-	return scan_heredoc_tag($self) if $cc eq '<<';
-	return $cc if $cc =~ /^(?:&&|\|\||>>|;;|<&|>&|<>|>\|)$/;
-	pos($$b)--;
-	return $c;
-}
-
-sub scan_sqstring {
-	my $self = shift @_;
-	${$self->{buff}} =~ /\G([^']*'|.*\z)/sgc;
-	my $s = $1;
-	$self->{lineno} += () = $s =~ /\n/sg;
-	return "'" . $s;
-}
-
-sub scan_dqstring {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	my $s = '"';
-	while (1) {
-		# slurp up non-special characters
-		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
-		# handle special characters
-		last unless $$b =~ /\G(.)/sgc;
-		my $c = $1;
-		$s .= '"', last if $c eq '"';
-		$s .= '$' . $self->scan_dollar(), next if $c eq '$';
-		if ($c eq '\\') {
-			$s .= '\\', last unless $$b =~ /\G(.)/sgc;
-			$c = $1;
-			$self->{lineno}++, next if $c eq "\n"; # line splice
-			# backslash escapes only $, `, ", \ in dq-string
-			$s .= '\\' unless $c =~ /^[\$`"\\]$/;
-			$s .= $c;
-			next;
-		}
-		die("internal error scanning dq-string '$c'\n");
-	}
-	$self->{lineno} += () = $s =~ /\n/sg;
-	return $s;
-}
-
-sub scan_balanced {
-	my ($self, $c1, $c2) = @_;
-	my $b = $self->{buff};
-	my $depth = 1;
-	my $s = $c1;
-	while ($$b =~ /\G([^\Q$c1$c2\E]*(?:[\Q$c1$c2\E]|\z))/gc) {
-		$s .= $1;
-		$depth++, next if $s =~ /\Q$c1\E$/;
-		$depth--;
-		last if $depth == 0;
-	}
-	$self->{lineno} += () = $s =~ /\n/sg;
-	return $s;
-}
-
-sub scan_subst {
-	my $self = shift @_;
-	my @tokens = $self->{parser}->parse(qr/^\)$/);
-	$self->{parser}->next_token(); # closing ")"
-	return @tokens;
-}
-
-sub scan_dollar {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	return $self->scan_balanced('(', ')') if $$b =~ /\G\((?=\()/gc; # $((...))
-	return '(' . join(' ', map {$_->[0]} $self->scan_subst()) . ')' if $$b =~ /\G\(/gc; # $(...)
-	return $self->scan_balanced('{', '}') if $$b =~ /\G\{/gc; # ${...}
-	return $1 if $$b =~ /\G(\w+)/gc; # $var
-	return $1 if $$b =~ /\G([@*#?$!0-9-])/gc; # $*, $1, $$, etc.
-	return '';
-}
-
-sub swallow_heredocs {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	my $tags = $self->{heretags};
-	while (my $tag = shift @$tags) {
-		my $start = pos($$b);
-		my $indent = $$tag[0] =~ s/^\t// ? '\\s*' : '';
-		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
-		if (pos($$b) > $start) {
-			my $body = substr($$b, $start, pos($$b) - $start);
-			$self->{parser}->{heredocs}->{$$tag[0]} = {
-				content => substr($body, 0, length($body) - length($&)),
-				start_line => $self->{lineno},
-		        };
-			$self->{lineno} += () = $body =~ /\n/sg;
-			next;
-		}
-		push(@{$self->{parser}->{problems}}, ['HEREDOC', $tag]);
-		$$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
-		my $body = substr($$b, $start, pos($$b) - $start);
-		$self->{lineno} += () = $body =~ /\n/sg;
-		last;
-	}
-}
-
-sub scan_token {
-	my $self = shift @_;
-	my $b = $self->{buff};
-	my $token = '';
-	my ($start, $startln);
-RESTART:
-	$startln = $self->{lineno};
-	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
-	$start = pos($$b) || 0;
-	$self->{lineno}++, return ["\n", $start, pos($$b), $startln, $startln] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
-	while (1) {
-		# slurp up non-special characters
-		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
-		# handle special characters
-		last unless $$b =~ /\G(.)/sgc;
-		my $c = $1;
-		pos($$b)--, last if $c =~ /^[ \t]$/; # whitespace ends token
-		pos($$b)--, last if length($token) && $c =~ /^[;&|<>(){}\n]$/;
-		$token .= $self->scan_sqstring(), next if $c eq "'";
-		$token .= $self->scan_dqstring(), next if $c eq '"';
-		$token .= $c . $self->scan_dollar(), next if $c eq '$';
-		$self->{lineno}++, $self->swallow_heredocs(), $token = $c, last if $c eq "\n";
-		$token = $self->scan_op($c), last if $c =~ /^[;&|<>]$/;
-		$token = $c, last if $c =~ /^[(){}]$/;
-		if ($c eq '\\') {
-			$token .= '\\', last unless $$b =~ /\G(.)/sgc;
-			$c = $1;
-			$self->{lineno}++, next if $c eq "\n" && length($token); # line splice
-			$self->{lineno}++, goto RESTART if $c eq "\n"; # line splice
-			$token .= '\\' . $c;
-			next;
-		}
-		die("internal error scanning character '$c'\n");
-	}
-	return length($token) ? [$token, $start, pos($$b), $startln, $self->{lineno}] : undef;
-}
-
-# ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
-# is a recursive descent parser very roughly modeled after section 2.10 "Shell
-# Grammar" of POSIX chapter 2 "Shell Command Language".
-package ShellParser;
-
-sub new {
-	my ($class, $s) = @_;
-	my $self = bless {
-		buff => [],
-		stop => [],
-		output => [],
-		heredocs => {},
-		insubshell => 0,
-	} => $class;
-	$self->{lexer} = Lexer->new($self, $s);
-	return $self;
-}
-
-sub next_token {
-	my $self = shift @_;
-	return pop(@{$self->{buff}}) if @{$self->{buff}};
-	return $self->{lexer}->scan_token();
-}
-
-sub untoken {
-	my $self = shift @_;
-	push(@{$self->{buff}}, @_);
-}
-
-sub peek {
-	my $self = shift @_;
-	my $token = $self->next_token();
-	return undef unless defined($token);
-	$self->untoken($token);
-	return $token;
-}
-
-sub stop_at {
-	my ($self, $token) = @_;
-	return 1 unless defined($token);
-	my $stop = ${$self->{stop}}[-1] if @{$self->{stop}};
-	return defined($stop) && $token->[0] =~ $stop;
-}
-
-sub expect {
-	my ($self, $expect) = @_;
-	my $token = $self->next_token();
-	return $token if defined($token) && $token->[0] eq $expect;
-	push(@{$self->{output}}, "?!ERR?! expected '$expect' but found '" . (defined($token) ? $token->[0] : "<end-of-input>") . "'\n");
-	$self->untoken($token) if defined($token);
-	return ();
-}
-
-sub optional_newlines {
-	my $self = shift @_;
-	my @tokens;
-	while (my $token = $self->peek()) {
-		last unless $token->[0] eq "\n";
-		push(@tokens, $self->next_token());
-	}
-	return @tokens;
-}
-
-sub parse_group {
-	my $self = shift @_;
-	return ($self->parse(qr/^}$/),
-		$self->expect('}'));
-}
-
-sub parse_subshell {
-	my $self = shift @_;
-	$self->{insubshell}++;
-	my @tokens = ($self->parse(qr/^\)$/),
-		      $self->expect(')'));
-	$self->{insubshell}--;
-	return @tokens;
-}
-
-sub parse_case_pattern {
-	my $self = shift @_;
-	my @tokens;
-	while (defined(my $token = $self->next_token())) {
-		push(@tokens, $token);
-		last if $token->[0] eq ')';
-	}
-	return @tokens;
-}
-
-sub parse_case {
-	my $self = shift @_;
-	my @tokens;
-	push(@tokens,
-	     $self->next_token(), # subject
-	     $self->optional_newlines(),
-	     $self->expect('in'),
-	     $self->optional_newlines());
-	while (1) {
-		my $token = $self->peek();
-		last unless defined($token) && $token->[0] ne 'esac';
-		push(@tokens,
-		     $self->parse_case_pattern(),
-		     $self->optional_newlines(),
-		     $self->parse(qr/^(?:;;|esac)$/)); # item body
-		$token = $self->peek();
-		last unless defined($token) && $token->[0] ne 'esac';
-		push(@tokens,
-		     $self->expect(';;'),
-		     $self->optional_newlines());
-	}
-	push(@tokens, $self->expect('esac'));
-	return @tokens;
-}
-
-sub parse_for {
-	my $self = shift @_;
-	my @tokens;
-	push(@tokens,
-	     $self->next_token(), # variable
-	     $self->optional_newlines());
-	my $token = $self->peek();
-	if (defined($token) && $token->[0] eq 'in') {
-		push(@tokens,
-		     $self->expect('in'),
-		     $self->optional_newlines());
-	}
-	push(@tokens,
-	     $self->parse(qr/^do$/), # items
-	     $self->expect('do'),
-	     $self->optional_newlines(),
-	     $self->parse_loop_body(),
-	     $self->expect('done'));
-	return @tokens;
-}
-
-sub parse_if {
-	my $self = shift @_;
-	my @tokens;
-	while (1) {
-		push(@tokens,
-		     $self->parse(qr/^then$/), # if/elif condition
-		     $self->expect('then'),
-		     $self->optional_newlines(),
-		     $self->parse(qr/^(?:elif|else|fi)$/)); # if/elif body
-		my $token = $self->peek();
-		last unless defined($token) && $token->[0] eq 'elif';
-		push(@tokens, $self->expect('elif'));
-	}
-	my $token = $self->peek();
-	if (defined($token) && $token->[0] eq 'else') {
-		push(@tokens,
-		     $self->expect('else'),
-		     $self->optional_newlines(),
-		     $self->parse(qr/^fi$/)); # else body
-	}
-	push(@tokens, $self->expect('fi'));
-	return @tokens;
-}
-
-sub parse_loop_body {
-	my $self = shift @_;
-	return $self->parse(qr/^done$/);
-}
-
-sub parse_loop {
-	my $self = shift @_;
-	return ($self->parse(qr/^do$/), # condition
-		$self->expect('do'),
-		$self->optional_newlines(),
-		$self->parse_loop_body(),
-		$self->expect('done'));
-}
-
-sub parse_func {
-	my $self = shift @_;
-	return ($self->expect('('),
-		$self->expect(')'),
-		$self->optional_newlines(),
-		$self->parse_cmd()); # body
-}
-
-sub parse_bash_array_assignment {
-	my $self = shift @_;
-	my @tokens = $self->expect('(');
-	while (defined(my $token = $self->next_token())) {
-		push(@tokens, $token);
-		last if $token->[0] eq ')';
-	}
-	return @tokens;
-}
-
-my %compound = (
-	'{' => \&parse_group,
-	'(' => \&parse_subshell,
-	'case' => \&parse_case,
-	'for' => \&parse_for,
-	'if' => \&parse_if,
-	'until' => \&parse_loop,
-	'while' => \&parse_loop);
-
-sub parse_cmd {
-	my $self = shift @_;
-	my $cmd = $self->next_token();
-	return () unless defined($cmd);
-	return $cmd if $cmd->[0] eq "\n";
-
-	my $token;
-	my @tokens = $cmd;
-	if ($cmd->[0] eq '!') {
-		push(@tokens, $self->parse_cmd());
-		return @tokens;
-	} elsif (my $f = $compound{$cmd->[0]}) {
-		push(@tokens, $self->$f());
-	} elsif (defined($token = $self->peek()) && $token->[0] eq '(') {
-		if ($cmd->[0] !~ /\w=$/) {
-			push(@tokens, $self->parse_func());
-			return @tokens;
-		}
-		my @array = $self->parse_bash_array_assignment();
-		$tokens[-1]->[0] .= join(' ', map {$_->[0]} @array);
-		$tokens[-1]->[2] = $array[$#array][2] if @array;
-	}
-
-	while (defined(my $token = $self->next_token())) {
-		$self->untoken($token), last if $self->stop_at($token);
-		push(@tokens, $token);
-		last if $token->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
-	}
-	push(@tokens, $self->next_token()) if $tokens[-1]->[0] ne "\n" && defined($token = $self->peek()) && $token->[0] eq "\n";
-	return @tokens;
-}
-
-sub accumulate {
-	my ($self, $tokens, $cmd) = @_;
-	push(@$tokens, @$cmd);
-}
-
-sub parse {
-	my ($self, $stop) = @_;
-	push(@{$self->{stop}}, $stop);
-	goto DONE if $self->stop_at($self->peek());
-	my @tokens;
-	while (my @cmd = $self->parse_cmd()) {
-		$self->accumulate(\@tokens, \@cmd);
-		last if $self->stop_at($self->peek());
-	}
-DONE:
-	pop(@{$self->{stop}});
-	return @tokens;
-}
+use File::Basename;
+my $_lib = dirname($0) . "/lib-shell-parser.pl";
+$_lib = "./$_lib" unless $_lib =~ m{^/};
+do $_lib or die "failed to load $_lib: $@$!\n";
 
 # TestParser is a subclass of ShellParser which, beyond parsing shell script
 # code, is also imbued with semantic knowledge of test construction, and checks
@@ -484,7 +36,7 @@ DONE:
 # scripts in which the tests are defined.
 package TestParser;
 
-use base 'ShellParser';
+our @ISA = ('ShellParser');
 
 sub new {
 	my $class = shift @_;
@@ -578,14 +130,12 @@ DONE:
 	$self->SUPER::accumulate($tokens, $cmd);
 }
 
-# ScriptParser is a subclass of ShellParser which identifies individual test
-# definitions within test scripts, and passes each test body through TestParser
-# to identify possible problems. ShellParser detects test definitions not only
-# at the top-level of test scripts but also within compound commands such as
-# loops and function definitions.
-package ScriptParser;
+# ChainlintParser is a subclass of ScriptParser which checks each test
+# body for broken &&-chains via TestParser, then formats and collects
+# the results.
+package ChainlintParser;
 
-use base 'ShellParser';
+our @ISA = ('ScriptParser');
 
 sub new {
 	my $class = shift @_;
@@ -595,35 +145,6 @@ sub new {
 	return $self;
 }
 
-# extract the raw content of a token, which may be a single string or a
-# composition of multiple strings and non-string character runs; for instance,
-# `"test body"` unwraps to `test body`; `word"a b"42'c d'` to `worda b42c d`
-sub unwrap {
-	my $token = (@_ ? shift @_ : $_)->[0];
-	# simple case: 'sqstring' or "dqstring"
-	return $token if $token =~ s/^'([^']*)'$/$1/;
-	return $token if $token =~ s/^"([^"]*)"$/$1/;
-
-	# composite case
-	my ($s, $q, $escaped);
-	while (1) {
-		# slurp up non-special characters
-		$s .= $1 if $token =~ /\G([^\\'"]*)/gc;
-		# handle special characters
-		last unless $token =~ /\G(.)/sgc;
-		my $c = $1;
-		$q = undef, next if defined($q) && $c eq $q;
-		$q = $c, next if !defined($q) && $c =~ /^['"]$/;
-		if ($c eq '\\') {
-			last unless $token =~ /\G(.)/sgc;
-			$c = $1;
-			$s .= '\\' if $c eq "\n"; # preserve line splice
-		}
-		$s .= $c;
-	}
-	return $s
-}
-
 sub format_problem {
 	local $_ = shift;
 	/^AMP$/ && return "missing '&&'";
@@ -635,10 +156,10 @@ sub format_problem {
 
 sub check_test {
 	my $self = shift @_;
-	my $title = unwrap(shift @_);
+	my $title = ScriptParser::unwrap(shift @_);
 	my $body = shift @_;
 	my $lineno = $body->[3];
-	$body = unwrap($body);
+	$body = ScriptParser::unwrap($body);
 	if ($body eq '-') {
 		my $herebody = shift @_;
 		$body = $herebody->{content};
@@ -673,22 +194,6 @@ sub check_test {
 	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
 }
 
-sub parse_cmd {
-	my $self = shift @_;
-	my @tokens = $self->SUPER::parse_cmd();
-	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
-	my $n = $#tokens;
-	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
-	my $herebody;
-	if ($n >= 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =~ /^<<-?(.+)$/) {
-		$herebody = $self->{heredocs}->{$1};
-		$n--;
-	}
-	$self->check_test($tokens[1], $tokens[2], $herebody) if $n == 2; # title body
-	$self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  # prereq title body
-	return @tokens;
-}
-
 # main contains high-level functionality for processing command-line switches,
 # feeding input test scripts to ScriptParser, and reporting results.
 package main;
@@ -803,7 +308,7 @@ sub check_script {
 		}
 		my $s = do { local $/; <$fh> };
 		close($fh);
-		my $parser = ScriptParser->new(\$s);
+		my $parser = ChainlintParser->new(\$s);
 		1 while $parser->parse_cmd();
 		if (@{$parser->{output}}) {
 			my $c = fd_colors(1);
diff --git a/t/lib-shell-parser.pl b/t/lib-shell-parser.pl
new file mode 100644
index 0000000000..1e521a94f8
--- /dev/null
+++ b/t/lib-shell-parser.pl
@@ -0,0 +1,517 @@
+use strict;
+use warnings;
+
+# Copyright (c) 2021-2022 Eric Sunshine <sunshine@sunshineco.com>
+#
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
+		lineno => 1,
+		heretags => []
+	} => $class;
+}
+
+sub scan_heredoc_tag {
+	my $self = shift @_;
+	${$self->{buff}} =~ /\G(-?)/gc;
+	my $indented = $1;
+	my $token = $self->scan_token();
+	return "<<$indented" unless $token;
+	my $tag = $token->[0];
+	$tag =~ s/['"\\]//g;
+	$$token[0] = $indented ? "\t$tag" : "$tag";
+	push(@{$self->{heretags}}, $token);
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
+	my $s = $1;
+	$self->{lineno} += () = $s =~ /\n/sg;
+	return "'" . $s;
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
+			$self->{lineno}++, next if $c eq "\n"; # line splice
+			# backslash escapes only $, `, ", \ in dq-string
+			$s .= '\\' unless $c =~ /^[\$`"\\]$/;
+			$s .= $c;
+			next;
+		}
+		die("internal error scanning dq-string '$c'\n");
+	}
+	$self->{lineno} += () = $s =~ /\n/sg;
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
+	$self->{lineno} += () = $s =~ /\n/sg;
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
+	return '(' . join(' ', map {$_->[0]} $self->scan_subst()) . ')' if $$b =~ /\G\(/gc; # $(...)
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
+		my $start = pos($$b);
+		my $indent = $$tag[0] =~ s/^\t// ? '\\s*' : '';
+		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
+		if (pos($$b) > $start) {
+			my $body = substr($$b, $start, pos($$b) - $start);
+			$self->{parser}->{heredocs}->{$$tag[0]} = {
+				content => substr($body, 0, length($body) - length($&)),
+				start_line => $self->{lineno},
+		        };
+			$self->{lineno} += () = $body =~ /\n/sg;
+			next;
+		}
+		push(@{$self->{parser}->{problems}}, ['HEREDOC', $tag]);
+		$$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
+		my $body = substr($$b, $start, pos($$b) - $start);
+		$self->{lineno} += () = $body =~ /\n/sg;
+		last;
+	}
+}
+
+sub scan_token {
+	my $self = shift @_;
+	my $b = $self->{buff};
+	my $token = '';
+	my ($start, $startln);
+RESTART:
+	$startln = $self->{lineno};
+	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
+	$start = pos($$b) || 0;
+	$self->{lineno}++, return ["\n", $start, pos($$b), $startln, $startln] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
+	while (1) {
+		# slurp up non-special characters
+		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
+		# handle special characters
+		last unless $$b =~ /\G(.)/sgc;
+		my $c = $1;
+		pos($$b)--, last if $c =~ /^[ \t]$/; # whitespace ends token
+		pos($$b)--, last if length($token) && $c =~ /^[;&|<>(){}\n]$/;
+		$token .= $self->scan_sqstring(), next if $c eq "'";
+		$token .= $self->scan_dqstring(), next if $c eq '"';
+		$token .= $c . $self->scan_dollar(), next if $c eq '$';
+		$self->{lineno}++, $self->swallow_heredocs(), $token = $c, last if $c eq "\n";
+		$token = $self->scan_op($c), last if $c =~ /^[;&|<>]$/;
+		$token = $c, last if $c =~ /^[(){}]$/;
+		if ($c eq '\\') {
+			$token .= '\\', last unless $$b =~ /\G(.)/sgc;
+			$c = $1;
+			$self->{lineno}++, next if $c eq "\n" && length($token); # line splice
+			$self->{lineno}++, goto RESTART if $c eq "\n"; # line splice
+			$token .= '\\' . $c;
+			next;
+		}
+		die("internal error scanning character '$c'\n");
+	}
+	return length($token) ? [$token, $start, pos($$b), $startln, $self->{lineno}] : undef;
+}
+
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
+		output => [],
+		heredocs => {},
+		insubshell => 0,
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
+	return defined($stop) && $token->[0] =~ $stop;
+}
+
+sub expect {
+	my ($self, $expect) = @_;
+	my $token = $self->next_token();
+	return $token if defined($token) && $token->[0] eq $expect;
+	push(@{$self->{output}}, "?!ERR?! expected '$expect' but found '" . (defined($token) ? $token->[0] : "<end-of-input>") . "'\n");
+	$self->untoken($token) if defined($token);
+	return ();
+}
+
+sub optional_newlines {
+	my $self = shift @_;
+	my @tokens;
+	while (my $token = $self->peek()) {
+		last unless $token->[0] eq "\n";
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
+	$self->{insubshell}++;
+	my @tokens = ($self->parse(qr/^\)$/),
+		      $self->expect(')'));
+	$self->{insubshell}--;
+	return @tokens;
+}
+
+sub parse_case_pattern {
+	my $self = shift @_;
+	my @tokens;
+	while (defined(my $token = $self->next_token())) {
+		push(@tokens, $token);
+		last if $token->[0] eq ')';
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
+		last unless defined($token) && $token->[0] ne 'esac';
+		push(@tokens,
+		     $self->parse_case_pattern(),
+		     $self->optional_newlines(),
+		     $self->parse(qr/^(?:;;|esac)$/)); # item body
+		$token = $self->peek();
+		last unless defined($token) && $token->[0] ne 'esac';
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
+	if (defined($token) && $token->[0] eq 'in') {
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
+		last unless defined($token) && $token->[0] eq 'elif';
+		push(@tokens, $self->expect('elif'));
+	}
+	my $token = $self->peek();
+	if (defined($token) && $token->[0] eq 'else') {
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
+		last if $token->[0] eq ')';
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
+	return $cmd if $cmd->[0] eq "\n";
+
+	my $token;
+	my @tokens = $cmd;
+	if ($cmd->[0] eq '!') {
+		push(@tokens, $self->parse_cmd());
+		return @tokens;
+	} elsif (my $f = $compound{$cmd->[0]}) {
+		push(@tokens, $self->$f());
+	} elsif (defined($token = $self->peek()) && $token->[0] eq '(') {
+		if ($cmd->[0] !~ /\w=$/) {
+			push(@tokens, $self->parse_func());
+			return @tokens;
+		}
+		my @array = $self->parse_bash_array_assignment();
+		$tokens[-1]->[0] .= join(' ', map {$_->[0]} @array);
+		$tokens[-1]->[2] = $array[$#array][2] if @array;
+	}
+
+	while (defined(my $token = $self->next_token())) {
+		$self->untoken($token), last if $self->stop_at($token);
+		push(@tokens, $token);
+		last if $token->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	}
+	push(@tokens, $self->next_token()) if $tokens[-1]->[0] ne "\n" && defined($token = $self->peek()) && $token->[0] eq "\n";
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
+# ScriptParser is a subclass of ShellParser which identifies individual test
+# definitions within test scripts and calls check_test() for each test body
+# found.  Callers subclass ScriptParser and override check_test() to
+# implement specific checks (e.g. chainlint checks &&-chains, lint-style
+# checks grep usage).
+package ScriptParser;
+
+our @ISA = ('ShellParser');
+
+# extract the raw content of a token, which may be a single string or a
+# composition of multiple strings and non-string character runs; for instance,
+# `"test body"` unwraps to `test body`; `word"a b"42'c d'` to `worda b42c d`
+sub unwrap {
+	my $token = (@_ ? shift @_ : $_)->[0];
+	# simple case: 'sqstring' or "dqstring"
+	return $token if $token =~ s/^'([^']*)'$/$1/;
+	return $token if $token =~ s/^"([^"]*)"$/$1/;
+
+	# composite case
+	my ($s, $q, $escaped);
+	while (1) {
+		# slurp up non-special characters
+		$s .= $1 if $token =~ /\G([^\\'"]*)/gc;
+		# handle special characters
+		last unless $token =~ /\G(.)/sgc;
+		my $c = $1;
+		$q = undef, next if defined($q) && $c eq $q;
+		$q = $c, next if !defined($q) && $c =~ /^['"]$/;
+		if ($c eq '\\') {
+			last unless $token =~ /\G(.)/sgc;
+			$c = $1;
+			$s .= '\\' if $c eq "\n"; # preserve line splice
+		}
+		$s .= $c;
+	}
+	return $s
+}
+
+sub check_test {
+	# no-op; subclasses override to implement specific checks
+}
+
+sub parse_cmd {
+	my $self = shift @_;
+	my @tokens = $self->SUPER::parse_cmd();
+	return @tokens unless @tokens && $tokens[0]->[0] =~ /^test_expect_(?:success|failure)$/;
+	my $n = $#tokens;
+	$n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	my $herebody;
+	if ($n >= 2 && $tokens[$n-1]->[0] eq '-' && $tokens[$n]->[0] =~ /^<<-?(.+)$/) {
+		$herebody = $self->{heredocs}->{$1};
+		$n--;
+	}
+	$self->check_test($tokens[1], $tokens[2], $herebody) if $n == 2; # title body
+	$self->check_test($tokens[2], $tokens[3], $herebody) if $n > 2;  # prereq title body
+	return @tokens;
+}
+
+1;
-- 
gitgitgadget

