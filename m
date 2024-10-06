Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146BA1A716
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231528; cv=none; b=MOypEy9YQv/FJ5aYp0f8vYUk88HPsVv5q7JNF+nqlRg1QPw0q2xZtYZJ9UiN7U3mqBr+wjiq8Efk6nCgAZdm/31tOjba90etAuT+wDGBfwKfwIm4+S1XYtjDtaeuLtTveJpcMSCFqv9uw0ILJtJIs5Vyd11vb/ivbR3YucqeeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231528; c=relaxed/simple;
	bh=8Ihs9tMnzLYZvpXKdtYhO/PCIpNui3itPgVGU/wvkVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1JVdpDYQr9qEM0v7al6G62o1ogkMX6NvxlQBVxV9TUgAzhNewgD8F8nyhFnel6Hoox6Kz+PkPzRIpHJFOrYiGUK5SrDeFIyS4I8PXqNyO+Bb63D60F2nv6mIH6w+avuxX9Uj4hD3RUPDw51eWgtWTXC8uvc9lDv1GrO4vP5wi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaP262EW; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaP262EW"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50c9fb5d88fso352394e0c.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728231526; x=1728836326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+qE+j4KCPcDSpK2HedCsmjVIpgbSDnRV4/07WRMgS4=;
        b=FaP262EWhl9W49mq3rSpxFYFWJAGxicjyuHpQL8fqES4w19KjlMqHz+jQMhqqiCZ79
         xTT2gd1Wehromb1bz0I6Ry0jp/EJUqMIHaoOW4vt6T8loSBbgOr9JPtUh+pYMJkp+1s3
         B54m7wtZlch3H8n9p7qLUHWi2n/0hvQdatbkF+KdkMPmGNqieEY36p59ARxv6RDyqxTd
         tj7DU1N+17TLJNKbvAwLQmR5pOLhfbegaNTrkOvJuv/prx4Ma9NzYLHL6Gphw5Q/ZP/O
         Dv4WAF52Uh1RE98lwBtRJuWGavp4B5lnlDP1PP+ikwK9gHiT8nz8KaPPIPgzrEcUO3Jk
         qrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728231526; x=1728836326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+qE+j4KCPcDSpK2HedCsmjVIpgbSDnRV4/07WRMgS4=;
        b=IvQgocadLWnuXVAvmaphnyNGnM2Ko8d5bjuUutTfwqneP0/DsNs3lJf/vd8oMcPm6H
         Rzcg1A40vpYpc5m+CMkNfI0A4E39fqRQZuICSp7Gryf6l/5hqoEFhSvXg01wOuJcBNFR
         trwcYZCKyZQEuN8R9/jQZUpcs8ZiKU0hH/o5558xLooor/7ADp022EKf4TZ7CnHXmPR6
         3vZ9d/EAiFdn/GXwqCsdFMpiqi8q3ngNOTVZ34CoRuHTpR7hAPeMq7da5qwjSM/g29jH
         VUyfZi5N0CIxE5iqkmt9c4EIa+8vGiFEu6eeiNS1PhyzyYk/jHGGzYCTsu+Y7nNqgHK7
         k26A==
X-Gm-Message-State: AOJu0YwZ5IkYb2I1Os7FQGNizcKs3V1iflKkzo49RyKfuqY6q/RTeUgX
	HMZiWOIChVskcvSGZMhRL5EFyBxzD9ntZviEnni1yofgGrF4BCY8qFOuMZF5MWNOxiMg1T6AbTW
	CbnwyGFgHdOCKxvXvR9wMhxacs8k=
X-Google-Smtp-Source: AGHT+IGtmyaNWhVqinBeUBoX39eFeFwQH1ar6zBS1yfZrKhR9Im3iS7++oTesD1m91Q4o3gGLmNdsOH/8rneW8jci/s=
X-Received: by 2002:a05:6122:2229:b0:50a:c7cd:bee4 with SMTP id
 71dfb90a1353d-50c8545a77fmr5599540e0c.1.1728231525833; Sun, 06 Oct 2024
 09:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com> <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 16:18:34 +0000
Message-ID: <CAPSxiM9eExGxy5biEr_23tCKXaUQg=tsD57VR7e2SVdvVJR+Kg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Eric Sunshine <sunshine@sunshineco.com>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Kindly, help take a look if this is okay now.

Also, I wanted to change this also to use test_line_count,
 test 0 =3D $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)

 But, I tried a different approach and the test kept failing.

Similar as

git show >output &&
count=3D$(grep NEVER output | wc -l) &&
test 0 =3D $count &&

Thank you.

On Sun, Oct 6, 2024 at 4:06=E2=80=AFPM Usman Akinyemi via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> At the beginning of my task, I made the mistake of submitting two patches
> for two separate commits instead of one. The first patch addressed the is=
sue
> of losing the Git exit status due to pipes.
>
> After submitting the first patch, I noticed that the output of wc -l was
> failing due to trailing whitespace. I attempted to fix this by using tr -=
d
> to remove the whitespace. However, instead of squashing the two patches i=
nto
> one, I inadvertently created another commit.
>
> Eric Sunshine sunshine@sunshineco.com provided valuable feedback during t=
he
> review process. He explained the details of the patches to me and pointed
> out that using tr -d was unnecessary to resolve the whitespace issue.
>
> The root cause of the whitespace issue was quoting $count in the test
> command, which led to the inclusion of whitespace in the comparison. By
> removing the quotes around $count, the comparison works as expected witho=
ut
> the need for tr -d.
>
> Signed-off-by: Usman Akinyemi
>
> Usman Akinyemi (2):
>   t3404: avoid losing exit status with focus on `git show` and `git
>     cat-files`
>   [Outreachy][Patch v1] t3404: employing test_line_count() to replace
>     test
>
>  t/t3404-rebase-interactive.sh | 74 +++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 24 deletions(-)
>
>
> base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-180=
5%2FUnique-Usman%2Favoid_git_pipes-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/U=
nique-Usman/avoid_git_pipes-v3
> Pull-Request: https://github.com/git/git/pull/1805
>
> Range-diff vs v2:
>
>  1:  be5a691e96f ! 1:  c9a0cca179b [Outreachy][Patch v1] t3404: avoid los=
ing exit status to pipes
>      @@ Metadata
>       Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
>        ## Commit message ##
>      -    [Outreachy][Patch v1] t3404: avoid losing exit status to pipes
>      +    t3404: avoid losing exit status with focus on `git show` and `g=
it cat-files`
>
>           The exit code of the preceding command in a pipe is disregarded=
. So
>           if that preceding command is a Git command that fails, the test=
 would
>           not fail. Instead, by saving the output of that Git command to =
a file,
>           and removing the pipe, we make sure the test will fail if that =
Git
>      -    command fails.
>      +    command fails. This particular patch focuses on some of the ins=
tances
>      +    which include `git show` and `git cat-files`.
>
>           Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
>  -:  ----------- > 2:  37b1411ee2c [Outreachy][Patch v1] t3404: employing=
 test_line_count() to replace test
>
> --
> gitgitgadget
