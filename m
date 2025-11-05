Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2C3594B
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301830; cv=none; b=p6y5zuWlOoSX+zApgWtCyQ5ToxxVScIxYOnh+vc0c2DKohna5qzcuAsOGpU/PNzsPBb5k1eqStjWyLjx1/IQzaKsOEa5EclIfhlDtSPhZ31PdYiRtKGeCT/2BeZ3lAHddMBa+m/O13dKQSrbF7LfK1gJjya4IrEpm47ZNi1jBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301830; c=relaxed/simple;
	bh=VG1MyNXZCNUvoi0sIvo1VNDuQNhnaNUk1SypnB6LpxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIO/BnW2kEE7iFBhuzq035XhPHBjwuIN3iJQsbxJtpH3kPbK4DchOa3xP9s8SaA4eZFDKA4ewsluEkNSATg0wM6bp5iwUKdGJ8GvJX2QDWGEV96Zw5KW3cfzjqUCbMExobLvMJpv/7ClE2ogbsQxQ4Wa+TCrxED8zy48WlXhTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6e4TEVf; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6e4TEVf"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656b9095869so246615eaf.3
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 16:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301828; x=1762906628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WH/Lfq4UdLKKFyyW+a/cHgZPKcETLE+AAd+cbCvoHuQ=;
        b=C6e4TEVf7Zz3r68eWARZ7Nl6kOBVrMrSg0pFQlAWeXmH76ka64C/lq2yXXJvXRNFl8
         EhqXvgC2P6etvH1aKe4RyzMpeWuoJHSMsLZcuipqKcBEkqOzXV5zSm4TiiHgXKCK3Umt
         WYdZsHIfjfR13SbilaNIqwO0o406Wu+eaW9c6HUyebq3uMH5Z19TphgOlDpTCZ0zT2/E
         rcgJVa7i+9xXeV5tXIZbn1wsaEjRDlU6Yujao4TJynXiqYDiIbH3D25NmHA8HyIY05xi
         +U45ZF4vwE9Yb0XdQPDNKmPnexQZg3i1SgkrfqttCxr1FavwxLf2ROvw70BFc90MaA2l
         GH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301828; x=1762906628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH/Lfq4UdLKKFyyW+a/cHgZPKcETLE+AAd+cbCvoHuQ=;
        b=pJAMvgq14vzjrtzi4OYeEqC/8//enDRHS04bKI24pDWRY/s5M0A4Wt0rjvlKscNWXZ
         p6+KNEVqUUjpwDSn3UBuwkrxLCfc7NzmRWka+tLMQtSUeNfbD6T/kqx+TzkiVyz0Rrff
         HfAjJINUZBYknlkNiy2K/sUnUamNDo1vJIq6hBh7CzTUZ82kbTgZK6cxbj3q/QiQMle6
         v8gwxFWkJr/Y4lzNpSqyMNRx0ojaS0LXn2GADcxACXGt+clenuSDfVEpJ6ix74IBoC4j
         ZR1jyEE4v+pVHu8jFmJvi2gwg8mYbf4+Vux4q+PyFBu4tgCi3dEDu4x9LzYbJSANFGu1
         wbkQ==
X-Gm-Message-State: AOJu0YxT238gfHD7K8ISToivcY8ke6ocFBJarQsmtT8OL48dcDShEA/9
	+0k+umcW0NVfSbmOFBA10y839AoNpHbXE/1r/8gsdDlQK8RcHLmOum7/
X-Gm-Gg: ASbGnctDsRF31+sHrVZheb8oDp/VT5ul4XUpkTZZqzre+E+zLF9wbCpx0tMB1NdOF9t
	fv+TseiKTDD7Nhm2+Iwy9GYlp9hJ1gzLpxx+wkPhno4diTFY8aYEcEtoJNobELGWr59zNZPixEG
	sLQTqpvoMSpFbz0Fs60yMHjnynNPoxW0B8CmkJ88lnlTJSAAd8TsHq15b558gV906b4H+xAafVV
	U0OAY6wJszeijV4PLdjyzLrcroHy/qLUW1Ep/6rKZqAOy2WJTDDnRNGJaR/lCVwjjMOe2TZK/t1
	ByFAwId4w5DJCKs3by2aYar59yCQfvJ4QuT4jEX11QfRNzj1eTsaOWqK8DJW1dyw+UPRPHw6wkz
	/95eN6Q8B5lltvZ+POWskcC9axVjSd7XWURWgj7QFNnt/u/g1Bs9NJCcE3xRcIMGQ9T2CCA==
X-Google-Smtp-Source: AGHT+IFEh7Yz1aQpULNW1ycXXXrGj1DZuKGf+gGnF2bZCxZSJkIqsNkSzfduia0M5THIzt/dMxgJrg==
X-Received: by 2002:a05:6820:2006:b0:650:1417:73ce with SMTP id 006d021491bc7-656bb6599a5mr354463eaf.8.1762301828359;
        Tue, 04 Nov 2025 16:17:08 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656ad064484sm1258417eaf.2.2025.11.04.16.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:17:07 -0800 (PST)
Date: Tue, 4 Nov 2025 18:17:05 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
Message-ID: <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
References: <20251104021455.379807-1-jltobler@gmail.com>
 <xmqqa512sfcj.fsf@gitster.g>
 <xmqqzf92quen.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf92quen.fsf@gitster.g>

On 25/11/03 08:44PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Justin Tobler <jltobler@gmail.com> writes:
> >
> >> I have a usecase where I would like to know exactly which files in a
> >> diff pair are considered binary by Git when computing diffs. When
> >> computing patch diff output, Git already omits filepair diffs where at
> >> least one side is considered binary and prints a "binary files differ"
> >> message instead. From this message we cannot discern exactly which files
> >> were considered binary by Git though.
> >
> > I have a usecase where I would like to know exactly which side of a
> > diff filepair ends in an incomplete line in a concise format.
> >
> > Should we add yet another column to the raw output to indicate who
> > is complete and who is incomplete?
> >
> > Where does it lead us and when will it stop?
> >
> > IOW, yuck ;-).
> 
> My point being that it will be a huge mistake to do this only by
> singling a trait that is not so special as if it is very special,
> only because you have been thinking about it too long (the "ends in
> an incomplete line" trait is what has been on my mind for the past
> few days, "this side is binary" may be what you've been thinking
> about).  There are many other things people would want to learn
> concisely in machine readable format, like "where did the file stop
> using CRLF line endings and swithced to LF line endings", that are
> equally plausible as the question you are asking, or the question I
> would be asking "which commit lost the final newline?"

Completely fair. Having a bunch specific options for special info we
want to add to the raw diff format would get messy quickly and is not
very extensible.

> Perhaps an extensible command line option syntax like
> 
>     $ git log --raw-extended=binary,incomplete,crlf,...

I quite like this and agree it would be better to have a single
extensible option.

> is in order, and the presense of these options would add "tt,ic,cl"
> somewhere in the output to signal that both sides are text, preimage
> ends in an incomplete line but not postimage, and preimage uses crlf
> but postimage uses lf, or something?

Maybe the output should be something like:

  binary=tt,incomplete=ic,crlf=cl

or something along those lines. That way we could freely extend in the
future without having to worry about a specific order. If we think all
of the raw diff extension modes would only report with yes/no for each
file we could just do:

  binary=yn,incomplete=yy,crlf=nn

but maybe we should be more flexible and leave it up to the mode to
decide what its values can be?

Also, maybe this info could be on a newline following each raw diff
entry? Something like:

  :100644 100644 a1961526 e231acb1 M	foo
  binary=yy
  :100644 100644 31eedd5c 402a70d7 M	bar
  binary=nn

> Extending beyond 2-way diff is still something we would need to
> think about, I guess, but the only thing we need to do may be to
> allow N-letter tuples instead of limiting ourselves to 2-letter
> pairs, perhaps?

Ya, for combined diffs I think we could just add another letter for each
source? Something like:

  $ git diff-tree -c --raw-extended=binary <merge commit>
  ::100644 100644 100644 f38991c02a 2defd2d465 54f409c249 MM      foo
  binary=yyy

I think it would be reasonable to expect that each extension mode
(binary, incomplete, crlf, etc) would want to check the commit and each
of its sources.

Thanks for the feedback :)

-Justin
