Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7853AA1A8
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199019; cv=none; b=X8ML2Q0YdWHVs/omBHc+FlXQp5afbi47WtwKtz9dfsXtP6rd09K5x+eVX+ORUV4uqnlFRkHS2H+yZ49rblhsQDDMS4GryE145g27TFx2MnMreuIodE/iTxNQ3sgVu+G7z1ltqE6WKGjiSmW+AnOfgJ6Jc5F2nOi18UEK5zG1ZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199019; c=relaxed/simple;
	bh=fQIJstYiDFPDjSPFyAzV1qKW/NKs3ReqB/T+sFXpT2U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f/S/4pBz1M8Se4pg8Z8hgjPOsBqJjwcjWOCtXO9x60GaPsKLWt0sMfeZHuIuw/vgRvMW7RSAUUHr1Aye2pDg04x4LoZTZAUIbvsw8FURkASWC6xAgjeDYBFPR2iHxCllEQkHgdlf9IlC1sjUE9Gz1bBG0JcGJOfIrbjmthyCiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex0T4lxm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex0T4lxm"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so39578a12.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788199018; x=1788803818; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V2UxfIAxi+HMhZSkSRzKzex8+bBgrmJvf9q98e1as2A=;
        b=Ex0T4lxmnJREDVPws+ahVszHWU27s7eCMHvbcw3/hKxX0/WIqkIN/dlG2AH3mWUyjQ
         NXYjbq6Sh43DVeMnxY8NuROfg/lLKJEmDiRN+WeC8WlqCoZgVVmREE1uBHMI8tBuMw3i
         oXoegKAv+TO9FxFbhqu8qg6+bjldd5KHeXJ8vZnwrlVg+k2G5OSsBe10u0CI6rATCwsk
         Jh/T7n5T6dnyD7WQafl/cQ9ZO2n2xYz7cLCOM9Ds9R5DH27h/pZaH9pojPWNO4wAagLa
         8LY5Xpyj+KGooUHhzAeh/Gh9a1x6cf5H/agPcGZw9dtQ45EMno5lI/0gFOLk4smC+lbK
         XAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199018; x=1788803818;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2UxfIAxi+HMhZSkSRzKzex8+bBgrmJvf9q98e1as2A=;
        b=YpTO+TjUDF+WUCIbJKxol26+j2ZhNVro+IcSElncDs3kDbvu/a4GLP4iMWceje6OLs
         DgZk7f+jkyuyPnQv35pJKD+JaowhGmLiFHpEKG0jTmLWkXQ/tZgz3HQpLsm4cuf+Fn9i
         AA2k/GIdpA4lZrJCIArh3ogDiyjS3RnqibA2VA+j8S4oRcKbPmVH4oSUMcFyDtWcQFf0
         FTWSu2d9PsoYcRIgrIVVGlWmJkwhVY1No6jHio9TjSclQFLb9zGqVrofWSqC2VtYyx2O
         8vXAIpnKtcZgW9N/vSsvqcgOyAzajhfNRrMfmS5zHN80pFNQigo+QvcAs20SwoYWxH6I
         80hA==
X-Gm-Message-State: AFuF++luHKGSzXNlOFuHGQ4sAIQg3ddXIohhvtBM0MuZSMCuqql/kBQj
	sKvkQjWSV2q/zyfwM9UOc5jHciEHVGR1YNtIKE/2c01Ut4i5LeeqAdlk
X-Gm-Gg: AR+sD1194bLRstXMRZGSC8Obcuml3FaXOPfK2Tdxjwi+pvjB8a820HRMezsnmQyLZLk
	IyUOPkcAwMobQGmNOpdEeRd1QC8dy9C6KS8QAeavFs34XGyf1laKu9jP1vFEYdy4a6gwLRaSUX3
	ML/9WLthqONfjsEcXNI6Xsrxvpmf3fFdFqj4QFcgKYLOYfm4+Tpp0J/FE1hjUq1dMZU1/p1OwsY
	7U7dB/1OqwbonIAXrfxNFwcB/yLkBSAQB9nTpqnjGKc1IZitNVrYwVFz4Ux8FrvL66WFqbIrDP/
	DAPoRcgmIpu7BZo/U59e4wzL8j6MvWEXpm0DlpLSpza8AK4k2H5OV9JZrUUXuvQURicsq/h+Bnh
	J0FwsIGHD+xe4IAyTjFaAph1FQorIUDcgShf8uiK7P9po9sH3ixi/GpYmP5aBtKq6VzWsmro7Ki
	A4EHEWCWn5WMxd3VORY6TpL5a+5TYm4u7BDl6Cl69wZa7fiONGJBfWvabkRWhLOyHL1X3L
X-Received: by 2002:a05:6a21:a247:b0:3d0:88f5:f812 with SMTP id adf61e73a8af0-3d268ef9f7amr49219749637.10.1788199017793;
        Mon, 31 Aug 2026 10:56:57 -0700 (PDT)
Received: from localhost ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b58c057bbsm17014379eec.19.2026.08.31.10.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 10:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 23:26:50 +0530
Message-Id: <DL3BN8L6HK8O.T44IZ297KCF3@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] typofix: fix spelling mistakes in comments and test
 description
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
X-Mailer: aerc 0.22.0
References: <20260830-typo-v1-1-d397c8dfb301@gmail.com>
 <xmqqzey2w5l5.fsf@gitster.g>
In-Reply-To: <xmqqzey2w5l5.fsf@gitster.g>

On Mon Aug 31, 2026 at 11:11 PM IST, Junio C Hamano wrote:
> Hardik Kumar <hardikxk@gmail.com> writes:
>
>> Fix spelling errors in the following places:
>>
>> versioncmp.c:           "fractionnal" -> "fractional"
>> git-gui/git-gui.sh:     "occurence"   -> "occurrence"
>> t/t0022-crlf-rename.sh: "similiarity" -> "similarity"
>
> git-gui comes from a separate project and a different rule applies
> to patches in that area.  See Documentation/SubmittingPatches for
> details, but the consequences to the rule are:
>
>  - Any patch to git-gui (or gitk) would not be a patch against a path
>    inside git-gui/ (or gitk-git/) directory.
>
>  - A patch message to git-gui (or gitk) would not contain any
>    patches to other parts of the system.

Thank you I had skipped over that.

I had sent another patch with the "versioncmp" prefix which only edits
the core files to fix the typos.

Thanks.

Hardik
