Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B117736
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343045; cv=none; b=Z7XtBhii8trAaO0P23fnlOgfG+2mDWel9fDN8+/2wNxNZEVMurFEvQ/NiWLMqcKEXysjq/Mz60dutFQIs3QXPzLSjL+Zm5obMpcUb5EboCOI29TWaIjFaN9IrBMGe/EhRphAe4zsaZFH4MboSy+u/T2ND/pjWLRi8VgDILnHKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343045; c=relaxed/simple;
	bh=nty8/QcRJ7AJQOJCJZiwHTi7jFeXN24UVFGhAArKMmw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YIIu+Nh0G36/FWCDiutCaVugNXlv7L6nn8B9cQ8EdVjBBEGVkJGWxnEm3Sfwxl6BwfUrEYLiAK4WassSqJP1nVU5/TQnX9GK7qofKKB7BeLJe4wnbEseeMGQ4FtmDF6oGUDEKz8c/QGDGcxabx12fw3jVT36aaZIkRw7kOHWlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWWjbzDi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWWjbzDi"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6afbf5b88ecso860446d6.1
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717343043; x=1717947843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZwBGTiJPesWN/i1o69j2rKckXyAspOufdr1v3pOiZMk=;
        b=XWWjbzDi7Mvu03gK3h9N0F6PQWjFqgdB4GicbfniNPW+FMTlu4Cbwy9XG/v2OkzOJR
         0f5MmUOUCe1l6SiIXH4kMTuOQIefP0vGuE1JF1UqR9tWlppdH1OB1OsZsnAMqIJdIgLv
         8uowE8Lq6QzweKM13/poQAh0pIxljg0YtQJzMk6vfjzzluyHQ3IBzgTvlnX2DqbP7Wga
         +BGnVUywF3x+gYUwRI77pLsI8bXGL69ij6N5Yyomtf+rpfFILxcPT8r39urY51l4XbDu
         1lXUslFhibfc7uz1zsZyt3AIoKLT32wFBy6f2p/r7WTz6qheG3gGVkLs7vLdOpmXN5r5
         aweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717343043; x=1717947843;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwBGTiJPesWN/i1o69j2rKckXyAspOufdr1v3pOiZMk=;
        b=lIe/DQjwizkDGjaBAaTLCJ585Ppd4SPx9tMplEuz6DwfQvs/1weYr6ExZ6oFf8Nvsb
         yLbIsYDu13RSMqvvXRW/1dJcYS9tjFFKvlG7OezqMsDlDUOloSGTM6v4TwIa+NwOi4PU
         0hMbERdIKlrrQh8OBLqDPikvUiK7r//focTE+fxEqjAhEd2ykfqnghrD0ZoJF7x9C/An
         i3Sozc+CVwqdiXFbPoCEnUtKmq+JjL9+RgrVuDnybKI95kjuWAK1131FdlzBqjjJm7Sa
         T8eEBGhgp6V3M6MEK4uffiTLHMi7YlUTYErGW1YPoBk0l2Ftyaw9Yuj0gTIHVq0IOoRZ
         xf7A==
X-Gm-Message-State: AOJu0YwYuIXxyRl1BIKo7eMr9BzlANEkwzfdOef2UYUDHpl6oSYo6ZHS
	FiI7QoxdVdrRlR9XNTYJ+4F3wg6Wn3ej4y4C8gYPuVp58TArzWWXekVyIA==
X-Google-Smtp-Source: AGHT+IHXjqqxhBycNPkXZc1CWsDJ9C/WvpVKem7MkenKgMtyo5bbupzuH0d7eUW57gMB5V6sktBKUA==
X-Received: by 2002:a05:6214:4189:b0:6af:b99f:f2f4 with SMTP id 6a1803df08f44-6afb99ff6a0mr12297426d6.1.1717343042739;
        Sun, 02 Jun 2024 08:44:02 -0700 (PDT)
Received: from gmail.com (12.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afbf338bddsm2179056d6.25.2024.06.02.08.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:44:02 -0700 (PDT)
Message-ID: <4542d34a-8387-4c7e-aeda-52ef28f8ed8b@gmail.com>
Date: Sun, 2 Jun 2024 17:43:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 5/6] test-terminal: introduce --no-stdin-pty
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Language: en-US
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
2015-08-04), t/test-terminal.perl learned to connect the child process'
stdin to a pty.  It works well for what was intended: satisfying an
`isatty(STDIN_FILENO)` check.

However, the fork introduced in 18d8c26930, that copies the stdin to the
child process, does not always manage to transmit all the input data.

To illustrate this behavior, we can use a function like this:

    send_data ()
    {
    	dd if=/dev/zero bs=1 count=10000 status=none |
    	t/test-terminal.perl cat - 2>/dev/null |
    	wc -c;
    }

We do not obtain the expected results when executing this function
100 times:

    $ for i in $(seq 100); do send_data; done | sort | uniq -c
         36 0
          4 1
         53 4095
          7 4159

None of the executions have successfully transmitted the full data.

If we do the same with a version of t/test-terminal.perl that does not
redirect stdin, a version prior to 18d8c26930, the expected result is
obtained:

    $ git checkout 18d8c26930~1
    $ for i in $(seq 100); do send_data; done | sort | uniq -c
        100 10000

In a subsequent commit, we'll introduce a new test that depends on
t/test-terminate.perl.  This test does not require stdin to be connected
to a terminal; however, all data piped into the process must be
successfully transmitted to the child process.

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
2.45.0.97.g9fa538478d
