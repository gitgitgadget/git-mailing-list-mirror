Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1897D35F8A2
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768374992; cv=none; b=I+7C87zmJ2+LMsT99dbSFSqS4i4heEZ6JzJUuZA6ByrZqecXBFT1BeHEf4mhRu/LKWaqjQx88VJE/H67fRvFmn6jaiczPbYDEzAzkvByX8lPIn1jf+9MUHfOilzWqePKpjAhNMFZqzYI1qu8si/GL9swOT7ez/IEGWDLGbSGQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768374992; c=relaxed/simple;
	bh=YZ/B1HJvr9FrTR57k8D12yj/kxPYggk59vLwVpft5P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGAvgmIveUmiA9CPTpaRaOYcSv/1A7yx/qQH1fr0NR9Y3XbgH2fqVRf7Geqr1I2NFY965B0Fi5h2Q/QM6WETiaG9nbKaVxVJlbUXlwfqMbF85RMgSx+Mxb9JjEcxiBNn02I8vZJvSjS7Tcehn/zIhOpB7XdEieImBZTA1bDSC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adhda7QG; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adhda7QG"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-121a0bcd364so9600961c88.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768374985; x=1768979785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0EbbArjwBKG7HCqwtw8C0hQ6JLIAVsehlwNyTGVIYiE=;
        b=adhda7QGfeZUxYVEvFK929hXWjHwRSbUTPz+Hf+5wOcD5Xw859omaF9fkZKXb6Bl41
         b50ahNoiY9XL/L87ue1HncAyp6P1b1bB8YopWLyVn364y2VwlTnXzD6CN8WuX1zq/Y9O
         v8CKfdY56uUS05K38T9Li3hZAKboOlW5JrvIoxbFZRIbUOvGVWMf8w3CwsS9ppPbquaF
         f2RkkVo33IuyCbGy40pNZRe+8b3Je4GovRB7eHZn4fsSTwuagHfubesQFffBEwuyE8Ma
         02+JvcxVSc6bQ4e9uOac3uG5cya/tvueTfVDMNhZOc8w/wgLAjkH98rS6/HyHneG0olg
         pqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768374985; x=1768979785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EbbArjwBKG7HCqwtw8C0hQ6JLIAVsehlwNyTGVIYiE=;
        b=LfdzQp3MJMFYeprD8klanHMPOdrFEhL9sJPZeRRbICGTY39UGQ0FkWswd1/DcwzRQN
         zS1Wch5T1Tc+LQjL5gxmMLVB9YSUP2hpMVmjBD4K7rlhU7ala1N8US+RvCxxLFzswNaN
         6Wqpq67YhnDST60XFWOAFKBbIRTkIow+RXL0bq4aO03YDHW9dPrH2v5wnQPWT/thHFv7
         uBBDd0p5AjjDm08Mi4Y6eJqSMqB5r9HNdnukw27YjEWZWWEE35PMuGElQTz9ulIr8yA+
         dP70csIfglnrpApgGEeYQU5qT+xsNQ89eP8g+Kq/qow94vnzclK0RVVZekmUMh1zNElA
         klOg==
X-Gm-Message-State: AOJu0Yz31AZ4yzR5epswL3i97wrPbluCoxjmeX6eUaBOpdo9ee8okSYm
	7wZrD0sYK9uqzZ2C2jmTAL5ciH5S6ctzEfeKDY9tR46+lNBEKxWouYvkTyKj4s3qPOG8ScD50v9
	wv5xciwtO2/Df/oQGzamMTpxTztRJrlw=
X-Gm-Gg: AY/fxX7IopwL2lczvwDS8OKkdv3y8patLaP584CkAvwKkWx6q40hRmlqNSwHgVZgWen
	XeClouTAl1NH7UDNPk5xZxHauQvsFjzoNoo0JqtUPL3zlEz7O5UCHajUPmxBLwmHBkxnKUdMZiG
	gOo/+9lqib+UxB/ZK2i629CZvKkimUvIJk/gTkaD3Opxqf87B/Im4DefC+fg0cJtpth9vagZ7wP
	ah3GSoXgKy0y9nJoTmCYDJXsYT1mv+6+IplCp1PdXbVtYUNYo5XXtdjuyBvo1v1fqPy8KxQ1L4=
X-Received: by 2002:a05:701b:2406:b0:121:9f05:c4c2 with SMTP id
 a92af1059eb24-12337747a55mr1087693c88.23.1768374984800; Tue, 13 Jan 2026
 23:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768318762.git.belkid98@gmail.com> <1e83c077f274d73aebe183ae61157593f4a358c2.1768318762.git.belkid98@gmail.com>
 <xmqqsec9i9qr.fsf@gitster.g>
In-Reply-To: <xmqqsec9i9qr.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 14 Jan 2026 08:16:26 +0100
X-Gm-Features: AZwV_QjwqwN-AJwcovqnIZOuW032-Ii8cukVxnehi7LDBSHudK6Gs0JeYR-MDsE
Message-ID: <CAD=f0L9yU=zZq5q-O1tjX3+JKz-CpWbVhA4PCyEq3+QyiTo0DA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 2/3] environment: environment: stop using
 core.sparseCheckout globally
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 20:38, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > diff --git a/builtin/backfill.c b/builtin/backfill.c
> > index e80fc1b694..90d5312240 100644
> > --- a/builtin/backfill.c
> > +++ b/builtin/backfill.c
> > @@ -1,4 +1,3 @@
> > -/* We need this macro to access core_apply_sparse_checkout */
>
> Why this removal?  You'll need to be able to access the_repository
> because ...
>
> >  #define USE_THE_REPOSITORY_VARIABLE
> >
> >  #include "builtin.h"
> > @@ -139,7 +138,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
> >       repo_config(repo, git_default_config, NULL);
> >
> >       if (ctx.sparse < 0)
> > -             ctx.sparse = core_apply_sparse_checkout;
> > +             ctx.sparse = repo->config_values.sparse_checkout;
> >
> >       result = do_backfill(&ctx);
> >       backfill_context_clear(&ctx);
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index b19b302b06..b6b19e83d1 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
> >        * We must apply the setting in the current process
> >        * for the later checkout to use the sparse-checkout file.
> >        */
> > -     core_apply_sparse_checkout = 1;
> > +     the_repository->config_values.sparse_checkout = 1;
>
> ... you'd need to access this, even if it is now called slightly
> differently, no?

Oh yes you are right.
I will return it.
