Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B12DFA36
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734060; cv=none; b=WCPV5DYTCgTWsfvPHS4LUivGx5b4ZZx+EOv0OwFMwUBR+y99rb4CaMglj0hpWIAwZ6jz30U4XCvG3oOu3iEvDhIEV1PIy4Uw0ZDt/Elzuum6LgcK3t/n7AHnAoO3vkU9cXNZnDCqQ7oH1YUGqW8BOPQ2pS83TZeXODKm4cTrpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734060; c=relaxed/simple;
	bh=KAvLYVQzkYmsVpL4gpBjyiny9XVzhQDM5FLqM+K1nTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQTObjib/5PvtKXDBKBfDpWZrT5POvULyPXj0QZvdov3Fho2wPiVipWjBH/ppIBiUp3B1LX+yDzYbHXMjENvct8oJyJ8JyFVwL8oDQHWIY2l22LPF8zXD/qsDtbu0OJDCaGcdpGKO7v9/1kGaeusNUSTVB0NZqD5L6LVXCS5LKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPiBnJme; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPiBnJme"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f8ae3ed8adso3321166b6e.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744734057; x=1745338857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dS4IEXlm0TPUDZGtSn346BFymp9qQbAdM25QjaQwtPg=;
        b=LPiBnJmexUYRZCCxJtRRhkAU+PIlA5mNlP2tx0++OKKsgado7FkiBAae+kSlnX4n+P
         99hEjGVI/NJN0ElT2O6gR/S6OjgZqrgZ4LTO5YyNT/hgDkVshoyVuGn2zUqjSy3ivdEg
         I7/K7Jm1jGNtZZqnQhe62cnvwGLpbictrRvGcu17ppIGo03nXv9USb2af6PxFqEnZc9U
         cN3kVKxF5WcFdhIcV9fV1IfiLubD98AObVuUOJRbEzOxU+WF+kkWZlQBxaYu0CrbWB+k
         yDGhN8/cD5r6RHB1BlCFfwod7898/EetV9rgmtHuIaBkS/0NnnUoT9dsa2UcGa6a4L+/
         uvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744734057; x=1745338857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS4IEXlm0TPUDZGtSn346BFymp9qQbAdM25QjaQwtPg=;
        b=hjaB8o+uV36LZMXQAXf0rIO2UyeJQtMejA+2lS8rggWShpf1RpWEL7E9DqkPweHU4F
         SwN6jXTbYY7nZvJU3W2Sd4OMMPrFyd61xwBF/BoPtFM7wdbB6uZduR1ZIlmzkaatzMaw
         ZnRCmjS7gnAtjyHUyH/7eKUNAPkavI0xqA4RKwGKRw9Yj3D82piDAJO+fFZ3ceK5eb2l
         aLXXdzrGtos2JBaF6U0yameUocxwwAsr2AGYImzMQiBHIVZ5c/iSvC1xft1PjyVkAno3
         FZYZw7Seh57IeyOjNoCEAAWUB4CSn6i7bQSvnmY+3xL8KSx/krlr45uryCuy/w3J28DJ
         6vkQ==
X-Gm-Message-State: AOJu0YwmuhdGsEg4Nzyo6gKWfu3zbBzCQ0id9P3C9orN8rDBuuRHcXbz
	jO3CGYTIUXcVwx5CWfFDAj0i2SLHLChuAeEcZqbLqKcaxLVllU8ArgjGLSZ6ghr2KfhsZnE/RUz
	nEJ/n6XXZw9JdL17J/6hjwiqr3nA=
X-Gm-Gg: ASbGnctGG0PvFFpZKN7mjIqKMW/vumsRI/5PSqfB9k7CXIMigc4zXCJeVdXE6QBlSgJ
	y7yWC5M3n3CoZ3/Dpy863Je8vJCFe3h+T7LJkhmfe9agcubQGvoufyuhwA/JtLNgN1t0ye6uWd2
	NHtAepAYIp1WloIe+Gui6ATLvDMx7QZuKSegLGZjRdUjtO09a2h8aUeKc=
X-Google-Smtp-Source: AGHT+IGiizxEhBeJI+QX2P5y+WL8ReMvmUX4Uci7GRd7/V/SvakCU+0SFqesejVmz5GfShjWR6AJkd1a4JkosCGEWig=
X-Received: by 2002:a05:6808:17a9:b0:3f9:4bab:da6 with SMTP id
 5614622812f47-400acaad243mr92726b6e.15.1744734057577; Tue, 15 Apr 2025
 09:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE8aReXOwM8ByyObxrb8NhRMYfK1OB_6B9eOO07mYXMkp_E8EA@mail.gmail.com>
 <39551FA4-855C-4E55-BC2B-F77D9BBCCF6A@gmail.com>
In-Reply-To: <39551FA4-855C-4E55-BC2B-F77D9BBCCF6A@gmail.com>
From: mu gsh <yue937@gmail.com>
Date: Wed, 16 Apr 2025 00:20:46 +0800
X-Gm-Features: ATxdqUFoN_9P6cGZELbZ4pbGkfbrXJT2SO5nKQsn7-9Kdb0-8di3QXja_yZ55Gw
Message-ID: <CAE8aReUm2rCR76L2T175Ng5Pir+-G_a4whxiOPhfvNzXSV_d2Q@mail.gmail.com>
Subject: Re: git merge bug report
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

focus on the feature 2, the two double empty lines, which one is the new one?
```
    bugger = "fix: the empty lines blow not the new added lines"


class NoMethod:
    pass


class Product
```

Should the second one be newly added? instead of the first

On Tue, 15 Apr 2025 at 22:13, Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Hi!
>
> > I would like to report a bug I encountered in Git during a merge
> > operation. The method from one branch was merged into the wrong class,
> > despite there being no reported conflict.
>
> Thanks for your script! I could reproduce this here!
>
> When two branches changes the same plaintext file, Git tries to merge
> them based on their contents without taking into account the syntax.
> It is done using diff algorithms, which you can change using
> `-X diff-algorithm=<algorithm>`.
>
> I tried the four algorithms available (minimal, histogram, myers and
> patience) and all of them produced the same result.
>
> Sadly, they are not infallible and those mistakes may happen. There
> are other cases where it can happen. For example, imagine a Python
> class with only two methods and each branch deletes one of them.
> After merging, it will leave an empty class definition, which is not
> allowed in Python (unless you use `pass`). These algorithms are not
> aware of that, and they'll leave an invalid Python file.
>
> Also note that they are not exactly wrong. They only do their work
> naively based on the information they have.
>
> This way, it's always a good idea to check if the merge went well.
