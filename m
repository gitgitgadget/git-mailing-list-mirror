Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613493074B0
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635821; cv=none; b=AEFgC3iUq9xrOzOCqycLxo7TKS8clBFa2BO0BDhSBRmxkQa4UbabRP4jPL6KcICLvNKuKOFY3t8aRRq0vfefCDpCJddY42QsI2ECplDsiHmkz8PNtE4eWHkUPZ5sWNxK+gin0ci71WVPdIiCj+SKhE5Cv4EsRXuTQEioKcc80Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635821; c=relaxed/simple;
	bh=JyBMc93TSHMJIuRFUJ3R6chJOfWPB9m/IuY6A70LimM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff610ZVcP0Pm43cGO0AUxoyaCUyoXmo2vrSlw7DcwHNjQVAj7JQTVsEHxhMUXtXZA/YVd8QkJxuja+aGqYn85xw6BiZxBdzFNzOjBKfR9Z2Oo7IcuOMYnEGbCWLJ9JvF9GolFoMExwRtI/K6ZdhLH4seCDxXu6RZpzbNJCWryXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxCKrqts; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxCKrqts"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e8135adfccso237084137.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751635817; x=1752240617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGR1rd39VZesJIy1ote/4Gh6fqNMmzfkPQIwu+rgvkk=;
        b=VxCKrqtsP7P9y+EBASv3B9dOa2PQbCfLpxxLsywGicqQQAv1Oytl5a6Ua6BCpxKd4e
         RzImVxR2c2/fSDvnbme36/qtJaef0IUdPUOhkOK206ev4/OXdSvmhHCe0t7mhffKdaIN
         s5ru4hvCtkKX9WqQzzMG5U/YHYj0LiYRyJi8BEqiKCjPx7jnthEB8ckCDYOAnXcnvFyB
         TqAcS9JSll0zbLvtM4J/AST4faF+AqbkqDpBIO5fDOnKgGmpk2U7OQtHfbsPgXmgCvXw
         TPWR92bvneSO3chki/O9tAsNF4dpW64lQHsCNe7zkZNU3a596G4JglXftJd724RcMOA5
         zjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751635817; x=1752240617;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGR1rd39VZesJIy1ote/4Gh6fqNMmzfkPQIwu+rgvkk=;
        b=dUGDRwVT/HJLcktzR7Wl6N/AZGfoqxaUQJmFHneiTIsqr7GM/bJftKhqJucsche6Lp
         oHLQfT7uH3woWUEpVIDUi+IeFM5gqy+qqVQASKPvzSdL4TrhLr8VqMq+0rDESE5LqznR
         oRgDsjmB+hAsVgzrW/4/pce5EZeBwIjUssy/NxH3b4GAIy75YLPn/jxco10DTrW1X7PK
         rx5iN/RNtiyA0OBCND/xst4BoBr4Zg+PbHX0PkoAodTqhwfI0PM5M0AwVJ33ZDCwzaIE
         oP9epAIMKZEKD9r6yAZJPUmlLA2hYNJwcfJSsOlmQLnc8xhB6qz6AO/6ubjtyz7AP37W
         jhEA==
X-Forwarded-Encrypted: i=1; AJvYcCV68ve+3S4SKaeCfIz/v+ShQ0qUsxN96ptLcgrQbtVVwMBlggXrmFcUXChbzDH5D+o/qNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeVJV5cca9dh2hOr5N8diF9EGgQdtDdiv5d3s/cti6rmz8t16
	6AD5WeFTy/cEGzdrmoRhmAEs/cF3xEiwZvb5bIeoYKZ3u4aINV9n9j1MfL3xYcus4qzBEsbkMFp
	UBctgR3Cqah8RKWg6b7BB81aRbnCq+5M=
X-Gm-Gg: ASbGnctsmt3af0ZDzP4r9x4kfcCsDyaqIKV4gODh03yHYsZrAoDbdC4PTKighOi5mfJ
	Gq/L183U3mEKL8ugushJDkoTnX5NYTD4bABBuRpGg8kU1WbWb/kFr8jIL2k8PwptlJJAFKr/kee
	XLphkk4a63BRYrF3grr1+50zt727+EDAGIdDNOmwgOyg==
X-Google-Smtp-Source: AGHT+IF6hMvDqjkNOUvbpk5z6I4SI0hCg+9q2RVk+rdQFd4tZgidjJ5BCh2U6Ia2nGHkizrhAPBNpJ6O6NL6OMwfiLc=
X-Received: by 2002:a05:6102:291e:b0:4e2:c6e4:ab1e with SMTP id
 ada2fe7eead31-4f2f1753968mr1162648137.7.1751635817102; Fri, 04 Jul 2025
 06:30:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jul 2025 06:30:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250703224428.GB1909836@coredump.intra.peff.net>
References: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
 <20250703153438.GA1309870@coredump.intra.peff.net> <20250703224428.GB1909836@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Jul 2025 06:30:15 -0700
X-Gm-Features: Ac12FXxfNsf4jvAxPj_rbnbVXzwdoY1hMG-BLPsYASB5exo0_9yNNGpFkD9h2vA
Message-ID: <CAOLa=ZRKMDKOFCLvcqyWKY_P7ruZSZPTfStXMnDt_eGOtY41OA@mail.gmail.com>
Subject: Re: [PATCH] setup_revisions(): turn on diffs for all-negative diff filter
To: Jeff King <peff@peff.net>, Eric Salem <ericsalem@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a7b01606391a7e09"

--000000000000a7b01606391a7e09
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, Jul 03, 2025 at 11:34:38AM -0400, Jeff King wrote:
>
>> On Wed, Jul 02, 2025 at 03:28:43PM -0500, Eric Salem wrote:
>>
>> > The git log --diff-filter documentation[1] for deleted files says:
>> >
>> > > Select only files that are Added (A), Copied (C), Deleted (D)...
>> >
>> > > Also, these upper-case letters can be downcased to exclude.
>> > > E.g. --diff-filter=ad excludes added and deleted paths.
>> >
>> > A simple test:
>> > [...]
>> > --diff-filter=D behaves as expected, but when using "d" instead, I don't
>> > get any output unless I add another option (such as --stat or
>> > --name-only).
>>
>> Looks like a bug. This used to produce the output I'd expect (i.e.,
>> commits "first" and "third", which do not have deletions), but that
>> changed in 75408ca949 (diff-filter: be more careful when looking for
>> negative bits, 2022-01-28).
>>
>> I don't have time to dig into it now, but I've cc'd the author (and left
>> your whole reproduction recipe quoted below).
>
> Argh, I forgot to add Johannes to the cc. Fortunately since then I had a
> moment to look at this, and the solution is pretty simple. So here it is
> as a patch with a test.
>
> -- >8 --
> Subject: setup_revisions(): turn on diffs for all-negative diff filter
>
> When the user gives us a diff filter like --diff-filter=D, we need to do
> a tree diff even if we're not planning to show the diff result itself,
> in order to decide whether to show the commit at all. So there's an
> explicit check of revs->diffopt.filter in setup_revisions(), and we set
> revs->diff if any bits are set.

So if `revs->diff` is set, then we compute the tree diff for the given
commit.

>
> Originally that "filter" field covered both positive capital-letter
> filters (like "D") and also negative lowercase filters (like "d"), so it
> was sufficient for both cases. But later, 75408ca949 (diff-filter: be
> more careful when looking for negative bits, 2022-01-28) split the
> negative bits out into a "filter_not" field.
>
> We eventually fold those into "filter", but not until diff_setup_done()
> is called, which happens after our explicit check. As a result, a purely
> negative filter like:
>
>   git log --diff-filter=d
>
> failed to turn on diffs at all. But rather than fail to filter by diff,
> because the filter variable is eventually set, we mistakenly show no
> commits at all, thinking that the empty diffs were cases where nothing
> passed through the filter.
>
> The smallest fix here is to just have our check look for any bits in
> either "filter" or "filter_not". I suspect it would also be OK to
> reorder the function a bit to call diff_setup_done() earlier, but that
> risks violating some other subtle ordering dependency. So I went with
> the simple and safe solution here.
>

The explanation here was really nice to read and explained the problem
well.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  revision.c     | 2 +-
>  t/t4202-log.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index afee111196..9892d08748 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3112,7 +3112,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>
>  	/* Pickaxe, diff-filter and rename following need diffs */
>  	if ((revs->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
> -	    revs->diffopt.filter ||
> +	    revs->diffopt.filter || revs->diffopt.filter_not ||
>  	    revs->diffopt.flags.follow_renames)
>  		revs->diff = 1;
>

Makes sense.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 4a6c4dfbf4..05cee9e41b 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -134,6 +134,12 @@ test_expect_success 'diff-filter=D' '
>
>  '
>
> +test_expect_success 'all-negative filter' '
> +	git log --no-renames --format=%s --diff-filter=d HEAD >actual &&
> +	printf "%s\n" fifth fourth third second initial >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'diff-filter=R' '
>
>  	git log -M --pretty="format:%s" --diff-filter=R HEAD >actual &&
> --
> 2.50.0.438.g3b3bebd3e8

The fix looks great. Thanks!

--000000000000a7b01606391a7e09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e6ff108dccfa4e16_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1objEyWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOThGREFDSmVBMkVDdWlyR0ZYOWVQU3RqSXUveXRHRwpoTW1BdE9BN2lS
TjFRNWlxaUk5MkVSTGhJQ0RBODZlSDZVWk5iR3VxY2FXUkVYU1EwcEtPKytOTG5SVzR2em1jCjkr
Qyt2b3lFU09rNFBUdDM3VTZMd1FITmYrNGtiV1dhYmJrTm5yQXlLbHo4MFpzRmtlTFBmOEx1L0ZY
QWJ4cXkKLzFvZWdLTXF3ejRuVnZCVGZxTStURUJ2aVVkTjlHREowTjBkclgzdFF6YXZ6RzZXSzJz
dTBWQysvendtQzl3bQpTbkpKLy9OUm0yZGpwUzlwQlhqU25RVnRRMCs3T09lYk9QZGhCVmhZSEJ0
Y1hKRmVJa0U0bHVGTnluUHd3Z1lNClBoVFFGWGNuK0pRZkFTOW9wVGFEQkVVaGpDbG5URjI0ODFX
SWhOaHU0RlBkODc1VWtYaWIvVk5oRUdtQ1V1NVYKbG9TQm9sYnpKSFU5WlZKdGtWL0w2RFVmRnkr
MXZMdkRiRTZzOGZwUzB5ZXFkM1laZDhPUXNUdHpDd0pxanBIVwo4UDF4YW5tbVBuSVBHU1hRckJV
cW1uRlcyQ0gwK0NoRW5oZVRpV2F1TW41UW9GNFlzTzIwOTcyR2dLMFBxcTlhCjgzVDlIbGNOcEE1
dGhkK3VmQk1DMlJCaUo3VmdxYld3ckRxSklJOD0KPWtqYmcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a7b01606391a7e09--
