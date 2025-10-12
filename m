Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CA5C96
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760312512; cv=none; b=sbqVapp+4RBPIG6HompwKtwwqFFYAlGMnH4u3uE48NbryoPHgIF1K+BIBCUPK3Yu3tkrPRwvBtIblBYr2CedmfMrTL+/HNxV046i7Jc+SspScazR22ma1FBXPg8vAZbBlwCbMEfpwTemH2exqCHx4cOYitUTxGX+TkTgyLgQcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760312512; c=relaxed/simple;
	bh=sxQvz0DPg0efi80r2Tzr3o+Wygi8Pe25iKF85KArjuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAJBfxYXv/hyvAXeQXGhSJ+J6L14IgJMQOUaVzVorkGkZ2cVEV6/C/XwBFuzTVMTMxjNykPkTjokqoA5BLgX/UICwotfliBZFcwnX3wY8eet9pSEFIk5c5gVwtUMfpzSnL8b/B4Bq7u7GtnzQ4+oDbAFyCztHSSgRaxAOXlPNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq7hLByF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq7hLByF"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7800ff158d5so3435830b3a.1
        for <git@vger.kernel.org>; Sun, 12 Oct 2025 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760312510; x=1760917310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePHsrYbXQB6EjXClzwxkFR8hD+syKzwlnT3q4jeNHkI=;
        b=Dq7hLByFmHT0FDGJw0mjkxPJiTwGBSyEheWmeQcU45fRwZILfLuOa74x3fnNVcMr7C
         27Ro0Q65bSWAQl2xcVhVuiqvNVgOuV+mTFSbHyT4DbyMU3dxL1S9hbCa1rvCsHW8G6je
         z8xmFrZa5L+s21uMIUJovjVyTC84HGrGXVbx+ashdSbqd6nTnYt7hEZt94LYD2ersmpi
         VuxrAUYBUM7a4KSxXp6JFiqAz+k6eA9jPG+MTA3YyZBdyZWpTO0PG3jBupAeG5RYioXf
         pREBgSiH9PUfBX1R0XgZlwpBSa3nbSrRMiqB1gRFaK7fOsdmfY+9iJSlPn7CjU4mltbo
         aDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760312510; x=1760917310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePHsrYbXQB6EjXClzwxkFR8hD+syKzwlnT3q4jeNHkI=;
        b=r7RqYnZVKyfUycQkjGOrOB63RfqQPd2jxpW2XWhsHwXOhVN0NGj6FJMJ6xZ26zLOj1
         QhYswo54+uoIj0hIG13LJxtF2jdPdyH5rSUlST9YGNJoEoeSlMrSrFQaUpiwp93zYKo8
         3sTGvwQrv3/uxQxWzSS3lX1lkFGsL6yx6npOn0CKWpK41cGiQhUlNgK3c0fWjleDkrzq
         S0XO8CpRDqdMaKxELjs/ikixaSTYBSKcvQ250yhLAgE3ENOBlWhylw0yX4eac1yeHqTT
         Bqa5jPA3bVV2ScZ1dEUIAiL4mFb3ocFmmLjXlC+wx3lnp5GgYJj+dkL97bi7nLZdn176
         RchQ==
X-Gm-Message-State: AOJu0YyGFt6aFe+JoocgSVqcgT/8/vaPGXGCjDecRTlD+333UBl+6NxN
	yIlhsITWm9PKz6DO1vpsll2dMGsHCq0H0srlaIUTSGpjTEGlDqd6JL7SOKs8GhlxeYRBMHSrVv2
	HqgeT8Jv6naIWWAFMt/OSqx9MbpXCBcU=
X-Gm-Gg: ASbGnctFsRuTYny7SugEcvQ10+bE/MTJRHabiUpzCyBNPkI9nMC3RPbnlDflM1B93ur
	I3joifYI3LplJF5JXCe1+JcXGuQKRw6nWhqnQuWdAeX3iuA855yN+62hqcNZtaZqfUi/1bggPQc
	BIRXJPv1bxdtFDY+dsvKFYB6l7ZmzGjN2vhmApdke47xVWLWQAMypotkY8hF/ZXemJ14VzM1WKt
	GqLKLHmB2xun3TqW4RHjnHO+hozPeMsfIJxNtmI
X-Google-Smtp-Source: AGHT+IEHqI/OTN9UEcHOoWDNZ/lh12rnT7TAnvYMFQ5VbnoSWjGVdcbo0mIZ+nj3AlxSXR3KJH54Whfm0ac523QcF6o=
X-Received: by 2002:a17:903:19c5:b0:27e:f07c:8413 with SMTP id
 d9443c01a7336-29027356911mr205225945ad.9.1760312510483; Sun, 12 Oct 2025
 16:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOporVVSRRL/v4Lq@ubuntu> <xmqqecr95ib0.fsf@gitster.g>
In-Reply-To: <xmqqecr95ib0.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 13 Oct 2025 00:41:51 +0100
X-Gm-Features: AS18NWDFIa_O4INOlK3NWC3J-TkbGaCoo4PpNKxIE3s68N9VoQM6bay7PyeSKzg
Message-ID: <CAD=f0L-QAfMhBw1_RyLkpdntjPfu4M+temmawWGEZjAJn_iQdQ@mail.gmail.com>
Subject: Re: [RFC Outreachy] Teach ci/check-whitespace to flag incomplete
 lines as an error
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 20:50, Junio C Hamano <gitster@pobox.com> wrote:
>
> Bello Caleb Olamide <belkid98@gmail.com> writes:
>
> > Hello,
> >
> > While going through the mailing list for some #leftoverbits, I stumbled on this converation.
> > https://public-inbox.org/git/xmqqikla86id.fsf@gitster.g/.
>
> Welcome, and first please learn to keep your lines under readable
> width limit.  As an applicant to a mentoring program with this
> project, you will be exchanging e-mails about patches, whose
> contents are limited to 80 columns (but subtracting 1 columns for
> "+/ /-" prefix when a line is shown in a patch, plus several more
> for "> " prefix when the message is quoted multiple times during a
> discussion thread, a practical line-length limit is more like 68-72
> columns), and you will be adding in-line comments in the middle of
> quoted patches.
>
> Hence, your comments in e-mails thrown at this list are also limited
> to similar line length limit.  Otherwise they would become very hard
> to read.
>
Hello Junio,
Thank you for your response. I will take these into account.

> I'll line-wrap the quoted text below.
>
> > After studying the check-whitespace script, I observed that the
> > script parses each line of the output of the command `git log
> > --check --pretty=format:"---% h% s" "${baseCommit}"..` and formats
> > the result.
> >
> > But the output of the git command itself does not flag '\no
> > newline at end of file' as it is shown in git diff, in a case
> > where the files does not contain a newline at the end of the file.
>
> Correct observations.
>
> > One approach I propose to take is to check the each file changed
> > in each commit and check if it has the \n as the last character.
>
> If a commit changes line 4 of a 100-line file that lacked the final
> newline, "git log" would show the commit, "git log -p" would show a
> patch to the file, but "\No newline" would not be shown, because the
> commit is not responsible for introducing an incomplete line to the
> file.  Looking at the last byte of "git cat-file blob $commit:$path"
> for commits that appear in "git log" output would not give us what
> we want.  We need a mechanism that notices and warns when a commit
> makes a file, which used to end with a newline, end in an incomplete
> line.

Thank you for the clarity. This would mean to compare the relevant files in the
current commit with its parent commit and report when the current commit removes
the new line at the end of file which was present in the parent commit.

But how about when a file is newly added and lacks the new line?

>
> If you can come up with a robust way to do so in check-whitespace
> script, with the understanding that the right solution in the longer
> term is to teach "git log --check" to notice incomplete lines and
> flag it (with core.whitespace configuration and the whitespace
> attributes to enable/disable the check), it might work as a stop-gap
> measure.  As I said elsewhere a few days ago, doing it right would
> be a bit too big for a microproject.

Thank you very much. I perfectly understand this now.
The right way would be the better way as we can just parse the output
in check-whitespace and it will be more interesting to work on,
as it would greatly increase my knowledge on Git internals.
If this would be too big for a microproject, I will look up
a task fitting for a microproject and then push forward with this.

Thank you for your time,
Bello
