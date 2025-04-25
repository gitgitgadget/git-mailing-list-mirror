Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A912E5B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598741; cv=none; b=fFLm5a5VV9y3joagS3ju6PNow/ZL3HPAgjNB2Z2Q8snSEieM/RtJOO9mbKcvh2T0KEN71HEuxqzX1ljsafAE2VxeOx9g7FXg4lvmKmBp98TvfGLv4EEt1u1FO7q6O/CPwTa1V3RqLvZo2MEQDMtY3+QfXItlfCz1qVONrw9nhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598741; c=relaxed/simple;
	bh=/UMBTlGNSGblBC1psyDV09Fu1cO53Gz+2aN1BvsiP9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0uFNWU26AGzBl3SUJ2EfgYVDVrx7upMAD7ACs/8RSL3X+YuLBOY4ZqRb+duiCyAo+y+ySX1pp5wE+DsyNXKOzHNy7Hc4nQYK1v8lyDTX9OFtfhNA6WfLr1yS6FSlVHYtMZG+99rN5RaFLV54nXXgdAFTEwV0Ozs9lN62vdoD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfcxSaAU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfcxSaAU"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso2747638e87.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745598736; x=1746203536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftdyMbv7fZsWRmFBmxz4qO7ELIEADQ7weh9QkGtzghg=;
        b=kfcxSaAUxBuKddgnMcRc7lHIWxzZ+SJVhSI7xFeXiWUYsMEvXiwdXor2eEIAF0Id31
         qMa7cv7dCAOaiTrBTGz6OH9fJSKi9llIh0ixE/GCG7C+MuefqwiQRv4XYVftD8N/S2jH
         mrVzfSW2d8i31qsIwVTr7iEPFoiJMz+PEMCODtLS5rzrEMUICZnecHQu4PdIve5Zi6JO
         HWYLwvFwWhDH+QaZXrsWJSTPA/bRs+57Gsi4+yu6+IRWpU2Nj16zNrRDG/ZHQMp7msm4
         5dqSH9z5N6kmIkF96qroYEq15ZJUi4FDeF0ezqr5NW/7v3JTJORmUthfcs649pndaMuy
         jCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745598736; x=1746203536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftdyMbv7fZsWRmFBmxz4qO7ELIEADQ7weh9QkGtzghg=;
        b=hQJX4epfdel00klHHeWOa71zauDtBqU8hnBlCBuTk7mJVJMMwpMdI6W6NAZtJUrtbq
         M8ZV+XFe38fIQifA8kpMM6MUal+m7kZxIxKgP1BsGvhyUn+LG7vrqV6L2u6NqfUmBhun
         DBulA+DRq9rgGz4BqvpV/KaUVEcdBOJ4Aqr3nI1ohEAJvaBjWgB1W+S981aEd1vAu6dR
         QIARKW1b7FaYg9X6t4JT5tCDdhDOH8ctauP/FMXFz4xsuSZXU6gwCTbfHKh+ZtzD6yrv
         OlXoyO+8EeeMwEJ4BMPzDVHax3/PqtOlYXGxQdFX5nTVwZVonYfRGWxy78rDcqHY2Aut
         IN1g==
X-Gm-Message-State: AOJu0Yx2Z3fQQRr+RfSOxwscvVWDkmT4gco+wEOqnWrulkDQ2xnfc5qT
	tDOztmu6PoMr1agyUbmBBlmSsAmooAE95812TVjgE4+nLG/3CEf8i6NRvgjrjZOfT0U+On8yd7T
	1YB9yCr+Sq9pQbu3YxKKTvxFHP3pAw4qoBDqpEQ==
X-Gm-Gg: ASbGncsl+w67830ckthQrvQsT85GBfq8dwXvbIMjpVoKZKIVl6yXOFIW5yu8xRcIdpy
	vbYB2+pW3JGs29l1eLlmw+FrTbOhQCGll6JtEkEto98X3khQKKVmiBNMcIRlcHKgBKNFJSZHVd+
	49b5zHYNmM15nRNfVXWXHb0J8VgD20d/OxpjnZbso=
X-Google-Smtp-Source: AGHT+IHSlxhjoJLtyZ80ZpBwTUpKANOxfAyu2EydfBkBG+0WtMv90aIAhbPphYXHY1ad5WdBmKi3tBP4ZeiXK6AyytE=
X-Received: by 2002:a05:6512:400d:b0:549:8d07:ff0d with SMTP id
 2adb3069b0e04-54e8cc0bd76mr993481e87.45.1745598735963; Fri, 25 Apr 2025
 09:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
 <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com> <d9a114915a30281518d6e411ee01aefa670139ad.1745587067.git.gitgitgadget@gmail.com>
In-Reply-To: <d9a114915a30281518d6e411ee01aefa670139ad.1745587067.git.gitgitgadget@gmail.com>
From: Scott Chacon <schacon@gmail.com>
Date: Fri, 25 Apr 2025 12:32:04 -0400
X-Gm-Features: ATxdqUH4bMWw1N73nXhBqWsWruDQN-Cp-jZYp_ob8Vj_bz9ZFTiJfBSTfZ483WU
Message-ID: <CAP2yMaKkYdoQRJ3tH_PNrDtmw5NGfsBe6DmCYs1wwZdkAkGQDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] bundle-uri: add test for bundle-uri clones with tags
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Whoops. I'm seriously sorry for the coda on this updated commit
message. I was testing out a different thing for something totally
unrelated and was just adding random text to the end of the message
that made me laugh. I didn't mean to submit this as the message after
coming back to it after a few weeks. I promise this wasn't on purpose.
(I'm not very good at Git)

Related to the code change though, there was a comment that the
message didn't match the patch somehow, but I'm afraid I don't
understand how. Other than the cheeky mistaken addendum, it seems to
me that the message still describes the new tests, no?

Scott


On Fri, Apr 25, 2025 at 9:17=E2=80=AFAM Scott Chacon via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Scott Chacon <schacon@gmail.com>
>
> The change to the bundle-uri unbundling refspec now includes tags, so thi=
s
> adds a very, very simple test to make sure that tags in a bundle are
> properly added to the cloned repository and will be included in ref
> negotiation with the subsequent fetch. ok, now it's right. christ.
>
> Signed-off-by: Scott Chacon <schacon@gmail.com>
> ---
>  t/t5558-clone-bundle-uri.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 33a7009e9a2..9b211a626bd 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -107,6 +107,36 @@ test_expect_success 'clone with file:// bundle' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'create bundle with tags' '
> +       git init clone-from-tags &&
> +       (
> +               cd clone-from-tags &&
> +               git checkout -b base &&
> +               git checkout -b topic &&
> +
> +               test_commit A &&
> +               git tag tag-A &&
> +               git checkout -b base &&
> +               git branch -d topic &&
> +               test_commit B &&
> +
> +               git bundle create ALL.bundle --all &&
> +               git bundle verify ALL.bundle
> +       )
> +'
> +
> +test_expect_success 'clone with tags bundle' '
> +       git clone --bundle-uri=3D"clone-from-tags/ALL.bundle" \
> +               clone-from-tags clone-tags-path &&
> +
> +       git -C clone-from-tags for-each-ref --format=3D"%(refname:lstrip=
=3D1)" \
> +               >expect &&
> +       git -C clone-tags-path for-each-ref --format=3D"%(refname:lstrip=
=3D2)" \
> +               refs/bundles >actual &&
> +
> +       test_cmp expect actual
> +'
> +
>  # To get interesting tests for bundle lists, we need to construct a
>  # somewhat-interesting commit history.
>  #
> --
> gitgitgadget
