Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811E21019C
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717824; cv=none; b=HxYsW7UFac2mv9cp4ajfFB91Xqhr754v1i3rhTLccyNyBRLNn1oNOHEVNr6MQcZfiHbABtEqVM36wf//tWdMjC4EaCeJEw7FTyTxx/w5u0z54QI9xsrmJahnOquNAvFIs8W+Wy6ruCihwhS3eAGjWluQWUCncBX7IIj9S4WTGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717824; c=relaxed/simple;
	bh=TjVAKKlsRVpdxeHazG/Xwwb3xp//rYC+ioGdPHR4CO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHLJuNgvV8PzVOnLy/3ZdTUO+Psa99x+LJ2uwJDvS/MU+tTs68Wak4nfJQMa4yy7Jw8ONL18Jwe0EP527aMNxlVUdWMoHcs0t2iwil2Ve/6SCS6tpOAckkescX5PebdqYeCRHWrclJ1ezUGBlzyrxnv+8HK5RarFMdJfzimxQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQd90otF; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQd90otF"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-417661eccb2so22084735ab.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757717822; x=1758322622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfLbF0XXcnCFsTVG2xWx59aRKkeE34qo4GhIYvXLaGk=;
        b=cQd90otFRo0KXef5Fdii2y/VjHSR7SIa1Qblq8RX6kbQJPdqN3FQenNm74cHMaIPTn
         AGmoDAQA18l0rVpgV3GBAVyrGx4+Cz8udAkEdeMMtxdIPbb7FJzSxbul7Vx4AgBgsnH9
         sHDTDtcGWigj2vTvJWlwzcJ46gfGd2ZqtBG2LYXKzDrRZ7tzCzel+BJQqiPcVLCZvwYn
         us1kTCZ650+oqS75dsiHNGk83zp0spUpY+BPNgT3KPMqz4BI8cbHbrEpulYAbDyeB+Vj
         9K6C1HOk3eAK+fXPxub41U6f1poQetwlKkpORN9e4rnprYlYH2d3zXkstY2Rqep1fnHy
         7Ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717822; x=1758322622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfLbF0XXcnCFsTVG2xWx59aRKkeE34qo4GhIYvXLaGk=;
        b=CXjrTnVYudAaGL0/Y/BNpWQAmj5w+cro1fT0M7FvZlW4d6PLQthbH6Xw+cfG+S+iCF
         zN04Ns+USNXY/bFBrGhaAnREqEo3j4pGh0DzCNrm8QuPcd4uwkAnW/3pnsYDWMJwgwFB
         mwc4r4oW2aKnHQNeAXv8J/pOWSZ8Xc0YP1v+X9hfg9fBAnYi/HkPncND7XnRTQB8Zh7y
         GKSkDMTw4lZvhWPBifPB0GAXQrLdXwqad5Pxh4+5OWeUn2LhvKms/S/q8xjXRwbHSGpx
         9xcGjd9jmsxpyseeq291oQEF+gjjILznusBjnIvN8B9n5R17Oa2CF63vbGCZTDX3YC2Z
         uMyw==
X-Gm-Message-State: AOJu0YwP/YSdLHvc0loYzV2GncVh1Ry3V5nsKy/ZGM9M2p3hThaRFhcV
	ir01TCIy52lGVXwxG5Z7aXVEMN0eB8MKobkTqjFdy7MgESc/5iWGnJ2FKQQTsEXNOQpLLtqCgwQ
	SufHjZ8AhTr3OMN2ywxuxkPJjqS9DcjEoxw==
X-Gm-Gg: ASbGncvIBAYGNoFcI0JinWW7djAUDAoO2793BdDTmSEWPj0G/hCY+p9l7DfQ6YD4Zck
	IyRnN6pCYh1zy57IymJQUjo4nsFoc203mh7TYCF4bT8UljoZWCViwf/X0NCTuqAO+ydrS4kZCJA
	I31XucCuWfYcaywf1JKaPMwdzwt7VNmRzit0Igo0VzpoMMLSrkhFwxQlKTPJC2cU1EVXyd25A6Y
	SlJyj9V/xWEOt7QjxAgBFO67/y/3HYYdAe4MavHtQ==
X-Google-Smtp-Source: AGHT+IEsg9vxiIdMBB66aEQ4rIdQrrIZerXoiG2Aa7iSemggbWg1LVxeBd1MO2HSDU2Livh3GCzIoWsGbeDMZX24eGk=
X-Received: by 2002:a05:6e02:b43:b0:405:b792:32dd with SMTP id
 e9e14a558f8ab-420a30271e3mr66399795ab.16.1757717822552; Fri, 12 Sep 2025
 15:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN6PR03MB428572C742338251D0399FDFAE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
In-Reply-To: <SN6PR03MB428572C742338251D0399FDFAE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 12 Sep 2025 15:56:50 -0700
X-Gm-Features: Ac12FXzsC8ROhOMPxtPrFD1NPWqOInGurecPt4aYNfp-sC6YzmIyG_0IfAc78nI
Message-ID: <CABPp-BHYEYgqo=G8q2XKReNn6PM+FWn1_8qfKq-ONS6pXXeN2A@mail.gmail.com>
Subject: Re: [BUG] Git merge produces inconsistent indentation in merged result
To: Guo Tingsheng <CoriCraft16@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 6:14=E2=80=AFAM Guo Tingsheng <CoriCraft16@outlook.=
com> wrote:
>
> Hello Git developers,
>
> I would like to report a potential formatting issue I encountered when te=
sting Git merges.
>
> Environment:
> - git version: 2.43.0
> - OS: Ubuntu 24.04 LTS
>
> Steps to reproduce:
> 1. Start from a commit containing the following method:
>
>    public void process() {
>        if (flag) {
>            execute();
>        }
>    }
>
> 2. On branch A, modify the code by adding a new conditional block with in=
dentation consistent with the surrounding style:
>
>    public void process() {
>        if (flag) {
>            execute();
>        }
>        if (shouldLog) {
>            logger.log("Action executed.");
>        }
>    }
>
> 3. On branch B, make no changes to this function.
>
> 4. Merge branch A and branch B using:
>    git merge A
>
> Expected result:
> - The merged file should retain the indentation style introduced by branc=
h A:
>
>    public void process() {
>        if (flag) {
>            execute();
>        }
>        if (shouldLog) {
>            logger.log("Action executed.");
>        }
>    }
>
> Actual result:
> - Git reduces the indentation of the newly added lines, producing inconsi=
stent formatting:
>
>    public void process() {
>        if (flag) {
>            execute();
>        }
>    if (shouldLog) {
>        logger.log("Action executed.");
>    }
>    }
>
> Additional information:
> - This issue appears to occur non-deterministically across different test=
 cases.
> - It does not seem related to core.whitespace or space-change options, bu=
t instead to how Git decides indentation for newly introduced blocks.
> - The problem was reproduced using multiple merge strategies (ort, recurs=
ive).

I've never seen or heard of such a thing before; can you create a
testcase to reproduce it, either a repository that others can clone
together with the commands to trigger it, or a bunch of commands to
both create a simple repository and demonstrate the issue?
