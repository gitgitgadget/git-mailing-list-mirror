Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAF1FF
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 18:39:23 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d7fa93afe9so1789066a34.2
        for <git@vger.kernel.org>; Sat, 25 Nov 2023 18:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700966362; x=1701571162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fbc0dvxvX36Kg4IGZ50pGTz6H9A8bmAUl2+QrAx5U8=;
        b=ropxqvdmUcfKytLGa4PZl/bn3M2ACR9IFbwqAoFNMYH4iRnZ1gOoPhO0ryQ1iKVFkI
         bieZnipqrZJoshV0qhvvdXXJYLLb/x70kfkUi2dLQkvNu1lxySaT7KId0DZookx/kYAd
         DTmKxcHafV0L+ewnnpzJV9JPUKcVwZRRCKj2WR671h29ocfsdSikWc6i2WunnnfQRcI1
         S+jcVkTKY8vR+vzhPJQXb0DYkHiT1/qylohEyeN78wQfdqtfFGZajNNZ6cfyY7+ZfjY+
         TxKMVdrbr4fmk3fXXi9U4WSyU2hf/Z/6+KZ9/2yTjduuopSWUbkvcbVbBW3EfbzHLFbp
         2urw==
X-Gm-Message-State: AOJu0YxLQgIMrofOpshJ0j+gpfD8KIzQKHvUnLQNvGmBgRWFSOrVosFB
	Rs4XlA3Qtko8i1aprNZElHtSJa3w4CuFpSiT+k1nSTIYJz/BfQ==
X-Google-Smtp-Source: AGHT+IFmqKa1pa6jNrLe34UG7PL7HhMT2oqQL2P29GUghEhlY4cTzdhWuwIRK+Mf81ji3P0HxUFWrXigTn+hamjpnA8=
X-Received: by 2002:a05:6830:2b27:b0:6d8:11f7:8a34 with SMTP id
 l39-20020a0568302b2700b006d811f78a34mr4124470otv.17.1700966362682; Sat, 25
 Nov 2023 18:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125094429.12025-1-linux@tux.freedom.nl> <20231125094429.12025-2-linux@tux.freedom.nl>
In-Reply-To: <20231125094429.12025-2-linux@tux.freedom.nl>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 25 Nov 2023 21:39:11 -0500
Message-ID: <CAPig+cQq0myrGFro_MO8H+x8W52UuivX=TzShxb5diVp2nLh7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-send-email causes failures because of wrong
 option specifications
To: "H.Merijn Brand - Tux" <linux@tux.freedom.nl>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 4:52=E2=80=AFAM H.Merijn Brand - Tux
<linux@tux.freedom.nl> wrote:
> ...
> git-2.43.0 =F0=9F=90=A7 perl -Iperl git-send-email.perl --help
> Duplicate specification "cc-cover|cc-cover!" for option "cc-cover"
> Duplicate specification "no-cc-cover" for option "no-cc-cover"
> ...
> Signed-off-by: H.Merijn Brand - Tux <linux@tux.freedom.nl>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -506,36 +505,27 @@ sub config_regexp {
> -                   "no-signed-off-cc|no-signed-off-by-cc" =3D> sub {$sig=
ned_off_by_cc =3D 0},
> -                   "cc-cover|cc-cover!" =3D> \$cover_cc,
> -                   "no-cc-cover" =3D> sub {$cover_cc =3D 0},
> -                   "to-cover|to-cover!" =3D> \$cover_to,
> -                   "no-to-cover" =3D> sub {$cover_to =3D 0},
> +                   "cc-cover!" =3D> \$cover_cc,
> +                   "to-cover!" =3D> \$cover_to,

Thanks for submitting a patch to address this issue. It matches very
closely an earlier patch[1] addressing the same purpose which has
already made it into Junio's "next" branch.

[1]: https://lore.kernel.org/git/20231116193014.470420-3-tmz@pobox.com/
