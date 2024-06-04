Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1438B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495520; cv=none; b=hpjRJspqMhptMGljfIq243IngCcNCXPYVbvcp+wJvR5WPziZx+cVNHcaXZmhLSvnJW5CrNHBrZ19x73SzaKT2rc7h2F+zc6RiUQmAwcOtvxfXal9nTKDGGE+FgI2FV5iXtE+I81vtyWjtqiSzUaVjZKPAqn5cx/CPJ2ZxBCf8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495520; c=relaxed/simple;
	bh=mEGJilbeU6+4HhpoN4CNd8W4er5YreUFSVnQv/8Z9Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmNO4W/brleNKtqLdM0YbH2uGpMpJ47dSh04aSQ/T8rLRNtEoUjFWRZM6eUJSTCqG28QbygPLOHNU2J/f34HKyTPvOUoNpCdIzOY2s+Tof26AO42waf1re9PTANR/77gAGjndsT/Ni88NXBiKQA/jZaLW89GzErHyzEJTC3j0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlFzPUNQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlFzPUNQ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b919d214cso2772792e87.2
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717495517; x=1718100317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=13FLGipIwr9h9jJgxmpAGAujIS9qUWr4josij+ukkVQ=;
        b=GlFzPUNQy6Yp8tks0mlAmRMeBV1Zn12v3XgwIYzlEYl4LtrvwIJrNRdbyX3tRmdXRp
         jphS3ZDD6Vj2Rr2wwZHRMdcwrm7WmD0hF+2TrubAiEYDhxxz2pE2stHQG1zWKO0hPsUy
         LdJrUZwC2HrN41m0zGIgvluMDRWIQrVrrk+N8FWfTLRaHsMHKb0exCYsdk1m6YLO7FuN
         7yKS4PDmFBW1nv/0EJSjo/PmsOJ8tt2bf3g2Z2Mdpw3WiC1UYZt+/cWPirSmI9/kqvvi
         qaygRl0fMyfP135qnCvS+tH2zPo35Z+5JAIrUl7nAFAxHOovvhlEOIn7h4ZD6AO3qEv3
         JmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495517; x=1718100317;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13FLGipIwr9h9jJgxmpAGAujIS9qUWr4josij+ukkVQ=;
        b=AM2IG7rD7qMkdiuxrRvXt+OheeNBtlhL+OPOFSxLRhOv+T5JqhdTDufx8/R6H99/Ma
         aAAwt/mKd+ZgZ7PWJuwR45SjJT6ztnmwq1Z2RMLrZGAAB326IwsnROC1ylrV/wp2LyQD
         wPB/xL4yPQfC6vf5JDWsvN5659yj3B9A8aq52H6chQE4PQHGJ6v1au6j+jXNgn70zqpi
         X1PF7QAe2WRpLNUp+mduk5ZQKXD05D9NGmxhxsYZYnbdxxziriCYWuu0v6AQAbcN4E9E
         3jDy4a9LUeyhmpyUH5buL76nO2dt3UCalBImQp0yJbksmLq3uilAmtxhLE3g7vHjh5nu
         h18Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpTNnCZEwLQvTPdZzdgnryD86+i296WaLkZgpnJc2z9Q/lxNFbq7gp9BISerEeCMGy5BPZbhi0Dn+8rd1VT0sRQRE1
X-Gm-Message-State: AOJu0YySRXXwckKgDKqqao+jt7doGHd7UpKD4sh5x1SNZWsYXPvKZFHw
	nwSuAgbzJ1PtqnuAvDCBoJ99PwrzrWRlc5C6LAdF/oefQhqjVejv
X-Google-Smtp-Source: AGHT+IEGAtSmX/KDM+KPTcFkB51FLXbBGd98gCN3kyUcdEJYMAsUuVl24HHXEc74Xfi64CPabap/LA==
X-Received: by 2002:ac2:58ed:0:b0:51d:4595:3527 with SMTP id 2adb3069b0e04-52b896d8ad9mr6642826e87.61.1717495516442;
        Tue, 04 Jun 2024 03:05:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1? ([2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35e4e29d4c9sm8348689f8f.85.2024.06.04.03.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 03:05:16 -0700 (PDT)
Message-ID: <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
Date: Tue, 4 Jun 2024 11:05:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 03/06/2024 21:38, Rubén Justo wrote:
> In 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
> 2015-08-04), t/test-terminal.perl learned to connect the child process'
> stdin to a pty.  It works well for what was intended: satisfying an
> `isatty(STDIN_FILENO)` check.
> 
> However, the fork introduced, that copies the stdin to the child
> process, does not always manage to send all the information.

I think the problem maybe to do with the use of File::Copy, not with the 
fork. The man page for the copy function says

     Note  that  passing  in  files  as  handles  instead  of  names may
     lead to loss of information on some operating systems; it is
     recommended that you use file names whenever possible.

Rather than adding a new flag to work around a bug in our script it 
might be better to try and fix the bug by using a loop that reads blocks 
of data from the source and writes them to the destination instead of 
calling copy.

Best Wishes

Phillip

> To illustrate this behaviour, we can use a function like this:
> 
>      f ()
>      {
>      	dd if=/dev/zero bs=1 count=10000 status=none |
>      	t/test-terminal.perl cat - 2>/dev/null |
>      	wc -c;
>      }
> 
> We do not obtain the expected results when executing this function
> 100 times:
> 
>      $ for i in $(seq 100); do f; done | sort | uniq -c
>           36 0
>            4 1
>           53 4095
>            7 4159
> 
> If we do the same with a version that does not redirect stdin, a version
> prior to 18d8c26930, the expected result is obtained:
> 
>      $ git checkout 18d8c26930~1
>      $ for i in $(seq 100); do f; done | sort | uniq -c
>          100 10000
> 
> In a subsequent commit, a new test is going to rely on test-terminate,
> and it does not require stdin to be connected to a terminal, but all
> piped data needs to be successfully transmitted to the child process.
> 
> To make this possible, add a new parameter "--no-stdin-pty" to allow
> disabling the stdin redirection though a pty.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   t/test-terminal.perl | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/t/test-terminal.perl b/t/test-terminal.perl
> index 3810e9bb43..85edc9e8b9 100755
> --- a/t/test-terminal.perl
> +++ b/t/test-terminal.perl
> @@ -12,10 +12,10 @@ sub start_child {
>   	if (not defined $pid) {
>   		die "fork failed: $!"
>   	} elsif ($pid == 0) {
> -		open STDIN, "<&", $in;
> +		open STDIN, "<&", $in if $in;
>   		open STDOUT, ">&", $out;
>   		open STDERR, ">&", $err;
> -		close $in;
> +		close $in if $in;
>   		close $out;
>   		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
>   	}
> @@ -78,28 +78,32 @@ sub copy_stdio {
>   }
>   
>   if ($#ARGV < 1) {
> -	die "usage: test-terminal program args";
> +	die "usage: test-terminal [--no-stdin-pty] program args";
>   }
> +my $no_stdin_pty = $ARGV[0] eq '--no-stdin-pty';
> +shift @ARGV if $no_stdin_pty;
>   $ENV{TERM} = 'vt100';
> -my $parent_in = new IO::Pty;
> +my $parent_in = $no_stdin_pty ? undef : IO::Pty->new;
>   my $parent_out = new IO::Pty;
>   my $parent_err = new IO::Pty;
> -$parent_in->set_raw();
> +$parent_in->set_raw() if $parent_in;
>   $parent_out->set_raw();
>   $parent_err->set_raw();
> -$parent_in->slave->set_raw();
> +$parent_in->slave->set_raw() if $parent_in;
>   $parent_out->slave->set_raw();
>   $parent_err->slave->set_raw();
> -my $pid = start_child(\@ARGV, $parent_in->slave, $parent_out->slave, $parent_err->slave);
> -close $parent_in->slave;
> +my $pid = start_child(\@ARGV,$parent_in ? $parent_in->slave : undef, $parent_out->slave, $parent_err->slave);
> +close $parent_in->slave if $parent_in;
>   close $parent_out->slave;
>   close $parent_err->slave;
> -my $in_pid = copy_stdin($parent_in);
> +my $in_pid = $no_stdin_pty ? 0 : copy_stdin($parent_in);
>   copy_stdio($parent_out, $parent_err);
>   my $ret = finish_child($pid);
> -# If the child process terminates before our copy_stdin() process is able to
> -# write all of its data to $parent_in, the copy_stdin() process could stall.
> -# Send SIGTERM to it to ensure it terminates.
> -kill 'TERM', $in_pid;
> -finish_child($in_pid);
> +if ($in_pid) {
> +	# If the child process terminates before our copy_stdin() process is able to
> +	# write all of its data to $parent_in, the copy_stdin() process could stall.
> +	# Send SIGTERM to it to ensure it terminates.
> +	kill 'TERM', $in_pid;
> +	finish_child($in_pid);
> +}
>   exit($ret);

