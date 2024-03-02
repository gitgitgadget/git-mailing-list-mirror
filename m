Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5640BE3
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409605; cv=none; b=VRbjkpARAhCX+oSYXUAoOjWXImLdZZwgYCISc5ijFKemxF/4w7YgOI9t7fJbwbnHqfLiULQOBPDoknXM4+Qr0AawgQyz/6GbaTYRCofq6Xi72Ko1+X7/2f6shPFZI63GhNTjySCkoDzMe7emyz93MHq2QlOCMekNRifxwRLgA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409605; c=relaxed/simple;
	bh=yY/7G/YrWSjf8pLcUzhv+b76S8rQ5RnEG3Bjo5vagMM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MAz/oJNHDI8uxixK05gRMkH9rux1Ai53tS7FDaSd/0WLo0YmhtgnKRpS78OamqRaCwQwS0Dx74Ahk8UwBiMr3Q3dp6ajVJ8nvgiMh1f91z/SoIdzXzsNNCZ7JIJSxD5P4b6MduJTvP9RcQL4sXG3KLcwoW4K1S+KmQ41GZlRA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kONOm4tt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kONOm4tt"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5133d26632fso627186e87.2
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 12:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709409601; x=1710014401; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqvatQONOLQNuz2ugX5Cg/mZAmmGfq0sUz7doTp/MYU=;
        b=kONOm4ttX34Rb2m8uTVr0kRZieIlj6TGHXSzTcDQfk1n7TXxgMHY1VQqhMZu6HBybS
         bXrbqkzWJkaAPZdNcyDTTm0TqD2N/3DHX+BPmjrPJ3iFfR2ykqR2dG1htzvpnmieKkJC
         2p7q4vYgzX1SP71eXqcqC9qB8MQP8ioNRE73r1n3XRh481arT7ZVbCGa9KG+Lj8Fek2C
         ppermeoulOFPq3wH9LvK5+zR5kkzbVj6VXdZPB9vt1IWWYya7IquS/gLDBtFsUaE6A76
         S8mlYS51nG3sRY1NLWWi+qa1G+dqmoK3EzPW6QNQKlf9OMBrUt/p7voUn5c5aFD1f9tF
         gGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709409601; x=1710014401;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqvatQONOLQNuz2ugX5Cg/mZAmmGfq0sUz7doTp/MYU=;
        b=lAxlE8ixtr1cPMOUic2MWw7GVE9RLoABFh+OXSxqeSORZBrnGb+WB2cKBqaYROes6z
         6scxnGJWT9WKVyUiVHcCDEVBF7xiCz9YLw0m3pD+yRIaXesiw5Y6E23bYvBKv3bRrNdn
         9wiawCuR4t/Xy0BPNBlpFg2PE/CFNMl+4ZZoxhr14qsdCwglAb0vzLhgYwu1ncm72cxW
         QkA3qx6pjgD0kWldqboniytcrNHSZ0PG0hQY1mI5pc1wpqtz/kt62W8CyEF862AD5ZlM
         xvHSxYmx3hzgvke3zD1CV6IWlQjnDJHCpMkmfXEJbKIP3kOPhadYq/KAXv0LjDeK8YLM
         H8Pg==
X-Gm-Message-State: AOJu0Ywaysfadycgp4r9/c9kqIsJOvPXefOnyfxZ3ehzah0s2FxSrIAQ
	YVTJyhPxWway69GJK2ioQezUKr8i+4gO3Og89POEdbKf5vOifwogfWkciNgkoo4=
X-Google-Smtp-Source: AGHT+IFwAQAL45/koWvoNxL2VNtLbQ1ebpQp9AeSnJfjk0ADRi+o1ktOVn6sTgCrlwcuVhUFHsoaVA==
X-Received: by 2002:ac2:424a:0:b0:512:fd2a:872e with SMTP id m10-20020ac2424a000000b00512fd2a872emr3152709lfl.18.1709409600822;
        Sat, 02 Mar 2024 12:00:00 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b005132359c699sm1076017lfn.70.2024.03.02.12.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 12:00:00 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
	<xmqqv864zjbf.fsf@gitster.g>
Date: Sat, 02 Mar 2024 22:59:59 +0300
In-Reply-To: <xmqqv864zjbf.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	02 Mar 2024 08:31:48 -0800")
Message-ID: <87wmqk8kw0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> What -n actually does in addition to its documented behavior is
>> ignoring of configuration variable clean.requireForce, that makes
>> sense provided -n prevents files removal anyway.
>
> There is another thing I noticed.
>
> This part to get rid of "config_set" does make sense.
>
>>  	git_config(git_clean_config, NULL);
>> -	if (force < 0)
>> -		force = 0;
>> -	else
>> -		config_set = 1;
>
> We used to think "force" variable is the master switch to do
> anything , and requireForce configuration was a way to flip its
> default to 0 (so that you need to set it to 1 again from the command
> line).  This separates "force" (which can only given via the command
> line) and "require_force" (which controls when the "force" is used)
> and makes the logic simpler.
>
>>  	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>>  			     0);
>
> However.
>
>> -	if (!interactive && !dry_run && !force) {
>> -		if (config_set)
>> -			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
>> +	/* Dry run won't remove anything, so requiring force makes no sense */
>> +	if(dry_run)
>> +		require_force = 0;
>
> I am not sure if this is making things inconsistent.

I believe things rather got more consistent, see below.

>
> Dry run will be harmless, and we can be lenient and not require
> force.  But below, we do not require force when going interactive,
> either.

Except, unlike dry-run, interactive is not harmless, similar to -f.

> So we could instead add
>
> 	if (dry_run || interactive)
> 		require_force = 0;
>
> above, drop the "&& !interactive" from the guard for the
> clean.requireForce block.

That'd be less consistent, as dry-run is harmless, whereas neither force
nor interactive are.

> Or we can go the opposite way.  We do not have to tweak
> require_force at all based on other conditions.  Instead we can
> update the guard below to check "!force && !interactive && !dry_run"
> before entering the clean.requireForce block, no?

No, we do need to tweak require_force, as another if() that is inside
and produces error message does in fact check for require_force being
either negative or positive, i.e., non-zero.

>
> But the code after this patch makes me feel that it is somewhere in
> the middle between these two optimum places.

I believe it's rather right in the spot. I left '-i' to stay with '-f',
as it was before the patch, as both are very distinct (even if in
different manner) when compared to '-n', so now only '-n' is now treated
separately.

The very idea of dry-run is that it is orthogonal to any other behavior,
so if I were designing it, I'd left bailing-out without -f or -i in
place even if -n were given, to show what exactly would happen without
-n. With new code it'd be as simple as removing "if (dry_run)
require_force = 0" line that introduces the original dependency.

>
> Another thing.  Stepping back and thinking _why_ the code can treat
> dry_run and interactive the same way (either to make them drop
> require_force above, or neither of them contributes to the value of
> require_force), if we are dropping "you didn't give me --dry-run" in
> the error message below, we should also drop "you didn't give me
> --interactive, either" as well, when complaining about the lack of
> "--force".

In fact, the new code rather keep treating -f and -i somewhat similarly,
rather than -i and -n, intentionally.

That said, if somebody is going to re-consider -f vs -i issue, they now
have more cleaner code that doesn't involve -n anymore.

> One possible objection I can think of against doing so is that it
> might not be so obvious why "interactive" does not have to require
> "force" (even though it is clearly obvious to me).  But if that were
> the objection, then to somebody else "dry-run does not have to
> require force" may equally not be so obvious (at least it wasn't so
> obvious to me during the last round of this discussion).

I'm not sure about interactive not requiring force, and I intentionally
avoided this issue in the patch in question, though I think the patch
makes it easier to reason about -i vs -f in the future by removing -n
handling from the picture.

>
> So I can live without the "drop 'nor -i'" part I suggested in the
> above.  We would not drop "nor -i" and add "nor --dry-run" back to
> the message instead.

I'm afraid we can't meaningfully keep -n (--dry-run) in the messages. As
it stands, having -n there was a mistake right from the beginning.
Please consider the original message, but without -i and -f, for the
sake of the argument:

 "clean.requireForce set to true and -n is not given; refusing to clean"

to me it sounds like nonsense, as it suggests that if were given -n,
we'd perform cleanup, that is simply false as no cleanup is ever
performed once -n is there. Adding -i and -f back to the message
somewhat blurs the problem, yet -n still does not belong there.

> So from that angle, the message after this patch makes me feel that
> it is somewhere in the middle between two more sensible places.

I don't think so, see above. I rather believe that even if everything
else in the patch were denied, the -n should be removed from the error
message, so I did exactly that, and only that (i.e., didn't merge 2
messages into one).

Thanks,
-- Sergey Organov
