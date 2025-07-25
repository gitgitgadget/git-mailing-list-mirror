Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487A23CEF9
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466204; cv=none; b=JFCpdY7uLksafsYZmuI4FJv7zIWOWvxb3Kx+gx6VFBisEBZkAhVXhBxli8uyNz2744tvaDAYAdjm/lBOgUtvJhi8CrPAZt/XyUCMkTWtSI8PKq82Y8VrJ+lsxTup5sTb1bI0YMFOM6GFS0wxIrvgS5O+A04kbU6cX+42Pi5hQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466204; c=relaxed/simple;
	bh=tSoXqLgUWKEPlcPGrGGG5vnVlOMJ3/7uHvBmF5jK5S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QHr+/kFQiCeWYwkoZd+5odRFP98ybWLWZFQkxtIEaczlMRLBrCkpCBCWqkni/UQDYyrmdv/ZjKOi8TBcw0NM3ku61aK4OGgwoatsAUyhcDOJHOHEZvtUQh5vMENwAX6NIvFaEO6qo+QBQg4Wq5it1V2DnhEizEIHsYKx1H2ftAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEi5zxmy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEi5zxmy"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so322211766b.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753466201; x=1754071001; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q8615+D1UCadk6QdEIlPmexwjvn4TmVGpZC3GE/aDw=;
        b=iEi5zxmyD3mtrLbj0ttk8NA/tMqK3HKCfyOGqPbgG6lUyIvraKlq1eGyQvPJI3WTLJ
         Hf+1w9z/85e9wMcf99dKdcS9ujm6pExgomTJrYfQyfMXNZDxgNlRMZPK/0SmcPgHvhB3
         /44lR16D+PNLnl9ziNeAKecY3uz1+mq9cUxzoCxBaNtKhJGGGp8e7STYwFo9KaPk+Oyf
         ozbkADXxW2WX2deiSNRN9CWxjtiaRF6a8IlMLSOcMV7Vx9AjZJES3QW0NtX37Ojz9dbw
         MiREaJXXl+zk3gc27nH03mivvjUeoHf3VkssBav9JnCVkaM5VyGem8tG0gMi7NeVI9gY
         BjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466201; x=1754071001;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Q8615+D1UCadk6QdEIlPmexwjvn4TmVGpZC3GE/aDw=;
        b=vy9WNem6skrFV5xrx/ao7f1ucdbdSfVNgJWBWwvZ+RAbPFnsb1Nizrv0GaQUHS1OoD
         kauBm1sHhYQiAGC1SJg+2ey7Zh/AdsGRX5SvSjI6i7TzTCqklawGmojiuzFPxK36JZ04
         fTbvh8DBJPl3v4fMbA0NybkQ4yqsOVrVjNyXkkMriFXX9yCOdm3bn/EGtiICrbsX/J93
         FhtDAsrcN1aAmoOTyEj4J4fQ23VzcQC650/pZ6poCjv+UNBYFHIeKSXdqG+gWIDozfXK
         EGIig5OfJ1f9WJSt8geYLAAN4tsFzccfdGUD5OdZYz1KWeO3R4s3V3yPS2LknVX6WZSh
         l1fg==
X-Forwarded-Encrypted: i=1; AJvYcCW6b4ILZ17EUd2cd7/loV3BGW+tixGCO07UlvhVoOXddAxY4XJlDASbYiRpYRqzcaKNJ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3qDtFIQunX0U144QLjiYkxfHTnztGtI8bMcRlDBAcUX25+Ry
	oAH4t8jV4uKh9TBdX6psg0EgYjh0i6TVMJtu386cV4MHnHMc9sD4Cf1/PIKii6Vzhu5FJSjSceb
	KXQTXaclliMtPjpBlexnHdLTFYHtrHJM=
X-Gm-Gg: ASbGncuClMPakL+JqGg2NkJ2N/A87RkoaXFA5MlMQALrrzg52Nz1P8iBGd4WUjkLfpD
	755rAgGmODzIyKWUEUfQP9LlaJ/JAu8HtHQi42tu+Vo9FwIIyLRLTiuSZUNvy0CS3vt3aRHDYus
	PCoIeaZt/GnLIm2saI3YF1qeLpk86n9t+PSZmKFY+gmKJfKKHi1UAXn1r932o52ZrZrdgVoXv6P
	xPqMywoc4SYbJw/68oQhgJxMUI=
X-Google-Smtp-Source: AGHT+IGGX6ErYQw4HVgJivm1avLXySPemOFt0oF3olxCouopw4sqsIiy0X0v/9SJcFoRI+0he46DAImCb1Su4HGYqEk=
X-Received: by 2002:a17:907:96a2:b0:ae3:f16e:4863 with SMTP id
 a640c23a62f3a-af61c2aeb94mr336831466b.1.1753466200465; Fri, 25 Jul 2025
 10:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFb3DeA9TwRnieajpa5S88ioc=65bUWh55mvDYz3CBp-xUcB3A@mail.gmail.com>
 <aIK-YVZWWAjHiIxE@fruit.crustytoothpaste.net>
In-Reply-To: <aIK-YVZWWAjHiIxE@fruit.crustytoothpaste.net>
From: Tim Cederquist <timcederquist@gmail.com>
Date: Fri, 25 Jul 2025 13:56:29 -0400
X-Gm-Features: Ac12FXxxAjvT-26gx-qiC9StVjzCKeNZDqqjUv0Cb1jbBRhBzBR6cRaQjSj28C8
Message-ID: <CAFb3DeD34EO3sYjinCzHVb8odO5+k13HNQ6m7Ru5KOCFP-nSGg@mail.gmail.com>
Subject: Re: git clone fsync error on FSx Ontap
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Tim Cederquist <timcederquist@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi brian,
Thank you for your quick feedback! I was not thinking of the immutable
file aspect, that's new for me and makes sense. Your feedback enabled
us to press the storage team and we are discovering we had a single
nic ontap that works and a dual nic ontap storage that doesn't, so it
appears your assessment of it being a storage failure is right on the
money.

Thank you again for your detailed response. It was very helpful!
Tim

On Thu, Jul 24, 2025 at 7:14=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-07-24 at 21:49:41, Tim Cederquist wrote:
> > What did you expect to happen? (Expected behavior)
> >   git clone https://github.com/githubtraining/hellogitworld.git
> >   Command should have cloned a public repository the NFS hosted home fo=
lder
> >
> > What happened instead? (Actual behavior)
> >
> > Cloning into 'hellogitworld'...
> > remote: Enumerating objects: 306, done.
> > remote: Counting objects: 100% (32/32), done.
> > remote: Compressing objects: 100% (13/13), done.
> > remote: Total 306 (delta 22), reused 19 (delta 19), pack-reused 274 (fr=
om 1)
> > Receiving objects: 100% (306/306), 95.63 KiB | 1.84 MiB/s, done.
> > Resolving deltas: 100% (70/70), done.
> > fatal: fsync error on
> > '/mnt/home/tcederquist/hellogitworld/.git/objects/pack/tmp_idx_gpahXY':
> > Permission denied
>
> This is definitely a bug in your NFS server.  EACCES is only a code you
> should see before you have a file descriptor.  Once you have a file
> descriptor (e.g., open(2) succeeded), the proper status code if it is
> not suitable for your purpose is EBADF.  (For instance, if you attempt
> to write(2) to a file open only for reading.)
>
> However, fsync(2) should never return EBADF or EACCES on a file open for
> writing.
>
> > fatal: fetch-pack: invalid index-pack output
> >
> > What's different between what you expected and what actually happened?
> >   fsync error - permission denied
> >
> > Anything else you want to add:
> >   From Ontap storage host sectrace events command, it indicates the
> > failure is due to the user not having 'Append' permissions to the file
> > and generated the fsync error.
> >   Running an strace on the git clone command shows the process runs
> > "openat" with 444 file permission but with O_RDWR flag.
> >   Ontap creates the file with 444 (read only) posix permission
> >   git continues on to write() into the read only file - ontap rejects
> > it and fails the command due to read only status of the file
>
> Yup, this is explicitly allowed by POSIX.
>
> >   I've tested with linux "instruction" command to set permission and
> > copy a file in a similar fashion:
> >     strace -f -o trace_install install -m 444 src.txt test/a/test4.txt
> >     This command opens the file handle 600, writes into it, and then
> > chmods to 444 << not using 444 to start the file as git clone is
> > trying to do.
> >   Additionally, I've added an inherited non-intrinsic permission to
> > the user of A:FD:tcederquist@domain:wa << this appends the required
> > write + append attribute and the FD means it is inherited by all files
> > and not overridden by posix permissions. This is not a solution but a
> > testable method. With this permission added, the git clone works as
> > expected.
> >   Suggestion is to use 600 on the openat/fopen for the pack index file
> > instead of 444. This is how 'install' sets up the file. However, I
> > don't know if this was an attempt at a cross platform mutex? I cannot
> > imagine any other reason why 444 would have been used for a file that
> > would have content written after opening with read only permissions.
>
> The goal is to create a file which has permissions honoured by the umask
> but is not at all writable.  There is no reason to write to a pack file
> or loose object once it's written: the file is immutable until it's no
> longer useful, at which point it's removed (which does not require write
> permission on the file).  POSIX requires that the restrictions set by
> the file mode be ignored when determining whether the file is open for
> writing, so your NFS server is not following the POSIX spec correctly.
>
> Note this is possible to do correctly over NFS, and many servers do so,
> but there are also unfortunately a large number of servers which do not
> honour the POSIX standard correctly.  In addition, this problem not only
> affects Git, but a wide variety of other software as well, including zsh
> and Emacs, as well as every other Git implementation I'm aware of, so us
> trying to work around it would still leave you with a server that didn't
> work properly with lots of software.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
