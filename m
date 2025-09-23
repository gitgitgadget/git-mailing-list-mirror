Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C726F296
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642989; cv=none; b=j6fE9h+tujHBD/sKgCPUb/seXRM4NAHxp4OS21M/5thHVlosjyqI/wPC4IxNYrqWp/H2CTmghlVbTQVkK2VyQzIUtLCSI8MphXwhypm92sJU2lhi1gsUsjuc/6nKQTvMBBgD9V1laFcu3u5pu7p1m3rjypFEyaNDc9T1/yns5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642989; c=relaxed/simple;
	bh=ceZ+l2WdtFfea5YDCp5uaUMxPuO3ivs9SLqejbSI6xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIiiDcrjMqQabhqy3Fdegf883GWM3BgMUxXqf1CNv+a3c9AyaRi4jjErwCIvGcPDVEYLrZgaOJCbCiFZ+IGSi935mHZe6uZwA0pKLz6aBYSFoXt5eXxao6IkY3u/fLttguj1Ejggh8tnINsE1r3Rub5jM9IZcQzBYO7K0d0/+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEdUVG+4; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEdUVG+4"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74572fb94b3so4006433a34.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758642986; x=1759247786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=epVcJ3v601U7+CMKe5rxEOUVoBSb7UlUxt5UtFSZ0j8=;
        b=KEdUVG+4dvkv4Ogm0FJz2J+Si45gLsCF1TNkGYeixQeCYxaa+CTSoQQERJi6zX3EVp
         N6Tg+rwBfjQpXmEJhg+9P0jJSenvLHvJyHqPbFQaPx6xriiLD72S2fyLOHFp6Sof2IXY
         uZ2n2BfLddtw5Onp8uIN/1WAYYtv2U3hsjAQOzaop8xPYBx9j7tiRcp5GhouaGUS06uU
         4r/HKKPfVDMQGg7xHwwvZTnHWtpoC+utDtKSuZfOz8wMjDx7O/oi74Q+BPlSAkEUVPXt
         M+zkoBog4E7w8Ip4dhydhpiTXs3ffHH2thkmAtpVKYkgby9EftVlHxCguVEn4dcsp8Sm
         T6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642986; x=1759247786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epVcJ3v601U7+CMKe5rxEOUVoBSb7UlUxt5UtFSZ0j8=;
        b=LVNJCqg8b/17u8Z6MMnJDBnDiJm1U9r9Yz0gfhiZrs6nXwRWS603WVJwX+z1opEUXw
         Rz3+hf889BW6bibaAzX0p9DGLyzDckTlDttVnmRsJcM+DmmHkVPCFeTpEUU/WJ+2IT6Y
         AXDCC1Fpmp66bL1cmdkbtszL+HD8hjePLUUP+p8f0GmNcoXu5tVcZ22jrH2mh8rZ3pKA
         c6goqSUKiuXLe5cSoy7OHoJ7UtMQg5uKb3yk/lzh8+u8Nd9B35lj8NlluQxioz+wrlPx
         xNHyCbKYN2Iao4a82p23dm8t04k8epOJdA9JqSqRdfiCCjgz1ARjwOCcK+1RKt9f807D
         yLrA==
X-Gm-Message-State: AOJu0YzbWAo1Q8gEOu7fG05r+aUlYibFAvuYE+fwLgUTrHRGRwAgiAcV
	EwpH2z4srBjlO5NRYNhm3CZ/1mAchVf34CFnIou7YwRCinGN7HEwYzKU7kKeaw==
X-Gm-Gg: ASbGncsFZGGc8hfwOOGpzXHuvnzVj9SXyuNMv9y08FyfGSKk695V4+8V62YQPwJ91mB
	qwPdE7RLaxkoRqAfGbCmyK//U333mLzXTPpC/Xv3E7tvXKXCZjaOJHHF8op+USKrb8B5HMhIN/+
	RQ7FMzKdtkMyaRD8LRsZD2T/CJFJGlIbOibu8jha4oPjNl+++IaYYHIU4zrXsCx0jyNYzdzrUp1
	ZRMDAmE+rE9cwpM8Ceg9ZQXIPvtk+uaPoYv8+SzHNCIKBa7HBWvP1SKOuU/ADaseyTbl9MfnTn/
	0JoDFO8Iq/FvcsjuRGh2SJ6siBkZzZ8hmIbWQQA7cXjEIQROvHHOwxqrftSXLMWjnqlB4gEgdsI
	r04O463sJGERM5mUU
X-Google-Smtp-Source: AGHT+IE62dwXYF6v/djH9N40LXefsOpJO8L7t8zzMHpTjdAcJ7qdA7vRquSt8VudQaFAqLDFTdzx1Q==
X-Received: by 2002:a05:6830:610c:b0:743:9758:113c with SMTP id 46e09a7af769-79148b0ad58mr1947779a34.12.1758642986205;
        Tue, 23 Sep 2025 08:56:26 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-63153ba1f80sm1207164eaf.24.2025.09.23.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:56:25 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:56:25 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] builtin/repo: add object counts in stats output
Message-ID: <jp2pzjazi6w6pm4jv7bk2c3gywksezpaoufd6aulcdxr4tbqi4@k3fjsgvejp5m>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-3-jltobler@gmail.com>
 <CAOLa=ZTihUt0d-3_LOydX4GxWPSquAOWkzw3+0XzM-zp6wFZ+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTihUt0d-3_LOydX4GxWPSquAOWkzw3+0XzM-zp6wFZ+w@mail.gmail.com>

On 25/09/23 10:30AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> [snip]
> 
> > @@ -159,13 +161,25 @@ static int repo_info(int argc, const char **argv, const char *prefix,
> >  	return print_fields(argc, argv, repo, format);
> >  }
> >
> > -struct stats {
> > +struct ref_stats {
> >  	size_t branches;
> >  	size_t remotes;
> >  	size_t tags;
> >  	size_t others;
> >  };
> >
> > +struct object_stats {
> > +	size_t tags;
> > +	size_t commits;
> > +	size_t trees;
> > +	size_t blobs;
> > +};
> > +
> > +struct stats {
> > +	struct ref_stats refs;
> > +	struct object_stats objects;
> > +};
> > +
> 
> Okay so we do use nested structs, which I mentioned in the previous
> commit, so we're all good.
> 
> Nit: A lot of the diff in this commit is because we don't make the
> required structs in the previous commit. Perhaps we could start with the
> nested structs in the previous commit? That way this patch would be much
> simpler.

Ya, I clean this up in the next version.

-Justin
