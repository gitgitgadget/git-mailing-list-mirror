Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B81487C8
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318457; cv=none; b=WBfbSL4S8Lanql3MaCUpxdqlvb9Kq9zTWabxQu/Jfy/9aVb81qUZl8BK/TVfoTD43cbbcrqKYl8ofLXaZBwU1XCbENMIxY13/5IivQah6SxxOnDT8+xP8Q9GADu/Ux+30RqVnAK9nTpf1QI5ePTpUxdWAiQ4fhK8m605l3WpKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318457; c=relaxed/simple;
	bh=Sm6a2dUtIDk/2AA9HKDLqbwOZ/30woxejBx9hcpergw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwMoec1xwvZEiO8wJrlRTLrphUd4X7RDN1awf5Kv4kXvBpm7r9nr6Kq9MiOyADSfco/HL+AW8HIpuCDyu9hJhDiJUS8Oo+ultVYrp4Qpv9N3kJgve4b6R8q+5y3ZzPNJ3OtLkBtzlg38UGeZfH0mrAeF1rc6ZS32rQuxt9VKDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B57XIJO/; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B57XIJO/"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700cd57a9fbso22400a34.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318455; x=1719923255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+vhBCZExNXR/UkFw2YjJq9v0pWhSZqg2MOoawTBE5s=;
        b=B57XIJO/7lfqYOXV1gLTraYTopMtsNCVqnOpeP557xf9D41Xl25HtTQfVy11a5yylz
         C4sHKQNSEFRdCC9gx4TftvHqDL9Dv7iFaYU02zz2fKqgedqMzIN9c5GXfr4Xm/4oISDK
         nWRDgqocR/J3EoA6WFmXZMS/+5OdRyTqis/8PqZceoXs1cEqhj1IWG8SFLRIhU6B//BI
         2LwqHKssYaydZDRjWcEbid4Q47kE1SwYE39pA9GHHfvDtout2ZqLQ1VX1iXNko512u0x
         B59XRYB3rirmWwleuyG6zl2KQDNWWHSDfERyfp3vK7Y33kyMx9WawhX1u7xLxYk1Jx3M
         yVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318455; x=1719923255;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+vhBCZExNXR/UkFw2YjJq9v0pWhSZqg2MOoawTBE5s=;
        b=UYpbPMDXjBASekGadzU721SqXpOOr6tTSpl7LRd1RM0m/8+NiVivRpE8phm2JBuozp
         rIz0mQlmf/Em15lB1ABZYRHWxBKMqBW4TPEJVv0GAOFyRU2HHrreQukvw/bU6CSFkaI/
         doCM9k07IjzU5mts8THTsFI4p1XpctSGHEuU5xlg5YHE7ftYn6ual83BawAMlBAyH8cW
         zQto/I4ZlmdFZYLeZIHdEKwvEeg5klmrQJxDHxOUVXayOypBcLvHzmUH8H1TR4Kn86eF
         FD8thnNe94IgVGdRbm2xNocCX40VigEmnsx3ibB+/q50iAkvgp7IZRCPtqdZl6Kf8FiQ
         1QDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3e1iOfiKxAO735bx//POs+4qDW2POOJsALDIoxQSPTLzz5clOTqexqB4s4T63WIrIBY6grBgsBAZD5FLniuE6ocVH
X-Gm-Message-State: AOJu0YyXOJeBeOqKXn0KTZqe4/SXQTONGJeTcLyhS4haBdyu8IejnO3Q
	shZjjkHu0/KmkqV6jsBCjI/pDEkiMK3p7JNphOQ8R9+BEbunY6RHT2Tkqr/TzpsFJIo3LUtEycS
	jWh+N1Pe9Xb9Jmg9oRaJpDh3gvtM=
X-Google-Smtp-Source: AGHT+IF0yppja/gL5JGQN8kEnXSjGhSqcxWKhPV5ybu4J1m0E2G9FenvNoB5K5K59KWF2yfxiQJmu9xDMGJ8WymzyaU=
X-Received: by 2002:a05:6871:8a7:b0:24f:d873:9f32 with SMTP id
 586e51a60fabf-25d06c51287mr8774567fac.26.1719318454975; Tue, 25 Jun 2024
 05:27:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 07:27:34 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240625064504.58286-1-abhijeet.nkt@gmail.com>
References: <xmqqsex2b4ti.fsf@gitster.g> <20240625064504.58286-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 07:27:33 -0500
Message-ID: <CAOLa=ZT5asAE8-=jY7iR2hsGGshjQtBvpjcVacQk5YFa0u3Sfg@mail.gmail.com>
Subject: Re: [PATCH v2] describe: refresh the index when 'broken' flag is used
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000c3d7a2061bb60531"

--000000000000c3d7a2061bb60531
Content-Type: text/plain; charset="UTF-8"

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> When describe is run with 'dirty' flag, we refresh the index
> to make sure it is in sync with the filesystem before
> determining if the working tree is dirty.  However, this is
> not done for the codepath where the 'broken' flag is used.
>
> This causes `git describe --broken --dirty` to false
> positively report the worktree being dirty if a file has
> different stat info than what is recorded in the index.
> Running `git update-index -q --refresh` to refresh the index
> before running diff-index fixes the problem.
>
> Also add tests to deliberately update stat info of a
> file before running describe to verify it behaves correctly.
>
> Reported-by: Paul Millar <paul.millar@desy.de>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  builtin/describe.c  | 12 ++++++++++++
>  t/t6120-describe.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index e5287eddf2..3e751f1239 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
>  	"diff-index", "--quiet", "HEAD", "--", NULL
>  };
>
> +static const char *update_index_args[] = {
> +	"update-index", "--unmerged", "-q", "--refresh", NULL
> +};
> +
>  struct commit_name {
>  	struct hashmap_entry entry;
>  	struct object_id peeled;
> @@ -645,6 +649,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  	if (argc == 0) {
>  		if (broken) {
>  			struct child_process cp = CHILD_PROCESS_INIT;
> +			struct child_process update_index_cp = CHILD_PROCESS_INIT;
> +
> +			strvec_pushv(&update_index_cp.args, update_index_args);
> +			update_index_cp.git_cmd = 1;
> +			update_index_cp.no_stdin = 1;
> +			update_index_cp.no_stdout = 1;
> +			run_command(&update_index_cp);
> +

We should also call `strvec_clear(&update_index_cp.args);` to clear up
used memory.

Nit: we could actually `cp` for both the child processes here.

>  			strvec_pushv(&cp.args, diff_index_args);
>  			cp.git_cmd = 1;
>  			cp.no_stdin = 1;
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index e78315d23d..ac781a7b52 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -671,4 +671,36 @@ test_expect_success 'setup misleading taggerdates' '
>
>  check_describe newer-tag-older-commit~1 --contains unique-file~2
>
> +test_expect_success 'describe --dirty with a file with changed stat' '

It would be nice to cleanup the repo at the end of the test by adding
`test_when_finished "rm -rf stat-dirty" &&` here

> +	git init stat-dirty &&
> +	cd stat-dirty &&
> +
> +	echo A >file &&
> +	git add file &&
> +	git commit -m A &&
> +	git tag A -a -m A &&
> +
> +	cat file >file.new &&
> +	mv file.new file &&
> +	git describe --dirty >actual &&
> +	echo "A" >expected &&
> +	test_cmp expected actual
> +'

You want to do everything apart from the repo init in a subshell, this
ensures we don't carry over the working directory to the next test.

> +test_expect_success 'describe --dirty --broken with a file with changed stat' '
> +	git init stat-dirty-broken &&
> +	cd stat-dirty-broken &&
> +
> +	echo A >file &&
> +	git add file &&
> +	git commit -m A &&
> +	git tag A -a -m A &&
> +
> +	cat file >file.new &&
> +	mv file.new file &&
> +	git describe --dirty --broken >actual &&
> +	echo "A" >expected &&
> +	test_cmp expected actual
> +'

Can't this be merged with the previous test?

--000000000000c3d7a2061bb60531
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8b14af264b5e0eee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNnQ3UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVNJQy80b2t2ZUhSMWQzWDJWMTFCQ216SjhFY2pmcApwZERCbjJYRE1z
TlJjSE5WYTRrdG93d2FESnRaejB6dFcyZzVKSHhrZHVuVThiSzZRd0RDdy9iWGJaS09RNGloCkhm
NDEzZUVCcWhkcytBSVdNOXVqSlU3Y0JlaEs3aVBPbHlmVzlIQWhiM3BCYmZ4M3M3RVkyQjhBdXlS
bmhoRGIKdkVBQ1BLYVhjakRpRkZyazdrTDJhcnFuZTlPYVpwUzJiY0RPeXY1U2lZTW9GQ1l3WnRu
cVFhM1NjczlGT1RPRwo5WFh2azZYelNSSzU1WWNIS2JudDVCQVVVMFhUcnlieUdGNGhySWFpNmhs
UkhrVmxVYU42aHFpeE1tZEpxbXUvCkxOeWhTbHdwdDJldFBPV1lnSURRZWNZU3NiS0dvQnZWaGhw
d3VZcnFYVDMrczdZMDVWZ0ordDBCNlBIWkt5elEKRlU1NUUwRnhzMjNuMFh6NFMybm41SXYxc0VQ
STFGNzVkRGJUM2wvWkE2QkJselE3UUM2VXJxenM5SWVFRE9jUAphQUkyakNibktRRFY5WHMxQnd0
NFVweUFKeXc0bld5M1gyZjNkeTlJN2hyRzV4Nkh6enRCeVVjVjNsTlpVOVdzClFra2lRWFY2ZHY4
dzBqRUM3YkVZcStjTmJpMmcxd0VtRjJ1Ykg2ND0KPUxqcXkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c3d7a2061bb60531--
