Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21E6FC3
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722914031; cv=none; b=U76HLbQcYWZ1WyeK2Mzf0fPUzJfYacASIhrs23OuleUhxKcMYvI+KMbwA/wqZ7lFFX+oc5UeVeHYP4YkYJl+aYcUo1+EMGcU0AxU+cOQfAdg4apVyRM/zCVHEpLKzmSJKCNNenQhgTsTSeJdhB//d2NW3TfXXd9BqzPcyqkU4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722914031; c=relaxed/simple;
	bh=C9vZxcIeUnq11zIp0152UQZ0TPfJE6pZBluv/iwILJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/aHWngc9QwUcS6leV05bUKpJtbcQe20jrgeiOW6qc9yq4Z4kc6cNRqnXTQWh1rdyGPxj95oTCsUw8buJ4UETqE8asp3jqlZSa3gOkbxFQTkzgrOD09CvZx3Qo9Px+lU/6tvVfXSzW/nNFrU1O1INpLapq9YT0IIvZ5Y5Vs66lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b6199ef089so1160206d6.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 20:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722914028; x=1723518828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P+osGvFlBVnl7rDO81ov4sZlC+GZDAZZr/29F61zRA=;
        b=jIB7L6xN8F2LrLIRU2HQiWgXRG8sO1u13u5EpH3D/eN4Nac0qlfX/hQPspaxD2OGzI
         jhBvuI9ODwg3WdaouGDRZ+3J2QjEZhxEb5Gv41gx6EYXwjLbh7SPKvvMmCTfBoHQqg2r
         1TB8dj2HgDErqBaOGjL6FNXmkdeG8VWL7pBiJoSX8n7b6hCDzURsyvFAvWl7HWExsYhe
         +5/1K3pssYUeWhYbB3u3bLa/s4aNg9iOgR6sIQAB4jN6TxrT+nSB9DfVBMwut25Ucuyd
         IlclvVEy/iivwAelUn2Yj/mmrek5Py4QQ3WvfzP5e2K2V6Uxl6cFbGUCZkgTTCdJbmXk
         7tLA==
X-Gm-Message-State: AOJu0YyOOEDg9LrJMR/fXLyyizD+hPse1T5UyNUk6NN+DFGAxD9Hy1K8
	gQQec70GT+26+AZu9sYgcYV3GrV6qxhZfRd0u4nYp4/aqpwHwBojlWeVS++/qxkqCVVUWcCluQa
	CyJl0hLnOafXvvYu/iejpz4nbj5c6zrRI
X-Google-Smtp-Source: AGHT+IEDT2jhJII4SPl2sMJP0bsD8mEdDFT9ohtzWJGx0poTGB94Hft3jIE+c+jwxK2CFAymdI8CzxVHaxjZ7+XUcS8=
X-Received: by 2002:a05:6214:4608:b0:6b7:b259:4632 with SMTP id
 6a1803df08f44-6bb9832ed1amr197146386d6.14.1722914028347; Mon, 05 Aug 2024
 20:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805235917.190699-1-abdobngad@gmail.com> <20240805235917.190699-3-abdobngad@gmail.com>
In-Reply-To: <20240805235917.190699-3-abdobngad@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 Aug 2024 23:13:37 -0400
Message-ID: <CAPig+cS6-gqZbJSz3wBcummyycJVudKybVZW=D33WHk-Fa9ytQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] [Newcomer] t7004: Do not lose exit status to pipe
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:00=E2=80=AFPM AbdAlRahman Gad <abdobngad@gmail.com=
> wrote:
> Split "test-tool ... | sed" pipeline into two commands to avoid losing
> exit status from test-tool.
>
> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
> ---
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -97,7 +97,8 @@ test_expect_success 'creating a tag with --create-reflo=
g should create reflog' '
> -       test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_r=
eflog1 | sed -e "s/^.* //" >actual &&
> +       test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_r=
eflog1 >actual.body &&
> +       sed -e "s/^.*   //" actual.body >actual &&

It's not just `test_tool` we care about; we also (importantly) don't
want to see `git` itself upstream of a pipe, and there are many such
instances remaining in this script. Here are some common examples:

    test $(git tag -l | wc -l) -eq 0 &&
    git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
    git tag -l | grep "^tag-one-line" >actual &&
    forged=3D$(git cat-file tag ... | sed -e ... | git mktag) &&
    git tag -l --no-sort "foo*" | sort >actual &&

By the way, these days, rather than:

    test $(git tag -l | wc -l) -eq 0 &&

we would say:

    test_stdout_line_count =3D 0 git tag -l &&

which nicely avoids placing `git` upstream of a pipe.
