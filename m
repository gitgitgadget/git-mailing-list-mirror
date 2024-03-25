Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B1839E1
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409873; cv=none; b=LhWtXZI4TtOze1xgYWD1PElJvQn8O3fFQ18uYPnVVpTGmsEjHROfCUonnJ7zm/kai9X2lPr+mFzvFFzNd12VDa3Evtf8VKm2y3TLML8EHV49u3aTPi3d4OEYwxHzHnZznzKVfNsCJA5KF/I/0iJFVkcGWi5X+7EFsESWHEpinCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409873; c=relaxed/simple;
	bh=z+qPHi4XlIwkyilwCVY97ZJj8xg1ZnFo6xXIfa4eIjs=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=E6h5mz8yhmFM6XKmGVCQt8fnE7EEngnkQGXQrazaWfMv5OSs/QBd24HeRa+Vc62e6HbPjddZtChukqkMa4sLOSbupdPXtk4jia3l0jKkmI3ww5mjUiXdbyOyLGLWm0JEXdEkFiyXgqQN5vPJd93PGkImgLUTlUQ75ibsRnxjEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWkmclix; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWkmclix"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e673ffbd79so2915738a34.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409870; x=1712014670; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh+rX1mLoyGYxHisU45jqeDEboHdUAEVVnCDUckW9cE=;
        b=QWkmclixXJE1IgILvgnP6kwU+wxn2dncjgSHtpLD8EhVnHrelpK5GZi/AaLjH9cmut
         WUYWSseqHoUemT+LTxFedOEvwLphrX69p2kXXQVHaqYDct7bQ/v4nAUHW3nt+WwnwsgP
         CWOquIzvT3YpyCROer+HkHnhhwbmik1QoPTL2EcELyJYOx3fh0yNmVGhk0cMCjZ6ARG6
         8tOTZDjqfYPrRD7cnKCy+TtuvOnVPJGALZNbBmAS2PQmtIqIXo7gG24EqPQeRMhaxw/j
         imEgOy+RCPIRhdO6Wv09medSCYJu45GOhrxaL9pi7DrjgMWMpQ54PY2B/bM5AxNBMY7r
         Rp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409870; x=1712014670;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh+rX1mLoyGYxHisU45jqeDEboHdUAEVVnCDUckW9cE=;
        b=jn7qVMH7Q4Fopln+9OnzPkLg1BJJuQryhD8sWgYOpY1lqH9xJola108Jc2prNQOHGu
         YEmmfLGgUP2sT2IIvp2vDxpl/1q2AFGXAD/jO7mHaFAyjEoAb0P0LazvlvkSHCT9c7Gp
         mkS8CptxWcfGAO9isl8HYcaRasGM6AQpAyb45jwQt70gYWkupZBzlU4av7IEnVIU2RVV
         89r+oMP6RCJzLVIjFB9Bdner0ygHHNI7EhYz0OmWLnd07pSbzt3y0r1NQLFD9zE1ey2z
         Ek7rbgkWcj6jRd89VeiFYbpY02phWPbz8frdq6vZugEK+egFoAJm8UOkUv4OhhtrZ5nN
         OeWg==
X-Gm-Message-State: AOJu0YxeqZSXuxFz6cFqiibytMtsPDnD06opgHyr2V5t8BMkZ9L0IhXG
	hbzsvWXWbyIcQpklbmZ7oXLx5x0HO9nIOBnc+LWRQxXlvH+zk/chRn9QpQxZH1w=
X-Google-Smtp-Source: AGHT+IHNFUZwbE+b7CT+y/Jj9aFeXH7fSdoLoGOIr+ZPp859FP2aghvqlKkffU9X1v/IwxMnDyA0cg==
X-Received: by 2002:a05:6830:2b26:b0:6e6:7d9a:e3c5 with SMTP id l38-20020a0568302b2600b006e67d9ae3c5mr11191686otv.34.1711409870612;
        Mon, 25 Mar 2024 16:37:50 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id n20-20020a9d4d14000000b006e67e27fd71sm1335863otf.28.2024.03.25.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqq8r26eyva.fsf@gitster.g>
Cc: <git@vger.kernel.org>, <phillip.wood123@gmail.com>, 
	"=?utf-8?Q?Jean-No=C3=ABl_AVILA?=" <jn.avila@free.fr>
Subject: Re: [PATCH v2] SubmittingPatches: release-notes entry experiment
Message-ID: <17c0263586f87125.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 25 Mar 2024 23:37:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Mon, Mar 25, 2024 at 5:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> +[[a-paragraph-summary]]
> +
> +*This is EXPERIMENTAL*.  When sending a topic, you can propose one
> +paragraph summary that appears in the "What's cooking" report when it
> +is picked up to explain the topic.  If you choose to do so, please
> +write 2-5 lines of a paragraph that will fit well in our release notes
> +(see Documentation/RelNotes/* directory for examples), and make it
> +the first paragraph of the cover letter.  For a single-patch series,
> +use the space between the three-dash line and the diffstat, as
> +described earlier.
> +

One very minor grammar note: "you can propose *a* one paragraph
summary".

Otherwise, this patch looks good to me. Thanks for considering this.

--=20
Thank you,
Brian Lyles
