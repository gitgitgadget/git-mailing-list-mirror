Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915822192FC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352016; cv=none; b=CroVEv0gUQSmN3UH6uKoPD6LJ/IL1o1KEHmsF6OXOGycCn3uujfAXMiAi/X8AsgAWSbUuJd1zVcuv5U4uv9PjLkQDz2q3pYSlEgdfz6ER1dkcOQJ3IKOlGGqoShazy8xDVZ1/IVAna2E3U7woLi73LrdbG5Bf8aZszqWqvh5Mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352016; c=relaxed/simple;
	bh=hjEG7IvvnUNAaS6nfRIhul00XIjLAwfQkK6oda2jFMU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibDUIydmcb90cQU3aLjiDynI542u/Ra7dAZi9zzr4dhlYrZSf8yTVfKQ1Tsxo2WgXO61XImgSWMOyctTnnbRid1wYpSwsjNypS9tThkwe1QpCTdnQnjqd7JDA3ZT7ou/MJ6KbWh8QW8L4wz50H2gqz7hGS6NtDvmMfOSu/TE9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8LESDvG; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8LESDvG"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso1753167e0c.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741352013; x=1741956813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHUEckJyutyWkw2eH+p7O7IpdebHwMHbas0Zax+b+yg=;
        b=f8LESDvGphZVRtJNvtFOPNSqEinmNp4w2+CHFkP6GUjN27mcoxpgU9LxnnLzxhnZPq
         24fi8lQENwSHiMrxR+q5RwLdKkN62QFTmyAvvmKwW4eI5bafS6oI+O5NKG0rhS64C55v
         nWEOKe7S7asxXy7ULKun0tE4QFQorkPk0UcNooYypgDlElUBqxmCzvZzciRN4OKafgm/
         1nlBB5txxSc8QzI2eHw+9rP9/R2P2YpDfZGJHQIUc3+mur4YMfSfYmyPnW6bUKHkNyhN
         h652qlxdaNEos/sZSS4Yf3Q1BvhGC1zSyejhNEqYgCaKq/z9XDmWJXqlq91rES1QHwP1
         2UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741352013; x=1741956813;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHUEckJyutyWkw2eH+p7O7IpdebHwMHbas0Zax+b+yg=;
        b=Octu7Ea96kL78Qv1vYPPlDg5N33zyd7ez/4DVkZk+26bTbr44CGDntMuYYffqNlQOJ
         s4aimljwTZTXosvQ4g6f9q8W6dnMLzZYq9Tq4yRvs5r/HkBpogRhDiuwkTqK6angvQ9T
         Q5uyqZ0VA1iZc3jTRmaPPg/ASpLbf6CWOhdlkNIa6XyZ+/ugIrphjMg009hL0aLl7Zij
         sQOqJz11sduA8a8TnsLymGH26cA2dLlWKpmE4sKqDKNedxQ9ueJzj/ReU0ptffKUEJH4
         L3TyFGoRwBG8uDUprny7g3MrfcwTmxOrhUyeTmQTkxPYuBcg0opOboe7f0C35z8zRwzq
         u65w==
X-Gm-Message-State: AOJu0YxtiV2j5Rk/JItdZUWwL1ivZwePv9eJIWaHIqsnfi1mYsiyxb0h
	Ie8dmYlrl5Ieetj5HvGooGjC9Z7zr3AWW29IR0fhvZgdgRs228yLC2QupqzODRbn74Mg0BmoNlF
	qfA2phIXeVTLn+3vnpoq9f0n+F3Y=
X-Gm-Gg: ASbGncvfGId8XwYg1EdF9kMf/v9Q/Y6uKouvLUPS+Zotk4Hk9L2Pzu+XMCVGOKXq9hY
	i+Uj37Gs9yP8MXyL1pPCJ9JRwECuPALmB5J+B/k77yOdZ1nUFoG8pRg8WE6Pdo0ssJFKhfbAm2z
	w1U5k5QFJeY+jglsQJodpWGDDj1iU=
X-Google-Smtp-Source: AGHT+IHEyFM/S1luFjw5yeBF4krqZy0k0L8ybulRm1LKZtxF/nSN4hE6qQilWymP4Hts1XUtkvX5aXuNvThVi93HpYc=
X-Received: by 2002:a05:6122:17a6:b0:520:63e6:79d1 with SMTP id
 71dfb90a1353d-523e42da858mr1904843e0c.10.1741352013152; Fri, 07 Mar 2025
 04:53:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Mar 2025 06:53:31 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z8rdg90kxmKHHbyh@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
 <Z8rdg90kxmKHHbyh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Mar 2025 06:53:31 -0600
X-Gm-Features: AQ5f1JpVPNzHUZqoCKwdSkbYfgWcNozMfbVjXupBaFAr_xhBh1vpnf34WMqzz7w
Message-ID: <CAOLa=ZSMLwt53TwziCe71UbKWgRyNgg5VvUwTUUDkN60ymmFPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] reflog: implement subcommand to drop reflogs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002cbed2062fc01c2c"

--0000000000002cbed2062fc01c2c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 07, 2025 at 12:17:26PM +0100, Karthik Nayak wrote:
>> Add a new 'drop' subcommand to git-reflog that allows users to delete
>> the entire reflog for a specified reference. Include a '--all' flag to
>> enable dropping all reflogs in a repository.
>>
>> While 'git-reflog(1)' currently allows users to expire reflogs and
>> delete individual entries, it lacks functionality to completely remove
>> reflogs for specific references. This becomes problematic in
>> repositories where reflogs are not needed but continue to accumulate
>> entries despite setting 'core.logAllRefUpdates=false'.
>
> I think the order of the two paragraphs should be switched: we tend to
> first explain the problem before explaining how to address it.
>

That makes sense, let me do that.

>> While here, remove an erranous newline in the file.
>
> I suspet this should either be "extraneous" or "erroneous"? I cannot
> quite tell which of both it shuld be :)
>

I was thinking similar but decided to go with the latter (sans typo).
Will fix it.

>
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-reflog.adoc |  6 +++++
>>  builtin/reflog.c              | 58 ++++++++++++++++++++++++++++++++++++++++++-
>>  t/t1410-reflog.sh             | 55 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
>> index a929c52982..4ecee297de 100644
>> --- a/Documentation/git-reflog.adoc
>> +++ b/Documentation/git-reflog.adoc
>> @@ -17,6 +17,7 @@ SYNOPSIS
>>  'git reflog delete' [--rewrite] [--updateref]
>>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>>  'git reflog exists' <ref>
>> +'git reflog drop' [--all | <refs>...]
>
> Should we put the command next to `delete`?
>

I would have like it if they were actually alphabetically sorted, but I
guess this is good alternative to cluster similar sub-commands.

>>  DESCRIPTION
>>  -----------
>> @@ -57,6 +58,11 @@ The "exists" subcommand checks whether a ref has a reflog.  It exits
>>  with zero status if the reflog exists, and non-zero status if it does
>>  not.
>>
>> +The "drop" subcommand removes the reflog for the specified references.
>> +In contrast, "expire" can be used to prune all entries from a reflog,
>> +but the reflog itself will still exist for that reference. To fully
>> +remove the reflog for specific references, use the "drop" subcommand.
>
> The last sentence feels like pointless duplication to me. We should
> likely also point out how it is different from "delete". How about:
>
>     The "drop" subcommand completely removes the reflog for the
>     specified references. This is in contrast to "expire" and "delete",
>     both of which can be used to delete reflog entries, but not the
>     reflog itself.
>
> It might also be useful to add a comment to "delete" to say that it
> deletes entries, but not the reflog.
>

Thanks, this does look better and I agree, we should call out "delete"
too.

>>  OPTIONS
>>  -------
>>
>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index f92258f6b6..232602c1a6 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -27,6 +27,9 @@
>>  #define BUILTIN_REFLOG_EXISTS_USAGE \
>>  	N_("git reflog exists <ref>")
>>
>> +#define BUILTIN_REFLOG_DROP_USAGE \
>> +	N_("git reflog drop [--all | <refs>...]")
>> +
>>  static const char *const reflog_show_usage[] = {
>>  	BUILTIN_REFLOG_SHOW_USAGE,
>>  	NULL,
>> @@ -52,12 +55,18 @@ static const char *const reflog_exists_usage[] = {
>>  	NULL,
>>  };
>>
>> +static const char *const reflog_drop_usage[] = {
>> +	BUILTIN_REFLOG_DROP_USAGE,
>> +	NULL,
>> +};
>> +
>>  static const char *const reflog_usage[] = {
>>  	BUILTIN_REFLOG_SHOW_USAGE,
>>  	BUILTIN_REFLOG_LIST_USAGE,
>>  	BUILTIN_REFLOG_EXPIRE_USAGE,
>>  	BUILTIN_REFLOG_DELETE_USAGE,
>>  	BUILTIN_REFLOG_EXISTS_USAGE,
>> +	BUILTIN_REFLOG_DROP_USAGE,
>>  	NULL
>>  };
>>
>> @@ -447,10 +456,56 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
>>  				   refname);
>>  }
>>
>> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
>> +			   struct repository *repo)
>> +{
>> +	int i, ret, do_all;
>> +	const struct option options[] = {
>> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
>> +		OPT_END()
>> +	};
>> +
>> +	do_all = ret = 0;
>
> Can't we initiailize the variables directly when declaring them?
>

We can, let me fix it! I'll also move the initialization of 'i' down to
the loop while we're here.

>> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
>> +
>> +	if (do_all) {
>
> `do_all` and `argc > 0` should be mutually exclusive from my point of
> view, as the combination does not make any sense. We should likely die
> if we see both to be non-zero. Similarly, I think we should abort on
> `!do_all && !argc`.
>

Makes sense, let me add a 'die()' there.

>> +		struct worktree_reflogs collected = {
>> +			.reflogs = STRING_LIST_INIT_DUP,
>> +		};
>> +		struct string_list_item *item;
>> +		struct worktree **worktrees, **p;
>
> Would it be useful to point out in the docs that we also prune logs of
> worktrees?
>

Yes it would, will add.

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
>> +
>> +	for (i = 0; i < argc; i++) {
>> +		char *ref;
>> +		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
>> +			ret |= error(_("%s points nowhere!"), argv[i]);
>> +			continue;
>> +		}
>
> Is there a particular reason why we have to double check that the reflog
> that we just enumerated really exists? It feels rather unnecessary to
> me.
>

You mean we could directly do `(get_main_ref_store(repo), argv[i]);` ?
The issue is that this returns '0', even when the reflog doesn't exist.
So to notify the user correctly, we do this check.

>> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
>> index 388fdf9ae5..b6e44ce6b9 100755
>> --- a/t/t1410-reflog.sh
>> +++ b/t/t1410-reflog.sh
>> @@ -551,4 +551,59 @@ test_expect_success 'reflog with invalid object ID can be listed' '
>>  	)
>>  '
>>
>> +test_expect_success 'reflog drop non-existent ref' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_must_fail git reflog exists refs/heads/non-existent &&
>> +		test_must_fail git reflog drop refs/heads/non-existent
>
> Do we want to check the error message of the latter command?
>

That would be nice addittion, will add.

> Patrick

--0000000000002cbed2062fc01c2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 93f29a999eeb0cdb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSzdFa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFduQy85bFl3TjB4WGNXOVZVYWVCS1ZEMTVmeWg1RQo2WVM3Z3hRSlEw
RGxaNFV1bjBLWDRMTkZmTGN0L0RiaW1RUU9vRk1oQTYwOTVRRDlUeTVpWXpPK2szV3dkR1daClQr
YlRTR250YUh5TnBhYStjS3RYTWR0QjhaRkZTOU0wU0VUbXlydXdMVERWYjJ2VnNOK3RBVUZzZE5h
eUdMS3EKQzUrZXhQSko4S0UyaEtKdFM3MldtMlZyb2UxZDJIKzlUYkR6SzFvQW1XRWM1VTQ1UnpE
MUdYSTZTeTBLaDVzMgp4OGlnV3B4WEtvenpYNitFM0VTRzhqYjFsYXpRRHFGN2NFcUN2dmViSmVj
TlA1TmZwMG81NEErN05WSlljUllVCmJDZ2E3M3loWDFxTWZZcExJRnlRQjNzUDh1MjY2UjEyOXZI
aWRLTXovSit1WHdOUEh3Mk91b0V3eXJ5cWlXTHkKdjk4R3NvOXJnenR4NnlYSlh5Zk9iUGRZRUlx
aXFBMklHSlMzb1RkN1Z6T0VIVUtBUVVzek5hZ0ZOdXpHSTJ0YQpIQUdRZkJVMEhpcDNTYjR0cWo2
aE9UaFQrYVJieXBhZ280Njd5VUxqYWdScVVPTWg5WnBSbVA3Zkp6ZExCaXY5CnlNNGppZUEwM1hS
VjUvNVQvQjJLRWVpS2xvY01QbWh4cU5HZWtpVT0KPVNSL2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002cbed2062fc01c2c--
