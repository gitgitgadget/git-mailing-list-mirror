Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8676293C4E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315114; cv=none; b=sq4AmCr/I61cdEJymWRMP7gMZ3LKUg9oxRIn3byw5gGMzT0/e4OnnEQh7ZSsKxfhJPnQe1KqAqsPdH0ephFCbVDu+wbvALe2kzPw45lNL9nypFD/cnsXUN6P/UqjjhMGu/YZmhXqDN0DjDQ+zFDIaqnUmGwoPJNdwlHpmGl0qx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315114; c=relaxed/simple;
	bh=5p5nUtKO+aoxO4Ygjw4VOrXzFudCwC0d7syMNIryuKU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=e6+ua1IC5uvNAAf4k55HMFxBdjjRox4pu4PkFUN0/lNo38dlafzlxxg+eh4X1Uns5m209Gp/sHqtz4+E0vbeH1k4KEjDjAQ/XtGF1sDy1d32jimxvfp1puRVQiWPeF6oGBtkdzsEWzd8wbEmEFpftma5fhEe9NQZYA0tUfS7KlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g89/Akfp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g89/Akfp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24c8ef94e5dso33107975ad.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757315112; x=1757919912; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRax/MOngoT8COgkIZ5o1CqlyrdyPatI6lai10viKQo=;
        b=g89/AkfpZh7vcPAoCi3SXrE1K9R4LtwUGFVbpZFSYiRew0FiH5sm7ibiBiUFyiHdeP
         MNdPPsfUZipFTyX0CFOx8FChi/lklPn/+fECZqefMnOJFdlLs6LJqwXNH8aC1KcLx9/Z
         ozFgsy2vB/XvoS5O8/clwXtXv8nlFcN9bBSCMk4vO/meMF2qBniWxd6Ow9jajeBXfooS
         7P0jov+4OLNivR95KE10LeooEMfq6QBXWYX5lyXNJTrbdrsydxBoO0AwqCpNGZ2o6lM8
         mo/K7lGaG/srKxaCBHPYFAQB03Zuii2MN1yG7k1cTpdO6ZhrW97ShUtlLsYkDe2Dw3tp
         QVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315112; x=1757919912;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bRax/MOngoT8COgkIZ5o1CqlyrdyPatI6lai10viKQo=;
        b=Rx7/lvNerxG5276vr9xf9tsK8cW2hmT4gO1PYJ5RxBHpH8AgsWy7zeh6uTlWBsOkZm
         jLnjBkzfVZ+3JyBHTq3TDuzHlbmziLpxF0cCQ0QrYe2IVw2wArAwQGqkaDsQ50BzecWn
         9pAkWP3t8PoM18al+WvcPL7b2hTCKrpc6Hlb1mDq5HM76BFIxLvUuGRPJ3nPhnoZQKMI
         G/d0jBEmCv3UhDQrg4m2tFVVvAFOmzrEk5RogwW1RAd2tgl+KveKn9K+DSeQg0zqdkMZ
         0mG6Llfi0uQdpAPZ1efGj6k7IJXBiOzT1yExxMqczlHD1McYoPvGavnU2sy+oH0IS22r
         yAng==
X-Forwarded-Encrypted: i=1; AJvYcCW00g0bKy99HC90rI4HYy8m3JINJ+CP8AQYNnthm75eKLMumWwtBz+mt4pkasSfC2KJ33A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhEerucAj6RwwAUCNvHPzdI0RwwLi+XVX42P1qcpXtRNESfRl
	VVMGcK7l6fEOPzSyYH0rQ0/6qvD1jYgVcKMVahKKdhzFj0x1PmmONZau2wQKqV0u
X-Gm-Gg: ASbGncvJ+B/id1Ir2LgojAxZC7PUYT6z5psdHOUDsyoEOPKl7hZs0zJUVQNpi+qJU9T
	uRWfkqd8pgH47SXdq0kSwx6ptTD70zB9GqwpMkjSrO/eQ7sNSotL4p+ImJKJAjojCcu8ScgD91W
	hwLGaYu5m2bJ6bSi6C8kgzft6i22WxmjZ3fjUUmK1eDidScRgMUoFOIcXHgbeOnH6KLDfzDT4EX
	R2cueN29vPis352FKiJm3MimfrYPhuPryBO8ge27+McXGN3b6N98g6Y6sgYzvo+S10CPuIvzS7g
	4GLynErSw86FbvcUEFLf61e3dRw3F5qqQcEssX2sd+ThZAtYDlYyaqoCLYo3WCD98dwwP/zMESX
	C/N6rsv+YTD7CIlc6k4a6T2ZVK5nib8vXCCgFyistd4Mw29tA9/LTIjoTJMZYhmD1FsHuwbKaRA
	==
X-Google-Smtp-Source: AGHT+IH8AKtkszUdm3WO4qKfqZxvlKw6GjzZ4tnv81WISWsN6AtXoKClNdWnM3ztuviQ3TsIv4ikKQ==
X-Received: by 2002:a17:903:22c3:b0:253:65e4:205f with SMTP id d9443c01a7336-25365e4e33dmr68902855ad.3.1757315111847;
        Mon, 08 Sep 2025 00:05:11 -0700 (PDT)
Received: from localhost ([106.51.239.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e445d875sm17695294a91.11.2025.09.08.00.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:05:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 12:35:08 +0530
Message-Id: <DCN87S14V9G8.3BAV5XX1BDHKM@gmail.com>
Subject: Re: Running out of inodes on an NFS which stores repos
From: "Kousik Sanagavarapu" <five231003@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, "Kousik Sanagavarapu"
 <five231003@gmail.com>, <git@vger.kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20250906141711.64419-1-five231003@gmail.com>
 <aLxUkTzuVaZrWDs2@fruit.crustytoothpaste.net>
In-Reply-To: <aLxUkTzuVaZrWDs2@fruit.crustytoothpaste.net>

On Sat Sep 6, 2025 at 9:04 PM IST, brian m. carlson wrote:
> On 2025-09-06 at 14:16:12, Kousik Sanagavarapu wrote:
>> Hello everyone,
>
> Hi,
>
>> These git repos come from another service and there are typically
>> thousands of them each day. It is important to note that we only store
>> the .git dir and expose a url which is configured as the remote by
>> default to read and write into this repo.
>>
>> All of these are small repos; usually not many files and not many
>> commits too - I'd say ~5 commits on average.
>>
>> Historically, when we ran out of inodes, we had implemented a few
>> strategies where we used to repack the objects or archive the older
>> repos and move them into another store and bring them back into this
>> NFS and unarchive the repo.
>>
>> However, none of these totally mitigated the issue and we still run
>> into issue as the traffic increases. As a last resort,  we increased
>> the disk size even though there was ton of free space left - just
>> for increasing the number of inodes.
>>
>> We can't delete any of these repos, no matter how old, because they are
>> valuable data.
>>
>> I was wondering if there was some other strategy that we could implement
>> here as this seems like a problem that people might often run into. It
>> would really help to here your thoughts or if you could point me to
>> anywhere else.
>
> There are a couple things that come to mind here.  You can try to set
> `fetch.unpackLimit` to 1, which will cause of the objects pushed into
> the repository to end up in a pack.  That means you'll usually have
> only two files, the pack and index, rather than the loose objects.

Thanks for this, I have tried this out and while going through the
surrounding documentation, found `transfer.unpackLimit`. This was exactly
what I was looking for.

> If you have a large number of references, you may wish to convert the
> repositories to use the reftable backend instead of the files backend
> (via `git refs migrate --ref-format=3Dreftable`), which will also tend to
> use fewer files on disk.  Note that this requires a relatively new Git,
> so if you need to access these repositories with an older Git version,
> don't do this.
>
> You can also periodically repack more frequently if you set
> `gc.autoPackLimit` to a smaller number (in conjunction with
> `fetch.unpackLimit` above).  If you have repositories that are not
> packed at all, running `git gc` (or, if you don't want to remove any
> objects, `git repack -d --cruft`), which will likely reduce the number
> of loose objects and result in more objects being packed.

Yes, I have now set the following config surrounding gc

	[receive]
		autogc =3D true
	[gc]
		auto =3D 1
		autopacklimit =3D 1

Curious to know if this will have any noticable performance impact
though. As I mentioned in my previous msg, these are small repos but the
number of repos being created and the operations performed on them are
large - mostly pushes,

> Finally, it may be useful to you to reformat the underlying file system
> in a way that has more inodes.  I know ext4 supports a larger inode
> ratio for repositories with many small files.  Alternatively, apparently
> btrfs does not have a fixed inode ratio, so that may be helpful to avoid
> running out of inodes.  I can't speak to non-Linux file systems, though.

Unfourtunately, I can't reformat the NFS. It is currently on ext4 and
even though there are quite a few filesystems which don't impose a
threshold on inodes, I can't migrate to them.
