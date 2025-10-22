Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A83446DF
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141411; cv=none; b=jyTge3YzSz7vGrxW7cXBBAP4xBOqFwBJ8zeas5FqE5Pj0Sjl/0YzFERhFEu9f7yOKCc7z4BdUshhJnafCFJgQIuJVNqCZ6EIgXW+HlD0G1KXlXzFXmBc5BTzWvDhoCpnFLiKAw966x3uK/isBch8J6NTQA0XAJQsDdyhQNdE4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141411; c=relaxed/simple;
	bh=Dl1OqH4urlrtnHZqyVKIwuHu8XKljjXG5XzBWrEZvj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8hTRm2qEXj7KXupJl2ig+KSMBRX0wvqPBzz27/xPnCYZWXw+5ODHA1uSWb+0usosl7+Jc17juAK3runmyDtYrtXWezuqAqAHH69va5VaBEhVxFem3z5RDP1EHFRAb8BuT8ccg1IAH05V29hphzK/jWpIZFid1/5VWqt7Wnnk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh4pDcED; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh4pDcED"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so851874566b.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761141407; x=1761746207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl1OqH4urlrtnHZqyVKIwuHu8XKljjXG5XzBWrEZvj8=;
        b=Vh4pDcEDHN2/RsvshJ+Xo0PlyPocqWce0w8Nq8GUWh60caSIW0R7ZlCSY73xe5g6PE
         H9XlxNIjrh0Y+g0Tei8tChTtvQ6KDzekyQlWIY44AP4vzlgANXXREt3Qpjo2PIVUnlH7
         GYbOr5uV3fb6U5Fm73DHXD4yAj0vAPZi7kgKkZ93X+RwwgnXiu+E7H0hteO6xSiMMVFo
         sCumb2jok939L9CDt3UEWqvy4vY8hg055fkaIII49S61AnEw0w9AZ86j8/AhxAN72WV9
         m0uYsoVYyZw+1lEiKI1vMAABt4D92nFx1wdPuI4gbPKt9o2m/Rif7IhpOcLI/dIWqVni
         f4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141407; x=1761746207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl1OqH4urlrtnHZqyVKIwuHu8XKljjXG5XzBWrEZvj8=;
        b=Z4sB/vwUySrwGz4knhsIvCcW09BRamvElPnM3+WiJv8MNUf+Rf7cmQW4/7QS3BF3Sn
         piVa4g4gmtU4kjA20lhH+LTfgmcTZQ3CAAPqYgFfftOjLddF0XSCOYQX3jRntJKaSHKU
         YfnT9DZpb22pswFDie7LhVAiNUkcOs9Zc8q8bTT2C0xGVHxwUwNQn7+wxUFeIutwsRdw
         pwtsSZTUiBnFmbl8EdyVUgcRslyIsVn/0U8EXFKW5IkICP9vKJTt3uPkwH78mWYYfgmz
         3qGuugbYdZPT1AGltTyj607euy03Kw3MmyaAq0WWX+z2AOttLH4PA9aeyJZNlimI8nvS
         g9Qg==
X-Gm-Message-State: AOJu0Yx+hqd9wryenZxDQZJjDUo1l4y/NEz30ybhy6M2HE/ZnwQygNfE
	F5pQ6e4ebXWCbnDf7oB07+6uejUy6vJI5d5h63x9Q6NAULn1JnqmW8GU9HuFb42sSzN3EJmynpI
	eN/o3Ou3TpoolmVvuUghe4cj/ZvRmu8A=
X-Gm-Gg: ASbGncseoPyfjNN7tMMeqiL759VWrXBDia5FIzpaWwRe8a6kZNWJYbCPNUBHj7bc3bt
	1sDzNgBGP4hkkupBvkxPRhLzc7EW5tDJWNAEX2Dh+cVx/MXyjCUU+fXM0FI6gAzrZ/kyVqvAmj0
	bL3p/1MYTGVtrWa1HrjJyRLy1+qGN8jEzLFrn3bVuTBoLNDY9b1uU6/c8JKvs1amwvBmtAMz81s
	LXuf7RrDpV7Q/LWYzWqGgxdqSQhqzQ0+kIKSVS8jss3xfJzEtjRQLeKC1/+XUyCRthGB58=
X-Google-Smtp-Source: AGHT+IFHzn26ui208TMbxmBfU/36rm9icXQ3arUA70ah9h0oZ5kV4AGsmGCzTqK5v2qw70282ldTKANo7aLK9jeCbhg=
X-Received: by 2002:a17:907:3d9e:b0:b3e:3c1c:d301 with SMTP id
 a640c23a62f3a-b64769cb8cfmr2451858666b.61.1761141406826; Wed, 22 Oct 2025
 06:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761135129.git.belkid98@gmail.com> <df8fbbd3a50748fd974083b6bbb07ffca91be465.1761135129.git.belkid98@gmail.com>
In-Reply-To: <df8fbbd3a50748fd974083b6bbb07ffca91be465.1761135129.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 22 Oct 2025 15:56:34 +0200
X-Gm-Features: AS18NWAGo_sVPEkfUeifOkQ2fUHAlOwLDW79rqgJyKg0N_7In7KlApL36Lv49NQ
Message-ID: <CAP8UFD2GCG5y7c=utQ43M=TfVPSDF0qUUAXH+U2nRpeuKfcW=w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v5 1/2] gpg-interface: do not use misdesigned strbuf_split*()
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:40=E2=80=AFPM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:
>
> In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> put into `fingerprint_stdout` strbuf.
> The string in `fingerprint_stdout` is then split into up to 3 strbufs

Nit: it's not clear if the first sentence of this commit message is
part of the same paragraph as the second sentence or not. If you
reroll this patch, I would suggest making it clearly part of the same
paragraph like this:

"In get_ssh_finger_print(), the output of the `ssh-keygen` command is
put into `fingerprint_stdout` strbuf. The string in `fingerprint_stdout` is
then split into up to 3 strbufs using strbuf_split_max(). However..."

Otherwise this patch looks fine to me.

Thanks.
