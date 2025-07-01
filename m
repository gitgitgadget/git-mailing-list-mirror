Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF511271A9A
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391624; cv=none; b=DbNOslGKxedELM51ddpZ+fadB9fyHSdvk5tMqOam3B9WmQvnITt9Va1k7aAOCMUPvMkMF+bgkwhAO+fsey6oVdkugXTUXUVrqMeBss7jf5JeNfWvhsJiCKe5XyF8b11FgPOKAGN1wlncbMicM+EkXOROmuC+bfn+n+F/4HCkZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391624; c=relaxed/simple;
	bh=w0r0m9jTRdsedRa+b2yC0VXKajnLTzaq+knHUR0xVX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YOCbuEGEm97s1OrC0YEJYUgaZEQ1YPIrD8zx3oJLgWxTqBAb63StSJwCpoC9GpPN82t6MMSNEBHbZt0GD/2SO/AF/ZpRZQucrFLF8tPn7HfujWqY98GkOB7XAfV0K5hmtMlhZbR93+kFx93W6OCXc5tr9N+9hrB+qw5c5X+Tta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU8MvQ2x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU8MvQ2x"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2366e5e4dbaso58552675ad.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751391622; x=1751996422; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTKmtRCBbfHhuWtd83ACJM8DmdRILKMVCZRrxYUc994=;
        b=PU8MvQ2xBymabaFW9KzpMXMHH2ZjITL/gOoQQW9oyIhAfmIewr+XgnUMuBp+MlwLEQ
         PgbaoFguLfSc6eqvlYmWU2sHXGQvSfu+UlUgFALnBDychKDmizlHecPcjqSuv6vObHil
         KQx/wWzxtpI+uC/TK99TJuAeQdmUEdjvd7JlcYJKbRkNW5qEPxrVfjmT6VK3py+HvK2s
         v6U4h2UJgZoF6bk5U+JuDONybTkF6rhA7mx7Z/q88cgxz10ZFjcBS5Q9DAxHO0hClaCg
         dmVRwd0LVDbwZdJX1sAFQUPw5V+zZiWpvQRcw0avPQ+7EL3A4+IGSNPkjzC0smkV/Ag+
         pi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751391622; x=1751996422;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JTKmtRCBbfHhuWtd83ACJM8DmdRILKMVCZRrxYUc994=;
        b=xPBCwVvBiJ811EUuC2gwt1/iVacz4jKX250XuJ0I0ZRriHbAxQVH/O8T7yA/sErGKn
         d3MM8Qn68n984HnZmfA2vONVUOPExJgDXaBP7GDjzcSq0tyjmg45fz1mEVLNOyGDWgOd
         C36bn+YDHapLuzqB25bS4Yhv1S5M75ZjVUgz/Zn8SECYjkcURdPSHTx24m+0Rf/b2mYO
         AMizVudAm6LDv/Eybl4ImF+TgX+/PtedEqBoQI1zeog2b0ChGY0OTRrA++mCLFeIs8LP
         0g42oNip2ZcmStdnr/7yAIpJsGpvyCzuQ69OwAMIFZofoUj+NkRYqUQIuFzTvc8KHFH/
         QR+A==
X-Gm-Message-State: AOJu0YzK6MZBqr0Vz7mgLbcPji1sld8PM+9eBts7DlCDqdF74msGwiaE
	LHyX7uBdH9yZoKOlzrfuEzvCBJSUgpY3Tvw9Gkhmwy7l1V+j/qgqcVIo
X-Gm-Gg: ASbGncvECYXwFmS81LdRyrm2exCxA9DpvFZ+XH04Wy+qCZl14piigBLR9CSDqRD8RqP
	8BOzk+9a8x62eufdhhs8bzTBjWMCuX1fhUmXUoDnWVv+m3eNw5tgP/aFekm24Vyxb5nJxachBSu
	rySE7PJev+dFgRFsVSnB0FCN/VXuRx3kY7yIQRjjjdyHRZxLCjUuit7Bxncw/Dxg5Vpj8jBaGa2
	AjRCAIijE/p+VHWo2bpojq3hFMFS4TxPMvU72VOx0nxboIizXuKXx9sHa8IyNIXx9OxAESCY4HD
	OTrYTngIahTL1jI/LFZE9FbJl+kKceGSb2Q9XD+dK/3+LBkzLV0OyNru9Qx41sGzpKEBPqmySlk
	0tqN7VFWNc/cePxI9C6gSc4rFgrY=
X-Google-Smtp-Source: AGHT+IGY8mpXV0GFVUdXa/FaDk/4VbIxegls5DyYacFTy/ecv7UlUp6mQ1yXOiDTuGtabcw4mbx1gw==
X-Received: by 2002:a17:902:ecd1:b0:236:6f43:7053 with SMTP id d9443c01a7336-23c6d8b607amr32855ad.2.1751391622129;
        Tue, 01 Jul 2025 10:40:22 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb39bac3sm108455135ad.133.2025.07.01.10.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:40:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
In-Reply-To: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
	(Jacob Keller's message of "Fri, 27 Jun 2025 15:09:04 -0700")
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
Date: Tue, 01 Jul 2025 10:40:21 -0700
Message-ID: <xmqqzfdnkdx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index c6e0e9d05186..61486e378cab 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -343,6 +343,7 @@ int cmd_send_pack(int argc,
>  	free_refs(remote_refs);
>  	free_refs(local_refs);
>  	refspec_clear(&rs);
> +	oid_array_clear(&extra_have);
>  	oid_array_clear(&shallow);
>  	clear_cas_option(&cas);
>  	return ret;

There is an early exit from the function that would bypass these
clean-up.  Perhaps something like this on top?

 builtin/send-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git c/builtin/send-pack.c w/builtin/send-pack.c
index b28da7ddd7..6ce9f6665a 100644
--- c/builtin/send-pack.c
+++ w/builtin/send-pack.c
@@ -305,9 +305,10 @@ int cmd_send_pack(int argc,
 		flags |= MATCH_REFS_MIRROR;
 
 	/* match them up */
-	if (match_push_refs(local_refs, &remote_refs, &rs, flags))
-		return -1;
-
+	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
+		ret = -1;
+		goto cleanup;
+	}
 	if (!is_empty_cas(&cas))
 		apply_push_cas(&cas, remote, remote_refs);
 
@@ -340,6 +341,7 @@ int cmd_send_pack(int argc,
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
 
+cleanup:
 	string_list_clear(&push_options, 0);
 	free_refs(remote_refs);
 	free_refs(local_refs);
