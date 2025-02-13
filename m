Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE21632DD
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466707; cv=none; b=nfu29q9r3eMJyaZ5Nkzux73ZA735w+dHQincGHwTNF4wo+sfjQOtmIPilzYk/Gl7jNSQDCZ16MdYrJyAH6XUmyJN8gwFXvoWJ2alZBSLdismr30y+iZnsyte75bpITXJ7wk5DJlpPUjy6x/wmQy2/rBWo4Hrtyl38X4YCea0Yik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466707; c=relaxed/simple;
	bh=MRas81PxBht2Vd20FddfmQE1en1/ND+50J82MbXR4bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mr01pkJPAiH7P+uiKcHLlxqTlvt3nyPfQcXHVzw/+ZDRvbZRrX295Q/lEL9YBjs0nn+33ft0srwTMz+v5m9QdgIO1qA0si5C+CkQ6ZPDubabP+aSjr5BKv5w1Hlnwo/lqkc4MibiXcfEPDyWlPcbwBRcAyJo7xE5hSSeqliVHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUTDVYA4; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUTDVYA4"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85532c7220cso84617939f.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739466705; x=1740071505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZInnFM27zgkQkpm1HXcg56sa/0HmNakjGVBN2b//Ioo=;
        b=FUTDVYA4mT4cnmoig2Ecq9hcEPbx0FHgcXPdJ8enmrhXbOzH4MCrv3iUJoUgpdOD9v
         xTpmn7f8bF6oxuXPn5Hvef4gd7u5duKm1TU9GAvHbGYONh+wjcHCUT2RH8wnbLl3qGQ2
         R6bUK7a+bbcTrpR4Y64jVA97rXMgjxHMsAJL2d8/27jHG1V8uf2FFg5PgJbxXPdDrpCg
         CQ83aTwz/do2IMWFyWurJ7PCGR6QDmccUBkAwO5hTCISeWcteQvUOotuRnbl727J0PHv
         V9w2R2al2HVuLSb5TFSMTFiNk474sPLFh74xpmZ5NEOebQFUq+1puPjk5WXwYwrtxuhd
         Zizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466705; x=1740071505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZInnFM27zgkQkpm1HXcg56sa/0HmNakjGVBN2b//Ioo=;
        b=L9C+puUD0t4zehamDVeN2ZcLzvftqGkIKgWjXxTxWRo+AEYwgNYY8ynu3bLSjejm8M
         9W7KxkBenDqN59lBGj1GOJfSR4IcpEz+MybC84e6EhiThqq1EVoh2iIjPWaqvkXQ2JrT
         QOipQCRazu2A0IeUiSKpxgLde6njAVO7xeXTVHPooiesoFEUXvyZCq0EPS+uZJ3+eoYa
         vCqsZUqthW5SAjyTJPU+XmxQCFONK3WkictCfEwBUhqf3tThX3eSBF4QQchthddbaJQl
         v9RsrUV1e/AnKQfVCSmuk/NJG0oTvsbYCBvlVzCXQvvS5J7bdLfu3lsHC6+cnXTXPo9H
         +qZA==
X-Gm-Message-State: AOJu0YxJ32LAPI8VUgq+uBa/8WnSd4nnuOh3VNwoDXUuMk3pk5zUqemL
	m0+G+qQPX0hp97zdvwVUdTrcW02HAebzoRd8JDEMES6eKR8ER9vD8zUCE0YPsSbywYXwAgflkar
	tsYQvu7jDm/I7CQJG9SdelCfq0I8=
X-Gm-Gg: ASbGncv+9O+CAsNoruSfLR8w53/7mCgCFWjiLeWq6NKp16Oq3Dz+aFMPLWXYHl1kCoC
	QAv8W4fDCi/eMapw/Sgnqt6iWbQkeERykZuqlD1ha9WKw5v372xnPw6eTWnsiV42xcIpChsvsu3
	cYOo1CUO22gZDEAeM+VEm20B7vLPTyAA==
X-Google-Smtp-Source: AGHT+IFsgMHz5/coXfNsscw19kyGpwYirVEOMk4AaWkVxm9cVlNTKslX0lY288e0oDBHhqJEXn+g+vPpVmVR76R13SI=
X-Received: by 2002:a05:6602:15d5:b0:855:6fa2:c324 with SMTP id
 ca18e2360f4ac-8556fa2ccc1mr10907539f.4.1739466704747; Thu, 13 Feb 2025
 09:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-3-meetsoni3017@gmail.com>
In-Reply-To: <20250213090040.16133-3-meetsoni3017@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Feb 2025 09:11:33 -0800
X-Gm-Features: AWEUYZkPKFU2rBFHXYylfUA532uI3RbmrZWle13d_vp8ecxRQU1O8sHlemcl3Ss
Message-ID: <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 1:01=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com> =
wrote:
>
> Previously, `get_unmerged()` used `string_list_insert()`, which has an
> O(n^2) complexity due to shifting elements on each insertion. It also
> called `string_list_lookup()` before insertion, which performs a binary
> search in O(log n).

Okay.

> This combination made insertion costly, especially
> for large index states, as each new entry required both a search and
> potentially shifting many elements.

Why does the combination make it costly?  O(log n) + O(n^2) is still
O(n^2), so I don't see why it matters to mention the combination.
Could you clarify?

Also, does it actually make it costly, or do you only suspect that it
does?  O(n^2) worst case sometimes behaves O(n) or O(n log n) in some
cases.  Since your commit message says "made insertion costly" instead
of "might make insertion costly", I think that would suggest you have
some performance numbers to back this up on some interesting real
world repository.  Do you?  Can you share them?

> Replace `string_list_insert()` with `string_list_append()` to achieve
> O(n) insertion. After all entries are added, sort the list in O(n log n)
> and remove duplicates in O(n), reducing the overall complexity to
> O(n log n).

Okay.

> This improves performance significantly for large datasets

That's a big claim; it may be true, but without evidence I don't
believe it for three reasons : (1) n here is the number of conflicts,
not the number of files in the repo or the number of lines being
merged.  Thus, n is typically small.  (2) Other O(n^2) behavior in
merge-recursive likely drowns this particular codepath out, so any
gains here just aren't going to be noticed, (3) After looking at the
code and knowing the specialized structure of the index, I think that
while string_list_insert() for n items in general is going to be
O(n^2), it will likely functionally be O(n log n) for this particular
code path, meaning you haven't actually improved the performance.

> while maintaining correctness.

More on that below.


> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>  merge-recursive.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 884ccf99a5..6165993429 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -547,15 +547,15 @@ static struct string_list *get_unmerged(struct inde=
x_state *istate)
>                 if (!ce_stage(ce))
>                         continue;
>
> -               item =3D string_list_lookup(unmerged, ce->name);
> -               if (!item) {
> -                       item =3D string_list_insert(unmerged, ce->name);
> -                       item->util =3D xcalloc(1, sizeof(struct stage_dat=
a));
> -               }
> +               item =3D string_list_append(unmerged, ce->name);
> +               item->util =3D xcalloc(1, sizeof(struct stage_data));
> +
>                 e =3D item->util;
>                 e->stages[ce_stage(ce)].mode =3D ce->ce_mode;
>                 oidcpy(&e->stages[ce_stage(ce)].oid, &ce->oid);

Did you run any tests?  I'm not sure you maintained correctness here.

>         }
> +       string_list_sort(unmerged);
> +       string_list_remove_duplicates(unmerged, 1);
>
>         return unmerged;
>  }
> --
> 2.34.1

(As a side note, due to the specialized structure of the input, I
suspect this code could be modified to run in O(n), i.e. we could skip
the string_list_lookup and the string_list_sort and the
string_list_remove_duplicates...  But, it'd make the code trickier, so
it'd need to be carefully commented, the change would need to be
justified, and it'd need to be carefully tested.  Even if we weren't
planning to delete this entire file, I suspect it's not possible to
find a case justifying such a change without optimizing several other
things in merge-recursive first, but optimizing those things probably
results in a significant rewrite...which we've already done with
merge-ort.)
