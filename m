Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0503148837
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147010; cv=none; b=afWRVScpIG9hrKGsTmx3XB0Qm7ROvUGag5Y3XE5G8Rz6eea6YspnCHH2ae5fLfZGra6Utctoj/0udpj8LKMdFTpXu/wl5b0SWdIykjWKdpBcT3ZdLd3X28ICe2iCigShQ3krs8cGEq2VcQEwGNUoGXz0f0kxryc0CVlNJv3kLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147010; c=relaxed/simple;
	bh=S5dAXr+eZNqxEZ/bb9YRS+fPO3F0t9FRbkQ3TLW1YbE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWG99wePUPa3G6oWuD5XqEcl+PalxNW0RVCquvftVzekZMEmJZeUMp7eJXiE/WMNLy6LhFvSTHPoZHh4ZLyxc+kmfGHeInLF/iSAcUgdnBP2xEbLiFY75Bx2fGgGCDhUvS/pYAANXZ0sMlkVFyw8s36dT5EvqlWUHxTSZixNM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBSCD4z0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBSCD4z0"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518a56cdc03so2625745e87.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714147007; x=1714751807; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VnJLDliN9u3wLMUWEV8xnG+vbDKYVn/eINQo2yJlAF8=;
        b=kBSCD4z00AK1kE6MwKFvMdmmvlMXSH+FuO7nKSDYF+XzcqvIOGJbstbcw4WsWdBoXq
         IDek3kj2P4m7d0l/5UP7nkr4SUozITTpmJDlndlbyfFSGbikJN9LSeZxlhXjT6bplkN7
         Jrl/fokAQinpj1unEGH4rr90RGEQR3yTI7ReZ3q1nQPbky9T7rBfgQjtLXFBzT4mhWzo
         AC+ySBHh3pCDoqEghLq2jNmQct8KXmVRg1NMu/YWFO21x52Kxhga6lAVsddq2yeFmQWJ
         sNWrOp7DazxBVrZKfe6IEZtH3tYq8maT+4WN0IykC7GcVa05VATrrvob3wcmJ+jEDBSk
         w3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147007; x=1714751807;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnJLDliN9u3wLMUWEV8xnG+vbDKYVn/eINQo2yJlAF8=;
        b=Kl5B2bEzx8bTjF7Wf64Rcl3J7hgCo+TpmpLJ/CTuHvn5B1LV/B0RzCet+JNq/ctMnI
         869qkwm9KxNNJwNYZIC1i3g+HlVMnw/SkvwZqknKGo1mEsWoP2aSEJJpsraVSNEt7BCE
         QtWdwNLkz5PRbd1n1GWHaeMSYMUuv/1/au1jjdZEXQZEYYbr6dD3qeJrcoUF6+B6fFhj
         jbrHhqjWASQCR8gNoSjQfOkf30fkU9U8U4U0faVh1ou8LEFKkQUpBaKRKxV789PiEWgw
         uOhww0wS5iAaYdXcM1tfa0Kw6PW5ZWUitqqCYepLL0uy+x6R8huFafsiRhaeCymYbEBx
         4gRw==
X-Forwarded-Encrypted: i=1; AJvYcCUqc+SsIqaC9FG6YWgC885xiyMw8QYDEc28eVLVG1aPXm0CztEOT+ZPuMbU1Px3Ot73M3brAzMYE+lrnzKtw3XTTzs7
X-Gm-Message-State: AOJu0YyN3FvEQ+A847C1J9qVp5cVB6f7Jwwc54//05kACsJk2ZWoo1tM
	dcB0XlYuadfx2WZV/ZPtjNxW/PM9yDB4ayi+vhqDvRa1jYSSCZo0C9eVmPVS
X-Google-Smtp-Source: AGHT+IH3kGUfNnVKKtbLvsk5uCknVGnLCIL0bq09L29JnczFOJya+yJTGE0SgIJwiLsPQLCJvLOnDg==
X-Received: by 2002:a05:6512:2383:b0:51c:fd0a:7e34 with SMTP id c3-20020a056512238300b0051cfd0a7e34mr105637lfv.22.1714147006316;
        Fri, 26 Apr 2024 08:56:46 -0700 (PDT)
Received: from FBUtveckling ([31.3.153.139])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24e8d000000b005178f5ad215sm3202687lfr.122.2024.04.26.08.56.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2024 08:56:45 -0700 (PDT)
From: "Felipe Bustamante" <fisadmaster@gmail.com>
To: "'Karthik Nayak'" <karthik.188@gmail.com>,
	<git@vger.kernel.org>
References: <000901da972c$61efc670$25cf5350$@gmail.com> <CAOLa=ZQyCwJO3QhLF+_ZkFWWoQ77o+0Mdrvz8hL0j-x3fdt-5A@mail.gmail.com>
In-Reply-To: <CAOLa=ZQyCwJO3QhLF+_ZkFWWoQ77o+0Mdrvz8hL0j-x3fdt-5A@mail.gmail.com>
Subject: RE: Use of Git with local folders
Date: Fri, 26 Apr 2024 17:56:46 +0200
Message-ID: <000201da97f2$579fa110$06dee330$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCJ8UaSDHsKvOzOZ9RAt48ByJcRFADyLtmftBRpS6A=
Content-Language: sv
X-Antivirus: AVG (VPS 240426-6, 26/4/2024), Outbound message
X-Antivirus-Status: Clean

Hi Karthik,

Thanks for the reply.

What you indicate allows me to create a relationship between a new branch a=
nd a new empty local directory, but what I need is to relate a branch with =
an existing local directory since the latter contains the changes made to t=
he source code and I need to generate change control.

I am going to clarify the working conditions to explain why we have worked =
in this way.

The computer for development is in a completely isolated work environment, =
without connection to any data network, all data ports are disabled (networ=
k, USB, Bluetooth, etc.) so there is no possibility of copying the code. so=
urce towards a more open environment.

This computer only has Visual Studio 2022 installed, no other type of softw=
are has been installed, which is why it is impossible to create branches fr=
om the master since VS 2022 does not allow branches connected to local dire=
ctories.

The only way that could be used to isolate daily changes was to create a di=
rectory each day, by means of a copy from Windows File Explorer, containing=
 the changes made during the last and previous days.

The structure of the project would be as follows:

1. CS_2024-04-10 directory, this is the original directory containing the o=
riginal source code. This directory was converted to a GIT repository using=
 VS 2022 which allows us to have the master branch. Because of the above, t=
his directory contains the hidden .git directory.
2. The next day, a copy of the original directory was made, and this copy w=
as named CS_2024-04-11. Because of this, this directory contains the hidden=
 .git directory of the original. We worked on this copy by opening the proj=
ect in VS 2022 and making various changes and then saving the results.

3. The previous process has been carried out for two weeks, so there are 10=
 source code directories which include the changes made during each workday=
 plus the changes from the respective previous day, for example, the direct=
ory CS_2024-04- 16 contains all the changes made from day 10 to day 15 plus=
 the changes made during day 16.

Now, what we need is to know if it is possible to convert all these sequent=
ial directories into a GIT structure with change control such as the first =
directory with the master branch and then branches that can be associated w=
ith each subsequent directory.

I have installed, to support the idea, the GIT program. For this reason, no=
w the development computer only contains two software for development, Visu=
al Studio 2022, and GIT.

How would it be possible to create branches from the master branch, using t=
he original directory CS_2024-04-10 and associate these branches with the s=
equential directories created?

Thank you very much for the help.

Felipe Bustamante
Sverige

-----Original Message-----
From: Karthik Nayak <karthik.188@gmail.com> 
Sent: den 26 april 2024 12:16
To: Felipe Bustamante <fisadmaster@gmail.com>; git@vger.kernel.org
Subject: Re: Use of Git with local folders

Hello Felipe,

"Felipe Bustamante" <fisadmaster@gmail.com> writes:
> Hi,
>
> I would like to know if it is possible to combine the contents of several=
 directories with copies of the same source code but with different changes=
?
>
> The stage is:
> 1. There is a directory with the original source code, without changes.
> 2. There are several directories, ordered by the date of creation, which =
are a copy of the original source code, copies made every day after generat=
ing changes, that is, the original source code resides in the DIR1 director=
y, a copy is made with name dir2, and changes are made to the source code o=
f the project. The next day, a copy of the directory of name DIR2 is made a=
nd renamed DIR3, we work with this directory making changes to the source c=
ode. The same process is carried out for two weeks.
>
> The important question would be, is it possible to combine these director=
ies in a repository with a Master branch (the first original directory (DIR=
1) and transform the other directory into branches of the master?
>
> It would be useful, if copies were made that were made on an original dir=
ectory (dir1) that was already becoming a git repository, with the use of V=
isual Studio 2022?
>
> As an observation, the work is done on an isolated computer, without inte=
rnet connection or to backup devices, the computer is fully isolated and it=
 is necessary to generate the version control, in the case that it is possi=
ble.
>
> Any orientation in this regard would be very useful.
>
> Thanks,
>
> Felipe Bustamante
> Sverige
>

I'm not sure I fully grasp the problem, especially around why these copies =
are made in such a way.

But, have you looked at 'git-worktree'? This would allow you to do somethin=
g like

$ cd dir1
$ git worktree add -b branch2 ../dir2

Once done with dir2, you can remove the worktree

$ git worktree remove ../dir2

But the branch ('branch2') would still remain and you can merge the branch =
as needed.

I hope that helps

- Karthik


-- 
This email has been checked for viruses by AVG antivirus software.
www.avg.com
