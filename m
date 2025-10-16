Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D73BB5A
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650183; cv=none; b=YfNkfg7vlwoulK4e6lNyDK1J+F8o85c6kkG32XGEZpVb18LoOG49NapUFuqEGRKGLg52Ep6RfUqhfGJx7ALb09fEahbLLS/yU3BDU46XBghxS4vSY5mhwNlNzkAwUzhWzHvfmq6uJ5XcVVcOeZSYtUDkGOwISKYrQvr36cpv0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650183; c=relaxed/simple;
	bh=eLavCjtDLZIFCpKdoxEjhKdiOsJIQIm68QFzWydC8bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZqT3KfuPrQuPxJ7QhR0imap1WBA7YUqOgyK0b/6aPpr6dK4Q+qeaUgLg2DkOhKiKCflELUkpaTpatmxVDuT4CwwDg5exOdePj2qg74IQGU9hWt7xmTsvxuk1L+BIhXQ6zNWxi7hSK5vzewVNEtVqOiu84AFb55Xc8z93Cwx43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJSp4TkU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJSp4TkU"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b550eff972eso825528a12.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760650181; x=1761254981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQSu8lEdnTTkX7nki+ZpQXw18bdSsEj5Ff1F0iWgJJ8=;
        b=UJSp4TkUXS8oi30aPMURpGyrFOSC7XkZgmUZRZaR8aBfq/v0+mkFSqmVISOmYBB+bp
         x+owJnfmfsMNAb9NDInGD8tUw/U1sna81wWRgtQDRZRXlGsQEfN9eZxZ+ToDhePyX9nm
         iqISTIqUPW3u74OjXxC0IGM6+G5SZD5HxxjSN+L/E2iKb7KlXER/H5ZFeXblWMy1YWpw
         xult7PdKSIg9Sw61hDKAhQafEs61n7es5CwORF8gNCKueaxaDaJZXTeafc2DedbshxdY
         aFWjlcLQrUbMYgsXYeaCDpmy/ckKVje4fJmZblfJtqNfSCGB5mmxUvc5IyVIKRxHleEN
         oYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760650181; x=1761254981;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQSu8lEdnTTkX7nki+ZpQXw18bdSsEj5Ff1F0iWgJJ8=;
        b=m1tW3p0a0haHmFIMcGe108yAR45oXtwcplM+oefjuK3P6gkjpJmX0x4bbrGFgvLGP/
         7adelaGt1Wkiso2aL9lpBjOcF5pSH+1vXSkUC6z/PGXIc08fJc4kqXemvp14bN9eoNvt
         4oaSy3KWuuxjyrLNeEHoicJ5nNiw6uhpErNg40q5FJwiVdqIGwjQSNmGXxKYTkmrjbCl
         TCSSvwziI0DuuP8GXkrDcmz7cl7CrLq1V83vomnH+jEkBfzTlxLZAGUB/A+a+Gk3q6xT
         2yEhRVFptzfXdkVysbaYPFS37B6Dqp4K0Vv+pnBxSI7wwVOZl1DTPE/7RI3luzpzY95Y
         RjTw==
X-Gm-Message-State: AOJu0YyF8y7Wqi0gKtPDhrHoJ4Jrsn4Tfo4Y4hKmyb4O65GU1s3jYfuk
	J638oxFnFdhuTVZDAp/8ueiFIzDLyJt31rMF1HMA8dfSNZLCaEuW4kv8QHsEJlSn
X-Gm-Gg: ASbGnct0q/tOVmoiYtR7Gon9K16AnjTL9/1jRkCwEQ1AM0Q4UleHCgy0qzgcS4NHtai
	ibX+xZyy53r9ir+re0qhbHY6ooCpdF74hVVnWWWbJEof7uh6SEEYWEv3IitY78+B0wdk6pp0yhm
	8fy/W25Kc+q803P+BERKTvJjKpgtNeDbcwDiPiycIu6Pf6RRRqe3uUvxqu8VcEZ9TDD2/PUZOme
	uMxDLkFaRBxEo6T0VHRDLHT5o/h1snHXJGO5SWQipKIcsuDiddT/Ny5iEWUA8m7euWE36ul3TXN
	lLRBBuIdxwQ27XepNbW7jVFZd6ttoXTuoJrrIvmUiEuPi6mgwC4OAVDcJ9EXokQ7ux1hPVMxjIp
	GqYH8HcZ5FHOo+0ldaQIQJFtbvC4glcjpyBt+C5mq50tg67563NzSDJwgpA==
X-Google-Smtp-Source: AGHT+IF+hJ050X+8T54M4E5YPWGvN9aak4YKVAHK63IxVgj5nNjgRCY2HdzfgulOls5yE7QsN8uNwA==
X-Received: by 2002:a17:902:e552:b0:290:ac36:2ed8 with SMTP id d9443c01a7336-290c9ce63d6mr14820025ad.24.1760650181044;
        Thu, 16 Oct 2025 14:29:41 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::43bc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22b7b2e2sm3802040a12.25.2025.10.16.14.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:29:40 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: Signed-off-by & the law
In-Reply-To: <CALnO6CC4hBBMyqEfLEn7EO28LVo7i4eDqAMLcFzSJZudVnB0oQ@mail.gmail.com>
References: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
	<871pn2ftx6.fsf@gmail.com>
	<CALnO6CC4hBBMyqEfLEn7EO28LVo7i4eDqAMLcFzSJZudVnB0oQ@mail.gmail.com>
Date: Thu, 16 Oct 2025 14:29:39 -0700
Message-ID: <87tszylem4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Thu, Oct 16, 2025 at 4:55=E2=80=AFPM Collin Funk <collin.funk1@gmail.c=
om> wrote:
>>
>> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>>
>> > Any contributors/users with an interest in law feel like taking a stab
>> > at answering "Is Git's signed-off-by legally useful" ?
>> > https://law.stackexchange.com/q/111158/26698
>> >
>> > Having a solid reference answer is usually a good thing, if one exists.
>>
>> Not sure if it has ever been a topic in court, but it would allow you to
>> argue that committers signed off to the DCO acknowledging that they have
>> the ability to contribute the work under an open source license [1]. In
>> other words, the they have confirmed the work is not owned by their
>> employers, as is often the case with Software Developers in the US [2].
>
> As Junio points out, this is dependent on the project attaching a DCO
> meaning to the sign-off.

Yes, I should have mentioned that, thanks. The DCO meaning is what I see
99% of the time, so my writing assumed it.

>> That is why I prefer copyright assignments. I have done many various GNU
>> projects that I commit to. I feel, at least in GNU's case, that they
>> force you to consider whether an employer may own your work [3]. If so,
>> the FSF will request your employer sign your copyright assignment.
>>
>> Obviously, the assignment process is time consuming and a barrier to
>> entry for new contributors. For that reason some GNU projects, such as
>> glibc and binutils, allow you to send patches with "Signed-off-by" to
>> the DCO if you do not have a copyright assignment nowadays [4].
>
> Less germane to the original question: I'm less familiar with
> copyright assignment, but it seems relatively heavyweight here. It
> seems ironic to me that GNU would want me to give up my own rights
> when contributing to their project ;)

I think this section from an article written by the FSF addresses your
concern [1]:

    Some developers worry that assigning copyright will strip them of
    all their rights to the code they've created. To address this, the
    FSF includes a "license grantback" to the developer in the agreement
    contract. For the developer, a license grantback means they can
    continue to modify and share their code, and technically, they could
    even distribute their software under a different license. In other
    words, by assigning copyright to the FSF, the developer does not
    give up any of these sorts of rights.

All of my assignments have a grantback clause. So you could use
changes/improvements you make to a program elsewhere under a different
license.

Collin

[1] https://www.fsf.org/bulletin/2022/fall/copyright-assignment-with-the-fsf
