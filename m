Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5A3EC803
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337297; cv=none; b=f+RRHrLP2w9pIFQH0kcESh8T4V3cT6T9JaKOBwU518X9AxAYSfoorYEcPc6aeFlYZ4K4pGoXCYd74NY2zuPQ69uTK4RNqotvUm9UQgmov9aY5LTKqhWMS9EMG+FGnW8aoB7QxeYgXf3o+fF2HnYzYNZwwH6Z7z/3K8Ia2qVjdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337297; c=relaxed/simple;
	bh=io0x3mEz3u+S42tOkIDNpxvklCLbhA8305jDn2ZWHyU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rae2fnXCXRmK+g6hcvqv0qhUCvVdTqbzlRGjlzgGxeE2AtU6qkXT31u03UtNrQOEDR4eAhEdq/ngWdF1cLsYqMsbqM7KKHf5A3y8hBZ0vG9Z1cHAB0kuv8a8eqfcY4JukUeU+qf39Bq4ySFYUTZiSlL7FF3vVmI2gHmKjasACXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RHb4YFTd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOj3VF3Z; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RHb4YFTd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOj3VF3Z"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB4317A015D;
	Wed, 29 Jul 2026 11:01:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 29 Jul 2026 11:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785337294; x=1785423694; bh=nHEPhvUUH6
	IaP/sUfgjOHurG2zO0kENEM756/yw9KX4=; b=RHb4YFTdzq/vAEiwLzSi1rZyFC
	PsMOqT8WRZNCfeNVlhvePOysIXoN8dX+P/pTCjvHSb9O2Dp18A85WYNK2jU0yeFC
	8HcR+I1BrGKjjHoFTZhWl6oEpWzJhOxsyXW/yK5jxowix3eS1WyOKCUGC49cPWbX
	OqDnyEsqhzUxDlj3KUWQjFsYFYvHrcpvwsz7I26SpPS3MTqOlDOwzs2JQRnQv+vK
	x2prOYcAA4ptvkj+o9wKZ2RYIfeFKGTZJ+C2Ztq/ucwYT2XZPx75vXVOm7GMAiQo
	nozMReb18ys86aoPGMROt9ojeeX/dPckSDrXN2KGKUkm5uXxKFJK7/6BvNuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785337294; x=1785423694; bh=nHEPhvUUH6IaP/sUfgjOHurG2zO0kENEM75
	6/yw9KX4=; b=MOj3VF3ZUipR3+9C3f8DWDfkwpmTVhekAVoDBsy5Rx+eUD+FsHA
	msfKAOCNJDNSI+rHrVzCyxCsVKsGZBMmNGjiGvLZ/u0AdGIMUb+dJ7y8fXRubxEo
	3KNY+YG9Z0h9qOKP33Sv7UsGvb+vPs1A7aM4uDYup8LjbvrNrjJqq+e02fGcyltJ
	iEm7ijGOr3cp2KqT7cKk5OTPpbpLsUYWvg+UzHo5kfJPS9lAl2XlOE+1/hFRvYON
	dS80X2y/QcDTPdHZ5nPnD7zMtprWYVtHmqkw3aiW8VN10NgvJXiUblx7P2erfAdz
	JhN6M5r3vIzUnyi6ymvGTEq7Wbx/tncXOLg==
X-ME-Sender: <xms:zhVqajyUmab4cWl4a4VpPZOJMJ6OOjbYf1ncCAfK-OV-NdXWJPZ5Cw>
    <xme:zhVqahSldXLCB9H6O1HjjWPQ7QO6JEBX9-936Eph0sXXDwUmrwx2QOQN4H0-ta5Xr
    6R4-vpKZJ8sFAtQgdKkpxYX6gfOOOamAVbnyPuh0imlNRHHbgCuykg>
X-ME-Received: <xmr:zhVqaq83ICl_HpdI5z56SaFZw9ci3Dwzr0UNqerhZP44iJENTI5VxiceCN6OF5xzNViRwENHej51X4sBC_RfjsxNOS6GbOc5uQ>
X-ME-Proxy-Cause: dmFkZTGYTht7lVTzgt1ebtnTXGEmiFhx71qButy0m8OUQ6xL521QNLIfg3t3/vvdvhMQB0
    MKQnnZSmFcKUL376u/zZcW69NIDaX1wT15I1/ougWb5y1Wx5X3PTCc4J0KzDQ/h+Lly+s1
    6qodasFxcXpqQdb3QurPHpFG+kh5PByq4h+mksnWTgvJMX0FQi2KJRpv9jiFhSBZPBTS5T
    zo5ABIzxoc7Vygsk1+KMTNQpit1OvdekJnH7kGvQvzn29gBCT5sJAWo1BmQc30Vn3myaRB
    LEUKO0XhaXm8YpD9E7oIWxqRgXgH30VWfdW9sZvE4Qq44l+sUfs6F+6+Jspr2xGp+KSsqz
    njoQh1zz948ruXci6w0a+UdOHaT+jEDq2IwfqgTT1rWTReF2UvFEzRWEbg1YWl3VOy/2EM
    sWirZVJmJsWoPr5stos7Pp+1Fdyv65r2GEutm4mHddbbuNNAFhpZgFkEzDvqeRBohRBVES
    V+7q7zoK+6dPilysKFVRBRauniMolhVczxsgHLUpmx84C1Ymfa2Vgg3Q3aqf0Iax4CsklI
    QwOHyUsBp2plgPzVSYdsAMZ0Sks4Pr+hyj9XYBsSWVX+hbe6Lh+uyR4R5GgixV90P/20o2
    PEcB8nyGSzlxwtkKzjDVJjL35KfURIJ41fYmsHW4FR8psQnjBTf5KFFbSwYA
X-ME-Proxy: <xmx:zhVqaoo47bOd_j9K3wXOyEoDBYVVbFboSb3vM48H0Q8qwYwL7vrhBQ>
    <xmx:zhVqanmMy3GgA48iKNve33Iec4SVurnFE6SHxwWmm_lbhGuy1irijw>
    <xmx:zhVqavJwA1-iP7_NXY-f9gEwrQWZMQKyk8VxeYEzJoYIotu6FNKmdg>
    <xmx:zhVqasw1nWLlAkqAEmsP01hmx8G5zrdV864gOi5eqX-bnxD0FrwWDQ>
    <xmx:zhVqanJw2Sz8np2dvl1PdALG-af9z1lgMawp8TSym-lwuGB-7BmFSKP6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 11:01:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
In-Reply-To: <20260728215219.753678-4-gitster@pobox.com> (Junio C. Hamano's
	message of "Tue, 28 Jul 2026 14:52:18 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260728215219.753678-4-gitster@pobox.com>
Date: Wed, 29 Jul 2026 08:01:33 -0700
Message-ID: <xmqqse51algy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> +
> +int has_conflict_markers(struct index_state *istate, const char *path)
> +{
> +	FILE *f;
> +	struct strbuf sb = STRBUF_INIT;
> +	int marker_size = ll_merge_marker_size(istate, path);
> +	int has_markers = 0;
> +
> +	f = fopen(path, "r");
> +	if (!f)
> +		return 0;
> +
> +	while (strbuf_getwholeline(&sb, f, '\n') != EOF) {
> +		if (is_conflict_marker_line(sb.buf, sb.len, marker_size)) {
> +			has_markers = 1;
> +			break;
> +		}
> +	}
> +	fclose(f);
> +	strbuf_release(&sb);
> +	return has_markers;
> +}

Left unchecked, this loop may end up scanning a large binary file to
the end in vain.  We may squeeze in something like this to punt
early.

 merge-ll.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/merge-ll.c b/merge-ll.c
index 5e5044b9e3..ef5287dee8 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -516,6 +516,9 @@ int has_conflict_markers(struct index_state *istate, const char *path)
 			has_markers = 1;
 			break;
 		}
+		if (buffer_is_binary(sb.buf,
+				     ULONG_MAX <= sb.len ? ULONG_MAX : sb.len))
+			break;
 	}
 	fclose(f);
 	strbuf_release(&sb);
-- 
2.55.0-609-g9a17695db7

