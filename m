Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFC1DB34B
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072370; cv=none; b=DBXZysYY0s5opwvJ99lMsZ3E7DDUwoPBFIAjDXQPbnaP8doGdoQGr1dzNfd10SKqVC0UpPpWZ8zrSaudT/layGnfNLuYV5PQaxCNF8F4w9oY0FfHqVQ32Lm37/dc+HJ0AWLGMs4bTlT2MtwOgx1gQ6j4icq20R61HhrlR+ZByag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072370; c=relaxed/simple;
	bh=1Ec5CmsM6yfsxqnnMe763ldDdhPV6RYY+r8R0aBy9Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CT+UIvXFJ+qu2T3uxwW3QM1fh2ANM5E0Alh72tZ1WUYBx0yyVkvcM921V5YpQWO0Ssj3QY2dLzHuf6ZM5KNzSS/GPGsQ1MRdmW9/wFCMiOR/Z4o6MHOOCkJVUE/MrWjd4CE6bH8KZ9B5/Jrb+0q1TGaxh4T7l54gnsodwHNP5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIrXsHXE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIrXsHXE"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99fd4ea26so201042685a.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728072368; x=1728677168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93D7ULudEjVMDAiFVomgtbNyaSDo1s4+mDQJrOoepkc=;
        b=ZIrXsHXEoSmSkVx2iVRaWDEoNjjbUe7RSlXy83BlxCQ3txDsDxe1G86Fb6fOoPqvw/
         BI/UJOWuWdn6tT4jRCpauOPY/XZEqsROXwJQm7rPnmKzCS6X9xSZJZwY4o9wbD5tCar6
         bYgR6bqzny9O8+cZAfnKgchoxdQ3Sn1cQeRKJUigiB/2bZirfiBxmWCWGdM1SwTiw6ak
         VFM773INr9kTM0DnaWT9cjrARbaktZNfQKwen/cMlA30VT/GB+P7P7jqrAl2C0/SvaGi
         h6EYZD4OjRYmJ3PDEI4+eAbbPEejz+YtwPedG+KdMC7l69/tlmbu+QBIZEix+dj9kEUg
         rM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728072368; x=1728677168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93D7ULudEjVMDAiFVomgtbNyaSDo1s4+mDQJrOoepkc=;
        b=l82XMfgI8ncQx0NiNzp54wNKrBzsIdRiI1o83wGeKgvvjrTieA4wpxRY1e4GPdJvHM
         xNIPSg38lWW8YsJGpmCGvfjcwOcA0RltrHW9YmrfBYYqydGDoK3Imew2uZirxZZntYOg
         xGGdhWCpSrpWqe/VfEkmNn9bCt2ySA4uHiRwfhu8udodGRis4g5tox5002D2clnT4D7E
         nvVoVObciW8ZQ2VRiyr1zrJD3vrTddRyHjTwVVr/1swOc/nSG1uu5MqbA/mvA44S8yCm
         IQlkQi9rmIWVaZpibliJulnnPioPSC621MWxz+6zYIa9A08mIvXLcZ3o2okLElV6MPOh
         696Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU5Qbmv+ZNA6R5cxlY5uVJ2R7/HB/FsJQ5RXvRzI28TckCjwnFw8+GIaOsWRgSlBQEovw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDR3xDwcjz3wZ5o6fpQDx8XqwRXQJOzLOdqbdXhTh27HM4m6Lf
	pPhSP79/TBHVhH1HwAmc7bJHCCSyg/iuUo4fzJAK++lk98ikZ5WK
X-Google-Smtp-Source: AGHT+IH8hWHdKj4XG6dZh005poOPJE0RTGKReK5BUmrg8E80cNSsJhHsMWAyq3kAkIFj780kXxjBKg==
X-Received: by 2002:a05:620a:4002:b0:7a6:6447:19ab with SMTP id af79cd13be357-7ae6f48813dmr614147785a.46.1728072367665;
        Fri, 04 Oct 2024 13:06:07 -0700 (PDT)
Received: from [10.37.129.2] (syn-068-173-161-103.res.spectrum.com. [68.173.161.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7561fc6bsm16118985a.17.2024.10.04.13.06.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 13:06:07 -0700 (PDT)
From: johncai86@gmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 shejialuo <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/4] archive: remove the_repository global variable
Date: Fri, 04 Oct 2024 16:05:54 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <40DAFE71-EC0C-4FC4-B7C4-F054562E8B19@gmail.com>
In-Reply-To: <xmqq1q106hdd.fsf@gitster.g>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <857291d7f7dffdd1a63ce9268c8ac91a82f2bdb5.1727718031.git.gitgitgadget@gmail.com>
 <xmqq1q106hdd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

On 30 Sep 2024, at 16:01, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> -#define USE_THE_REPOSITORY_VARIABLE
>>  #include "builtin.h"
>>  #include "archive.h"
>>  #include "gettext.h"
>> @@ -79,7 +78,7 @@ static int run_remote_archiver(int argc, const char **argv,
>>  int cmd_archive(int argc,
>>  		const char **argv,
>>  		const char *prefix,
>> -		struct repository *repo UNUSED)
>> +		struct repository *repo)
>>  {
>>  	const char *exec = "git-upload-archive";
>>  	char *output = NULL;
>> @@ -110,7 +109,7 @@ int cmd_archive(int argc,
>>
>>  	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
>>
>> -	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
>> +	ret = write_archive(argc, argv, prefix, repo, output, 0);
>
> This looks OK, but unlike the original, write_archive() now needs to
> be prepared to see NULL in the repo parameter.  Is that reasonable?
>
> Perdon me to think aloud for a bit.
>
> The context before this hunk handles "git archive --remote" which
> can be run outside a repository (and that is the whole reason why we
> ask SETUP_GENTLY), but this part has to happen in a repository,
> doesn't it?  Or is there some mode of operation of "git archive" I
> am forgetting that can be done without a repository?
>
>     ... goes and looks ...
>
> OK, write_archive() has its own setup_git_directory() call when
> startup_info->have_repository is false, so this happens to be OK,
> until the beginning part of archive.c:write_archive() will not
> changed to start dereferencing "repo" pointer.
>
> That sounds brittle, but probalby outside the scope of what this
> patch series wants to address.  It also makes git_config() calls
> even before it realizes there is no repository and dies, which
> smells fishy without actually doing any harm.
>
> So, after all, I think this step is probably OK.

Yeah I think these are issues we’ll need to address once removing the
the_repository global from archive code.

Thanks
John

>
> Thanks.
