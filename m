Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843A13E41D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524588; cv=none; b=SBKJsNxdr5DEKX0IsiIsTvH8PEBsiUf1t24oBhgdMBJMUCOIHOa8MWY0/BIW40BmxPFkMTV3HQ0mOcQbD+W9EIjm3r89Kmejisbi1NpBZJ6Nq7Z5jSFugTmEiIgaBVCRQISCRt4fjHJI8XA3A2AdODlTJHEWXZzqKQzqcHpK5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524588; c=relaxed/simple;
	bh=dvpfFQOmem3MJ0aSvAZ82gR85ll01GVDo8O4jZOzg5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIF86LXqhNDWc9rWwiEqxIdF6fFaM7KaLT9eOcgFBOdQ1+zCTkRLyFwyvL05vtE0FuWHncA6CfMNfgXA9mbh6unCBMLRVQpDNH6uCudrYTbTKjcdyEAWSzde/qaWDGI0h2MbLRaFS4bB4baCzFRy44HbW35x/N0+/7uydeF9rnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgI0jljD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgI0jljD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so42407305e9.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726524584; x=1727129384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FyuiGqkEXgPEphH8Vl/Ekwa7x+RwRdMXDktgjA3TLk=;
        b=DgI0jljDiRx8U2euQ2LT9xZbPKK/f8XFy5FVZ+3HcSmWs4bOAyzMtz9d4w5B6GF+jJ
         w7KvkuiTWCSQuqVBa6PJhL2TU/m6yzER0Hkkl1Br1T6bcepQN8vbZyXlYDzOTeNTDeNA
         5c+oJ//Z7zOmPARlWJhF8nC8Z+0kXeytQ0qNXwez9+4vBoERgTvUCRIPXT/Ky/nyptpW
         G/to2YTUWMXethryroLYmLzBhCHTMaUmijNrBMwZeZ9akxlUQJP69vOZENNhOm2TaZaL
         QmPwyCt5YRCwobz6hcxMJyfZjWUBmMT6eEsCtrVW0FRHTF5/3zDdX7B1eA6vN6NorcVc
         RHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726524584; x=1727129384;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FyuiGqkEXgPEphH8Vl/Ekwa7x+RwRdMXDktgjA3TLk=;
        b=FllaJBvhR75SQGSZjTF7aGBGweRP/JDQU4fE/vfBeKJ4vXiNJdCbTo9dUD1EOPAKmh
         upoOOWJSo5qEiZsZV4M+8i9PvsL84qc97DlNjZ/SIn+whuRORol9NbPpj7L8aYEZRI4F
         b7urazsIsaj8gZpGPEzXEQn3yTwrVMvS85ipq/rNZBrqShvx27wmw61U7gNPisfl48WL
         mIDul2jKNwfd3WcmktSlrctPOJ8YtFWtzNQAXDjsqEPf+G9irXQR9hGRO6f3/+98LBBC
         uI0+JHYGxeG1YSy3XKnGkLRTcF2w3z+2aPW0Po0EyInBBwpOPacrqOCnTD+lV6Y+44Kl
         DxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhFnBkgFOCH9+TCKu0MjFatrWNVUBcXHd5cokbrPiUA9NUR4K0V1Y5BtDfIojbbL/n+ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVwGOtpnuVdg+IKE8AdY2/gwSBCPhRsjA4YvEPLcu99DxpznN
	FdKms+fczoe3DzLgcMiGK8llU4L7mfJW0wqwm4UovX0cTeSdhJVG
X-Google-Smtp-Source: AGHT+IFn8UOD8Oow8wPXmamrF7LtgYXQKLAp1KPX9z0hec4W1VGsqwXmatp2Zg690ULsCPAdw2Bq3g==
X-Received: by 2002:a05:600c:4f03:b0:42c:b3e5:f68c with SMTP id 5b1f17b1804b1-42cdb4e6a86mr109668185e9.4.1726524583971;
        Mon, 16 Sep 2024 15:09:43 -0700 (PDT)
Received: from gmail.com (192.red-88-14-200.dynamicip.rima-tde.net. [88.14.200.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b8b15sm86895605e9.4.2024.09.16.15.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 15:09:43 -0700 (PDT)
Message-ID: <be0149e3-148b-4e25-9e44-f3f9a3303fcd@gmail.com>
Date: Tue, 17 Sep 2024 00:09:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add-patch: edit the hunk again
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <cba63486-2186-4e8e-aad4-ed7f54606ec7@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <cba63486-2186-4e8e-aad4-ed7f54606ec7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Sep 16, 2024 at 02:33:54PM +0100, Phillip Wood wrote:

> > The "edit" option allows the user to directly modify the hunk to be
> > applied.
> > 
> > If the modified hunk returned is not an applicable patch, we give the
> > opportunity to try again.
> > 
> > For this new attempt we provide, again, the original hunk;  the user
> > has to repeat the modification from scratch.
> 
> As you say below it looks like we started doing this by accident with
> 2b8ea7f3c7 (add -p: calculate offset delta for edited patches, 2018-03-05).
> I think that although the change was accidental it was actually a move in
> the right direction for several reasons.
> 
>  - The error message from "git apply" makes it is virtually impossible
>    to tell what is wrong with the edited patch. The line numbers in the
>    error message refer to the complete patch but the user is editing a
>    single hunk so the user has no idea which line of the hunk the error
>    message applies to.
> 
>  - If the user uses a terminal based editor then they cannot see the
>    error messages while they're re-editing the hunk.
> 
>  - If the user has deleted a pre-image line then they need to somehow
>    magic it back before the hunk will apply.
> 
> > Instead, let's give them the faulty modified patch back, so they can
> > identify and fix the problem.
> 
> The problem is how do they identify the problem? I have some unfinished
> patches [1] that annotate the edited patch with comments explaining what's
> wrong. Because we know what the unedited patch looked like and that the
> pre-image lines should be unchanged it is possible to provide much better
> error messages than we get from trying to apply the whole patch with "git
> apply". It also makes it possible to restore deleted pre-image lines.
> 
> [1] https://github.com/phillipwood/git/tree/wip/add-p-editing-improvements
>     Note that the later patches do not even compile at the moment. I've
>     been meaning to split out the first eight patches and clean them up
>     as they're mostly functional and just need the commit messages
>     cleaning up.

I can imagine that we could give the flawed and annotated patch back to
the user, if they want to fix it and try again.  Am I misunderstanding
your envision?

At any rate, I'm thinking about small fixes and/or avoiding to use a
backup (":w! /tmp/patch" + ":r /tmp/patch") if I have doubts about
making a mistake after spending some time thinking about a hunk, so as
not to lose some work.

> 
> > diff --git a/add-patch.c b/add-patch.c
> > index 557903310d..125e79a5ae 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1146,6 +1147,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
> >   				      "addp-hunk-edit.diff", NULL) < 0)
> >   		return -1;
> > +	/* Drop possible previous edits */
> > +	strbuf_setlen(&s->plain, plain_len);
> > +	strbuf_setlen(&s->colored, colored_len);
> > +
> 
> At this point hunk->end points past s->plain.len. If the user has deleted
> all the lines then we return with hunk->end in this invalid state. I think
> that turns out not to matter as we end up restoring hunk->end from the
> backup we make at the beginning of edit_hunk_loop() but it is not straight
> forward to reason about.

I'm not sure I understand your comment.  We are adjusting "hunk" right
after that, no?

> 
> > @@ -1273,10 +1277,6 @@ static int edit_hunk_loop(struct add_p_state *s,
> >   				return 0;
> >   		}
> > -		/* Drop edits (they were appended to s->plain) */
> > -		strbuf_setlen(&s->plain, plain_len);
> > -		strbuf_setlen(&s->colored, colored_len);
> > -		*hunk = backup;
> 
> In the old version we always restore the hunk from the backup when we trim
> the edited patch which maintains the invariant "hunk->end <= s->plain->end"

Same here.  Are we losing that invariant?

> 
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index 718438ffc7..6af5636221 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -165,6 +165,20 @@ test_expect_success 'dummy edit works' '
> >   	diff_cmp expected diff
> >   '
> > +test_expect_success 'setup re-edit editor' '
> > +	write_script "fake_editor.sh" <<-\EOF &&
> > +	grep been-here "$1" && echo found >output
> 
> 'grep been-here "$1" >output' should be sufficient I think

As I was writing the test, it was clearer to me using "&& echo found"
here and "grep found" below.

> 
> > +	echo been-here > "$1"
> > +	EOF
> > +	test_set_editor "$(pwd)/fake_editor.sh"
> > +'
> 
> I don't think we need to write the fake editor in a separate test. Also it
> would be better to call test_set_editor in a subshell so that it does not
> affect later tests.

Yes, t3701 deserves an update.  I tried to respect its current style.
I didn't want to start a mix.

> 
> > +test_expect_success 'editing again works' '
> > +	git reset &&
> > +	test_write_lines e y | GIT_TRACE=1 git add -p &&
> 
> It would be nice to add "n q" to the input to make it complete.

I have no objection to that.

> 
> > +	grep found output
> 
> Using test_grep makes it easier to debug test failures.
> 
> 
> Best Wishes
> 
> Phillip

Thanks for your review.
