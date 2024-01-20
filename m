Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10038F9D6
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705760035; cv=none; b=E3FED8yfIu4KfmRsywkZes/O76Tw41yfRUMNDlkrJDhzMEYAKeIuSr3oaVg3oSpR7BdgIedX3vmiUVTR/j1Ir1yRVHsZlshAyLYeLd9V6hYRy619BUlcTuegngP+CpWHwtdPEhluotWJDg2eM2By40qawdHb1ERnBwCqoLS1PcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705760035; c=relaxed/simple;
	bh=n78u07sVx2Q2KOxIbvBtC+J2s9VldIDbwlA+3pgoC08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EidLl5As7KHCjF/6RzP0GAtx2lO/jOj+/UXmUkKmakcQSYxSz+PAV5bh13IcmSEoB5hviJFKxem9BVc3upW4zp3DuXu6a8vL9uN28Y8+31xEPFfJltdO7WNZZufqMeLql8dGPpiQHP+pBuqsIJ2+SE7ytaPkIV/sLE8aaH77B/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVNVLxEF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVNVLxEF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ea34df934so7088705e9.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705760032; x=1706364832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=47shqtAyEH8tlxQpT12Ll7PyKY3bq29BVfyDfvD/Skc=;
        b=TVNVLxEFhDorGaGrVb0WYErp0zElBkPsp4A/dDYuEeoq1fZM2896wbfXPQ4qlVJQcM
         ssekUxF6eQhak+bJhaYTmueHTmZTJ3paIcBbafxK/jEEct7yfQHD6soQswhBnDyPf5Dj
         viu6umYEMS6tmhVHO+TGvD2vrSHAFBnivpit9AiTbzbRF9Ue1ncdBxlj9ssuoS5ojLJV
         P41/k0Xq93tLHR7bYX63FZ/7WAew3UqRzWON3YrWswZRCtilqts8ZxyxJEZPxNR07vdy
         Gtk3w4T7ZtVWxbk8xLXhe97macz0VtMLO0y8W2lSIeBHMs/HxdAVzRApq74eC8V1jrLF
         LRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705760032; x=1706364832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47shqtAyEH8tlxQpT12Ll7PyKY3bq29BVfyDfvD/Skc=;
        b=NZ/ROnz/H0K75/YDewvk1eFMFp8qgyophjZLIim5mJuGFirRbMulVMeuXHc0ajWSTF
         kPJhhDZRhUErSt5OT+RMW/te3AJ/659Z+sZEz02s6tlXKjmlpvqwPVCiIra14qX5z983
         6hlBvgF01ITW1+vl848Py3d2IOFKjM+J+cqxnJ1RgofLZ5uGA3o1uEvz/FQi1bO2k5OG
         iHg/LwKn+Ze5fv7wRtJbsFygz/OkfvJhHycTMxqELkb8WVT57d9ZrkwInpqVgjI+kieM
         TV6NPjSteOGRX6MiPaNpDJH6J8z1Y5VL6suw2l8ZYkmoF7szB4Ww9G8pyfLh2SQil5RV
         M/QA==
X-Gm-Message-State: AOJu0YxZ61Kw/+LQRHaGgOUEHji/K+6xFHayJs3zdUAEDiDK/aYc5nY6
	YgTu7mj2uk1Uh/eJeDy7LmnIOjcTNupahaMEK4u8f55IR+6HI3zk
X-Google-Smtp-Source: AGHT+IHOVc7vZMHIEKI65KKn/j0+17FP7JjgRQyW7ofaH7jE4PQnH2QKylYfbGa115hQTcQ7roG/Ug==
X-Received: by 2002:a7b:c3cc:0:b0:40e:4d21:6729 with SMTP id t12-20020a7bc3cc000000b0040e4d216729mr771514wmj.71.1705760031976;
        Sat, 20 Jan 2024 06:13:51 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id l34-20020a05600c1d2200b0040e89ade84bsm12283335wms.4.2024.01.20.06.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 06:13:51 -0800 (PST)
Message-ID: <82624802-aa7f-4856-b819-9a2990b25a69@gmail.com>
Date: Sat, 20 Jan 2024 14:13:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] merge-ll: expose revision names to custom drivers
Content-Language: en-US
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
 <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 18/01/2024 22:09, Antonin Delpeuch via GitGitGadget wrote:
> From: Antonin Delpeuch <antonin@delpeuch.eu>
> 
> Custom merge drivers need access to the names of the revisions they
> are working on, so that the merge conflict markers they introduce
> can refer to those revisions. The placeholders '%S', '%X' and '%Y'
> are introduced to this end.

Thanks for working on this, I think it is a useful improvement. I guess 
'%X' and '%Y' are no worse than the existing '%A' and '%B' but I do 
wonder if we want to take the opportunity to switch to more descriptive 
names for the various parameters passed to the custom merge strategy. We 
do do this by supporting %(label:ours) modeled after the format 
specifiers used by other commands such as "git log" and "git for-each-ref".

> [...]
> +will be stored via placeholder `%P`. Additionally, the names of the
> +common ancestor revision (`%S`), of the current revision (`%X`) and
> +of the other branch (`%Y`) can also be supplied. Those are short > +revision names, optionally joined with the paths of the file in each
> +revision. Those paths are only present if they differ and are separated
> +from the revision by a colon.

It might be simpler to just call these the "conflict marker labels" 
without tying ourselves to a particular format. Something like

     The conflict labels to be used for the common ancestor, local head
     and other head can be passed by using '%(label:base)',
     '%(label:ours)' and '%(label:theirs) respectively.


> @@ -222,6 +222,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,

Not part of this patch but I noticed that we're passing the filenames 
for '%A' etc. unquoted which is a bit scary.

>   			strbuf_addf(&cmd, "%d", marker_size);
>   		else if (skip_prefix(format, "P", &format))
>   			sq_quote_buf(&cmd, path);
> +		else if (skip_prefix(format, "S", &format))
> +			sq_quote_buf(&cmd, orig_name);

I think you can avoid the SIGSEV problem you mentioned in your other 
email by changing this to

	sq_quote_buf(&cmd, orig_name ? orig_name, "");

That would make sure the labels we pass match the ones used by the 
internal merge.

Best Wishes

Phillip

