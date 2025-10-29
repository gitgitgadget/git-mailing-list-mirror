Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0872FB962
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779915; cv=none; b=unzrbMry0wFJ8PWjVp6DfM0SJk1pIWkvgFTdcdifkm1g8sw5OTR+aPUoEXt4WTvLD5hJD0alDCT5ZUS8jdg1lAFh4aYxja+4IlsKbE9OD5ch8tQioJMbMGYLIcfZvfJ59+zHFllQULL3yFFetegb8UeXXPK6W9TbE5UBupPofp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779915; c=relaxed/simple;
	bh=1pIg18FCx79KqnL5LsC6jg8n65qDZEyPtI0v30dKeMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1sDw3fbbvDAPoRqdkyTTPZ3Gufk5Q9ltOil3FsJYlPtgVXb409oYbOrGWGsskqjBrA8O4r1DkHNy8SMhAFOOHYd2GmSjBNyBFkJAlxXm5n53i53Ed+3GXJcsQ08QJvnAY+HYM8x7TQPOTqwY2N7am4lnXtJs2A3SwfiNsDrh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj5kpdQ2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj5kpdQ2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso2829104a12.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761779912; x=1762384712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kWMn+r/E+j1kH1xbcq/wBE3/xHx65pzXo/yzXrkDGKs=;
        b=hj5kpdQ2MF3YGmI4ueea2GIHnftzXGrGKW1KR2d/qd0XjAcI3C0me2DE4LuJFSQPAk
         bisNnLIFdvOKJ29i6M3ko0hX7X+8plFg2LYRxqlN8ButftrK/Pus9CcvnWvSnUlu6Q5t
         zNtxFw9diiQw1KRBYxXK/hfpVtSlKUawjvlo8yWXTdte+0L0k1GDKAQzcwqgB1V/cqfT
         lGTpuJYyHSqIZ6IEuH4/F7ynrTpWDYSsnOkiVcd35c3Zil8uftwJWKXXImqylfaK9SyY
         OhB4YnWC+pBSTvXiV6/RjmX7Qq8i7HsP0+3+FtgVc/AoHJNyjRfvvEEtnBD/6piLWvNI
         t4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761779912; x=1762384712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWMn+r/E+j1kH1xbcq/wBE3/xHx65pzXo/yzXrkDGKs=;
        b=AmlrgXe0TYSPGfPdw+Dy0/igZ/Lwla3Cr7IpyKDcA6R3kRc3329rz3qrGpxj9dnlFM
         WMhm0sKdaN5iAm27sorG7foP0a64+IWOor6ztMULwk91NGULT7FYhm/csQS2Rx2Yl/IK
         IQBCicufO8VRvTEaA5OXQgolU5Z7CWyx4QYFpZFvanK5XAk+hf78rbJM6dPAQiAJPGP2
         rouC15mndUHTajahz9tOnCZJ2GP78aCePhrHWgeOyzPPNoqUFeZ9yV0/FWFSfuKymx9v
         mmQJeBLThKMCYYbV2XtgoYsRC0Ko0MR0LvFh0vIzNC8eLqkmK48ABSH6/B282jsAG0sO
         DOhw==
X-Gm-Message-State: AOJu0Yz7eiEnPgTRmWOyG0V3EeunzBYDwgx/VJ1vBwd7GTudXpQRfIpX
	bk/yNwrE0FCixELBpcA8r19niEVOCsm/O2HZbFMvvaygihEKbQJX/yza+fzRtw==
X-Gm-Gg: ASbGncsZ5WtR52jd5+YyeqJiUCcTI2qlUEfFwObFUchHeMipXLDjBMs5gIWuj91wKMv
	1h9Wk0JGRz8Ni0D562zM0vXc+3inXfbOlEqVg6IGDmLyOKzob6vKeofQbnPvlSmfqcs37eFxnGO
	z0xYInPdQJJ1kKgnJrmTM5QVi81EKVYmbP/Tduu5k9i3jUqTLUWM2Jp/rQ0Z1D/ZRgsjLvgc8gg
	dtT3hsaLQBp3ZPJ33kUVbi6twqZt2thCubWlGbUhPGYQBA4gw8lOuVqAk7Lglyt3cFHQy5WuHOP
	6jNBehztAUkCpAbX2dHBiy76wbIOdtuk3I0nwiVt4iVGx7MmC7N9GeX6YcfKdzc7ckoyHyIvEl3
	bfpDNQe4hEas7bkLtSJ38Vqfqs4rw9gjydZH3VmdqVWEYf+JLkukdHRSr/utTbOWmxEJBlny8zz
	hR8kQpnCnqmedKgEqDH4UPgKWiUXsFPw==
X-Google-Smtp-Source: AGHT+IFLw+e0IMgYBGxATKzCRDR26lboMl1W6H2ukZUsG49zv+FsbEpuV9IRg1+7VeG1VbuCVXmz7w==
X-Received: by 2002:a05:6402:2345:b0:61a:7385:29e3 with SMTP id 4fb4d7f45d1cf-6405efd7be8mr1448185a12.18.1761779911500;
        Wed, 29 Oct 2025 16:18:31 -0700 (PDT)
Received: from localhost (62-165-236-60.pool.digikabel.hu. [62.165.236.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm13250706a12.37.2025.10.29.16.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:18:31 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:29 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUGS] Git v2.51.2 on NonStop
Message-ID: <aQKgxfZ9WQjyrhpa@szeder.dev>
References: <xmqqo6psjq2n.fsf@gitster.g>
 <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
 <aQKVByfUdYHSEcDz@szeder.dev>
 <000201dc4925$2cdbc450$86934cf0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000201dc4925$2cdbc450$86934cf0$@nexbridge.com>

On Wed, Oct 29, 2025 at 06:41:27PM -0400, rsbecker@nexbridge.com wrote:
> On October 29, 2025 6:28 PM, SZEDER Gábor wrote:
> >On Tue, Oct 28, 2025 at 01:40:42PM -0400, rsbecker@nexbridge.com wrote:
> >> I have found new defects on 2.51.2 that were not present in 2.51.1 when building
> >with OpenSSL 3.5 (probably unrelated).
> >>
> >> Many failures in t7900 resulting from the use of test_subcommand ! as seen
> >below. This is run in bash 5.0.18:
> >>
> >> + test_subcommand git gc --quiet --no-detach --skip-foreground-tasks
> >> + 0< run-no-auto.txt
> >> {"event":"child_start","sid":"20251028T172435.690328Z-H36b1c598-P7b000
> >> 02d","thread":"main","time":"2025-10-28T17:24:35.879833Z","file":"/hom
> >> e/jenkinsbuild/.jenkins/workspace/Git_Pipeline/run-command.c","line":7
> >> 40,"child_id":2,"child_class":"?","use_shell":false,"argv":["git","gc"
> >> ,"--quiet","--no-detach","--skip-foreground-tasks"]}
> >> + test_subcommand ! git gc --auto --quiet --no-detach
> >> + --skip-foreground-tasks 0< run-auto.txt
> >> test_subcommand[5]: test: argument expected
> >
> >This is a strange trace output, as it includes file descriptor redirections, but lacks the
> >trace of commands executed in test_subcommands.  This trace doesn't look like it's
> >coming from Bash.
> 
> The test_subcommand[5]: test: argument expect is coming from bash. I cannot see how
> it is coming from anywhere else. The test was run with -x but snipped. Reference to
> test_subcommand ! git... fails exactly the same way. Is there something else I can provide?

The -x trace from Bash doesn't include file descriptor redirections,
but includes the commands executed in test_subcommand, and the number
of '+' characters at the beginning of each trace line indicates the
number of subshells, so when the test is really run by Bash the trace
from a test_subcommand invocation looks like this:

  ++ test_subcommand git gc --quiet --no-detach --skip-foreground-tasks
  ++ local negate=
  ++ test git = '!'
  +++ printf '"%s",' git gc --quiet --no-detach --skip-foreground-tasks
  ++ local 'expr="git","gc","--quiet","--no-detach","--skip-foreground-tasks",'
  ++ expr='"git","gc","--quiet","--no-detach","--skip-foreground-tasks"'
  ++ test -n ''
  ++ grep '\["git","gc","--quiet","--no-detach","--skip-foreground-tasks"\]'
  {"event":"child_start","sid":"20251029T230304.507599Z-H3fb05a16-P001a33ae","thread":"main","time":"2025-10-29T23:03:04.512913Z","file":"run-command.c","line":740,"child_id":2,"child_class":"?","use_shell":false,"argv":["git","gc","--quiet","--no-detach","--skip-foreground-tasks"]}
  ++ test_subcommand '!' git gc --auto --quiet --no-detach --skip-foreground-tasks
  ++ local negate=

Since the trace you showed doesn't look like this I still doubt that
it came from Bash.

