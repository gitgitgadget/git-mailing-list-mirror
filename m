Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84201634FD
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201039; cv=none; b=Vry8F+0fYLNUjkTZCNcgNbuCRGU73vvNb+1XMR12xWgTfJljIRRrZorv6LrfM4/zwe2jRNQDzIJb2oZiHQJJQkFQL7GaGGSHux4jOrGWzOlGwyjab92Ybt/jO/vP9gXsvVMgx6Hl02p+HEHEnbQqKVqHckk5ntydS09wxfHE+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201039; c=relaxed/simple;
	bh=vnSOaMxtBQOC8buvsyZCq55ty0UENrMrcOxApN7LKTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjdVtmAxzsyDgM5c7EeQjGIz/kIgzJGYSdIqtl+4RZDBz2OI3Iq1pHmh1ZXsTGAAXSg+CjxxuaW+c6GbdsP+7H3U5zn5L9swJjo+GM/dUP6g8OIRMiAGuZKSzLdxB1M5+HO33bRHtlD3IH6ZM5GU8zge57Dt8V9b3lQ+vO6A000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=lpWYCgB+; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="lpWYCgB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709201031; x=1709805831; i=oswald.buddenhagen@gmx.de;
	bh=vnSOaMxtBQOC8buvsyZCq55ty0UENrMrcOxApN7LKTI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=lpWYCgB+M9W+FbqhW5NqA/h6guqdvBT5cko/0qfJ9bUAeaci5h1jYqHJjUtUp9cs
	 3z5ESfzWsOuS9s56XslO3Oa1zHXz7KDQuAJWwcI1NtiqPv0B1hzpkE+wrhLrP30Lb
	 wxrKNuSD6DYZqLNRropapJmF72zRmHGqfwl63qfyx39GSKaaXGIQlzqEIeMFAqVNR
	 Gw3XhT7mYQJz1GB514zFD0PfPRu4hp3wzKW5Tsqj+f9QaWpq7/Iuf0YG5zJrZqVfW
	 Xbe2GTWC19S9MmpAxWA8HKutcgsitYenZNZuiymtM0/3fWgSb+fQdxmDUi1L31t1C
	 2fBElwpH1IaLABS/kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.106]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1qpS5M3I2M-00rXTM; Thu, 29
 Feb 2024 11:03:50 +0100
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rfdGY-Z09-00; Thu, 29 Feb 2024 11:03:50 +0100
Date: Thu, 29 Feb 2024 11:03:50 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFD] should "git log --graph -g" work and if so how?
Message-ID: <ZeBWhkSwec7PmQID@ugly>
References: <xmqqo7c5n0ob.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqo7c5n0ob.fsf@gitster.g>
X-Provags-ID: V03:K1:tKDXwGqhgW79IZA7zw8ASLfgy4E+ffnD3SN3RFBNBpuEgze9TrQ
 cm+gPSjgKD+NAAIJfjKLmUmTboQUso7xuqYUKTQP5l5HLA7hn/BP4Mg/xYB1FrcOWy4nPyL
 RLjlUna+S71Kjqph9EWfFcHekXpoXasWK2x+jHaEb9s3/z1pM5UoeIYVQatP1JqVm/zu797
 x3JYW0GGnIn3YPDQZfbug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FIm1aUEpaQc=;QSVihdXFCudw5/d3c567prxJbNn
 NtpP17pfJCVPcvcRPLtC+8+gIlqU95WV7U86h8bASf4AM1Fhu2By9SwU3uLgOT8L5Yo5uYS1D
 3FbehlJGrpNVztgPjcxeVrYbe6+2ihBhA8Tiu3U9cfYVA/78fURUnHifLjEqktA0H+EIZjy1Y
 DC0yLbLiKIsNw+/xp6aNIc3T2A112vC8PUywfSJkdj7MM4EaYLhr6sO6wPKyFuJnt1W2GnYKb
 kGNiHuFo993fZHXzH7pe+WaitasWe0EbB/T+40+L9fCUSi0k68E2z0pM/9k7ewBvIjt5qSo4/
 RboLh7mMYus9kOeuhuDFeZ5q4p6F3xmqfJ1gxBbBMJbjfYOa6WRRT46/kKzVfs01tPyan4g5U
 dfSz/YWTEB80BTE+nXmKoMF6ySoHPPybDOXIDqdHzF5cPyjgMgjK4OwNhore+ZZI9VWdbvpLT
 iL+nOGsN8U364gjKlCjAduAYrzC5XfnYcOvNzsLJc+H/cWp4/34OzDyJJLCZJEgfRAQlWwnIj
 Az9p7Gm7nhasv10CaOeGI/D6RF86h6VtUWz920GhRV29GCJxvTOgppDmgY2Q6vnwzPlQ1Qjvr
 YvPIRd/g1Gbpiw91osDZlia4dm4JXbj/+ume802edID75WKe8ik4lEQqu7Q3IPGk3++fhWXJx
 4Z/+tgm9neBpP+oaCYyWB7g0o0UBHAVs2i1rV6NHnOn0wXq0QG6BW99NaO362jK1foepFxsI9
 X6/kTwYgHvlTrK06hVrqx5FMmZcXcoc+fBZ27T4NFXWLCzWKaY3PhkcCR4vxTOs9PXv+6C+Gq
 1yhVmo6+7ngimwD5WrCGlNRj6WSN2E6KU3qEvURx+nMJI=
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 11:04:52AM -0800, Junio C Hamano wrote:
>Now, if I could run
>
>    $ git log --oneline --graph -g --since=3D2024-02-20 --boundary
>
>on the result, such a history might look like this:
>
>    * snapshot as of 2024-02-24 (HEAD)
>    | * snapshot as of 2024-02-23 (HEAD@{1})
>    |/
>    | * snapshot as of 2024-02-22 (HEAD@{2})
>    |/
>    * add 'bar' (HEAD~1)
>    o add 'foo' (HEAD~2)
>
>to show the same history.
>
>Unfortunately, "--graph" and "-g" does not mix X-<.
>
>So, the RFD is,
>
> (1) Should "git log" learn a trick to show a history like this in a
>     readable way?  Does it have utility outside this use case of
>     mine?  I am not interested in adding a new feature just for
>     myself ;-)
>
i'm not sure i fully understand your use case; i failed to extract the
conceptual requirements from your description.

but as a "heavy revisionist", i would appreciate it very much if there
was a convenient way to list and diff revisions of the same logical
commit (ideally omitting empty rebases). sort of like a range-diff on
steroids.

this would certainly require correlating the reflog with some stable
commit ids, like gerrit and jj maintain.


