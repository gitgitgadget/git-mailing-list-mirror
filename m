Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE43CC7C5
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077420; cv=none; b=lHR2Zi/LcU4pKK1a/WnyI1YWfXUDeFgPRFWubMz0GI56idywVxThmkRI+HNJmUjfZF6jnB5h8QkZUlzIrLfm2RdJvYxO4doCya/pM0CV8I3Yd3Vl4/CuCKjaXFqIj051iDphrBC5W9+XrGktLYwxO8UOYtjUaQVbJQi6tbi3XLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077420; c=relaxed/simple;
	bh=RKCmKbtlqkPtxCyIENsO5LBeHoR4fAjtmZ7zxigBY4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sbd5ZMuXpzEKmaIYy93FNEDmGO4KzQyugcveOi75yG6+OhobyhCzTpDBRop5T0kFcnbl2rDF6kXrLsYd8TIdZKtiHo18aFVF4/Jdu3JPD7UznlrMxDsaG12XARFnE6mPE/ifhVmr26J6xTqwb/QCP6Nun29c5p87aQogZLy7c3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I4uef60E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/dvWKeL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I4uef60E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/dvWKeL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A93B01400042;
	Tue, 18 Aug 2026 14:23:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 18 Aug 2026 14:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787077418; x=1787163818; bh=9MgoSj43JK
	umjRIz0YMR7LnaofURnivAv/pvdJ5QbAM=; b=I4uef60EgNmuqvKKPZ28Sh5jwH
	r66Z0Pq3z/t+CIjjxGi5yPjQ1O39M3hz5EOVQMgEWYnnMq44qXhNVMK71ARrUfT4
	iPpzs9nqCeahcAGJNRqX8PlaTteboTqVwM3v//KUmhes0/MVQ0vbRVsIdpxyJlDZ
	5EKyCoOj4xmNSyo+aYKuK/y1f3enTQCZAyqdqFx/zruFu3oEe/IS5Aw85cEy6K6C
	AAGFfCrFAgHcXH9VSM2+r40q1DqwmXNaoYnLpdPwNwc7tIeTFnsedUbiDthS4vxL
	mrXUKORKbTWRolyzTckUxSqv4oHXNg7WimmlczqGpjXuVu+hOI7eyFCiZ/aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787077418; x=1787163818; bh=9MgoSj43JKumjRIz0YMR7LnaofURnivAv/p
	vdJ5QbAM=; b=E/dvWKeL86JNZtdPAex2/wB1oW4b8+tydM68qAR25iMiXyxn+Az
	hkW5LL0XIaYDZd0nNBSfHuWvJLomIzZ6zT6jsOfRpZ6v5yhhLk3H5cHbkCyGbc+/
	tKHOGmTfKYQRz1pJcFQLJ+5onL8OSsnvDEpA2gu5WP78YvtzKmCdYZQe0AMU148L
	kWVP/NTb4823ELOsW8W1rK4RwvvTqh9+645zXJIvsnT3czaa56EKIl+C6k/CnKZq
	JYZqCkAiG6XQOQAUuUyv7UQjJ1lsEBq5EmvZms7xzN4CvzQdVGwlKPhir+VHNGb0
	Ggvevi+SIi1h+zRr2LyK6q6Yq5oJJu76BjQ==
X-ME-Sender: <xms:KqOEaqchR2wN2Xuz3V46yo-ZpMtdkijPTGyuJppv9XAC7dMyWcXe0g>
    <xme:KqOEarpVS4wgMg4Oau_6f3vD5K7JLS1shCttnxne7RekrHaGlsiG5B1qX6Hobk7oV
    pD_oY68N7cesO4G1C0_an-BjtXpOiP7bTIV2FiIrmfUb5XQIC3NYQ>
X-ME-Received: <xmr:KqOEao6kDvOyqWL6BsTQB5aUTnIlOgzmcJpY5TtEbWll4f07W3n5cLi90vwB-d0Fi2rP47b1Tm4oO3cAKrtBsRGZ8ViRJTysMQ>
X-ME-Proxy-Cause: dmFkZTFCTVjFNRSuaDgjctUmZttKBeL/bDfK5r4iVymWXe/+YmodxuJKmpZBu36SFFUld3
    FnLchNYRL3dmjA3NiojAZtxTcrQ0jG3Aim+FvD2TOAKq10eE9wwoRQgs1o5duDFVqFSIEz
    s02Zz5ZeaVj/YbxhxWUm8Vcyp+L87R3Ss//N7/7Y+NhZQpQmMbFolPtcCtKeN+Z4Zj5bNu
    jSasA5Cp6iYutf/pKb3ji/uKW/Y7uJYrjtU0ZxaPprzVqdS/+5tr5WI0dRPXg2q4Nj1MFJ
    LtUz4n6gmNpfkcSooU9f82gh72Rg0/yk4dQxxBNlRV3xaybT/PftLGvVJ0FazfHTB7TcqT
    Xgo8PyhmAbRoKjSH4QAHxb/RhBqHIlQ1ZCj0CV8QbtpUgUaUwHkyFtaLHTyVwMxeFFkMSl
    XfVU0kx8Wg9+DOeWzjyb6rzmVpQ8mANNpYED17C6dJl44/Kj9V0Ej5yFAtiJR3wmknyuNK
    /Z5OMkwRVniBjZnN6T1BZmI8Fx1oylYy7CjiigjBKKRClf+TPTTCZyh9JHx4RSTZzHwWF+
    Pg62rGd1bWnPQE633t+MRW+ERz5484mBvzJDaOJdDIYSkIIFTvDxCnVVHLmKuLv+ZxNIkE
    VTocQeu0MFFAhKOB282HZfcCom9B+Rt59V/CsKQVwjgPjSBafTD+2e5q639g
X-ME-Proxy: <xmx:KqOEahooxmQut1rQihApQ_BS1VnbNxIo7POvFzgiJdT98TMQmbakkg>
    <xmx:KqOEaqjqv9538Py9Am49DrmDWCTf5ee1FeGL7_PSkFz9a8nQmly99w>
    <xmx:KqOEarJa-1Euf4_GLMbDdMCIDEblauifn64qy8nAy0qBjT2FD9WVkw>
    <xmx:KqOEaqCTbCGPXtaeXXdDuVAsH8BaVsIRUHagIE31g8JKlbRb7TaZ7g>
    <xmx:KqOEarwoFlr8oL1kjOzfRBoMzHa6GVj9eTzg0DDYFJRi72ICYxDNWXia>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 14:23:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] odb/source-loose: distinguish missing and corrupt
 objects
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-4-ec234567510f@pks.im>
	(Patrick Steinhardt's message of "Tue, 18 Aug 2026 16:19:31 +0200")
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
	<20260818-pks-odb-generic-corrupt-objects-v1-4-ec234567510f@pks.im>
Date: Tue, 18 Aug 2026 11:23:27 -0700
Message-ID: <xmqqzeyjxp7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -91,11 +91,16 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
>  		struct stat st;
>  
>  		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
> -			ret = quick_has_loose(loose, oid) ? 0 : -1;
> +			ret = quick_has_loose(loose, oid) ? 0 : 1;
>  			goto out;
>  		}
>  
>  		if (lstat(path, &st) < 0) {
> +			if (errno == ENOENT) {
> +				ret = 1;
> +				goto out;
> +			}
> +
>  			ret = -1;
>  			goto out;

Exactly the same comment about "turn it into an enum with meaningful
names once you add to an yes/no set a third choice" applies here.

> @@ -155,7 +163,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
>  
>  		if (parse_loose_header(hdr, oi) < 0) {
>  			ret = error(_("unable to parse %s header"), oid_to_hex(oid));
> -			goto corrupt;
> +			goto out;
>  		}
>  
>  		if (*oi->typep < 0)
> @@ -165,7 +173,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
>  			*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
>  			if (!*oi->contentp) {
>  				ret = -1;
> -				goto corrupt;
> +				goto out;
>  			}
>  		}
>  
> @@ -173,21 +181,20 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
>  	case ULHR_BAD:
>  		ret = error(_("unable to unpack %s header"),
>  			    oid_to_hex(oid));
> -		goto corrupt;
> +		goto out;
>  	case ULHR_TOO_LONG:
>  		ret = error(_("header for %s too long, exceeds %d bytes"),
>  			    oid_to_hex(oid), MAX_HEADER_LEN);
> -		goto corrupt;
> +		goto out;
>  	}
>  
>  	ret = 0;
>  
> -corrupt:
> -	if (ret && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
> +out:
> +	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
>  		die(_("loose object %s (stored in %s) is corrupt"),
>  		    oid_to_hex(oid), path);

A missing object is not necessarily repository corruption, and the
code path to deal with it needs to jump here, so naming the label
"out:" is more appropriate.  OK.
