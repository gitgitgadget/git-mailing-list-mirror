Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CC14A8B
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404568; cv=none; b=g3fGbqosHTiLJeods9WJ3Ws6s6lPyULT3izTFG6EQkXZA5X9N9Rfi/gd1PwrjBS6bCmZ9gZEYX3507TL2NW0lPlo0vZM3wn8uFtm9kytv3nFjWivpPMn54SSi0UU28sfDEyveGWP10hK9LjsiK+8zTHbRg0KIgN7MYxHmmB86hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404568; c=relaxed/simple;
	bh=322FKPXK02gs3ezo3obk/JbreJueC/0X5QgD4e5rB9U=;
	h=Date:From:To:Cc:Message-id:In-reply-to:References:Subject:
	 MIME-version:Content-type; b=eEdE+US5v9SJw3jAZHTyWAoUJ4shdPZ1zLesSVr69seCiMBaw88HOdrTrkGPofLckxfM68/HonDjaz85490yVIXTbbWgrwMLULsTVpUprkBHlXVjRGI+D1M05gbfgoHFkM60q+gsCXfIwh3WIdAKftaLYOYFrlNNH+CjzBqUiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=UKsRpZW2; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="UKsRpZW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=322FKPXK02gs3ezo3obk/JbreJueC/0X5QgD4e5rB9U=;
 b=UKsRpZW2E7/Zf92uQUKWdWhK3QRfQF6qYGensqRNLZWqaBkgT5Djsm6CAQnSQo485vD8TLQNUoRi
   tdRXIfd9BhAsJbHu4iDbKL1UVYvevvMShycJonMfawmjTo+8Ronu8g59UfvGFMExmDGPZke0MoTM
   90eASQMQwnxmNQGiffRIAZu2jwRj/yUb/HuOVmYHZ3aFwbb0V7nWYQVuvmQfmT3rQW+OHcUOAIGn
   QdxTU+4utUKeoUo9NuoU6WVQ+IBLo1U9EsW3kp1dTMYCBZAfXjeVrj3oW8QFRGAY/jVATv8BABov
   AfkMxM9yDxRQ9mNEbiBl/5FkdcYBI4GN1pflJw==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20250214 64bit (built Feb 14
 2025))
 with ESMTPS id <0SSS00AYUC4E8WA0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 08 Mar 2025 03:24:14 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Date: Sat, 8 Mar 2025 04:23:00 +0100 (GMT+01:00)
From: Bence Ferdinandy <bence@ferdinandy.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Igor Todorovski <itodorov@ca.ibm.com>
Message-id: <6d77cffc-94a3-42ca-938d-791256b508fd@ferdinandy.com>
In-reply-to:
 <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
Subject: Re: [PATCH] fetch: fix following tags when fetching specific OID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: quoted-printable
X-Correlation-ID: <6d77cffc-94a3-42ca-938d-791256b508fd@ferdinandy.com>
Reporting-Meta:
 AAGkFeCys0q8uen8CljnbhrRMwhiJd0Po+wTmeYpSuiJcBmQbYpeoP0T6I1ljy7D
 pbK6V+bz1/QDPA43FX7bWONhf/wB7B99C6zkZfArBdKpiKY3M6wa2v+w71XIBSbt
 kQ3Rd4dS427yn+PBDClctbiYfbJKvuktV7UQHlWw1bbssa6VuqkFtkEZEKEvaaF2
 CbzYCXTmOOq2QyWaQE9WBA6pZhHcBaTJbZl2M72Sg7XoAtOV6giO9PMbtfZNqanm
 iTP2Ln2leOhK+zKNCS2VpcVXXfQcg+nqNJjmX1FgWAcnbqBUuowN/ss6avCvu869
 neP3Bv3PO0qCbEb5J3aJMmQ3IOD+JZG1HZ4DOltpRHHoNL69pGJ5ipQhYn1V01Uo
 ha0PXZp3BAH5pHfvUQ7I9KK05jG4PDcGiVpTXagw4gPTnI9pR+6lvLN27SN5KrXn
 ebOLzIzSBei4L6oF7zPsOG2Dg65BbMG4MTMQ4CkLRGRnVXZ224GuTlA=

2025. m=C3=A1rc. 8. 0:27:43 Taylor Blau <me@ttaylorr.com>:

> In 3f763ddf28 (fetch: set remote/HEAD if it does not exist,=20
> 2024-11-22),
> unconditionally adds "HEAD" to the list of ref prefixes we send to the
> server.
>
> This breaks a core assumption that the list of prefixes we send to the
> server is complete. We must either send all prefixes we care about, or
> none at all (in the latter case the server then advertises everything).
>
> The tag following code is careful to only add "refs/tags/" to the list
> of prefixes if there are already entries in the prefix list. But=20
> because
> the new code from 3f763ddf28 runs after the tag code, and because it
> unconditionally adds to the prefix list, we may end up with a prefix
> list that _should_ have "refs/tags/" in it, but doesn't.
>
> When that is the case, the server does not advertise any tags, and our
> auto-following breaks because we never learned about any tags in the
> first place.
>
> Fix this by only adding "HEAD" to the ref prefixes when we know that we
> are already limiting the advertisement. In either case we'll learn=20
> about
> HEAD (either through the limited advertisement, or implicitly through a
> full advertisement).
>
> Reported-by: Igor Todorovski <itodorov@ca.ibm.com>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Peff and I talked about this today, and neither of us could find any
> reasons not to pursue the approach listed in the footnote of
>
> =C2=A0 <20250221072558.GA572877@coredump.intra.peff.net>
>
> , but this is a more conservative approach that should fix the issue=20
> and
> apply cleanly on top of 'maint'. It may be worth picking this into=20
> 2.49,
> even though we are already quite late into the -rc cycle, this is a
> fairly nasty bug.
>
> builtin/fetch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
> t/t5503-tagfollow.sh | 15 +++++++++++++++
> 2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fe2b26c74ae..a06d1305016 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1777,7 +1777,9 @@ static int do_fetch(struct transport *transport,
>
> =C2=A0=C2=A0=C2=A0 if (uses_remote_tracking(transport, rs)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 must_list_refs =3D 1;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strvec_push(&transport_ls_refs_opti=
ons.ref_prefixes, "HEAD");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (transport_ls_refs_options.ref_p=
refixes.nr)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strvec_push=
(&transport_ls_refs_options.ref_prefixes,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "HEAD");
> =C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0 if (must_list_refs) {
> diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> index 195fc64dd44..8495730e264 100755
> --- a/t/t5503-tagfollow.sh
> +++ b/t/t5503-tagfollow.sh
> @@ -160,4 +160,19 @@ test_expect_success 'new clone fetch main and=20
> tags' '
> =C2=A0=C2=A0=C2=A0 test_cmp expect actual
> '
>
> +test_expect_success 'fetch specific OID with tag following' '
> +=C2=A0=C2=A0 rm -f $U &&
> +=C2=A0=C2=A0 git init --bare clone3.git &&
> +=C2=A0=C2=A0 (
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cd clone3.git &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git remote add origin .. &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git fetch origin $B:refs/heads/main=
 &&
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git -C .. for-each-ref >expect &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git for-each-ref >actual &&
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_cmp expect actual
> +=C2=A0=C2=A0 )
> +'
> +
> test_done
>
> base-commit: f93ff170b93a1782659637824b25923245ac9dd1
> --
> 2.48.1.1.g965d2fe18fa

Thanks for cleaning up my mess!
