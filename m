Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF94C6C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342234; cv=none; b=DlB/biLYVYbXKGhzhOy0pZkHTuZASzWJZZdeKqlIeo67sSHTZUkPLuriMnKc1wZkZ5rfI7eABC5/pj2ihhY+7U02gv18LWGYHy5Y2YXdSGc/BPnBkx8nTBBGHRmk7f684hzeB9nCVb5Vg5pzlD6D+YeePzbY19oVBeoGe+553f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342234; c=relaxed/simple;
	bh=CDvBHmcojPCY3YqQO3B0uSLY/VwSahNjYXX5seGqdrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDtDJTz6eA72q89G87LkJrLOPWYRnDrw1llxChlKSbiUcPIX/HjxgzzrZ3ignmgOJa6lJ1WGlSSWOwsWSoyVTpu62p5JeW51fba+QX2guyaoQ+COkT2RA74LYbGyzwQUfehi58GxtbJXy9PCBJCmwVoNwQK7E22Q14gzawoOahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQNl4LR0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQNl4LR0"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6139292ed7so276353a12.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771342232; x=1771947032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLeiwVP2f+ZMsC+ADAQKeXmJCPKiau6OoGoWoeXAcKs=;
        b=LQNl4LR014FXNSVAfGWZCFWAuqachbXIv4lo8+pzEnDqZuL5zcnaNcFxvimhFs6BRP
         W0SHTeW58d+48jcIPYQ2kyn+RKkoioEHZl2u3MpaACWD5PGKcrn/oStzNT/EKr2aBWuG
         5sU71FLdhjJK04v+2Cimt/MNeSNp+vRf4y98HFoW0b1fHJVu9fY3zx6JNmFvPewKIyxC
         fGKfxo2eQmmBh+/QMEWFH2ajBzAFP2hFcpLbg1FwDN1QbcDWjRmOaOEoiXEMgKzrga1Y
         tEu8Le6lrFq4czoru0cTzR6jzxyUkPrxwVh9gHmEsh6E+Lc+WNA2HFpHDufJ4b9jvTsS
         7zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342233; x=1771947033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLeiwVP2f+ZMsC+ADAQKeXmJCPKiau6OoGoWoeXAcKs=;
        b=YEWlKUGzvSuRT8uWz+7qpIoAoA5tslLe/6TB0xSoGB0xkKX//Ft/bKweO1+wPK9JHh
         l2IoGesE6gG/Fsr6TGNomqihDK65z+KaS7bZf2b448oTvDnwpiXEF7CQYlgzb3PWgSwB
         bSs9t6JeI+4iORF6JtiT6Int8yCiR+9OHtg1UZXLmA/a16Lx89gU0S8Bq7s9StCKik/E
         RPmFKnfDz3HOlFQG7uOXFOV+TNnlo9uFGim/EqgK+3IivgRB/qE29H6V+cc4mpHO96Xd
         g6BurwK16KJusTvp4X3MbA8p8BQvz8zK1kxd/JCVSK4rulBGBPnLuk2uyDOVeVlTN8rt
         jY/g==
X-Forwarded-Encrypted: i=1; AJvYcCWFoLnxOi+tV8RlT/Dm6/fzDRG8+J0kmsnt3JAJOxlgBrsSY+yb0vu79KRlLVJLX2e9wrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVw/thkMqL4wdH8XNUd0CU3vuS/cx/IiYOErFIlyAN3AQqNvCL
	m6uM7FqaCiv1nQ2ylf6efvFfljr2Q+62k2M+kw9vCZhDmdrSr7kp9M8B
X-Gm-Gg: AZuq6aIznU4iItjCfG4zpIVxjnI5H9thwe58tAijqu8eHME+yY0XKX7vS/5DE/rjno+
	YkqTV79eHCx0Do4Ux1noPzetsSukfWpCsBSH7ILS4eGebNzc8aBnCIfw9OkSl0Vr4t09gg91pUV
	NTqmzqLWqT+unpokkTvJFFQ2TowGIM38zJ5CHjJqoESIHNi1Bq2rfdh/3YkUdyuiNoXJcL94taj
	ZeiXcZfu7rcba8vbHUcvhmwF49gx71/iHLNaJk4sXKx6U9B0KS2jgBlqggRpviiZENM2T1gRIXs
	7GGvkyLdxb1XmV7CafP+uLnMPGMTOp3fvbdkJBekGHzr3AEGjLMvwIg0ztRAgYOVfnEhDs26GKH
	IkFAfM4jXi0h92EpoGjIXRrTRGXcAU/HnpObf9+PoGCZdtoMIPDmNLPC9OHQJPHfwUN+xiaHSXD
	xJxg1tAh5mXJZ0CwCxyX2t+4GE0wk=
X-Received: by 2002:a17:903:2c5:b0:2aa:df82:ed85 with SMTP id d9443c01a7336-2ab4cef7591mr115211535ad.1.1771342232437;
        Tue, 17 Feb 2026 07:30:32 -0800 (PST)
Received: from [192.168.0.105] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a713675sm147256525ad.27.2026.02.17.07.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:30:30 -0800 (PST)
Message-ID: <e5cee6ca-b908-466a-b496-0b170c6a2838@gmail.com>
Date: Tue, 17 Feb 2026 23:30:25 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
 <20260217084124.150366-1-a3205153416@gmail.com>
 <CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik,

Thanks for the review!

> Small nit, it would have been a bit nicer to separate these out into
> individual commits with tests added per commit.

Since this is a security fix involving logic changes, I kept the tests 
and code together to ensure the commit is self-contained. I hope keeping 
them together is acceptable here!

> Wouldn't something like 't0009-git-dir-validation.sh' be a better name?

Indeed a much better name. Will rename it in the next reroll.

> I understand the exclusion here (they are non-fatal flows), but wouldn't
> it more make sense to add these two exclusions within
> `read_gitfile_error_die()` which already has two such exclusions? By
> separating this out, it gets really confusing.

I actually implemented exactly that in previous patches (handling these 
exclusions inside 'read_gitfile_error_die'), but Junio pointed out that:

 >> diff --git a/setup.c b/setup.c
 >> index 3a6a048620..8681a8a9d1 100644
 >> --- a/setup.c
 >> +++ b/setup.c
 >> @@ -911,6 +911,10 @@ void read_gitfile_error_die(int error_code, 
const char *path, const char *dir)
 >>  		die(_("no path in gitfile: %s"), path);
 >>  	case READ_GITFILE_ERR_NOT_A_REPO:
 >>  		die(_("not a git repository: %s"), dir);
 >> +	case READ_GITFILE_ERR_STAT_ENOENT:
 >> +		die(_("Not a git repository: %s"), path);
 >> +	case READ_GITFILE_ERR_IS_A_DIR:
 >> +		die(_("Not a git file (is a directory): %s"), path);
 >
 > Hmph, isn't this backwards?
 >
 > We used to treat STAT_FAILED as OK without dying in this function,
 > because we conflated "there is nothing there, so you should go one
 > level up and try again" happy case with all other stat(2) failure,
 > and that is why we introduced STAT_ENOENT here.  ENOENT is the
 > *only* case among what used to be STAT_FAILED that we do *not* want
 > to die in this function.  The same thing with NOT_A_FILE vs
 > IS_A_DIR.  We used to treat the former as OK but the only case we
 > wanted to treat as OK was IS_A_DIR and all other cases, like FIFO,
 > we wanted to complain, no?

In other word, ENOENT and IS_A_DIR cases are *VALID* states during the 
discovery process, not *ERRORS* that need to be suppressed in a "die" 
function. Therefore, we moved the decision-making logic up to the 
caller. This allows 'setup_git_directory_gently_1' to decide:

ENOENT -> Continue search
IS_A_DIR -> Check dir
NOT_A_FILE -> Die
Other -> Call 'read_gitfile_error_die()' *REAL ERROR*

> Okay so we unconditionally read the error into errorcode, quick question
> that comes to mind: Wouldn't this break the previous flow for when
> `die_on_error = 1`? Where `read_gitfile_error_die()` would've been
> called?

It does change the flow, but intentionally, by passing &error_code 
(making it non-NULL), we prevent 'read_gitfile_gently' from 
automatically dying.

We must do it because if it encounters a "garbage file", we now want to 
capture that error code and verify it in the caller. But more 
importantly, if it encounters ENOENT (which is now a distinct error 
code), we definitely do not want it to die, nor do we want to treat it 
as a fatal error.

It does look a bit verbose, but it makes the state transitions explicit 
in 'setup_git_directory_gently_1'. I believe we are on the right track!

Thanks again for the feedback.

Regards,

Yuchen



