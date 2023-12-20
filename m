Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D612482D7
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo4ZUJZP"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d7e67d31caso4737b3a.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 11:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703098992; x=1703703792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaHMeYN9ttdrsXCCDPxoLTm1fRFofteyYyP/TG7n+E4=;
        b=Yo4ZUJZPNhp3yoP8XcJCUe4zfNrV6o1Iy36KvjEWtgK0VTyzBkWccsOcEk55WFNIby
         EHSGj/XQMuVC2FIJcteY+B4CqoKMmsKhUKQyQsXDIMqWTPkPmui2CgpVpE1UdC0kjxK9
         KVFVq6+oNOLrdoaaZovLIQVe976aWgP4ImdGHT4cIKqKRIPO1ZhzuFRMz821S1NiPg5u
         GSGWmZJz/sQhfSZlNGabokzd2TdyC+U9DBL6GH81x2xtJak/aHCUHLvrGiUcoAA5vKM9
         ObPbCzkt6cXtadzniJE3olDgIcIfl7WuVpB9uI7t0Rch8FvwA6obcmj20ozdM5oHQKwN
         yG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703098992; x=1703703792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaHMeYN9ttdrsXCCDPxoLTm1fRFofteyYyP/TG7n+E4=;
        b=I7DTxiDqiD1YNV0kraFolSwnrZHWx59sXkg2conB8CTdZS0Lei1RtSufF3MlYP2zGX
         CVu9yTJE/5xvpOLLCgopBVdlsoXHxCyZRioSXBM9Bw0mc1Tu5SUmnZErKG4U1HWZFYyv
         DY83g2kLCGVsw2hKvfRJ6f8dhV5rwLM6WiOYnu4+lwLk7l3cZCGMjCdIrcIC5MgxvOHy
         2pYYxDUwKYJbLlHVSvAiMlh8Xn9PKXw3M3mbylKs8tntbPfJTQOdEM7M1tl3kdpF73LX
         XU7xfRimtdchV++2koWsydxOBruqClzr/7odL8nVXvRFQwQVaJM2FEC965CVNHqrjMQy
         LKAQ==
X-Gm-Message-State: AOJu0YyX7Z9gkJrxm3QGlW5beTuAx7AdFDwvedVrAeVEtdYwd/isA6O2
	p+bYRWCDbrNrVu9PzoGT1cJD7J/k0WR0d3jZOXw=
X-Google-Smtp-Source: AGHT+IFBRXfaf73yffCzisuvdKU5Cnm8QyJxppAHpMHmNVeGX75rRIYNxvjZ9Ir8EpO+ebJX+CennD9+Ta+z+XZHSH0=
X-Received: by 2002:aa7:8742:0:b0:6d9:4ac6:1585 with SMTP id
 g2-20020aa78742000000b006d94ac61585mr1030262pfo.28.1703098991693; Wed, 20 Dec
 2023 11:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVy0zKcmc8tjmgzs@tanuki>
In-Reply-To: <ZVy0zKcmc8tjmgzs@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 20 Dec 2023 20:03:00 +0100
Message-ID: <CAOw_e7aDPTjDj_K3yyyatWkw3R-oT+_u1LgZyzQEE=6LnH+pmg@mail.gmail.com>
Subject: Re: reftable: How to represent deleted referees of symrefs in the reflog?
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>, 
	Terry Parker <tparker@google.com>, Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 2:46=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> To me it seems like deletions in this case only delete a particular log
> entry instead of the complete log for a particular reference. And some
> older discussion [1] seems to confirm my hunch that a complete reflog is
> deleted not with `log_type =3D 0x0`, but instead by writing the null
> object ID as new ID.

No, writing a null OID (more precisely a transition from $SHA1 =3D>
$ZERO) means that a branch was at $SHA1, and then was deleted. The
reflog continues to exist, and new entries may be added by reviving
the branch. That would add a $ZERO =3D> $NEWSHA transition, but the
history of the branch prior to its deletion is retained.

>  # This behaviour is a bit more on the weird side. We delete the
>  # referee, and that causes the files backend to claim that the reflog
>  # for HEAD is gone, as well. The reflog still exists though, as
>  # demonstrated in the next command.
>  $ git update-ref -m delete-main -d refs/heads/main
>  $ git reflog show HEAD
> fatal: ambiguous argument 'HEAD': unknown revision or path not in the wor=
king tree.

This looks wrong to me. HEAD has a history, and that history didn't go
away because the current branch happened to be deleted.

> It kind of feels like the second step in the files backend where the
> reflog is claimed to not exist is buggy -- I'd have expected to still

right, I agree.

> see the reflog, as the HEAD reference exists quite alright and has never
> stopped to exist. And in the third step, I'd have expected to see three
> reflog entries, including the deletion that is indeed still present in
> the on-disk logfile.
>
> But with the reftable backend the problem becomes worse: we cannot even
> represent the fact that the reflog still exists, but that the deletion
> of the referee has caused the HEAD to point to the null OID, because the
> null OID indicates complete deletion of the reflog.

This doesn't match my recollection. See
https://github.com/git/git/pull/1215, or more precisely
https://github.com/git/git/blob/3b2c5ddb28fa42a8c944373bea2ca756b1723908/re=
fs/reftable-backend.c#L1582

Removing the entire reflog means removing all the individual entries
using tombstones.

> Consequentially, if
> we wrote the null OID, we'd only be able to see the last log entry here.
>
> It may totally be that I'm missing something obvious here. But if not,
> it leaves us with a couple of options for how to fix it:
>
>     1. Disregard this edge case and accept that the reftable backend
>        does not do exactly the same thing as the files backend in very
>        specific situations like this.

I remember discussing with Jun that it would be acceptable to have
slight semantic differences if unavoidable for the reflogs, and there
should be a record of this in the list.  I think there will always be
some differences: for example, dropping reflogs because of a dir/file
conflict seems like a bug rather than a feature.

>     2. Change the reftable format so that it can discern these cases,
>        e.g. by indicating deletion via a new log type.

This will be a bit messy, because it means that every read of the
reflog has to special case the "deletion marker" to make sure it is
absent, and on every reflog write, you have to create a tombstone for
the deletion marker, to make sure the reflog exists. Also, what if you
have something that looks like:

refs/main@1 : 0000... =3D> 345....
refs/main@0xfffffff:  DELETION

the reflog doesn't exists ("DELETION"), and now it is recreated, ie.
the following is added:

refs/main@0xfffffff:  TOMBSTONE DELETION (make sure reflog exists)
refs/main@2 : 0000... =3D> abc.... (the entry we want to write)

the result is that the reflog would also surface the first entry (@1 ,
000... =3D> 345... ) again. To prevent that from happening, you have to
write tombstones for all entries if you "delete the reflog", but then
do you really need a separate existence marker?

> None of these alternatives feel particularly great to me. In my opinion
> (2) is likely the best option, but would require us to change the format
> format that's already in use by Google in the context of multiple
> projects. So I'm not quite sure how thrilled you folks at Google and
> other users of the reftable library are with this prospect.

Google uses reftable for datacenter-local serving. The reflog is
stored in a database, because it's never involved in serving traffic.
When I implemented reftable-on-filesystem, I found a few bugs in the
reflog code because it was never exercised at Google. Terry/Jonathan
may correct me if my knowledge is outdated.

Luca manages large Gerrit installations. He might know if anyone has
been using reftable in the wild.

HTH.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
