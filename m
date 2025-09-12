Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCD21019C
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717833; cv=none; b=Tp6QJftSTQ+lasx5CR45H/XFaVL5XjeXJPdNbo9vz08t5BZrg8KHPg5NKBzixwLOi68PySFbzN7kCbBmT2JMlQFktSDSTOQo2tu4I9YycoQJKfM6voVMUxhHQWNEm8DKxJRSueztvxP0DOpPf0l/OFhRxj6RyODjjE5yArMvplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717833; c=relaxed/simple;
	bh=AaK+fzPLGJxdHuO+iWxjK4f83jmD2mCG7EylPO1wPz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaqqfvMy06Quvjo7jXMu8UWyCPZoStQDzWeaovKqs4yMf6XUKORhZBUYh4aAR4aeFbfSr8G8MUxwQfv81YQcMGYyt4y7U4ZXfzo8Em+zSwcDYf3bV/ZIrrnP/9oA1+pNlz1zvDbMSk/V/sKJ1GkSfniSz9aQA+KRj3gfMtK6LPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQFQb+NB; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQFQb+NB"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-407ec3048a0so25614895ab.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757717831; x=1758322631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FFc/hEhj5CKfmHq/+e/QLOdAkfFOyTq/ASLSvZcTyc=;
        b=HQFQb+NB6I16Oy0GBkdccRSBWJkY2jepntX/SU5dtd970wLolzqdKH6z94mZ28U0PW
         s6KPySD+u7mmXQFlh61RKJfRnqrlifn84778lmSisqW/xZibAuQQys3wj9wPcxzktXLT
         8LCTHFN+Vf2ZftU0gGV8ASgOn3wEquW46CNHUF6KukncfsVHritjI12gnDK5WADhFe71
         tM+3fYL8pW84L12zPku6tSHCy0IWn37AA+pMBnXWOTcbx8x0ISU34C7fm9ndPCJG8gsS
         tieL6lHV2izoQMe4jiUxnMWY0OhIJkrKnCQiPWR9DTjGRXiDkR7rxVqAowdCRYI5O9Np
         pNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717831; x=1758322631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FFc/hEhj5CKfmHq/+e/QLOdAkfFOyTq/ASLSvZcTyc=;
        b=uxFwy7A+vaK1JTeNa/wF2J/QM7/5d7NCrUbVSipuhiCoWZojoD1/LntMspLCIQzaMl
         tlI/Xgo4kOTiyTe08+ZLL2Yapbs0qT7shZHzxZWPUUtKZqXz99MfkGO/AdxNDGCiBszV
         tGtbecvqPQ0IkjS0yHJrU9agcWXLIKrACM0Km6/EnBJG3qKoTNLHUUSRsXrJfN1wIBCv
         LdJ+17Flb0nsxETYjuvYvlD98mpJm3oWm6XKajeKQR7xY1kVUcfTjMWeG81iosu61cFe
         Bd18secYYz48CBG3DzOR22qUwhVcteaaM39pvz5vHNAN4KYFYZvQ9GJdske7JXKR5YEb
         dUvw==
X-Gm-Message-State: AOJu0YxmgyQKIPpOvvx/cUX+wyDHa2kSOSnsgnKK16NMIwDaUceLd8Lu
	s4R1tR4Tdmw/40J8tA4MRP6PAeXy4J5CZRL6H0w8moMvnu3BkVXUNcKOwxtd+L5bGAAXrMEIG77
	7j8kkXKqIrBvLaUadd9Wy62MxrL1uX10=
X-Gm-Gg: ASbGnctMaeaZRgI4OCYbfq3A9uT4Kum2we0jVETBy4a+dNHd1le5TbOyNH2XdGyLAfG
	RdzmsanOUHmhOAAdZ2fAJENzVdLMlsySXr/dTjADSQfTxgnOa52ENnxrbNgmh0TwTr22M7q6BtE
	TPnDkdpHrucprfQFKj2JNFEO2U6Y3eIcNUDQNp2UiaB6a4mtQtnxC6XlWrI/mNY9QmHh1LbffeF
	297jKFO+voOF3aU0ug/UD5fo0PC2aOY6CqWc9WYLA==
X-Google-Smtp-Source: AGHT+IFn0TGF5d9VJFOfGTlAfomLo0GQ1ljwdm5JdMvToc104QoEmLvEG+g0KiaiuB3pkMbK9agaKTNP6K6ur6kjMzI=
X-Received: by 2002:a05:6e02:4406:10b0:422:62f8:20ef with SMTP id
 e9e14a558f8ab-42262f82257mr35416285ab.19.1757717831358; Fri, 12 Sep 2025
 15:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN6PR03MB4285B971FAD1CD485B9A8840AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
In-Reply-To: <SN6PR03MB4285B971FAD1CD485B9A8840AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 12 Sep 2025 15:57:00 -0700
X-Gm-Features: Ac12FXz5xMcWDqSNH5Yp9k5hsJ4BY72vJLGW2vnMpx9EEX6GxLzThxmEwAnxCAM
Message-ID: <CABPp-BGawdV9n9BtrwVXO1Vc2pBcuq1UtQA-1XEyHD4zB1vVCg@mail.gmail.com>
Subject: Re: [BUG] git merge reports conflict when two branches add
 independent methods at the same location
To: Guo Tingsheng <CoriCraft16@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 6:38=E2=80=AFAM Guo Tingsheng <CoriCraft16@outlook.=
com> wrote:
>
> Hello Git developers,
>
> I would like to report a potential issue in Git's merge behavior, where s=
emantically independent changes at the same position are reported as a conf=
lict, even though they could be merged automatically.
>
> Environment:
> - git version: 2.43.0
> - OS: Ubuntu 24.04 LTS
>
> Steps to reproduce:
> 1. Start with a file containing only:
>
>    public class Calculator {
>    }
>
> 2. On branch A, add a new method `add`:
>
>    @@ -1,1 +1,3 @@
>    public class Calculator {
>    +    public static double add(double a, double b) {
>    +        return a + b;
>    +    }
>
> 3. On branch B, add a new method `subtract`:
>
>    @@ -1,1 +1,3 @@
>    public class Calculator {
>    +    public static double subtract(double a, double b) {
>    +        return a - b;
>    +    }
>
> 4. Merge branch A and branch B.
>
> Expected result:
> - The merge should succeed automatically, producing a file that contains =
both methods (order does not matter).
>   For example:
>
>    public class Calculator {
>        public static double add(double a, double b) {
>            return a + b;
>        }
>        public static double subtract(double a, double b) {
>            return a - b;
>        }
>    }
>
> Actual result:
> - Git reports a conflict and aborts the merge, requiring manual conflict =
resolution.
>
> Additional information:
> - Although the two changes occur at the same location in the file, they a=
re independent additions with no semantic overlap.
> - It would be desirable for Git's merge algorithm to automatically combin=
e such changes, as the final merged state is deterministic and conflict-fre=
e.
> - This limitation may impact developer productivity in real-world project=
s where multiple contributors extend the same class or configuration file i=
ndependently.

Thanks for the report, but how is Git supposed to know that they are
independent changes with no semantic overlap?  Git doesn't understand
the semantics of the files it tracks.  It has no idea whether the
things being added are functions, or statements/expressions within a
function, or college essays, or hand-written recipes, or data dumps,
or anything else.  It would need to know those semantics, which would
probably require something on the level of use of AI to determine that
the changes are independent non-competing additions with no semantic
overlap and that you want to keep both.  Instead, it knows which lines
are the same between the two sides, and which have been modified since
the common point of history.

Without this knowledge about the meaning of the content, assuming both
are wanted is wrong.  It would mean that all the other cases where two
sides each add lines would also end up with both sets of lines, even
when those are conflicting lines in a recipe or conflicting statements
in a function, or whatever.  When both sides modify the same area in
different ways, it's a potential conflict that needs to be given back
to the user to resolve.
