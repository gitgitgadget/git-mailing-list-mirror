Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6B748F
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977000; cv=none; b=kXfzLrSTms3hUp2Oa86MdKl1lPRX0MJ0bVnVh3b9Y9tiAMjqlRLsJXvth9/x2PzJLCFdwNXRQLiEE8AdFvmGZJWgfIJYOobt2GooRvODm7eVuBOagbQyd78tUfyo5nZLkvyUtgKkR72xwgEzSzh290PCrK8lZxTQgM4hT936y90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977000; c=relaxed/simple;
	bh=JbfVYHnfNv+hUWZjgbvXxCjYYHnOW0Qf8RZQBgqLWSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgLk/NuAHS+N71M2dOqaGQF+WtlWTFjssEVEeRE6qlJEBW+QOygswEjdmpTIHfMEeVENQNagu5vddGQW0Hup5t2nC+7owSsQfeqySvhs91GrG0eDX2HgoDWnMuEmALnFOQUmOB1gudQkQNeVvy2ePGgFhRxV6maODQADE7DQR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI65I9Yu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI65I9Yu"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso5784613a12.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748976999; x=1749581799; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCyJI0Ts9x+gZrJYhP4PKYCguzXIvlKp7cu2R2eEFjw=;
        b=RI65I9Yu0ommMal6mUag7kynIocXHRRGWIjw4kmrI+9jHH4PEKjr8gBtMq587kXZOw
         An4A/0FAnkxuE2fwcTxtKfTk6SouZ2Uui7g9YZYWZvku77A8W9A/Ph+C+8lD9QFJhDs/
         BriUn6cnc20J0tTQpJtqjy1jMxxN+TM4wyq1HxdL+01/4y81isVraEi75frNZCed6xXz
         P47nyFMBRXbtDAb/EXCDJf1BxH1gsrQPv6DjotLL10vcVZs3F3Km3QCblRmqQRxnqUZa
         ucyuuzMU0uH++TcwXzIpMmJ3CJwyTClGlqIG8gB4v8T8dtaO33Majx5s4eZqp1in+/mH
         FyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976999; x=1749581799;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCyJI0Ts9x+gZrJYhP4PKYCguzXIvlKp7cu2R2eEFjw=;
        b=L8ptK6ktQnjCvjewhYI4a05v/UIA6HiEXHZ4dR50phD9jJ8OdrdErxMGQ5zlKwAoh2
         zFFOOpdDJ/n/633vpb595vtJw84uZjpaMkf6KktFkMNFPv4WZNGgY14ppu32jZk9Bo+1
         E2g8q7ol6aLyGB78kHFhQqyMAkYyxiOD2HDhys53OJTGdPeHoQbiVfG3lcgwdiFM4jAP
         2ZOhC6MRClOR3K5cHa4RNnaCoOSsEFv5a6FD7vdKpTlfgyp7N0aLeKu+E5XQVjOtPXEB
         MWns6Igoe4mJCjwnqMXtfAKOd+jEHGwXnQasbDLku/AjjtFV2QIKQ9Vqs9OHWOESxIaC
         hTzw==
X-Gm-Message-State: AOJu0YxpIGsKfK7R+dLwOE/LAXHsXs/ryqwthqwKhM1B7eqzisJnHcE7
	2JFxL+MkUVXKpM3YxwHhEv5m8vk49W6PGRE2Jcfpu8/BMHE9r4RLXulv+rJMwQ==
X-Gm-Gg: ASbGncsSmVeEQqC/o8qi5L/eZMOcxMA395KVDg5MxXotjTgbUKa2eyhw42B9gCRje7Q
	7sNG+HLnmQ1rBPXB41UPvyN5UPM3al7bjOfRPoV7KZHVgsENlLFBTvSEuPTEdPRrBrBSoPtRdoh
	ywy9353dcnCMrRhPUB/Bw5awASVxuSTCjtWdzJiQt158CpQ7JqN/FtUv1cIC986QjTr32aQ0jnB
	cOpDVvaGbv/SzEJ1mWms82Wq2jA6ZeSRmrAm2XivTOQ7klNvFU7llQEe8PZkArsDFQxuUEJvrMm
	4XkMwJXTe/bxWjueRBqdyvmTdfTYTSo=
X-Google-Smtp-Source: AGHT+IGdthzoJfIVMJmyvVW90SRXctKzLrXjNL935W5elTU6SkxKHK3+W17muDTbEjR1kiex7GeyDw==
X-Received: by 2002:a05:6a20:a11c:b0:215:e60b:3bc7 with SMTP id adf61e73a8af0-21ae00895damr23714883637.26.1748976998711;
        Tue, 03 Jun 2025 11:56:38 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe9648dsm9758148b3a.6.2025.06.03.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:56:38 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] CodingGuidelines: document formatting required by
 generate-configlist.sh.
In-Reply-To: <xmqqiklcri3o.fsf@gitster.g>
References: <xmqqplflsmic.fsf@gitster.g>
	<45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
	<xmqqiklcri3o.fsf@gitster.g>
Date: Tue, 03 Jun 2025 11:56:37 -0700
Message-ID: <87sekgpsbe.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junio,

Junio C Hamano <gitster@pobox.com> writes:

> Collin Funk <collin.funk1@gmail.com> writes:
>
>> + When documenting multiple related `git config` variables, place them on
>> + a separate line instead of separating them by commas. For example:
>> +   core.var1::
>> +   core.var2::
>> +  	This is a description of 'core.var1' and 'core.var2'.
>
> As `core.varN` in the above example are all what the end-user would
> give literally, just like `git config` command name in the first
> sentence, they should be marked up as literal strings, i.e.
>
>     ... For example, do not write this:
>
>     `core.var1`, `core.var2`::
> 	Description common to `core.var1` and `core.var2`.
> 	
>     Instead write this:
>
>     `core.var1`::
>     `core.var2`::
> 	Description common to `core.var1` and `core.var2`.

This markup is different than what is used in
Documentation/config/*.adoc though. Here is just one example:

    $ head -n 3 Documentation/config/core.adoc 
    core.fileMode::
    	Tells Git if the executable bit of files in the working tree
    	is to be honored.

That was my reasoning for writing it how I did in the patch. Are you
saying that all of these should be changed? I do not have any experience
with AsciiDoc so I am not sure if that is correct.

>> +This format is required for the `generate-configlist.sh` script to
>> +properly generate "config-list.h".
>
> It is not wrong per-se, but this tempts people to "fix" the
> generate-configlist.sh script so that it can grok the comma
> separated list "again".  And when that fix is done and reviewed
> carelessly, we'd again break some implementations of sed the same
> way and we will come back full circle ;-)
> [...]
> we explained that the reason why we want to do so is because it is
> easier to "grep".  Does this "do not comma-list variables, but list
> them one per line" also give us better greppability, and if so we
> want to explain that way, perhaps?
>
>     $ git grep '`core\.var1`::' Documentation/config/

Yes, that is a good side affect of the change that can be documented.

I will send V2 after clarification on the other point.

Collin
