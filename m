Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4E13B5B7
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447118; cv=none; b=lZCMOQwMEW4X00FLuop0lY7r7oXUkmZIUH/PJp117h4QPExwWEVjeSC1WKBKB4wejFM4UJR3/mYC+wPe0Qss4vSIR0n3H6CjGGHN5r7dK+UYjVZJBhUzbxxljUItr6EIyHGO9xAyQ/izfUL3A0ZHVdRPRNkKeEcELLySJHkz8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447118; c=relaxed/simple;
	bh=7aZ27ysAPiHC/lLUvIXh/g7iOTT9uU08+KxJU0nHESw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HKzHuUmo78/MPIX5BdL+DAUwZcH39wixWGv2nkaruV7oBSNX0ISQJCZT0OUMJR8Qn3DIkiIF1pHPPVE/uJznVD/lThFzHuD1IqaQdqsxoN/5qmJUvfXwfQtpNz9rHLwHlvB5MJfCUA5pdh7b5iWooKWbmD+YxC1Bjz7crnToofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnGWYjs2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnGWYjs2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4212a3e82b6so23019955e9.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717447115; x=1718051915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lq/b1bUNfdeYcYuytQwJtXRULZtZJnBomfU6UZWsw/w=;
        b=DnGWYjs2SPHXINySeKiK+/XcpVG4pSh8Klzh1LuUVZRL9srONBVxHJcJK9QpUkM9uE
         Zj6J9O8PPdXUYKOhd+TOgRMl3wZkdHhADgWZ6yOPdOaT9f1qwzx8joD7nIyi+ja3fCZq
         LgieH1bA5Nb/Hvlk4d0c6sL31AIN3BzYyJra2i6BWLFG8MGQEKxhsqJ+uykEUHw5MeUk
         ZS4WUhroTAgCR2JfDq2U2ZLu4Ht+IgVMUkbBElBJ3S7j2cyuYRNiRF0x/4qg0iKC7q9B
         rSQ16D+gWH7vPzCJ2jTovYGUqT65E4kifD6S/FYo634alcdnwnRruGFq5RGXFR6FfcG+
         uWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447115; x=1718051915;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq/b1bUNfdeYcYuytQwJtXRULZtZJnBomfU6UZWsw/w=;
        b=Bf8pYEe887hIQF68fC2zlo40dz0OWD9p5UoxWTAmYJK1oDyLvGee72mhXxMsubUCVy
         x/swQOmv+eeG8zg9/zmFQ5+IylOAlg4pdx6oBQ1aG7BlHitPmAzVeQVP9Ewp+DMOimn1
         MWyOxFV93KQ6lH6f4jVNq5/W2FfUhkMAqboQoNWQu3m+wXhOHfJemhRLIE2sGF9EYO4b
         6Bf6Uywzaj92GeUlonOUOl1sj7KVcKIEG80om65JYzkzQiODKl/ilKZUFyZ/pQc3URTB
         FhSq8fw2SAtwr4vC9tA6wTBDJCXTHO6PeQ2RKHlEqbd2PAVV0/sSnlnMSKjwrb/VlODb
         545w==
X-Gm-Message-State: AOJu0Yz2PQjvevDiekdwKM6YqRHlPEqoDLU81PVk6Mra8aTixuH/VUIU
	5icSDkQ9cFagmu+8jbmJBtCcuYB0/Pc/LloZOaLNKXN3y2W1Tz1wdf4Zpg==
X-Google-Smtp-Source: AGHT+IEU10g+ohvxyQjbhqUl5WullrkJI+UIMgMTWrG9Hr6w6VRTLLk14KamZeA4ej4tM0QU+9Yleg==
X-Received: by 2002:a05:600c:3514:b0:421:1b8d:2df0 with SMTP id 5b1f17b1804b1-421451199famr6162915e9.7.1717447114973;
        Mon, 03 Jun 2024 13:38:34 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f57sm9782456f8f.12.2024.06.03.13.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:38:34 -0700 (PDT)
Message-ID: <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
Date: Mon, 3 Jun 2024 22:38:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Language: en-US
In-Reply-To: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
2015-08-04), t/test-terminal.perl learned to connect the child process'
stdin to a pty.  It works well for what was intended: satisfying an
`isatty(STDIN_FILENO)` check.

However, the fork introduced, that copies the stdin to the child
process, does not always manage to send all the information.

To illustrate this behaviour, we can use a function like this:

    f ()
    {
    	dd if=/dev/zero bs=1 count=10000 status=none |
    	t/test-terminal.perl cat - 2>/dev/null |
    	wc -c;
    }

We do not obtain the expected results when executing this function
100 times:

    $ for i in $(seq 100); do f; done | sort | uniq -c
         36 0
          4 1
         53 4095
          7 4159

If we do the same with a version that does not redirect stdin, a version
prior to 18d8c26930, the expected result is obtained:

    $ git checkout 18d8c26930~1
    $ for i in $(seq 100); do f; done | sort | uniq -c
        100 10000

In a subsequent commit, a new test is going to rely on test-terminate,
and it does not require stdin to be connected to a terminal, but all
piped data needs to be successfully transmitted to the child process.

To make this possible, add a new parameter "--no-stdin-pty" to allow
disabling the stdin redirection though a pty.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/test-terminal.perl | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 3810e9bb43..85edc9e8b9 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -12,10 +12,10 @@ sub start_child {
 	if (not defined $pid) {
 		die "fork failed: $!"
 	} elsif ($pid == 0) {
-		open STDIN, "<&", $in;
+		open STDIN, "<&", $in if $in;
 		open STDOUT, ">&", $out;
 		open STDERR, ">&", $err;
-		close $in;
+		close $in if $in;
 		close $out;
 		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
 	}
@@ -78,28 +78,32 @@ sub copy_stdio {
 }
 
 if ($#ARGV < 1) {
-	die "usage: test-terminal program args";
+	die "usage: test-terminal [--no-stdin-pty] program args";
 }
+my $no_stdin_pty = $ARGV[0] eq '--no-stdin-pty';
+shift @ARGV if $no_stdin_pty;
 $ENV{TERM} = 'vt100';
-my $parent_in = new IO::Pty;
+my $parent_in = $no_stdin_pty ? undef : IO::Pty->new;
 my $parent_out = new IO::Pty;
 my $parent_err = new IO::Pty;
-$parent_in->set_raw();
+$parent_in->set_raw() if $parent_in;
 $parent_out->set_raw();
 $parent_err->set_raw();
-$parent_in->slave->set_raw();
+$parent_in->slave->set_raw() if $parent_in;
 $parent_out->slave->set_raw();
 $parent_err->slave->set_raw();
-my $pid = start_child(\@ARGV, $parent_in->slave, $parent_out->slave, $parent_err->slave);
-close $parent_in->slave;
+my $pid = start_child(\@ARGV,$parent_in ? $parent_in->slave : undef, $parent_out->slave, $parent_err->slave);
+close $parent_in->slave if $parent_in;
 close $parent_out->slave;
 close $parent_err->slave;
-my $in_pid = copy_stdin($parent_in);
+my $in_pid = $no_stdin_pty ? 0 : copy_stdin($parent_in);
 copy_stdio($parent_out, $parent_err);
 my $ret = finish_child($pid);
-# If the child process terminates before our copy_stdin() process is able to
-# write all of its data to $parent_in, the copy_stdin() process could stall.
-# Send SIGTERM to it to ensure it terminates.
-kill 'TERM', $in_pid;
-finish_child($in_pid);
+if ($in_pid) {
+	# If the child process terminates before our copy_stdin() process is able to
+	# write all of its data to $parent_in, the copy_stdin() process could stall.
+	# Send SIGTERM to it to ensure it terminates.
+	kill 'TERM', $in_pid;
+	finish_child($in_pid);
+}
 exit($ret);
-- 
2.45.0.97.gb691764a17
