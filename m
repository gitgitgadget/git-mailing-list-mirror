Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D59137C55
	for <git@vger.kernel.org>; Mon, 20 May 2024 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245247; cv=none; b=Ks/TIyAhYXzn61RMvnoQd8uHkBFX2hOySjCHtJk5qTrsIXuxdR/+CBYpbv5xO9lfHlnyS33pt/Q09xx3GySYBesqelBPSsSh/wHBZ5V75dvVS7hOZsQgSQIEagqAsoKsA5t8dHo/3Mg0PekzkxLVleoIxbrtgnjOW+ITvD8jLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245247; c=relaxed/simple;
	bh=TLPz4k+PEmZQTPMgRJxPrJD7+0v5WZ5gvD465bXoGcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNyPiqVUAY3vMUctMUDyBUZ9EOvLG7FUdZaAY7+dSLgB+70eEBWxtY3p/zZmDmgkICpF/XKwSV9jESLoRn3tVQDbKV42Tq96mFT9WhVQlQVGj9o3Yj6JyFaoQPNQqNzfI/mudRRjQo8gIRjrpvTmZiNBZNOmOG0ViQHGjZ5xzns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGQ9XYKK; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGQ9XYKK"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4df439e1056so1221649e0c.2
        for <git@vger.kernel.org>; Mon, 20 May 2024 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716245245; x=1716850045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RisJWE8uGHfZPWrtcXg6VpckPXad12ok5zqQDcjVUMs=;
        b=HGQ9XYKKmLYVyqIjupzs8Bg7u4EI0L99D+BLb+abFVcx5pEHMwayBm3w43mAzROzgz
         9aGjKxSKS6JMUoyMfg2aYgisL+dcM2xE3C7hN9zlSJIEG74EfpszDiRjaXnFMWFmZDyG
         mxvW6IQKY2yUCxD68LNuR2sXxFSu8OKFwzAQnC1UHpV6ERYqMXWZKz4YK84ou0OGOCmd
         JO6t0MYP2OBvUwgTEowgYVNaUHRqP+N9aoRdUY1oUPMsHdwmNkSlzz44usBAfLuAZUDE
         5/rVf42z+t6uW9/T5nFivlrFv1NP7xfyATD5y1Cpq8monVlJ4+EaulIkWpFZLTQhjYer
         WBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716245245; x=1716850045;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RisJWE8uGHfZPWrtcXg6VpckPXad12ok5zqQDcjVUMs=;
        b=n6AIKPR+NHEahz0Yu5XQ7dWXCqwY29xIwEUj/pAKYvtg7vVSpsrhd5e61RF4YJeC54
         cZhuztkpvVYBrD3riWbVQx7dZY4YwVdJ2a0DEmQw0XfWzc+UXItZsIaZfC12Y6J3+DlD
         W507eimdBVWoFGDcALHy/VygQndglafJ0yWh4ejnuqE+DIFUAt9p7XQlAQ3sRA7aJ5lP
         IQ4Z9uV5oqr4BwmamABhFXUrXnAEpPwaC6Jp/rVpxmQp6Rempuu0SL1oYOS40v9p2jeS
         Vf9CFg8I4hq2HBx4d2lKMVIKj/IWJV/MaoiTZcKHBSjSMx2gDgGtV55wCrf8z9W6u7y+
         2ODg==
X-Gm-Message-State: AOJu0YwpnFnyVwLfzJtLEiVsJlniHQ86t2XtO45SKMjX/QbUmwJWuNgW
	/RHlMLwnvraI99Cg0bXj6Nt6RTvXoRyLczf6Y+JTot6nTDpDBvT2
X-Google-Smtp-Source: AGHT+IGWGrjVokK0Wf1b3INhLvF2zZTj7OiTyKCFm5NajT5B4Ll63wZG2qeuHHXUokuiUWLPHm2lCw==
X-Received: by 2002:a05:6122:1786:b0:4d8:7222:b6da with SMTP id 71dfb90a1353d-4df882c2a3dmr28794515e0c.6.1716245243731;
        Mon, 20 May 2024 15:47:23 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df994eef05sm2655610e0c.18.2024.05.20.15.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 15:47:23 -0700 (PDT)
Message-ID: <dcc9f9bf-3c0f-435f-ba10-35ff31122b7d@gmail.com>
Date: Tue, 21 May 2024 00:47:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com> <xmqqh6esffh1.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqh6esffh1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, May 20, 2024 at 12:30:50PM -0700, Junio C Hamano wrote:

> > Invoke the pager when displaying hunks during "add -p" sessions, to make
> > it easier for the user to review hunks longer than one screen height.
> 
> If the hunk fits on one screen, it is annoying to see a pager
> invoked and then torn down immediately,

Good point.

> even with "less -F"
> (--quit-if-one-screen).  As we know how much output we are throwing
> at the user, we'd want to make this conditional to the size of the
> hunk being shown and the terminal height.

Are you thinking of something like?:
 
diff --git a/add-patch.c b/add-patch.c
index cefa3941a3..495baad3ac 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1449,11 +1449,18 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
-				setup_pager();
+				int lines = 0;
 				render_hunk(s, hunk, 0, colored, &s->buf);
+				for(int i = 0; i < s->buf.len; i++) {
+					if (s->buf.buf[i] == '\n')
+						lines++;
+				}
+				if (lines > term_columns())
+					setup_pager();
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
-				wait_for_pager();
+				if (lines > term_columns())
+					wait_for_pager();
 			}
 
 			strbuf_reset(&s->buf);

This would significantly reduce the blast radius.

Thanks.
