Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2F146D45
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515961; cv=none; b=iy5+WDsdC+DaIPU9t//oKwDCU4T81hLXAglsFWjHQ24e+kkgdUE7CTPFnjxfBG0CQ/IGwRcPRXjiGffxOzhL6RzdmGAmT/e77Fg8rTpadtCQNJwopkl+iVH+Cf3DNLBJkg/YUo5kfKVEvid29OVyzUwVjTO7oXGfcMT6XPGImQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515961; c=relaxed/simple;
	bh=cfnxYjWK4tvkQ3CEtrU34iqY9I+oMh1PmAyKGVg8khk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNDRN2VGA5xqYuapRWr8SpwdGwYSntLFMBfykd8Bt2jTsoWv/i5NlXShYgGlHhglhKg7DT41jpSct7I9VEeJ+7XyjOS4iCzTKSjtwBHtiRFQEZJeJQh0fAnbzdvJGYQEC9kaU3z/N2KL0nwBOtr4EyBnNumRfVFwCtljJFkiZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGwl6lRU; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGwl6lRU"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c661e75ff6so1820774eaf.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720515959; x=1721120759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOfJP70y43eeJVmFOGJEzKJKur54GF95spqxkptMml8=;
        b=FGwl6lRUDop0iNc2m8ikZQE8YYVNfUzDtaAjPGb1bdoMi4IWWgCPsBTgC+sGqpXdwI
         JXfBFbHBSD9C+fhOOo08c/S6J7HLvM5bBPLMMvgTnNfjxizI1q5WNdzABemZqk9VUqgz
         hSQOaTu+stKYahqphuhX2Qfcm4iCStWYOVFMDwTmj088T0FVPbKEP0NPJtF9ez1TMN/v
         P7CZtkynhyZ2EPUPfBJRQrLOLwRzRTfAlRKbtTOpqFpA3/kzSfe76Wy2e+5xUt/5csfS
         4jEN8tipGLUkAkt+qEE8/yZDzFlFxRawp7ktoYi45RJLXTHgwI5f6c+gIwdP0hjU44lj
         F0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720515959; x=1721120759;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOfJP70y43eeJVmFOGJEzKJKur54GF95spqxkptMml8=;
        b=Jb66NawuveleyXiKmueBLeZHywJThmjsIrZZQl8J/7LjFK/IMZ65kkHafFEyuyCL90
         IzMIK4MUA5JVvAGLt/C3MMUhNkU+2XtlhvqvhjQt+KpMB72GIs60+9y2lHcHQqXIsy3b
         9q9Ngo5cRn88VAz4fHHfj5mKoSBqwH7wTwjljRZj5k8pYo1e2nO9RY1h8gGs1HzKO/g9
         JKXH8E3p5FTFBBQ5teotaZI6LWaueVYFehOBvyZLIY8pC74JQL/EAp0daPNikRPJXpxT
         WHYv645OjGovDcL7R3DCLvTqILgCquyxylBH+5yTtt+hMq7Z0ZOc86rijE5oGE00D+RG
         g9Sg==
X-Gm-Message-State: AOJu0YyrcRh12/x9F8tjLuMDPxEUk3smbGOzhF/S7Bcu6U4FJiqLstTA
	6XAHZbbWRwh319bGigFitCv372NNcY9bTsMJnV5M+kv2AAFn32fX3UszeolRIeH6piWiQbzWq8J
	b691E8Y8wqQhiNwF9XTZYI+K+oEo=
X-Google-Smtp-Source: AGHT+IGWkALW9AVJi+qis3lPaBuPlICT+Fl6eSOozqBQzLnFpm8+iV/aWYdu7bYyG2V7zVu+I4tC0ewA65h0S8zpHk8=
X-Received: by 2002:a05:6870:c994:b0:25e:d62:f297 with SMTP id
 586e51a60fabf-25eaebe167cmr1588967fac.45.1720515959237; Tue, 09 Jul 2024
 02:05:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jul 2024 05:05:58 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240708233220.GA934035@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com> <20240708233220.GA934035@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Jul 2024 05:05:58 -0400
Message-ID: <CAOLa=ZTDhXfh3rW8mcv7N51psRZ-k_w+vfFe7Hc4a5OE4O42TQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/push: call set_refspecs after validating remote
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000094cfd5061cccd65e"

--00000000000094cfd5061cccd65e
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Jul 08, 2024 at 04:03:50PM +0200, Karthik Nayak wrote:
>
>> Since 9badf97c4 (remote: allow resetting url list), we reset the remote
>> URL if the provided URL is empty. This means any caller of
>> `remotes_remote_get()` would now get a NULL remote.
>>
>> The 'builtin/push.c' code, calls 'set_refspecs' before validating the
>> remote. This worked earlier since we would get a remote, albeit with an
>> empty URL. With the new changes, we get a NULL remote and this crashes.
>
> Interesting. I think this was always a bit buggy, in the sense that the
> some of the code was prepared for pushremote_get() to return NULL, but
> the set_refspecs() call was not. So in theory _any_ problem with the
> remote that caused pushremote_get() to bail out would be a problem. But
> in practice, I'm not sure there was a way to do so, since the remote.c
> code usually falls back on the given name as the url if needed, rather
> than returning NULL.
>

Yup, that seems right.

> And 9badf97c4 does something a bit unexpected here, since the fallback
> calls the same add_url() function that we feed the config values to, and
> so it respects the same "empty means reset" logic. Which means that an
> empty-string remote name will no longer fall back in that way.
>
> It's a little surprising that we hit the "empty means reset" logic here.
> I wonder if that fallback path should be avoiding it. OTOH, an empty
> string URL is nonsense, and it's not going to work, so maybe returning a
> NULL remote is a good thing. The issue here is mostly just calling BUG()
> for something that is bogus input.
>

Yup, that's the explanation that I should've added, thanks. This is a
good summary.

>> Do a simple fix by doing remote validation first and also add a test to
>> validate the bug fix.
>
> OK, so we push it further down, past the "if (!remote)" check in the
> caller. I think that's a good fix. It does make me wonder why
> set_refspecs() does not simply take the remote struct in the first
> place? I.e.:
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 992f603de7..ae787f1f63 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -96,9 +96,8 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
>  	refspec_append(refspec, ref);
>  }
>
> -static void set_refspecs(const char **refs, int nr, const char *repo)
> +static void set_refspecs(const char **refs, int nr, struct remote *remote)
>  {
> -	struct remote *remote = NULL;
>  	struct ref *local_refs = NULL;
>  	int i;
>
> @@ -127,12 +126,6 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
>  			if (count_refspec_match(ref, local_refs, &matched) != 1) {
>  				refspec_append(&rs, ref);
>  			} else {
> -				/* lazily grab remote */
> -				if (!remote)
> -					remote = remote_get(repo);
> -				if (!remote)
> -					BUG("must get a remote for repo '%s'", repo);
> -
>  				refspec_append_mapped(&rs, ref, remote, matched);
>  			}
>  		} else
> @@ -648,7 +641,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	}
>
>  	if (argc > 0)
> -		set_refspecs(argv + 1, argc - 1, repo);
> +		set_refspecs(argv + 1, argc - 1, remote);
>
>  	if (remote->mirror)
>  		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
>
> which is now possible after your patch. Note that set_refspecs()
> currently calls remote_get(), but the caller will use pushremote_get()
> to get the remote. I think that set_refspecs() is actually wrong here,
> but it doesn't matter in practice because "repo" is always non-NULL at
> this point.
>
> But with the patch above, this kind of error would be impossible to
> trigger (but again, your patch is still necessary to get the ordering
> right in the first place).
>

I think this is a great addition on top of my patch, I will add it in.

>> I noticed that this was breaking on master. We run tests on Git master
>> for Gitaly at GitLab and I noticed a SEFAULT. I could also reproduce the
>> bug by simply doing 'git push "" refs/heads/master' on master, next and
>> seen.
>
> I don't see a segfault, but rather a BUG() that triggers SIGABRT. Does
> that match what you see?
>

Yes, it is indeed SIGABRT and not SEGFAULT. Will correct my message.

>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +
>>  TEST_PASSES_SANITIZE_LEAK=true
>>  . ./test-lib.sh
>>
>> @@ -38,6 +41,11 @@ test_expect_success 'detect missing sha1 expressions early' '
>>  	test_cmp expect rp-ran
>>  '
>>
>> +test_expect_success 'detect empty remote' '
>> +	test_must_fail git push "" main 2> stderr &&
>> +	grep "fatal: bad repository ''" stderr
>> +'
>
> The test makes sense. Your single-quotes are not doing what you expect,
> though (they are closing and re-opening the outer test body, so end up
> as the empty string). You can use $SQ$SQ instead (I'm also working on
> patches to allow you to specify the body as a here-doc to avoid exactly
> this kind of situation, but I don't think we should depend on that yet).
>

Good catch. I'm wondering how it worked though, since I wrote the test
before the fix and used the test to validate the failure and the fix.

> I was a little surprised you needed to use the name "main" and not just
> "HEAD" or something neutral (avoiding the INITIAL_BRANCH_NAME stuff).
> But we only hit the problematic code path when we match a local name.
>

Exactly. I'll add a comment though, to make it clearer

> Also, minor style nit: use "2>stderr" with no space.
>

Thanks, will change.

>
> Anyway, thanks for catching my bug! I think your fix is the right
> approach, and we just need to adjust the test. I do think we should do
> the patch I suggested above on top. I'd be happy if you want to add it
> in to your series, but let me know if you want me to write a commit
> message or just send it separately afterwards.
>
> -Peff

I will add it in. Thanks for your help!

--00000000000094cfd5061cccd65e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c9460eff4dd5485f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTS9YVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1g1REFDU1hXTEhlM0g2TC9MWWhBSXVNMHZFVEZzdQorM2F0WFovclRR
a2Fsd3BJWE5CN2hrV2FOdGc1UCtYZEdGb2J3V1Q2dmlOZ1huVHQzcmZoMXpkNjlQVGVUQXNiCnBI
Uk84amxHRW10SmlpTXBNREd4YU8xQXFmZGNZcVNTamlxcE5TNE1FbE9OSzZ4ZytxVlAwS0o5VCtl
RHV5VjIKRC9GNkdocGQ0ZWwxUlVtVEtlNHFOTytuU2Q4YmZSQ3RpY3FrbGN1dU92MEVjSzk1UC9k
TWwzR25GMCttNVM2QwpxMlgvVHh4VThhRS9leU93V24zRlFjWldzVEIvalhWZGhMeFE0UzIvamd2
RWlrcVpOYzhNdVVETVNuRmltUWJSCno1RmQ5dVMzbU92bVBEZjNQZ0d2Qm9jeHpEemIzUUw3STdy
TXpFMTNnMDdJajZQQVZvLzBMZjdkRmpMN3NBZjIKTEg0N1NTQ1JUYVhUNUUwZEpFYjRxTXJJdDNU
SDZnUFQ5WFgxRUhZZDZsMU94ejUwVk91SzVnZTZaNnFwVlppdwpzWGpBNThDTnhxLyt6UTdPNmpI
RVI5K1ZwcHBSOEV6S2xPV1YxbmkxTGxSVmYwQ0tsZjZJbnZ5YnV1ZDFTeFZrCitPM1lCUnVtb1Ri
bFovWGFQalJBYjY3Q1RRczUyWDlQaGsvbTFwcz0KPVFIcjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000094cfd5061cccd65e--
