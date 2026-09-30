Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D75408028
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795187; cv=none; b=DRhYHg4JdlUETqp3TQZZfwznaLYxlVh9HpMrByPwiTrPwHd2e93hV1Bw69NjqXDmFhO34e0W8FEEaVp77cJV1mJx+dnTMKKCKsq2+qkB+Wx6XvMqrwDbpvcJ/ZiwG+i7ni0FFfIdeW1eIKJOniLsfspyhAJxeMxchURg0eQd+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795187; c=relaxed/simple;
	bh=TO1LZrCOnESBgSIDV0cMnwYHgpkhY6Mr7xNE9MjuZmI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=cmlAoASi+9LO8LjL2JwRa0og3cauAq7jzEhwW8swrKP9bkpdYKYhxmVZTTWW3yUIFseHU6YZjquQt0zFIdKSwdrtcQMPvZAQrLTLUdYE0h7X8xgnyR/6zCRddcNwpFXzdvDlLMhHsZUh1Bx9B0YTt27jNh3oNMBM5/b+fFJSP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFJI0Drv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFJI0Drv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so29528575e9.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790795184; x=1791399984; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzKBBDxOHJTVyxiBlh4UyKyRye/yrUD6DrGFd8a91qE=;
        b=aFJI0Drvwvj5QSezEvcz51H2MBrp/Xh8ks+LMHNBWoPoNsNIwZusaBV30LE/3AKlfu
         7jCD+ht5IptH5KaeVqo1SMxsmQOSFlAgMvk3AQ1YLEeIKW0ZulduaI4T7XKzB4Qd6fFk
         fnRnAgTmsHEDLvHR1tv7+as3EXZOp6oe1vPykFtXNKxdAVeroFysaMnbnD/7DEzteiWC
         eaRmmpxw51WsXWgKUhMO2FrtYRWpj4CJef8tFp1b5Ul5lf0JHTDzw0L8AHzmtg2YzePW
         IsbxH1LSAqMgkFXbI5m40Zl+sXISrKf7VVJlPdCQo/7lO9smajm/UfDBDi6XV5E8PHIj
         W8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795184; x=1791399984;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzKBBDxOHJTVyxiBlh4UyKyRye/yrUD6DrGFd8a91qE=;
        b=ypz0CZ6vQmbKUtNCcVVfQDj8iSMeExzAxTC6JUdDlaPtzIakF4YVJcBE7lW42RSS5l
         IwfgDWl7km5Hc3zY6ySx3rSabML4jzCYMNRJIrhdd1KkQlkkWEbadrb2rIPGYZMVvQrs
         HJwOtTwM+7KGHa4RUz07PpntQGwPmgAES9HhAbVh7Wmfn57w02APz5afdmIqlDxJAqx9
         HahH+K8aNlkdSy1s0AK/XYLXBzm5NnJB8jkjjnHh1jEZplJ3oyHuyT/ixCZNiRno7x3Z
         9raarous0OnBxg+rxIbvL9aZdQqnbzxYXy7PHo0cVDIVl+GrxPxpioADkg+NL7VLyMgp
         fAoA==
X-Forwarded-Encrypted: i=1; AKwUvBz7GzNMd0bz70iLacuBAqJWwelASVj/lQ/GAMtS9y3+GdpLKF+31FJRaD6EGybh+ImEOnw=@vger.kernel.org
X-Gm-Message-State: AFuF++looOrQfpjLqYdnTEOsBVvHV0QLC+r6vrmYtd4zVsACHbNbt/aI
	8rSMyz0k+EZFn2CAVlloJ5NQMQxARwyUI9uITA9X26GATrp43MVZazgy
X-Gm-Gg: AYBFou2Xn/4wl/wxxxmwGCxnFU1TABU/YIAQqQq4wEcq+WLi8BbQwceQm0l6o75G8tp
	X0+JdxlS/sAp+GP3PKgsC4FCpmaCALVDcRUoNOw7b2YzH0tntE8ErfAsbpaQIUEVU5uM/piqaxE
	t4HAjju8vbH7OyNPPRlqr2QysouMICrZUeQ/tKh28QkQe2Rh1ftlME58OYJ0spn3Vvt0Zb7G2Gw
	KYZZgl3qCts7b7RAKJtBayXuMuTga9/E5Al5VZ1lqAnyZwdtwbdzpChVTpMpMfv9HWxPc86mR3R
	ayfObOkOQ3/GBDDaY+0R2eyq1MTF9wg2MYm0pMdIglxJkpv8M7QvsPj1RYC/UW9lxgAz13nhOfk
	ztJEKL5LuFoo/a79I1Zk+V+0Qw/5On+pM7+aJlSEgORBrQYO3limlnjyMERJEUD2QFvZGyQYusM
	Nzrgud9yT/YQ+LTB3O7oXWZ3PTdAnbaX+vjv0aNLk6k7NnO53ROd5UmISCPVV5PxFhk5H/EZz55
	mgYKQbWd87mSwkSlYrAQ29L9gR5fCy4jJmm+jCfdu12wOw5S4kp7V39FBnoR4lIgE5l3ORfy1q3
	R2erH+HeP38yu8o7DQ9/DWWURnh75rLOGwimV/QTeQyfSexbbwBNy6SyRx5ybVbKljY2+PnU5GW
	ChqvI6uKwaBA6b0r6UpIrTQR+
X-Received: by 2002:a05:600c:4714:b0:4a0:bc9:28c6 with SMTP id 5b1f17b1804b1-4a01b00f6b4mr43478265e9.34.1790795183590;
        Wed, 30 Sep 2026 12:06:23 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:5109:cb7:aac5:8093])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9634a9sm1452345e9.2.2026.09.30.12.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 12:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 20:06:21 +0100
Message-Id: <DLSVWT1QTELK.17U19NG169AW9@gmail.com>
Subject: Re: [PATCH RFC 0/5] Add --dry-run option to git-backfill(1)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Derrick Stolee" <stolee@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
 <ed1b9048-d438-4143-a224-fa0e28d4fd42@gmail.com>
In-Reply-To: <ed1b9048-d438-4143-a224-fa0e28d4fd42@gmail.com>

On Wed Sep 30, 2026 at 7:14 PM WEST, Derrick Stolee wrote:
> On 9/29/2026 8:21 PM, Pablo Sabater wrote:
>> [Cc'd Derrick Stolee for his work in the backfill(1) command]
>>=20
>> This series adds a --dry-run option to git-backfill(1) that reports how
>> many missing blobs would be fetched and, when the remote server
>> supports the object-info capability, their total size:
>>=20
>>         $ git backfill --dry-run
>>         After backfill, 48 blobs would be fetched (1.20 KiB).
>>=20
>> If the server does not advertise object-info, only the count is shown.
>
> This is a helpful capability, but I'm not sure the size check counts
> as a "dry run" because it involves a network call (and possibly many
> depending on --min-batch-size).
>
> Perhaps a different argument would be better, such as --info=3D(count|siz=
e)
> to make it clear what level of information you want to know in advance
> and thus how much effort are you willing to put in to discover this.=20

Makes sense to have it as an --info option.

>> I am not a git-backfill(1) user myself, but it seemed useful for users
>> to know how much data a backfill would bring in before running it.
>
> I'm not sure that we want to add a feature based on speculation. Git
> is a collection of "itches" that the contributors needed scratched.
> The work is motivated by real needs.
>
> While I can see some benefit to curiosity, I'm not sure how much this
> would prevent users from making their decision as to whether they
> should run backfill or not.
>
>> The number of missing blobs is the sum of the number of blobs to be
>> fetched in each batch. The object-info capability lets us ask the server
>> for the size of each blob without downloading it, so summing them gives
>> an estimate of the total.
>>=20
>> Note that this is an upper bound rather than the exact disk usage:
>> object-info reports the uncompressed size of each object, while the
>> objects end up stored compressed and possibly deltified in a packfile,
>> so the space actually used on disk will usually be smaller.
>
> I don't think the uncompressed size is a useful metric here, as it is
> likely astronomically larger than what will be downloaded. How will
> this help a user make a decision?

Yes, that's one of the itches I have with the object-info protocol: it
cannot give you a reliable compressed size, and that's why only the
total size is supported.

The object-info protocol could be extended to support the
objectsize:disk attribute, either by having the server know what we
already have and the oids that we want, or by directly having the
server send us the compressed size of its local copy (to avoid too much
work).  Even with the first option, because it goes in batches, it
would still be an estimate, just a closer one.

Given that I don't use backfill, I Cc'd you because I wasn't sure if it
was really useful, and the main motivation was the "I'm going to check
--dry-run before backfilling" case, so it helps to decide.  If it's not
that helpful and seems to end up as a decoration option, it might be
better to drop it.

>
> Thanks,
> -Stolee

Thanks for taking a look,
Pablo

