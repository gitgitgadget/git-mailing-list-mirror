Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DF2B2D7
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390574; cv=none; b=VcfZkOAeF09OrlRULndD1uJ+pClbSBuGKyDUnV8KHYlp9cSSpQ6r7Tcrfzlb2nQOinNVXEy1Tj6IPi4EcpGjXVKinxSphi03ItcSgp/hQt0xQHTR2DMM3DRm78Buh2lDKOefunaO0g6Uvydh797aMlomc77QI8G1h8dLjIwLd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390574; c=relaxed/simple;
	bh=kG8QKn5fz9fNY4RgT83XUlSEnE1DrOhUShwN44vQDqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGxhoM4tcBLo3vNs0zfdqF4A7dbwwRVhFSbmVnARi8m9+EvZ5AD8H5CTu+2hy97sGdKC0/PKMBqvb46o9HAvAWQwTyGrQoAEehwNs9HrQ7tYIUiJDaNy/YYCnGlwt5urdOpVk+ye8nl87s+ePnIGU9kmLckZPz8zAcScGAeRopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b/54iTer; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STfjJjV1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b/54iTer";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STfjJjV1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3ECD2EC00CC;
	Mon,  6 Jul 2026 22:16:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 22:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783390571; x=1783476971; bh=Z4ADp8ln6X
	1heUBix067K2ClDFnfNv3OEXHrWn0Epmg=; b=b/54iTerNF6tcuE3uLE9lrSLgL
	XyNTM59JrrWS73oggADYDQTwpuwXrXTm1CVTlRi8NsycNlCmFFHagVWqhZ4Kn+Lh
	ccs45vzkgPSX0rsih3enG4npaZqUTP01doGMbUnI+qXWRgn1M3dhBNqR1z2/z0TB
	N58Csn7tDzzE2b80BWp+WB03x0rTGv251F+3WLuWP+vvmx+xVVNC3CmEuPqX6Y45
	VsZP0wh6EFQ1q9BLQkzpmR1WNDW0NGIL2BvFQEP/FT+3kVOZb2gnRXDT6YWd6HMe
	QewTJYiGgUicTqfUp0WIrK2L32mn0v+djJr7vUZgu/C/2kLUORiVzdVBgTtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783390571; x=1783476971; bh=Z4ADp8ln6X1heUBix067K2ClDFnfNv3OEXH
	rWn0Epmg=; b=STfjJjV1mxuY4f3b661xzho93niyfSVg+pT+WkLCfZjM/sAQsiG
	rGs+1HjxU9lmD4Ci9Dshzfiqwr9qQQySj0aQpgPMLDujQ4TFwrQ0Cl8bRyyp6drj
	X53V9c4FOr21YQYrrIoJ15lhHYd/2MTKYjhNMlGjFjxPkCZpqiRABM1NEgcfzjn/
	YdaY2pJIllemDXBf3qzYjI6dt4H/7KOqBTRlqND98XZsTizWh/qq2zZm4s5s1Fhs
	E6wW75hIGpdzABqnnuGggbQCxSX7NEqFvFwawUp/piZk0PuAVfmxoLaWLIV29QK+
	CsvqaQ/cW+JqHloqN5PWyvctUMnIG2DGnNw==
X-ME-Sender: <xms:a2FMahPEOzv36plOgrBkmgU63XABn-dMUC220S0MAPd92xRwdnieeg>
    <xme:a2FMaraF8dcRN609M20HWuQj7jZ1NnBrX9XhH2FvGJfFeaFr19A29qrkZLXLVQKD4
    9m0nvKoYcC5m7s97_Y6Yu7yumaofLVLusLf7FBZg5Q0FK7wa2-8Xw>
X-ME-Received: <xmr:a2FMatp6PTxfkiecE7uX3pWxW5SjSfEVzapZm6E6u4AiJjUpXTzqnL8AhpjC4Fy1IPS6GpBkMqqAPukStL1LFjdrn7ThhmlXIhSgqg8>
X-ME-Proxy-Cause: dmFkZTFQh5oyIMDH2kDmLkIAAKrR8Kzb/xJNGoSmu09iPJn0bTsOcJNIgHRqZltFijwltz
    aAmXOzAVwCUir1f+ta8DmU5hSaKSb3I3rv7gTVXnhJaD+fjUfP5PkWws+QXiJtSPpEiw+v
    YK3o9u/gaUHwcGVTnLBFxMGP3XetYiheB967s2/Rc2c8vpwfEkdhCtja07jEH+w2z7SnzD
    kEekf4yaDtyls9JzPxsP7WrfOz3c16lcDtdT6z/VXHa5DHZZckVyMtfgC66siBAB22+8gj
    W12tETJhmMuk7Tuy6vCkk7c4wDMzQPRyZ5Ps9DWg6FJDljtJDWBFMkBZHbwacFcI5ijqQF
    FYjnPry0TAP+oT6urPnrARfAWGtJmzT5MexHSXOrGzlMMARd3Cg+VFP/SuMFVvBkdiyOwV
    Pk/G+0Xh1GUQ5a7FxRvzzOCt/DfUM1/VvOsKBltDKCllqyXJLwhNnf49FeqxkYI6eJU9Md
    dRddYOWTj0MJmT18z2b0N34s1X4SXqXoEWUK+rdGOegCr6Wn1EDcDtIamvlbOv+zSMTrDq
    g7iPCwb1zUw8WvVNkxGpoBwt0g0HZkUyF2M+RFtbVNdPGH2XyLlmgAw2O4jA5wf7w3b7GV
    amyoI3bdnim2Op8r2FsIXjVL1aS6gxicivHbZbVFtE5MGqHbnXaQe9ChQftw
X-ME-Proxy: <xmx:a2FManauTxinngMLDAdifZjiRZSuZO4Mv612ZmkiC3ygM-zThAuFmw>
    <xmx:a2FMatTH1IPAwE3dE9w6_Q3Ym_uvq2_4_YPHNHZ8-79gQZAyGAkdow>
    <xmx:a2FMam4OI2cpXHLstWiAWzC6No0ltKRxIgyfvj38wWeX6ocx9kFRhg>
    <xmx:a2FMaqwCH4iTGjnFtEjeSOb928Y3xxf4IpNh9xsTL0xjm-2t2fR0tQ>
    <xmx:a2FMauRDbDsthoFT-bTtwtxkU9Wb6dEk2gUMBV0-GhC_MF21rWCjVX0l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 22:16:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1410-reflog.sh: avoid suppressing git's exit code in
 pipelines
In-Reply-To: <20260706205036.3453-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Tue, 7 Jul 2026 02:20:36 +0530")
References: <20260706205036.3453-1-gatlavishweshwarreddy26@gmail.com>
Date: Mon, 06 Jul 2026 19:16:09 -0700
Message-ID: <xmqqechf8ryu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> Piping git commands directly to wc -l suppresses the exit code of
> git, hiding potential failures from the test suite. Capture the
> output to a temporary file first, then count the lines separately
> to preserve the exit code.
>
> Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
> ---
>  t/t1410-reflog.sh | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index ce71f9a30a..397f94b039 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -244,8 +244,10 @@ test_expect_success 'delete' '
>  	test_tick &&
>  	git commit -m tiger C &&
>  
> -	HEAD_entry_count=$(git reflog | wc -l) &&
> -	main_entry_count=$(git reflog show main | wc -l) &&
> +	git reflog >reflog_output &&
> +	HEAD_entry_count=$(wc -l <reflog_output) &&
> +	git reflog show main >reflog_main_output &&
> +	main_entry_count=$(wc -l <reflog_main_output) &&
>  
>  	test $HEAD_entry_count = 5 &&
>  	test $main_entry_count = 5 &&

If you _know_ output from certain command must be 5 lines, would it
make more sense to use test_stdout_line_count, perhaps like

	test_stdout_line_count = 5 git reflog

or something?

> @@ -254,16 +256,23 @@ test_expect_success 'delete' '
>  	git reflog delete main@{1} &&
>  	git reflog show main > output &&
>  	test_line_count = $(($main_entry_count - 1)) output &&
> -	test $HEAD_entry_count = $(git reflog | wc -l) &&
> +	git reflog >reflog_output &&
> +	test $HEAD_entry_count = $(wc -l <reflog_output) &&
>  	! grep ox < output &&
>  
>  	main_entry_count=$(wc -l < output) &&
>  
>  	git reflog delete HEAD@{1} &&
> -	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
> -	test $main_entry_count = $(git reflog show main | wc -l) &&
> +	git reflog >reflog_output &&
> +	test $(($HEAD_entry_count -1)) = $(wc -l <reflog_output) &&
> +	git reflog show main >reflog_main_output &&
> +	test $main_entry_count = $(wc -l <reflog_main_output) &&
> +
> +
> +	git reflog >reflog_output &&
> +	HEAD_entry_count=$(wc -l <reflog_output) &&
> +
>  
> -	HEAD_entry_count=$(git reflog | wc -l) &&
>  
>  	git reflog delete main@{07.04.2005.15:15:00.-0700} &&

Can you explain the addition of these consecutive blank lines? The
same question applies to the blank lines at the end of the test in
the next hunk. I ask because formatting issues like this often
resemble unedited AI-generated code that hasn't been properly
cleaned up before submission.

>  	git reflog show main > output &&
> @@ -321,11 +330,15 @@ test_expect_success 'git reflog expire unknown reference' '
>  '
>  
>  test_expect_success 'checkout should not delete log for packed ref' '
> -	test $(git reflog main | wc -l) = 4 &&
> +	git reflog main >reflog_output &&
> +	test $(wc -l <reflog_output) = 4 &&
>  	git branch foo &&
>  	git pack-refs --all &&
>  	git checkout foo &&
> -	test $(git reflog main | wc -l) = 4
> +	git reflog main >reflog_output &&
> +	test $(wc -l <reflog_output) = 4
> +
> +
>  '
>  
>  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
