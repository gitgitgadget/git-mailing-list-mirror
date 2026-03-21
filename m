Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4272EB0F
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774126049; cv=none; b=pVQH7emHmQFq+6VksybF2V8PL0Wh8L2a8SnF9ghiS1heTzl7NCIthAbbi40TWJdMRYl8ZHddS97qeqa4iDZ959tpg1CePgD3ib+VmX5HN/WSWPhKocAl4oevmOjOemqLr41EkrWEj2sujr+WDTh1oH+9I4bpWmi93DDOrekqWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774126049; c=relaxed/simple;
	bh=51Pg0aCT/8+5x97VCkpfSmkcKOyvicJwAodAHzWacHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNzaqLi14tn0hLZO88DLFRigQSyrWwa18PrD1p1N7TlKQQ7Y2VBE0WbzZkfcvn/oX78UXGFC6rO8u1LRqVuzM+X6uZw/U/TVC96SlUHqilrGmggrxF/S+i8kBcWpCuozx6dnE7oMQ19HFZ36DZfN8VzxMD7nVEIwma9joYSAyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=dx8QG6Z/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="dx8QG6Z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774126039; x=1774730839; i=l.s.r@web.de;
	bh=MXZQSAhMTXGmeAbAnc8J6gy8Xw6a3OVhmn+NYh5JvQc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dx8QG6Z/utr0oc0xO1eIMMB4Uo7va8VNJk9fIh36K+l7PEYLHbAvWH2zihTZ6h6I
	 v7rrtOTZ5mqMqKumobSHiqKk4gzJPdgGwKp3KS82MamqmIiy86dA6Kf6Acfvl2b8b
	 4PN9VEx+ixD58S7H6S/w5/L61gPMuMHa70LyAMewecO2M7VqOd5nMNjWE3AY5LS6h
	 ZJrliqtVXPooy/XMexDXFbnFM1g3wr6M8mCeGa33REaBd/b7DoasFQ54wJ2+Isl/F
	 TvgRT4PHheKzsuE8Cl8dpuOYxcIWSFK1I2f4VE9etmVTa8VGALQiGN9AWwQgQC/UV
	 4AdR7jpODGaF7Y81ig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcpt-1w7k6m0d7b-00QYGF; Sat, 21
 Mar 2026 21:47:19 +0100
Message-ID: <3e387439-c066-4e45-b28b-43f77c8824d6@web.de>
Date: Sat, 21 Mar 2026 21:47:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260319233546.GA3632561@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V0M79r0C7T3L4xvxu1UejgFGOg6dp+rDn8rzqNOkqgHlaDFE591
 Ia31mrTZngXiIOg7yzuDSlZeuiG5fAE12GXz4Y5yAEMmI0ed8uUkD4LftrLQUBjvJn6INda
 PKqQJKEjeU+zz1gW2hPstZrb8n7rHzswzml6K+LID8WskkYuTiYyHTOlJktd/SqDcptn+ev
 6fIq3xUtsusQyL6CsYClw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+rs/B+SFG2M=;FOFxjr2ZlsyQOGdKVKvt5wMiAR1
 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
 pqn0Zgq21o5kIokc+ge/

On 3/20/26 12:35 AM, Jeff King wrote:
>=20
> @@ -669,10 +673,13 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *f=
p, int term)
>  	 * we can just re-init, but otherwise we should make sure that our
>  	 * length is empty, and that the result is NUL-terminated.
>  	 */
> -	if (!sb->buf)
> +	if (!buf)
>  		strbuf_init(sb, 0);
> -	else
> -		strbuf_reset(sb);
> +	else {
> +		sb->buf =3D buf;
> +		sb->alloc =3D alloc;
> +		strbuf_reset(&sb);
> +	}
>  	return EOF;
>  }
>  #else
>=20
> So I don't know that it makes anything simpler. We have to copy the
> values back into the strbuf either way, and we still have to handle
> restoring the strbuf invariants. Even the strbuf_init() case is still
> needed, because we don't know whether getdelim() just didn't allocate
> (in which case we could leave the strbuf alone) or if it actually ate
> the allocation we passed in (which was just a copy of sb->buf).
And yet this function can turn an empty strbuf into an allocated one
without rolling it back on error, leaving code similar to this silly
example here leaking:

	int copy_one_line(FILE *in, FILE *out, int term)
	{
		struct strbuf sb =3D STRBUF_INIT;
		if (strbuf_getwholeline(&sb, in, term))
			return -1;
		fwrite(sb.buf, 1, sb.len, out);
		strbuf_release(&sb);
		return 0;
	}

Some strbuf functions restore the original state in such a case by
calling strbuf_release(), strbuf_getwholeline() doesn't.  If we are OK
with that then it could be simplified by growing the buffer upfront:

	int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
	{
		ssize_t r;

		strbuf_grow(sb, 0);
		errno =3D 0;
		r =3D getdelim(&sb->buf, &sb->alloc, term, fp);

		if (r > 0) {
			sb->len =3D r;
			return 0;
		}

		assert(r =3D=3D -1);
		if (errno =3D=3D ENOMEM)
			die("Out of memory, getdelim failed");
		strbuf_reset(sb);
		return EOF;
	}

Ren=C3=A9

