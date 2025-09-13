Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6314B977
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791490; cv=none; b=tGF36zjl6QkT9euy84z1ndZ/+Ip/DzMO7q7GaHHok98hNJY9wBdyCy88fRfQOAkSXa3UeHCDuEdVUG7SeGEINsG8kGZVZRZs/QPoMeuKVUjbQdl+asCceyx6ihXYrWhuQ8tc8fap3McOLhGQAjh4vhUjGknCHP7gg9J7OllPGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791490; c=relaxed/simple;
	bh=LcyCADXntSfHJOczKM0J6WvtfrN0BUApb0cxHunvMHA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dgFXwj/6e//kNGDhfnHDD4L6saJQOJzFokaPsQzgo7NuTtU+ZIUZEw4rJH+ynbfRMO3QEWzN+OpGam9gWLq1ZDfwW9ufcVS/0tQqtzaBk1VU6ezPYEQzOkSMB8JzNAqv0m394UIshyedr493xhJ18WI+zjUAkst9dGlNn+yU5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRJZmnDe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRJZmnDe"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea3d9ac7700so1185984276.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757791488; x=1758396288; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nxATIQnFEsKUkaxegtzy/oH8vmlDUqjZD/zYh6iHwA=;
        b=XRJZmnDeZN7qsxuGQ7a3gIOqYiLvfiCJnMw+xouI/oPGQPw9E/Vhe/tlZFhm0DC8ke
         ZLxIlhArfPoP0tbJdKYFwIdIaVO+rSjwn888u40wAXyIs2qmTFEIp6dHzIoxnEYYCSZ0
         k639AZAi+P4lTwXDN4vnptCKTqRnVH8zOrXODiAkI6/bodACOQ3q7PM1nlrLeQ2MkM5U
         LLrQi4lVz4VfwxkeGG5eTTIDk0kdHJck4tk/kOhE8pUL79U5WRI4ZFsK3kdkA7xZ10LW
         PigtdUfENxPve2d4Ih7tN2Jn3AkKOBEUZnhcPz5EhySfg0NZqteBuJW/HoFO/QvzPm7Y
         VMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757791488; x=1758396288;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nxATIQnFEsKUkaxegtzy/oH8vmlDUqjZD/zYh6iHwA=;
        b=bz041A7Y1BVmVwYoW8l2M85WHtNOKw+60AFYDFsnJFWfLv1kGT2B2vgLowobBmFprH
         88Dc3M5c9bYlRM1bBcUZceFPKqLfsETKgnfXEVLZsHAbHmieq6+dAmaRrgt+6N9gQjs2
         TjHJ4ERsCBAEOXrnkJloVPowvy6FO8JG/MYpo5KjojNEd6i5UTiEJXHqFWnCgNC9HQYw
         qotAs/TCwMENu22FN+5WHAd0BeTjqZoGk/h8ArJUp/y9Eu/sQGJ1r5hevnVka6ApJBtI
         JRqA3lF/vjSOTRhI166Z3O8Zp8kEBDgo+sJmJ2aUYOVcjg+SclNUmbkHymcQVGihmS1n
         wWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjKFh8qhNTMaq3Z/0rK5Y+N6cID0dkx6A0NlEZWPbbmYC2TLRG67c6NHouBlIqjfpowek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDMaQGrl/OJQAnBgJAelps/jv3o4e0yKQveuItw/dBx+bmMnw
	XoQQlNSZG7nRniI9zrCarTDfUj/gK2r796p1hPMdNimgLehadmllVBixuYR0dJtw
X-Gm-Gg: ASbGnctz2Q33WrhliHtKdvSOl80JWWXGy9XOXn+LtdW4QC+FbP+rqZbDojYUsfRfnOU
	GKHvdOk6MtB3zjs+zFvdpYLmeVujC1DrPhNFTE/l93gvDR/PlDkA5VOQtaZHd1WmDAD4yCzxDvV
	lVo+vllBenlGmq79rJsy5KQRTXX7vNhHucGuIxA55s8EU8zwGkrOqYqD6CqEXnKnNoK7N1GfnAO
	omJ57CElO7QJEbILvwfz/yr4QuSSjgnglyW3gt+Nbcs8XK6ZftHZfu4I+mBXYmjtATV1Jom6m5m
	0Ab7tDmpeSFyojs+HBoPEjXwi5V7KCFtr6Ff5zx0P7571rOeWvaOWHM3QuqtTZkA7HLVn5PBWHX
	GtvQBKrvPYhrpLIfOWtcxyxYMAQLpzQLBjY7puK9YTJT6YYDUeJ/N1yw29k9tuDiWQbDkm8GtEg
	zGQ8FVhbSJD/oEb8ly1F3g0OH2lA==
X-Google-Smtp-Source: AGHT+IGc76GfjxA6S6T992FzEddXsr1DqsULkzDPwbStCdbVbsRGhnXgwKH703awzMmC/9Sh8pAGjA==
X-Received: by 2002:a05:6902:6b0e:b0:e9b:eaf2:4d55 with SMTP id 3f1490d57ef6-ea3d9a7ab0dmr6054298276.31.1757791488092;
        Sat, 13 Sep 2025 12:24:48 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3feaeeab8sm362778276.5.2025.09.13.12.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 12:24:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BUG] git merge reports conflict when two branches add independent methods at the same location
Date: Sat, 13 Sep 2025 15:24:36 -0400
Message-Id: <1020FC45-71F8-44AD-AF5A-BBC98AFC6C84@gmail.com>
References: <CABPp-BGawdV9n9BtrwVXO1Vc2pBcuq1UtQA-1XEyHD4zB1vVCg@mail.gmail.com>
Cc: Guo Tingsheng <CoriCraft16@outlook.com>, git@vger.kernel.org
In-Reply-To: <CABPp-BGawdV9n9BtrwVXO1Vc2pBcuq1UtQA-1XEyHD4zB1vVCg@mail.gmail.com>
To: Elijah Newren <newren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 12 sept. 2025 =C3=A0 18:57, Elijah Newren <newren@gmail.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFOn Fri, Sep 12, 2025 at 6:38=E2=80=AFAM Guo Tingsheng <CoriCraft1=
6@outlook.com> wrote:
>>=20
>> Hello Git developers,
>>=20
>> I would like to report a potential issue in Git's merge behavior, where s=
emantically independent changes at the same position are reported as a confl=
ict, even though they could be merged automatically.
>>=20
>> Environment:
>> - git version: 2.43.0
>> - OS: Ubuntu 24.04 LTS
>>=20
>> Steps to reproduce:
>> 1. Start with a file containing only:
>>=20
>>   public class Calculator {
>>   }
>>=20
>> 2. On branch A, add a new method `add`:
>>=20
>>   @@ -1,1 +1,3 @@
>>   public class Calculator {
>>   +    public static double add(double a, double b) {
>>   +        return a + b;
>>   +    }
>>=20
>> 3. On branch B, add a new method `subtract`:
>>=20
>>   @@ -1,1 +1,3 @@
>>   public class Calculator {
>>   +    public static double subtract(double a, double b) {
>>   +        return a - b;
>>   +    }
>>=20
>> 4. Merge branch A and branch B.
>>=20
>> Expected result:
>> - The merge should succeed automatically, producing a file that contains b=
oth methods (order does not matter).
>>  For example:
>>=20
>>   public class Calculator {
>>       public static double add(double a, double b) {
>>           return a + b;
>>       }
>>       public static double subtract(double a, double b) {
>>           return a - b;
>>       }
>>   }
>>=20
>> Actual result:
>> - Git reports a conflict and aborts the merge, requiring manual conflict r=
esolution.
>>=20
>> Additional information:
>> - Although the two changes occur at the same location in the file, they a=
re independent additions with no semantic overlap.
>> - It would be desirable for Git's merge algorithm to automatically combin=
e such changes, as the final merged state is deterministic and conflict-free=
.
>> - This limitation may impact developer productivity in real-world project=
s where multiple contributors extend the same class or configuration file in=
dependently.
>=20
> Thanks for the report, but how is Git supposed to know that they are
> independent changes with no semantic overlap?  Git doesn't understand
> the semantics of the files it tracks.  It has no idea whether the
> things being added are functions, or statements/expressions within a
> function, or college essays, or hand-written recipes, or data dumps,
> or anything else.  It would need to know those semantics, which would
> probably require something on the level of use of AI to determine that
> the changes are independent non-competing additions with no semantic
> overlap and that you want to keep both.

Sorry, can=E2=80=99t resist: we=E2=80=99ve been writing semantic analysis co=
de for decades. It wouldn=E2=80=99t take AI to get this right.

What=E2=80=99s hard about the situation is that it doesn=E2=80=99t generaliz=
e easily: a semantic analyzer that can resolve conflicts for one file, proje=
ct, language, etc., is not necessarily of any help to its brethren.

Still, if you write a lot of Java or similar code and have this problem freq=
uently, building a merge strategy option or mergetool you can use to resolve=
 this easily seems worthwhile. (Not something mainline Git needs, of course,=
 for all the reasons pointed out here.)=
