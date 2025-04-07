Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B91EF0A1
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744061323; cv=none; b=gT/AmpTZ1iV/ios/JyRMpIalZ97TwtrK2L8R9LIAZDLFm79yIkkaTpJvhIQjOkOtpsOeDOj7aMHXLyKgRds2xcpqA8mI9ItctSpIyTweeMX33nJOVsYA8m9EocEubv6KITCr9hpPpLO2NWbYEr8uy2jkHoHy4rFFEBeR/DFKIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744061323; c=relaxed/simple;
	bh=6MujbZVmJ79bLnQuqcaa1WALT5tTwlG7FCHZnxDdjTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxkQ6e7INF7VLBsVr79NPW8qPE8W760mVkqVbbyKK1B1icVCHclAGrzD3CW3aPcweExZ6SR4EE8dDKXd847Mwclc3koEzDMXAM//3A1321KJoibd6Z2ra6Ce3g1OmChyag0LRfrIXIPQD5tKw7gFVTLswFsbha0MVq4036layVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcr7a/KL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcr7a/KL"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so7119927a12.3
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744061318; x=1744666118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzgE+CBD39mNLQAGltCcYjNAfsvcAK6ayzG7aZrAVMM=;
        b=Lcr7a/KLy82vr4RoAE2CX1TgQ7toIsZphOjhOh3I76q+29Trlgsluwpbdab5/R44Ri
         wmwQ7xWV+FLOi/0y22vxGxNFAHTPYzqjpQ0N5skS5A6UffYbaFE02AQtp8YZ4wATa+ov
         lwDxGB5lnimek0jOiylOHa3mbAhzzDzQnPaLpeO2Hu/NgvXool3k0bH4PMUHZQ08R9cZ
         93n8zUEBSNmODVbTJxOTxg/OfKCtLjhQ7tHBSOd35WR7/zmLBYRiWprN8YqXpVHOyMFY
         U3RvEUrWGjfEMTyiHvEIN1y/AGn9sQLvSUMxAnB31ramC/B0lrQSqG48dbHqVplFZ5FA
         tJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061318; x=1744666118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzgE+CBD39mNLQAGltCcYjNAfsvcAK6ayzG7aZrAVMM=;
        b=lRA2LRxprI7XiESNVQL/Z/KaLeYjPzZU3NBdWwZQAmULqXunA8n2rgQE0J84HCP4n+
         0IpTv18J+gI6JpKrx+ab08661WptPzuO8wu72zv6qVnHIcFyj3MUNuMJ57ojOMP/bPzr
         0sKyD/DkkUl18E5hbQG793LDSYBV0kcFEtsjGdDkrALbxnbbtHAN+7jFxw5IpXZbzCZ5
         MlyV3P9c+zO2lnBaF516hPPPivQBjFnn9eE4D0kEWqNNBrNCucveZca4it+6FWtoq+3B
         wncphcm4lew3jCYyQhL3ROOvNsNenLIJbLgTWBZSJvDHUHZliL0c2HIdGNpYn3deth26
         8ZEg==
X-Forwarded-Encrypted: i=1; AJvYcCViyueBi5wAWQS80Blco2PTCcx4hzdbX34Iybji8MgzBRt0ZmO+Zaf5bSBkmrlBvM/PZ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUX5FZnXUoNwOPcOaCpP0sBxercLzNWHlqbYhxgDYOaossi4GE
	HKZFELaPv/GyI+iqbPlfaMGyymSRSa6QM3GzcQHe+FrM5AtfK4I=
X-Gm-Gg: ASbGncvBdhwjonAF7UAuXfkKFu5fWzxxAxTX+T09mHZSEzJ3RgeKB4lON/za0GpW5ut
	4qU9e2m6cJMYlriwlAzQu3qrvj/QRyrPKnajjDpHr24OR3XrAeIjlTyy0I6faTachnuPwQ0DhJU
	aTBe1eqdWwWWq1ojYCoBanFN5ZkBHhTQ70AU30VUOCev039ANfFHVaFGm9rFR9i0DFGOxo/7JpQ
	mx/jmTOBlKmouBLmWGSP1NBV1eghNpmzbcarTQSUe5ZHlWL0R/gkJRMAQK0+1KtjtUy66YRdRgR
	u4UQkbF9ljw0GYQ6lNbd9tZPV9HyDOwip4yysU0DZsMG8FUvSFT+QhrPbaqUCc8PAB0FGrYjabo
	lUHPGPXp+zOdUIKZpuE2+ynprS059a19BBA+SbY9LI6/7sqFAWy4PDwFbF6X9VetDlCOT8AK7Tl
	O1KP9lkYCTJJ1WDeDaMzm3T7I=
X-Google-Smtp-Source: AGHT+IHjnqLFvt7aviad/+App6ckXzQWHnqNYusAe5L9zcrN+wsEZVRStyH/ia7elNvmyBHqRGSj8Q==
X-Received: by 2002:a05:6402:2713:b0:5ed:d988:ae0c with SMTP id 4fb4d7f45d1cf-5f0b661a489mr11384756a12.24.1744061318140;
        Mon, 07 Apr 2025 14:28:38 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f0880a45bdsm6978080a12.71.2025.04.07.14.28.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 14:28:37 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: gitster@pobox.com
Cc: anthonywang03@icloud.com,
	anthonywang513@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	karthik.188@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	shyamthakkar001@gmail.com
Subject: Re: [GSoC] [PATCH v2 1/3] t9811: avoid using pipes to expose exit codes
Date: Mon,  7 Apr 2025 23:28:34 +0200
Message-Id: <20250407212834.53183-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqo6x7nb2a.fsf@gitster.g>
References: <xmqqo6x7nb2a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anthony Wang <anthonywang513@gmail.com>


On Mon, Apr 7, 2025 at 7:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> Anthony Wang <anthonywang513@gmail.com> writes:
> 
> > The exit code of the upstream in a pipe is suppressed
> > thus we lose any exit codes of git commands that are piped. In order to
> > ensure we pick up the exit code, we can write the output of the git command
> > to a file, testing the exit codes of both the commands.
> 
> Sort of correct, but ...

Would it be more correct to say that the shell only returns the exit code of the 
last command in the pipeline? Then, by writing out the output of the git command 
to a file, we can test the exit codes of both the commands? If not, I am not 
quite sure what the additional nuance is in this case.

> 
> > ---
> >  t/t9811-git-p4-label-import.sh | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Missing sign-off.
> 
> > diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> > index 5ac5383fb7..5abac938d0 100755
> > --- a/t/t9811-git-p4-label-import.sh
> > +++ b/t/t9811-git-p4-label-import.sh
> > @@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
> >               cd "$git" &&
> >               git p4 sync --import-labels &&
> > 
> > -             git tag | grep TAG_F1 &&
> > -             git tag | grep -q TAG_F1_1 &&
> > -             git tag | grep -q TAG_F1_2 &&
> > +             git tag >output &&
> > +             grep TAG_F1 output &&
> > +             grep -q TAG_F1_1 output &&
> > +             grep -q TAG_F1_2 output &&
> 
> Think what these tests are trying to do.  After a "git p4 sync"
> operation, they want to ensure that tags TAG_F1_1 and TAG_F1_2
> exist?  Does the test want to see a tag "TAG_F1", or is it only that
> the test is written in a so sloppy way that grepping for TAG_F1 will
> be happy when any one of TAG_F1_1, TAG_F1_2 and TAG_F1_ONLY exists,
> making its purpose of verifying that the tags are in the expected
> state pretty much useless, and that is the reason why it needs to be
> followed up with the two extra tests?

I see, it seems I didn't fully consider the goals of the test. It does
indeed seem like the test has some redundancies. If I am understanding
correctly, the test grepping for TAG_F1 is not even necessary, and it
seems like the tests for TAG_F1_1, TAG_F1_2 were added afterwards to
ensure that grep TAG_F1 was not passing when TAG_F1_ONLY existed. If
this is the case, would it be better to just remove the grep TAG_F1 test
and just keep the two tests for TAG_F1_1 and TAG_F1_2? This would
simplify the test and make it clearer that we are only interested in
the existence of those two tags.

> 
> What is the desired state you want to ensure after "git p4 sync"
> operation above?  I do not do "git p4", but you may know better than
> I do, as you are the one who is patching this test file ;-)  I am
> guessing that you want TAG_F1_1 and TAG_F1_2 to exist and you do not
> want TAG_F1_ONLY to exist?
> 
> If so, instead of grepping around, we should be testing that in a
> more direct way, perhaps with something like
> 
>         git show-ref --verify refs/tags/TAG_F1_1 &&
>         git show-ref --verify refs/tags/TAG_F1_2 &&
>         test_must_fail  git show-ref --verify refs/tags/TAG_F1_ONLY &&
> 
> no?
> 

Possibly, but I believe adding the test_must_fail check would be modifying
the original intent of the test, as it would pass even with the existence of
TAG_F1_ONLY. However, if we are only performing actions to cause TAG_F1_1 
and TAG_F1_2 to exist, then it would be an issue if TAG_F1_ONLY existed.

My original plan was not to change any test coverage, and to only make small
changes following the goals of the microproject, but if you think it would
be beneficial to change the test to check for the absence of TAG_F1_ONLY,
then I will proceed.

> >               cd main &&
> > 
> > @@ -208,7 +209,8 @@ test_expect_success 'use git config to enable import/export of tags' '
> >               git p4 rebase --verbose &&
> >               git p4 submit --verbose &&
> >               git tag &&
> > -             git tag | grep TAG_F1_1
> > +             git tag >output &&
> > +             grep TAG_F1_1 output
> >       ) &&
> >       (
> >               cd "$cli" &&
