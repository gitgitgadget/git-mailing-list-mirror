Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F71CEAB2
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633077; cv=none; b=UnqH1I+rRXm3WlHuWJ7AIwgi9V0RXg4NsZHi8gdf/XscGZzSZn7z7P88XoI3N69Oe7REkIqbUXSsCFFnYNHoAyLutUfWd2zAsUbh8NBTHO7pcTOK+5w9tILvRo5PhgJ0Jf0yP9V9u2V8tz4r/Fg/HboUgk9H1RCgFkJ0H3gG/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633077; c=relaxed/simple;
	bh=fTcPmDwoWGN01QCHcaOr3ePuFJJJgpcx2aZ9h/D2z0w=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=TC2q76Md3AMdzJiOgRFb74O5VIsfUFmr/H6Sbls6uP6SD9uXJMkemnXOs1txHT6wypjjCfhC8oWupEFNWbhZNE29eMEJmr+GBPUTI9imrD4qztHAvBRjOom6mCG+b2FqrY75jY+TuiCPqT2BK07PUEbVFdGE5RT32eb0wBrnI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=GjeKhHZB; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="GjeKhHZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=FdSN6ohOhCixEn3NmNE7LhNgtLctCw7nMr32O/4mb3A=;
 b=GjeKhHZBTgXL5DXIeMozyl6zRLBiTafE6cSVQOnZxm8cgh5yII/xGatVYBBs17n6PlbbvLkFQWnc
   hGaeAPCEnRlLZHcA9R6sNzB8XhG+75oWq3af8oInB5fAB6grS3fE8T/oXDiAJGKa0OmrhjXw62Zv
   8bxEzfJmnLngza3fIjv+MYCQe55QoumGwib+oURnMk26GVizOBl7CabNyVNJ6dp7TcfpYW4gSlyv
   4CKYUlkRxTJYJnf6ciE5HIg052wPKUlf2Z8WE7XMERE5bRA9pSrAoGiXvMGPu60KyoLtKHugpW70
   exHzYG+b4l5pTAdjceNjKc5GdzL65uzCrkoocQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNK00OM2C8ANM60@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 26 Nov 2024 14:57:46 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 26 Nov 2024 15:57:27 +0100
Message-id: <D5W75LQ6Z44H.3LKJ0OX40QKVQ@ferdinandy.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
Cc: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>,
 <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com>
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
 <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
 <CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
 <D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com> <xmqqwmgs6mxk.fsf@gitster.g>
In-reply-to: <xmqqwmgs6mxk.fsf@gitster.g>
Reporting-Meta:
 AAHrCFbdGFNgWmFYLR8CVguzGdlo4TSC0OsRNL1hOB6ViNoYXbxLk4GKu4skm73T
 2Oi8itx924I0TpXGFDwbDXlcuY9pbD+Mq0ancM6h4ibcIU1qcrSd7udLCLOlPFvN
 k2GwBU/ZKXh0mAyEY6qaBnKSlFODCfYHVvKID0KOrbKTQ2psgGZDvEVSkEOBOcTw
 Rph+dIuUcAINt0wfP5ll44mHu23cqOzU15kqHnhUPxLOGJvAY+g8xQBiUmGmvbg1
 t6guCA0wo+2Kk31C+hQZzBnL8KZgrKWvc92Dsnb0cPJntZ3UNJjPJUlHWqxw6UNX
 ONvJGJKRvUZy3y03BmyFdnH7+owgXJUH+Yz35lRtnSp0sr4S0ayTfKBK81zfZ0m0
 8bqmCHC82suXU16YVY0TlHGw05sKtQoerLVUtuEPoGhoLZ9La03Np/0OhEGpQc50
 8EXrkmdI1BikSB8v9U6c4GKraDXluiu9TO45mZyvnziuCN66NYTOzt0=

sorry about the other thread, I saw "extend whitespace checks" and I though=
t
based on what Kartik wrote that `log --check` should have caught it, which =
is
why I thought it might be appropriate there.

On Mon Nov 25, 2024 at 03:56, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>>> At the least you should see `git log`'s output, but if there are issues
>>> they should be shown inline. So when you say 'no output' do you mean yo=
u
>>> see absolutely no output?
>>
>> Absolutely no output:
>> 	https://asciinema.org/a/lsqp4e1bNst6cFWw9M2jX1IqC
>>
>> But I figured out why: the whitespace and the tabs were not mixed on the=
 line,
>> just across lines. As I read it, that is not an error to have tabs on on=
e line
>> and spaces on the next.
>
> Our .gitattribute starts like so:
>
>     * whitespace=3D!indent,trail,space
>     *.[ch] whitespace=3Dindent,trail,space diff=3Dcpp
>
> so, unless otherwise specified, we frown upon trailing whitespace
> and space before tab and indenting with non tab is permitted, but C
> source and header files have further care about "indent" (short for
> "indent-with-non-tab".
>
> So mixed or not, if you indented with spaces and not tabs, that
> would be noticed.

So `git log --check --pretty=3Dformat:"---% h% s"` was _not_ supposed to ca=
tch
this?

I ran the CI with this patch again:
https://github.com/ferdinandyb/git/actions/runs/12031250376

and it's all green, so wherever this _should_ have been caught: it didn't w=
ork.



>
>> Anyhow that should be now cleared up, thanks. Gotta say, I was expecting=
 to
>> learn about internals doing this, but I also ended up picking up a coupl=
e of
>> usage things as well, like --range-diff for format patch and such.
>
> I usually have "--whitespace=3Dfix" so if you did "git log" on the
> commits I made out of your patches, it is not surprising if your
> "log --check" was silent.
>
> I re-applied your v14 with "git am -s --whitespace=3Dnowarn" and here
> is what I saw.
>
> commit 75a6a3e6597d5f3959eb269122e8c5f4e4baac0e
> Author: Bence Ferdinandy <bence@ferdinandy.com>
> Date:   Thu Nov 21 23:55:03 2024 +0100
>
>     refs: standardize output of refs_read_symbolic_ref
>    =20
>     When the symbolic reference we want to read with refs_read_symbolic_r=
ef
>     is actually not a symbolic reference, the files and the reftable
>     backends return different values (1 and -1 respectively). Standardize
>     the returned values so that 0 is success, -1 is a generic error and -=
2
>     is that the reference was actually non-symbolic.
>    =20
>     Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> refs/reftable-backend.c:833: indent with spaces.
> +        if (ret)
> refs/reftable-backend.c:834: indent with spaces.
> +                ret =3D -1;
> refs/reftable-backend.c:835: indent with spaces.
> +        else if (ref.value_type =3D=3D REFTABLE_REF_SYMREF)
> refs/reftable-backend.c:837: indent with spaces.
> +        else
> refs/reftable-backend.c:838: indent with spaces.
> +                ret =3D NOT_A_SYMREF;

So this did find it. Maybe something is misconfigured in the CI?

Best,
Bence

