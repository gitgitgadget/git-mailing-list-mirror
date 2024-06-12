Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398FB31A67
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228979; cv=none; b=lYZa3cX84kEJ0HiD+FhK9o7XvQOQ3Z35pksDkI9qUnm7FVRJwZdjYqkJW5XCEwI2X6sW/O/LtrzgZyfquUqWiA1ro84CHZHRb+1U4pN2mcxW/tXRTleSPBgiOlo9FYHFL9Ml1W57jEihmq2axtM3BaAQ8p6sRfkByg7NxQLmYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228979; c=relaxed/simple;
	bh=bVNiZm7XC8TJ09sZlbyG/JvSl0m4tOEfv0Ivbm4CjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc7wQFsxqIngCxukqdbDcBDGEPLC2nm730Q8Fu/S2wu8b+9O7KYSpbzFCP+5kU8xwEI5BmzZi/NtefP2fcArHkS1CIFSfI0abVBpgDebjB4FKkee1wxi7799PsDy/9U48jA81eoaf9JAj0Pkj21d6X6AZFguWx0eP7B6cxwTw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=J0xZtXWN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="J0xZtXWN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b09072c9d9so2910166d6.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718228977; x=1718833777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zQ7cp+KwnmmsUlMwyyYv8Rg820JvJFjWiI+KszbexwM=;
        b=J0xZtXWNHrU4mUnlT+r+Ksbll5dTeQvfSFkWiyhMAsnkCiZey/3taD6n8/F/RUS0y9
         nMM1HjX1At03t99+c+B6CldLxAbUXIGusl462Rs0Vau4jQ0iK63KSnnLKYMSohXBXHWg
         BvD8U6nD6EJJplCYHEaLryZQbh6Fo0zI4y3dz8//RqUBnAt2D//s/KK2RJfLIJ5IV2lt
         OjMRdp+EbzldO/dY3F3UnrUuwWQB1Qkwjam/i3nYkCJJeDXwNPiZ3YptZYRTKF1YH5ry
         BoKzWHnTYsXc8QGF5iBvxWBMWMU7nPMb0CXLiT8f3WNyT+jMMx9xIvj+GJSXlmRszpxa
         vAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718228977; x=1718833777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ7cp+KwnmmsUlMwyyYv8Rg820JvJFjWiI+KszbexwM=;
        b=pgXTORB6sIasDlrq6oJNEo6dbYBVQhda7FTmh9z5DuYS+zuwSD/C8XIs2pGB1quJlw
         3/muH4IatdALKKaY/0b7MN+61jT7SI6c0cg2nHSLWfmoTi/Unpqkm+9HBoNNNHSbSXOa
         QstLFh6DbLf01R9QUh+I/iJ8R+HuCJOMoVj5wJ0N5NDPaxeIThKBMDWl3iJIg1LhEVB2
         ccP5aWPxsyOhE5A7rhfPrOvHOXC66z+Q+SKyjleUnMbaKdOA7mzsoefnGzwidFGsvJ6j
         YCtSJqs+IzUdSlUK6/Su6iO6T5gIJpiU0XOEkCdyX1kc60vpGRO27ky7WWaHXLvzA7i1
         cTYQ==
X-Gm-Message-State: AOJu0YyZdD6dAR15U9wQr5GibJ1nWsWd4l6T+ir/jP77XmJ8BEC/J3M4
	BxAZSElc9KPkCczmN17eKsPCGTbTmE8nX4U26jpQOsjzjVNaLzFrKeF7jera/Uf9N5pckQKT9XI
	A50g=
X-Google-Smtp-Source: AGHT+IEAHdaGB7voVnAr4d+T9dWoPKZO9mYN7jzu8f778fNEOiAg0shAhtlb66VcgRT0J1KzHwVSeg==
X-Received: by 2002:ad4:5aa6:0:b0:6ad:77c8:a4b9 with SMTP id 6a1803df08f44-6b2a33a9c86mr19253646d6.3.1718228976859;
        Wed, 12 Jun 2024 14:49:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5efd26bsm83666d6.136.2024.06.12.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:49:36 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:49:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] t5541: add test for rejecting a push due to packfile
 size
Message-ID: <ZmoX7qfB2eAxdMSu@nand.local>
References: <20240612115028.1169183-1-cmn@dwim.me>
 <20240612115028.1169183-4-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612115028.1169183-4-cmn@dwim.me>

On Wed, Jun 12, 2024 at 01:50:27PM +0200, Carlos Martín Nieto wrote:
> This rejection requires us to make sure we handle this kind of error
> correctly rather than throw away the report in remote-curl and end up
> with "Everything up-to-date" due to the lack of report.
>
> Signed-off-by: Carlos Martín Nieto <cmn@dwim.me>
> ---
>  t/t5546-receive-limits.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

I haven't looked at the CGI stuff to know whether or not this behavior
can be reasonably emulated without the new Python script you wrote, but
a couple of small things in the meantime...

This patch's subject line states that it is modifying script t5541, but
the patch modifies t5546. I think the latter is correct, and there is
just a typo in the subject line, but wanted to make sure I pointed it
out regardless.

More importantly, this test fails after applying through this patch, but
not 4/4. After applying the final patch, it looks like it is still
failing for me. I figure that I am probably holding it wrong, but
regardless, here is the error message I see on my machine:

--- 8< ---
+ git init /home/ttaylorr/src/git/t/trash directory.t5546-receive-limits/httpd/www/error_too_large
Initialized empty Git repository in /home/ttaylorr/src/git/t/trash directory.t5546-receive-limits/httpd/www/error_too_large/.git/
+ git -C /home/ttaylorr/src/git/t/trash directory.t5546-receive-limits/httpd/www/error_too_large config receive.maxInputSize 128
+ test-tool genrandom foo 10485760
+ git add large-file
+ test_commit large-file
+ local notick=
+ local echo=echo
+ local append=
+ local author=
+ local signoff=
+ local indir=
+ local tag=light
+ test 1 != 0
+ break
+ indir=
+ local file=large-file.t
+ test -n
+ echo large-file
+ git add -- large-file.t
+ test -z
+ test_tick
+ test -z set
+ test_tick=1112912053
+ GIT_COMMITTER_DATE=1112912053 -0700
+ GIT_AUTHOR_DATE=1112912053 -0700
+ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+ git commit -m large-file
[master 03a3078] large-file
 Author: A U Thor <author@example.com>
 2 files changed, 1 insertion(+)
 create mode 100644 large-file
 create mode 100644 large-file.t
+ git tag large-file
+ test_must_fail git push --porcelain http://127.0.0.1:5546/error_too_large HEAD:refs/tags/will-fail
+ _test_ok=
+ test_must_fail_acceptable git push --porcelain http://127.0.0.1:5546/error_too_large HEAD:refs/tags/will-fail
+ test git = env
+ return 0
+ git push --porcelain http://127.0.0.1:5546/error_too_large HEAD:refs/tags/will-fail
Enumerating objects: 8, done.
Counting objects: 100% (8/8), done.
Delta compression using up to 20 threads
Compressing objects: 100% (6/6), done.
error: RPC failed; curl 55 Send failure: Broken pipe
send-pack: unexpected disconnect while reading sideband packet
Writing objects: 100% (8/8), 10.00 MiB | 34.04 MiB/s, done.
Total 8 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
fatal: the remote end hung up unexpectedly
fatal: the remote end hung up unexpectedly
error: failed to push some refs to 'http://127.0.0.1:5546/error_too_large'
+ exit_code=1
+ test 1 -eq 0
+ test_match_signal 13 1
+ test 1 = 141
+ test 1 = 269
+ return 1
+ test 1 -gt 129
+ test 1 -eq 127
+ test 1 -eq 126
+ return 0
+ test_must_fail git -C /home/ttaylorr/src/git/t/trash directory.t5546-receive-limits/httpd/www/error_too_large rev-parse --verify refs/tags/will-fail
+ _test_ok=
+ test_must_fail_acceptable git -C /home/ttaylorr/src/git/t/trash directory.t5546-receive-limits/httpd/www/error_too_large rev-parse --verify refs/tags/will-fail
+ test git = env
+ return 0
+ git -C /home/ttaylorr/src/git/t/trash directory.t5546-receive-limits/httpd/www/error_too_large rev-parse --verify refs/tags/will-fail
fatal: Needed a single revision
+ exit_code=128
+ test 128 -eq 0
+ test_match_signal 13 128
+ test 128 = 141
+ test 128 = 269
+ return 1
+ test 128 -gt 129
+ test 128 -eq 127
+ test 128 -eq 126
+ return 0
+ cat
+ test_cmp expect actual
+ test 2 -ne 2
+ eval diff -u "$@"
+ diff -u expect actual
--- expect	2024-06-12 21:48:50.005929827 +0000
+++ actual	2024-06-12 21:48:49.677930723 +0000
@@ -1,3 +0,0 @@
-To http://127.0.0.1:5546/error_too_large
-!	HEAD:refs/tags/will-fail	[remote rejected] (unpacker error)
-Done
error: last command exited with $?=1
not ok 18 - reject too-large push over HTTP
--- >8 ---

Thanks,
Taylor
