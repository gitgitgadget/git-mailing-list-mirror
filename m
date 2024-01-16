Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCD20B11
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435614; cv=none; b=uGGSsPOcxK3DQ5xfpRGxcQrItmvE5MvEap/pfdceHqPIztuOSnj3P5SMhmFarPem1vguGJeu+CKXl3rhcwrsJ2t5T/EItSk7RUJ6iv8Ndwrbl2Z4QSOiSygprOioNV1PfrtYPA7RrZ/4A6LPisGsKmRxio4OcvdDaEw1b+Js2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435614; c=relaxed/simple;
	bh=t3NdZJ1+xhhJFx8TE2fK33WPDcaD1gRyC72qf42ve7s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ZcqWOjaILL6D1XtbF55RIyz7oGv3Ov7SWogjk8VRqcWH40JHxS4e+SKsiIz626CJ93b+E22Hl6YSdiJMqEzTxO/DabamYp2gsSKwF2oiIEoT1rvdDvXjK0CbZqnNKeZVPpy/fzkyPemVTQNDx5T2QjqjkQLKE1vQg6yIT/fazkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyskzZxZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyskzZxZ"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbdbfaab70eso8709534276.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705435612; x=1706040412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zObHRsn6x+wW8AM3CbwULvZCf5RvlNKqRUVJWywwRE=;
        b=kyskzZxZHPCrRkqX59PIyIDbg2BMFrD/APjVqr2yoWaHcfR7uxLZOiP2iPDfHXuU55
         us3YgWwZDSUfhUcCT7FUuR9VGeiVsYeCDFf9+BMa9THO3Qyn2sZ5Xy+pawb6UOGazzd2
         TOWUEe5mIV8hmfWny8PO1/FQ/e5nKfWXbnfniaTOs4b3M+tWpJg0aGm8Hyk2pXMaUqsa
         9C8g2jhJvlx/AXEKy/Xt5V+Svt/sLxT8iNs6S5MBbnI1VuEh5rYSZ7aqlMuNrCEUQOT4
         VUMOjqufsY+vTrlEg1b1yxRdgAUHVq4mIxb1LPUigxe9ml1JgOcRZPuwA5Ws9p+3h/5N
         6J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705435612; x=1706040412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zObHRsn6x+wW8AM3CbwULvZCf5RvlNKqRUVJWywwRE=;
        b=HPLngq5lHbJjNO7R+PZOqOo5ID4qHmde8BuoI07tX5jhJLwK+RphiNhrcRWDfvmHkW
         AhJHfN0NkVTyY8fJzjhxH3cG4hPK9I6p4Tjys/1I3yA3F3qFqYSnYxALTutmSASguF24
         Ll8w5L0FNUr81azFk0sPv9FLKRfaJlcEbKmKbaaXoKFbX+tdqviyxPTLaQWMNIqJOVI6
         Hf09oGqoCFT4wygN4weKbje8uMD4KrEzL01K1PlypFimyDR647NiG2BSadAuMVgAI9rR
         EXM6gBYsDEcp591xcJrdt6MTdyyKzbyf10aQ4ggQblsmMkrKhwW0RUappmS9yfohN0Bf
         Dqlw==
X-Gm-Message-State: AOJu0Ywm8O4nXm6YOW8k+t76QQ3TBghAyappJ5/sff2zrWCpD+29mYKE
	u/74nZBZuX1orwSCv5uw2pY11WfNWCX0SBUemII=
X-Google-Smtp-Source: AGHT+IHBxyVCXReiSJXwRoU63l/ktvU0jRW+ocHzM69P+YLYaONhuYNSu/i76RAI0nXxUtRWr2HBp0LALi+/JJ/FNpA=
X-Received: by 2002:a05:6902:18d6:b0:dc2:352b:5879 with SMTP id
 ck22-20020a05690218d600b00dc2352b5879mr571126ybb.107.1705435610334; Tue, 16
 Jan 2024 12:06:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
 <xmqqcyu35rg9.fsf@gitster.g> <xmqq8r4r5ovf.fsf@gitster.g>
In-Reply-To: <xmqq8r4r5ovf.fsf@gitster.g>
From: Nikolay Edigaryev <edigaryev@gmail.com>
Date: Wed, 17 Jan 2024 00:06:39 +0400
Message-ID: <CAFX5hXR1S_pLr+HTyR5ucazniO+4qZC_DyivDELitwS-Emx4GQ@mail.gmail.com>
Subject: Re: [PATCH] clone: support cloning of filtered bundles
To: Junio C Hamano <gitster@pobox.com>
Cc: Nikolay Edigaryev via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Junio and Phillip,

Thanks a lot for the explanations of how this is supposed to work. It
seems that to make this work properly, we'd need to:

(1) add an argument (or an option) to 'git bundle create', so that
    the user will be able to explicitly request the inclusion of a
    desired remote's URL

Without such mechanism in place data leak is possible, e.g. remote with
credentials hardcoded in it.

(2) extend the 'gitformat-bundle' to include 'url'

However, a remote can have multiple URLs and other remote-specific
options might be necessary to properly work with it.

(3) add an argument (or an option) to 'git clone', so that the user
    will be able to explicitly request the write of the URL contained
    in the bundle to the repository's config

Otherwise, it's insecure, e.g. someone might craft a bundle with a URL
that collects data from the user.

I don't want waste anyone's time on this anymore because I've toyed with
'git bundle' a bit more and realized that what I'm trying to accomplish
can be done the other way:

1. git init

2. git bundle unbundle <PATH> | <script that swaps hashes and refs in
   'git bundle unbundle output' and feeds them to 'git update-ref'>

Hopefully this discussion will be useful for people looking to
accomplish something similar to what I've described in the initial
message.

On Mon, Jan 15, 2024 at 6:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> diff --git a/builtin/clone.c b/builtin/clone.c
> >> index c6357af9498..4b3fedf78ed 100644
> >> --- a/builtin/clone.c
> >> +++ b/builtin/clone.c
> >> @@ -1227,9 +1227,18 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
> >>
> >>              if (fd > 0)
> >>                      close(fd);
> >> +
> >> +            if (has_filter) {
> >> +                    strbuf_addf(&key, "remote.%s.promisor", remote_na=
me);
> >> +                    git_config_set(key.buf, "true");
> >> +                    strbuf_reset(&key);
> >> +
> >> +                    strbuf_addf(&key, "remote.%s.partialclonefilter",=
 remote_name);
> >> +                    git_config_set(key.buf, expand_list_objects_filte=
r_spec(&header.filter));
> >> +                    strbuf_reset(&key);
> >> +            }
> >> +
> >
> >> -# NEEDSWORK: 'git clone --bare' should be able to clone from a filter=
ed
> >> -# bundle, but that requires a change to promisor/filter config option=
s.
> > ...
> > But a bundle that were created with objects _omitted_ already?
> > ... the source of this clone operation, i.e. the bundle file that is
> > pointed at by "remote.$remote_name.url", cannot be that promisor.
>
> Extending the above a bit, one important way a bundle is used is as
> a medium for sneaker-net.  Instead of making a full clone over the
> network, if you can create a bundle that records all objects and all
> refs out of the source repository and then unbundle it in a
> different place to create a repository, you can tweak the resulting
> repository by either adding a separete remote or changing the
> remote.origin.url so that your subsequent fetch goes over the
> network to the repository you took the initial bundle from.
>
> The "tweak the resulting repository" part however MUST be done
> manually with the current system.  If we can optionally record the
> publically reachable URL of the source repository when we create a
> bundle file, and "git clone" on the receiving side can read the URL
> out of the bundle and act on it (e.g., show it to the user and offer
> to record it as remote.origin.url in the resulting repository---I do
> not think it is wise to do this silently without letting the user
> know from security's point of view), then the use of bundle files as
> a medium for sneaker-netting will become even easier.
>
> And once that is done, perhaps allowing a filtered bundle to act as
> a sneaker-net medium to simulate an initial filtered clone would
> make sense.  The promisor as well as the origin will be the network
> reachable URL and subsequent fetches (both deliberate ones via "git
> fetch" as well as lazy on-demand ones that backfills missing objects
> via the "promisor" access) would become possible.
>
> But without such a change to the bundle file format, allowing
> "clone" to finish and pretend the resulting repository is usable is
> somewhat irresponsible to the users.  The on-demand lazy fetch would
> fail after this code cloned from such a filtered bundle, no?
