Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801121B9C5
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004915; cv=none; b=Mh93ZCR6HYmMeiyzUxgZjuiHHo2LdL1t/iinyv0aQRLNPYfwFyVwsX3/p/jSyJOeO6w+cAj+5a+WswXKAXh3427wKpeg1VIaouWWAVVuC+Gs1haO+ynzTfp9LXrQsQ1CikDPY5o8tNnNBBP08uq0EyN3zSTQQBoJ9uTJfhdqTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004915; c=relaxed/simple;
	bh=gP5/nMJ2EXc9iBgx90RjYuPQYJR7IYlJ93nMzbx41I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPOTe9qbcevDa95sEb7dp2ZvIWbnEphWh23Z+/7v4rySkutCsDQyaTrEQY99sBxytmup4srqDtGC3lnKDKJjkigXHkRQc96CGg6AzDq0D6MV8y+vnpJOy+Y6mIaufN1FjPyxene6PCTqZLtrWXy/4LuvbGF82UI7Adr8iAhD6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRZvd1/g; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRZvd1/g"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7273b0d4409so89319a34.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740004913; x=1740609713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHADEihHnkf7AIC3pnl17Ca0TgBdbhaZ5Qt03GqSnns=;
        b=LRZvd1/gXfRK005xSWhJ+CSgTcmiffV0fnFvetSRIWKlwIwFnH6dRS7EUnyjBwn3gO
         pSuU7xaa5KQDQjzIEJEonSJwETrXLAhSw8f2EtjqFWxNp8mPQZbUUHGuHHhd1XWMKXpw
         CqkJSbcyCj+B7kcMEq+zcp7HtIpWYEr2vtRKoDz7RXVEFRhNq52mmBR4zMEimjpDDIX5
         8OutuD545LOWgpxgevBwZfCfiIIANwACy8xWJBqy/fD/5UInrMpcpFlhCn4lZStjhu5t
         6f5ix7Py0oq5YK6rm+s8KRiaskFzr6QVXp78mjngFfEbXGYC0lJj3dU22KI7AJDX78iG
         184w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004913; x=1740609713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHADEihHnkf7AIC3pnl17Ca0TgBdbhaZ5Qt03GqSnns=;
        b=PmKBNM7oVPVtn9+HdkvNoMPV8Xot0fm/vY62PELyjV8TD3LC7JE3vURMP3rP9cVuUM
         cIE9GFFlvVqUQ3IdjCD6d7iAhyR3EtC+vgxAgktpOlNoS25pSrY99OXJ2PryUeGS8j4x
         sjz4z0fdfnHxsGodQ9q61MKre0eYRCOJ9v4g0CoO+5uAUul+Hw7Fqyv6TftdJS9Bp7LA
         9HJ/hOzTJpTDkCSDL9+kWQ1CYK1FfNAm7Hj9juJ2YSiccIwdbElxegWtOf9c45Sv2Sah
         yE4azyh3C9fqQR8U45JKR48O46+A+XKaOMujWyKjKuWftl6zGWugqiqpj04jFPWI9h85
         hXJg==
X-Forwarded-Encrypted: i=1; AJvYcCVq0UfXYViXWQzuXPd+EJVx/x+SSSn0zl/2ROBnNJf7x9ZCHtxxtGcIodwf+D2WWS8FhJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jNViqxLuEKjHpbHJ2r9I7CsIt4hAN/9j5NnPokcMzg8ywZeg
	0ZAjXJe6ZOgs+gCC2xBQgsXPTQaxY74vqAtMAYVMKGDdCn08SnNV6NyQAahP
X-Gm-Gg: ASbGncvneddW/JbMW7UV1G2Qt3qAx0jdIE7+F6P2uOwnPpOaNc7MIiCmIyTvxHlstF2
	t0TRhSlyR7N6EYzjrjSDsDp9vvtjc8ch8BwhWn/koBQDB3WYtJhtTIQXzEHt0tQsiIPK6PLc7gq
	ACQqjMlmxBl7FvohBFLaQRBz/d8U6kxw9WiZIVEWlFuquy1Sulk/vImbaiNJDYAMzQ3G9ZrjJrj
	8ZFfl1bd76jS0FOiluJNPRR5xRR/JtOQKobtpj1Vp4JZLnZofULw8T7ylOPjidFJ0obUj8JSuSa
	mpQKVNZd
X-Google-Smtp-Source: AGHT+IFp3T5pKKi6vPOFVBmWii4v5z4dywHAGo4XxrTcawcHArx7JG3veVWguCnvTiEwlCWLrJvpwg==
X-Received: by 2002:a05:6830:700a:b0:727:3a2e:2132 with SMTP id 46e09a7af769-7273a2e22a5mr4473606a34.21.1740004912815;
        Wed, 19 Feb 2025 14:41:52 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-5fcfed137fcsm810826eaf.22.2025.02.19.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 14:41:52 -0800 (PST)
Date: Wed, 19 Feb 2025 16:38:43 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, peff@peff.net, 
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
Message-ID: <yz74evgjbmj24cakoaseq53ief3jyonujd2pevm5exwcs3kdvl@aqhsafm4hmmm>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
 <d6d4230e-7b80-4eec-b218-37717ae2e298@gmail.com>
 <wv5ziveuff7iellcmjcki372m5vp6nmltyls43e4wzslcqymog@gwczuaucpkke>
 <xmqq7c5lfvh8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c5lfvh8.fsf@gitster.g>

On 25/02/19 01:57PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >> I think only accepting NUL terminated input is fine, but if we want to
> >> accept other formats we should  have a plan for how to do that in a
> >> backwards compatible way as we cannot use `-z` to distinguish between input
> >> formats.
> >
> > If in the future we want to support the normal format, we could introduce
> > an `--input-format=normal` option or something along those lines. 
> 
> Please don't.  Have an explicit '-z' option from the beginning, and
> if the initial version is incapable of reading from text input, then
> it is perfectly fine to have
> 
> 	if (!nul_termination)
> 		die(_("working without -z not supported (yet)");
> 
> Otherwise people have to remember that unlike everybody else that
> uses "-z" to signal NUL termination, this one alone wants to use a
> "--input-format" option that nobody else uses.

Thanks, I think this is a much better approach! :)

> 
> >> > +	/* Don't allow pathspecs at all. */
> >> > +	if (revs.prune_data.nr)
> >> > +		usage_with_options(usage, options);
> 
> Hmph, this is very unfortuate.
> 
> The "--raw" format was originally designed as an interchange format
> between the frontend and backend.  
> 
> The frontend programs take two sets of contents stored in various
> places (like tree vs index, tree vs another tree) and express
> comparison of corresponding paths in (<from mode+contents> <to
> mode+contents> <path>) tuples" (a rough equivalent to what we
> internally have on the diff_queued_diff queue in core).
> 
> The "--raw" format was designed to "dump" what is in the
> diff_queued_diff list.
> 
> And then it would be passed to the single backend, that takes
> "--raw" format, pass them through the diffcore transform machinery
> (like matching removal and addition to detect renames), and produce
> various forms of output (like patch, diffstat, etc.).
> 
> To me, what you are writing is the output phase of that pipeline,
> i.e. the backend.  We do want to (evantually) be able to filter with
> pathspec, and all other things the current diff machinery does after
> the existing "all-in-one" "git diff" and "git diff-{files,index,tree}"
> commands do from their call to diffcore_std() and diffcore_flush().
> 
> The revisions option parsing machinery does accept options that
> would *not* make sense to expect for them to make any difference to
> the result of running "diff".  Rejecting them is a nice thing to
> have, e.g. "git diff --no-merges HEAD^ HEAD" does not error out, but
> some people may want it to barf (I don't care---I am not sick enough
> to give apparently nonsense options to random commands), but it is
> perfectly fine to start your implementation with "nonsense options
> may be ignored".
> 
> But in a "git diff-* -z | git diff-pairs -z" pipeline, I do not see
> a particular reason why you would want to forbid the downstream
> command to further limit the paths it processes with its own
> pathspec, e.g.
> 
>     git diff-tree -z --raw A B -- t/ | git diff-pairs -z t/helper/
> 
> sounds like a perfectly sensible request to grant.
> 
> My recommendation is to avoid deciding to reject things your initial
> implementation happens not to support (yet) too early.  In the end,
> we want this backend half just as powerful as, if not more than, the
> real "git diff" machinery that has both front- and backend in the
> same binary.

Ok, that makes sense. I was originally thinking pathspec limiting could
just be handled upstream, but it probably doesn't make much to
arbitrarily limit this functionality and remain more flexible. I'll do
this in the next version.

Thanks
-Justin
