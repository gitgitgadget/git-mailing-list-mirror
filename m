Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D81FB8AE
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864548; cv=none; b=O4URRAyJ596fePgcUt6OY0DGzPXyvVlWIWjCrPmyQgeGyIbzkmm+x2hpA4DvjbjYBamzDRZMdARiAB3OwD9mWg6Nr1FZ+8CMJD5yRP2fwarYRS28mEgMsN+RedYmk9Qac9DEcN9IODbt4oNgK1HgtUibvF1V8kYwz0vVIJ/K65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864548; c=relaxed/simple;
	bh=OkXJ9yOnDvTusEtwTpc9dvO6dfPm7NEifTSxA5y2c7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKPGpp/NeALlOXOOBMcLGpr3AYypwhEHJofLw1YlPt9sRxOHyNvDNBwqbSI9ehLlF+g954XAXny9mId3ObI80Mi2ZifTL/qxACHLNYNFn49kySH6B52xO1JqFp0Xr+qWm4ofxVUwx84chr5+Yo0HcVFOf411V8QYR+oUihyJDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcme/u3y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcme/u3y"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cbb6166c06so937806a12.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729864544; x=1730469344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beuGhou3JUcJSnsjP7tkdohdK8tuKCbrtkisQI9YcU4=;
        b=fcme/u3yo6hYe1l4JtnxemD8ihOWyh5CU5fYdg2bS6dTcvqbRwBPlavC+KpanwD/Vs
         u7HjxMpb8F78LJhASN3bAyTlBJgQFHG9CqkyTyQWvrWRhW3h2o1FkVuL8VFa43hcL2Hp
         3DmBANYJE1Ngudyn6hkjhgFEKT/n3jwVDftKx7ANqg8lrUbjKdhRLQFTYNuWJAIsUdan
         dfZ5sekATA4gMozKgDxscglp/eW6jrZVSKVByBlEpoTjpG/84jE/UAeZz3e5YCoiK7z7
         hYeuepevFUBEKdc5695ByzkRpdFKxg3Y7KfLYcXe7lK1dQRSKwUc5umhwOsxWeMqAaXK
         K60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729864544; x=1730469344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beuGhou3JUcJSnsjP7tkdohdK8tuKCbrtkisQI9YcU4=;
        b=PZ3LsupxjCe1eO4kdNxsS1VPcSUZxQUQbJ/0rNg/dy/Gl/w6oTjDDLA5pgVgppxb/n
         aLhg/TBcCsdcE9tEAtP4XFsqUgRR9nCRnFOeQKdNK/5hDgP9H/UN0g+18ewh0zbsPyAH
         JYTPp5wbWZaz7S9ljRG1LnJCp4b7VxsiTJbWt9bpPVfUXCzb8Eg58EU7J0wMtK5wN1lP
         UG0CBYVcqCbQyZJqnhw75KsGLfuZFgZRBgXuem4SQWlWO3XbTo7T16rqYhZuCBt0LqIN
         c3svMYGkuFqnlE/csziGL7Ce94ON3kPWXenFk0+1LmZWyoRqBfGyouYbZjsbdcXu2iqS
         ge8A==
X-Forwarded-Encrypted: i=1; AJvYcCWyFy1t8ccWf7WlmQRk2s8SWYsOR1a2cdHqCIfbj6DjyFjhZG7vKeoPvdYDcRcAQqWF+B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwCzPY7JsCXgooIKZGeSOLqk1RQtkSbiwt1unhjd3fGZrNXUB
	gpEpUR5oJ7mWZG9gFOPM9D3+0pfyQPZ4VfGW5ea+tnZdpBVLWMYLmfa1e1kmu2ro9UIX+FJ/7//
	lB/eJr0HaMemsMImfR3wJDY/dYn8=
X-Google-Smtp-Source: AGHT+IF8K2AQMcu0db3kHBfJEVbmgvTIcyrzW9GvpYG6bNVyIqP3SogKceFxiTUpinJ/fV/sqVNqmkkh2Tbsm3/Coo8=
X-Received: by 2002:a05:6402:4407:b0:5cb:68d3:9d81 with SMTP id
 4fb4d7f45d1cf-5cb8ac2d4a2mr7607767a12.3.1729864543979; Fri, 25 Oct 2024
 06:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com> <20241024205359.16376-7-eric.peijian@gmail.com>
 <CAOLa=ZSVxOoS0iQ0Ku1LF2jwSw2uK8DMjFJYL77Bto98_sKMUg@mail.gmail.com>
In-Reply-To: <CAOLa=ZSVxOoS0iQ0Ku1LF2jwSw2uK8DMjFJYL77Bto98_sKMUg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Oct 2024 15:55:32 +0200
Message-ID: <CAP8UFD3cAyVZN21_2BGWCfqKhEMhnhqEiU-TL3rLvDOXzp2Hxw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] cat-file: add remote-object-info to batch-command
To: karthik nayak <karthik.188@gmail.com>
Cc: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org, calvinwan@google.com, 
	jonathantanmy@google.com, chriscool@tuxfamily.org, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karthik,

On Fri, Oct 25, 2024 at 12:53=E2=80=AFPM karthik nayak <karthik.188@gmail.c=
om> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> [snip]
>
> > @@ -314,7 +323,10 @@ newline. The available atoms are:
> >       line) are output in place of the `%(rest)` atom.
> >
> >  If no format is specified, the default format is `%(objectname)
> > -%(objecttype) %(objectsize)`.
> > +%(objecttype) %(objectsize)`, except for `remote-object-info` commands=
 which use
> > +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not s=
upported yet.
> > +WARNING: When "%(objecttype)" is supported, the default format WILL be=
 unified, so
> > +DO NOT RELY on the current the default format to stay the same!!!
>
> This seems like a planned breakage, wouldn't it make more sense to
> implement %(objecttype) first?

I don't think it's fair to say it's a planned breakage. For example if
a default specifies what is displayed on the command line and if
what's displayed has an informational purpose there, then changing the
default to add more information is not really a breakage. Here we make
it clear that a possible breakage (in case the feature wasn't used for
informational purposes only for example) could easily be avoided by
not relying on the default, but instead specifying exactly the desired
output format.

And yeah ideally both %(objecttype) and %(objectsize) should be
implemented first, but on the other hand sending short patch series
and growing some features step by step is a nicer approach in some
ways than sending big patch series that are hard to review. So I think
it's fair here to start with just %(objectsize) and leave
%(objecttype) for a future patch series.

Except for this I agree with the comments in your review of the v4.

Thanks!
