Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B558267B95
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875861; cv=none; b=umQW18bDOO8kPqKLSBnbsB+p2C0B6dhzJHWtVP/aeVn26cy1rW3oCbTecmM1RkiUYVnmVnjNt8iCydAxy8BJ/jXWQRv8WONgOIYYNIKzA5EPBvucpsPF+Kqxffnt2+1v6mMrZ1jGkZbJ4GuA0b6SPr9FBZWDSTfOWmNbnDkPmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875861; c=relaxed/simple;
	bh=z7xICDMbZalKuX5jarhTAcae/qoVS6cF43u5OikP6gw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy2YfCxXi+fyy+TEn2l7vjaYcqSs4TaIxVHWA3GkuRniaeGzaNIg/kWuQ+9D/6T+ttmFLb312nnecQcNg4fPfmZ5JtxcP9XpremYhYHk6WgynuCwnl/E4geYLtrkhwHqmZVKushb+WpG/51BSTv/Rju6gD4+yO1GrDmw81v5ptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0ozrKtR; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0ozrKtR"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb18130f9so506005e0c.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741875857; x=1742480657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUL7ThXE1esQ5x4AibxFRB+Jucp7X4IFi4vhtLg+zRY=;
        b=c0ozrKtR/mDZ40zbut+cw9bDzKDFYrLuyq8kpG+ONEaGt6srFVzKdct2YQgEFAEe+5
         qe/wpFmiAL4axEPQ5+AHw2pPjHXRBQTZFwHS62ixXJXlWNX7a3Ny2JnWia4hwbLijmK5
         zn3s8pDZnX2NKIoMg7ZMpTnkRDvU8fEvRcIGYuVEW36H9JXytedMHZL+dsu1WJolzqMq
         mnk/MjTwLR7gN2zJfwrWp9G6//LJDXZymcwJeKsEDuTkJo+XoDw0TY+2yM/LitDRcJsS
         Ft2fl3sjTP9Az3M09qEKJ3WugCp8Kqb0k6Wv7HFSZU2h0ypZ/OjV7R+d3pENni3nATVS
         dDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875857; x=1742480657;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUL7ThXE1esQ5x4AibxFRB+Jucp7X4IFi4vhtLg+zRY=;
        b=A5N5nQr9s8RSoe+Uoy+1jbyEK43ny8aOYv5wc5iPTqSREOXZwA3oxM6NUwHnJ00Ino
         HCvTpL7jYLyCn2b1YsrWz8+u2tJ1Bg0OluvXtWGeSbmb0C0tWPwHmxeEK2p0JS6I30H7
         rd6IXf28fz41BjnXezs0x6rIOV1nMcTRXkGlLasj22rT7vCudlHRV2/9DdtMf4tGNbs1
         ph7Yd1wr6HqL/ZNZypcfSS6xH3VYHfjz49m43uXKvQPSV3ZdXINRdt44QdIk5U9xyi6N
         WQWWqIgL3lKKFq5BGhDWJjidJ2CmGrJQoruuU4YumC3SVuMEAkr4UkTA0q1ndOXEgnpQ
         qQiA==
X-Gm-Message-State: AOJu0YwJQtJAkwCpIIIfWo7illJrwh1pQMT8E/s4mrXVmGwoz+4mgyV2
	/DmT6Uo51G7sNrio9W7iR94h9Q1tubuTsVuHGCZDDhcDVjj8EgDDnjtROlrnj0Jo/dWWYwFjcxt
	KbtgCc+oOcAwxwvNVYjNk/ah6Kx4=
X-Gm-Gg: ASbGncswMjEfHi/l8fk3NKmNNS7vxNZAGOO3/3D5GsRx9EyKxiOBMj/uMrxx7in4ezJ
	nXm4xr0KuoMXl1xTDq+GXcBWvtQ5dTjR7g6ju3gbZPK7gSkNLpq30vhaE6zQN+vAx4uSlE/0i6/
	zF+o5vkMSrgdRuJ1cAERN3b2wV
X-Google-Smtp-Source: AGHT+IFoiLonCQ6WHv1+xG4goEc/Ysdvz6TGCEPATTWLDVv7iOnO3fiibGdl7yw66b/D0/ZHqs73dWJ0EZkrHDU5qn0=
X-Received: by 2002:a05:6122:8c25:b0:523:dd87:fe86 with SMTP id
 71dfb90a1353d-52419916900mr12013958e0c.6.1741875857087; Thu, 13 Mar 2025
 07:24:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 09:24:16 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z9E0oDgGOM1R-4mI@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>
 <Z9E0oDgGOM1R-4mI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 09:24:16 -0500
X-Gm-Features: AQ5f1JqfhYQ7hP0DLHLJMjWu0F5Eeo05DsqbDbfjwzo2sVOM2BPX94QP5guEgd0
Message-ID: <CAOLa=ZQ3Rgi+yyma0Zo6uK04eu9Lk1dk_uYTU-4hFfh9POTNYA@mail.gmail.com>
Subject: Re: [PATCH v2] reflog: implement subcommand to drop reflogs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000b48b5606303a1305"

--000000000000b48b5606303a1305
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Mar 10, 2025 at 01:36:25PM +0100, Karthik Nayak wrote:
>> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
>> index a929c52982..6ed98ddaef 100644
>> --- a/Documentation/git-reflog.adoc
>> +++ b/Documentation/git-reflog.adoc
>> @@ -16,6 +16,7 @@ SYNOPSIS
>>  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
>>  'git reflog delete' [--rewrite] [--updateref]
>>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>> +'git reflog drop' [--all | <refs>...]
>>  'git reflog exists' <ref>
>>
>>  DESCRIPTION
>> @@ -48,15 +49,19 @@ and not reachable from the current tip, are removed from the reflog.
>>  This is typically not used directly by end users -- instead, see
>>  linkgit:git-gc[1].
>>
>> -The "delete" subcommand deletes single entries from the reflog. Its
>> -argument must be an _exact_ entry (e.g. "`git reflog delete
>> -master@{2}`"). This subcommand is also typically not used directly by
>> -end users.
>> +The "delete" subcommand deletes single entries from the reflog, but
>> +not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
>> +reflog delete master@{2}`"). This subcommand is also typically not used
>> +directly by end users.
>>
>>  The "exists" subcommand checks whether a ref has a reflog.  It exits
>>  with zero status if the reflog exists, and non-zero status if it does
>>  not.
>>
>> +The "drop" subcommand completely removes the reflog for the specified
>> +references. This is in contrast to "expire" and "delete", both of which
>> +can be used to delete reflog entries, but not the reflog itself.
>> +
>
> I guess this paragraph should also moved between "delete" and "exists"
> now.
>

Yeah, make sense.

>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index 95f264989b..cd93a0bef9 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -449,10 +458,58 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
>>  				   refname);
>>  }
>>
>> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
>> +			   struct repository *repo)
>> +{
>> +	int ret = 0, do_all = 0;
>> +	const struct option options[] = {
>> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
>> +		OPT_END()
>> +	};
>> +
>> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
>> +
>> +	if (argc && do_all)
>> +		die(_("references specified along with --all"));
>
> We should probably use `usage()` instead of `die()` here.
>

Good point.

>> +	if (do_all) {
>> +		struct worktree_reflogs collected = {
>> +			.reflogs = STRING_LIST_INIT_DUP,
>> +		};
>> +		struct string_list_item *item;
>> +		struct worktree **worktrees, **p;
>> +
>> +		worktrees = get_worktrees();
>> +		for (p = worktrees; *p; p++) {
>> +			collected.worktree = *p;
>> +			refs_for_each_reflog(get_worktree_ref_store(*p),
>> +					     collect_reflog, &collected);
>> +		}
>> +		free_worktrees(worktrees);
>> +
>> +		for_each_string_list_item(item, &collected.reflogs)
>> +			ret |= refs_delete_reflog(get_main_ref_store(repo),
>> +						     item->string);
>> +		string_list_clear(&collected.reflogs, 0);
>> +	}
>
> I noticed that `git reflog expire` has the same arguments to specify
> which reflogs to expire:
>
>     [--all [--single-worktree] | <refs>...]
>
> The only exception is that they also support `--single-worktree` to only
> expire relfogs from the current worktree. Supporting it should probably
> not be too much work, so do we want to do so to have feature parity
> regarding the reflog selection?
>

I think it would make sense to add support for `--single-worktree`. Let
me add that in, since it mostly a single-line change.

>> +	for (int i = 0; i < argc; i++) {
>> +		char *ref;
>> +		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
>> +			ret |= error(_("%s points nowhere!"), argv[i]);
>
> As a user I wouldn't know what this error is trying to tell me. Does the
> reflog exist but it's a symreflog that points to another reflog that
> does not exist? Do its entries point nowhere?
>
> How about: `error(_("reflog could not be found: '%s'"))` instead? And
> seeing that you copied the error message from the "expire" subcommand
> we could also adapt it in a preparatory commit.
>

Thanks! let change it in both places.

>> +			continue;
>> +		}
>> +
>> +		ret |= refs_delete_reflog(get_main_ref_store(repo), ref);
>> +		free(ref);
>> +	}
>
> The code is correct, but do we want to maybe wrap this loop in the
> `else` branch to guide the reader and make it blindingly obvious that
> the loop does nothing `if (do_all)`?
>

Wouldn't it be simpler to return at the end of the `if (do_all)`? I've
added that, but if feel strongly about this form, happy to change it.

>> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
>> index 388fdf9ae5..251caaf9a4 100755
>> --- a/t/t1410-reflog.sh
>> +++ b/t/t1410-reflog.sh
>> @@ -551,4 +551,71 @@ test_expect_success 'reflog with invalid object ID can be listed' '
>>  	)
>>  '
>>
>> +test_expect_success 'reflog drop non-existent ref' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_must_fail git reflog exists refs/heads/non-existent &&
>> +		test_must_fail git reflog drop refs/heads/non-existent 2>stderr &&
>> +		test_grep "error: refs/heads/non-existent points nowhere!" stderr
>> +	)
>> +'
>
> One edge case that I haven't seen is to try and drop multiple
> references, some of which exist and some of which don't. The loops you
> have seem to explicitly allow for deletion of only a subset, so it would
> be nice to verify that the logic works as expected.
>

Good catch, I also noticed that I didn't have a test for worktrees. So
will add that in too.

> Patrick

--000000000000b48b5606303a1305
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5312d80aff3f6e86_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUzZvNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3ZiREFDUWlkbmpHcUcxQnBVWitWRHBUOXErSkdpago3QjByR293T3Qw
UlZJVDYwcXROU2RoS2JVaUFEZmR4RFFnWmp1VTN0RUtDdTlTeVpJOXBPNmRib1E2VTY4WmJGCkdn
TnJoS2NQMGhqSUpJdkYyOTNtOEs4Wk1MWUFzNU1tcEpLNTdJYXlSbWd3bnZ6UC90UVo4RUROUFB5
KzBSRkYKZWcxL2F6S0NHQUl6blZrWUJwdDVFYU9FVnVmekh0VkJyd3IrZlhOTGlOaklacnhpT01X
UUxrTzdCdGd1bWpRYQp2cm9rR2diQXhiNzNoS0svUSt6WUhXU3A5Z211Z0liK3ZJUi9zU1B5eDVo
WkRkeHhLVGl2bmNUeVN5NHZqalU4CmIrOW1tNFFJaU5XWlU4V1ZsRFNiNU5zYVBscGh0d2xUY1dJ
cy9WeEVjS0VkaVltcFVMeGE5MU1zc1BUZ2JvakIKU29ROFpITjdQS1NSSzZSNjY5ejFiZWszdVVl
WVE2QjEvWFJ3UkcxVlQ4QjhtM2pMRzlZdTQ2b0xscHVENEdHQQorVXBKLzlXTUdMY3VITklWaUdN
dHBWbWhKOTkwMCtJUmdNUDU5SEpMNnFPMDBteHBxY210bHBaKy9laWFKNDE4Cm1kdkNKcDJyL2lR
blg2Rzd1R0FhNGNYdm1ucjIwUnJzVmRHd0dudz0KPUo2QWwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b48b5606303a1305--
