Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9CEC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiAaWWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiAaWWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:22:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D22C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:22:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s9so28179012wrb.6
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IoGvfX0jZTTIaBqmJmGRJmwl1PqcSfSqEQmdDnkxGks=;
        b=mjbNqtVEzP+O8IVziNH3ktOoHpWfIA1jtkBgr4EO8pRFjIUVSH8Lwkt7/iWKmmNdSI
         ex5QHMluMXDgeYYm3Do1jhKIuHh/UUuAiEKzCZNsoUImgjyi5gSLztjFKuIotuY0PbIA
         Lc21F+2KiKxZdqQ6P7fped4pcRnIjzUgCDF5vA13UxSI/jiGcj2ZhbE65HI/pMVWId9k
         d098w4NunWmvio0vdll0uMWiT3NYMPCSqyd7CgMMLo5yJQwiiPo9iPQ0mF2tdH6fK8UB
         P5GrYqpsKX/Wxu62BjcY634vuMuSjkG6i33DOpUOqKbHW9YMZkqXV0IJYIZmhltKZl2g
         LNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IoGvfX0jZTTIaBqmJmGRJmwl1PqcSfSqEQmdDnkxGks=;
        b=PKKeRoutEsrApqTg3/oHVwRiBavuPijHP/BnuJY1OBXidsKWMT0HMjuOxtNgnsMD2/
         DnzmKnkjuNGyfgGBTWa0w5pMgc1qjVilwcDXRtNpBqnEZ+O7HN/kBcYT+48rRejDWgbD
         aZphwZ4D0VOEQbk5GQa5Bv8ZAbrsr0UzDfx99FfYL+W7PTPgLhZriU22EpLH9E3gOLmZ
         aIOLG9fFQelDOW5jKCYqKaYi6XJ/aO6FrxIscoPUvNg72VbbxZFyen1WAc0EAyT/cgmy
         rtXA8wtHxlwHbSqdvoBWf/RLUJgGnPv51BUsqSnndzOLrgLBXBgIUDNnd+AnkTwkFIlk
         VGmA==
X-Gm-Message-State: AOAM531ol4ncQBiW4eAUJkqDLe7UtpL80OouZMJlPRvCEnjFavTjqFHs
        DnGIlyOiH/BKMiYVlo4KsBuZQvpWHXA=
X-Google-Smtp-Source: ABdhPJxgftacZacO7N5GIG75NeouhTv7bpCRBzRnLAMrFdANOxC9b/N1n37UhGOYcznEmd4GMmTi+g==
X-Received: by 2002:adf:a313:: with SMTP id c19mr19024956wrb.552.1643667731441;
        Mon, 31 Jan 2022 14:22:11 -0800 (PST)
Received: from smtpclient.apple ([2a01:e34:ec41:7980:bd0f:43a4:6858:c6cb])
        by smtp.gmail.com with ESMTPSA id y15sm18822686wry.36.2022.01.31.14.22.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jan 2022 14:22:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Stage, test, and commit only some changes, then repeat
From:   =?utf-8?Q?G=C3=A9ry_Ogam?= <gery.ogam@gmail.com>
In-Reply-To: <87iltzpo1r.fsf@osv.gnss.ru>
Date:   Mon, 31 Jan 2022 23:22:10 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0558E792-899A-4B08-B0A1-4844E5D1EFF2@gmail.com>
References: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
 <87bkzrvpjv.fsf@osv.gnss.ru> <49031AA3-CDC3-4CF6-A04B-E3533907FCA4@gmail.com>
 <87iltzpo1r.fsf@osv.gnss.ru>
To:     Sergey Organov <sorganov@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Le 31 janv. 2022 =C3=A0 22:56, Sergey Organov <sorganov@gmail.com> a =
=C3=A9crit :
>=20
> G=C3=A9ry Ogam <gery.ogam@gmail.com> writes:
>=20
>>> Le 31 janv. 2022 =C3=A0 17:27, Sergey Organov <sorganov@gmail.com> a =
=C3=A9crit :
>>>=20
>>> G=C3=A9ry Ogam <gery.ogam@gmail.com> writes:
>>>=20
>>>> Hello,
>>>>=20
>>>> I would like to stage, test, and commit only *some* changes of the
>>>> working tree, and then repeat this process with the remaining =
changes.
>>>>=20
>>>> My current solution (published at
>>>> https://stackoverflow.com/a/70914962/2326961):
>>>>=20
>>>> 1. Stage some changes:
>>>>  ```
>>>>  git add -p file
>>>>  ```
>>>> 2. Save away the remaining changes:
>>>>  ```
>>>>  git diff >patch
>>>>  git stash push -k
>>>>  ```
>>>> 3. Test the staged changes.
>>>> 4. Commit the staged changes:
>>>>  ```
>>>>  git commit
>>>>  ```
>>>> 5. Restore the remaining changes:
>>>>  ```
>>>>  git apply patch
>>>>  ```
>>>> 6. Go to step 1.
>>>>=20
>>>> It is not ideal because a) it uses a patch file for saving the
>>>> remaining changes; b) it uses the stash only for setting the =
working
>>>> tree to the index state.
>>>>=20
>>>> It would be ideal if I could save *only* the remaining changes in =
the
>>>> stash instead of resorting to a patch file. How to do it?
>>>=20
>>> It looks like you don't need patch file for this workflow. What's =
wrong with:
>>>=20
>>> git add...
>>> git stash push --keep-index
>>> ... check, git add fixes
>>> git commit
>>> git stash apply
>>>=20
>>> ???
>>>=20
>>> -- Sergey Organov
>>=20
>> Hello Sergey,
>>=20
>> `git stash` saves the transition from the HEAD state to the working
>> tree state. It also sets the working tree to the *HEAD* state.
>>=20
>> `git stash --keep-index` saves the transition from the HEAD state to
>> the working tree state. It also sets the working tree to the *index*
>> state.
>>=20
>> `git stash pop` applies the last saved transition. So if the working
>> tree was not in HEAD state (like after `git stash --keep-index`),
>> there will be a conflict.
>=20
> Did you actually try it and got conflict? I doubt there will be any if
> you don't modify anything after "git stash --keep-index" during =
testing,
> and if you do, than any method might bring conflicts.
>=20
> In fact I just re-tested this to make sure, and got no conflicts.
>=20
> -- Sergey Organov

git init
touch file
git add file
git commit
echo one >>file
git add file
echo two >>file
git stash push --keep-index
git stash pop

G=C3=A9ry Ogam=
