Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014A387343
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775601676; cv=none; b=f+EtHCCOy+ABzTRJklt/dCUK5lTAAOhwE8ZffM9bAhYsqAbJNsUT3M/bBLex4IMPVCc90v1QQox+Kj5ZJF1amHhZgN/Htdy2M7toJCnhvytFyDGWqaBmh2wsPD/iWnPWXBMJi4UkvmUbTNfqoWbsqvi4Aj9owCtHMMJoywflk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775601676; c=relaxed/simple;
	bh=OL487U6PFkKLHHtkU4j+UZsmnVW1c3/94gzVPA9T6lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTeapIFZ3LmXyX0B6ImEz9G52/imsScH6TF6qv1sHInadxzthqmxG5w2tyxpA8ZABe0eTkpt367IgTUnc8dUkhayP41Dgk5RUSn/qMa+aFKdVyMBCQQood2SxspTjz9D+iRrq3KsWBi8wBFuM+JMCNvOGJDcfxFiD2hhYngj+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQjo0Iaq; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQjo0Iaq"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4710c186d8aso912336b6e.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775601674; x=1776206474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcZNgFc86iczCK1Oi6GFPYL4w1PJxtJh28IvQ9x3cAA=;
        b=eQjo0IaqQjUr7DeocK96qDfMB8oHdB7CQux28b0GokiHSH45DioCkBc9y1Ux38NyTm
         KnYYaeBuPHPq41Im2NdFRgmtoPJ+0ugUWpRiJ8GOSGq3E3hogGC8regH3tsTEFOyVkRm
         bW8TUImZLgrpvPGIVd9llflkYGZH5Aw882D2MbkClpYss0XzsFGKjSfJXBSM2AYqZjhJ
         q1jPlgjkq5IWvfwq47Hobh8d5tti7nJr0jvfcWONjFpkloKCQz2wiPBxBUsknV8bdlTM
         LnfEsOESzc09flBPC4YuV/wgFM/+ty5oczhqUJVxOEEayruUU0Wlk5Vlma5nRkFlXcoZ
         8uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775601674; x=1776206474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcZNgFc86iczCK1Oi6GFPYL4w1PJxtJh28IvQ9x3cAA=;
        b=JRnuyk0XJgSuFSllt+7a+SbZTDD/VTRJNzapuUHswqFW2fMg336h9SA30KrdxBRsqC
         jxmEXsY3zUrmL6BXD5NyriqOh4LZpp73ItlG4gMHgu056B08Auv52Sk0/+sC3kK7J2Rw
         z2DYgMl8uBcfEarfiXV4LqcqjcsvO4aat/FlY8lJK8kPHceRYHT62L0lWUzovkbUCRhN
         i+4b2Xh1Jrrd/woFXQNbhjevIwg2cZUni5DxmNSp3BS6hW7GxJBOI84INzoor5Y7sC6M
         ajBTXBahPcAvgvCGLwbdi9El/BvUt3G6vJg4dnLmzQWpWWGMCqxaO5f0jECT2dVyFzHX
         v+FA==
X-Gm-Message-State: AOJu0YwTrxUjo01DS0zV36nP5qG5Ga+yPi+1xyBAcuQ+TOabyK0xXGgy
	FsfELlqN+b2mCuTVx6hG1hRQK4s7c+GKJbRm99Lb2WylNyogBq4EDTSe
X-Gm-Gg: AeBDievI+0VyE9oud1ZJZGKS2jZxJS45tEyJXPkF5ccL2CoPZdwWS1HR/qLZZIMDA/6
	KY6bErhQ4QHQPMAWmeBEBQAkkx+sft+Irvbgd1Bk5+ckEiGE+IP8DsHfIn4JWnBCsQh8kiKoL54
	gJj8pplmdlcMdXkbS2L93RiUiRm5OgB9EA+WZCAvb6IoNo2cjyP5J0M3yUo8g7RkhIApmeWzSZZ
	TFMiMzmz4gkNC+RJ6S6afH+gZmi9qVIEuOZbhGtu8XqMITh4NvwKxZPSEhQMEDCXAC0tI9VPvFw
	YS4QX9581IpeQe/dlqxXe3SOvO+/ES8b2FG3sBhBH9LFIqPtiN2sNqFhc2pf2dOf/9SM+azdYmP
	zMTttCd6LxO8yLtZdSzff+FYXPEYpdV/5GayZXd2GP0nQkK7DLcR3ZlnhuFwZYisHBX8CQIFTqK
	XfkurZs415g2qSYG25
X-Received: by 2002:a05:6808:2519:b0:468:48d:806a with SMTP id 5614622812f47-46ef4ffecdamr9372859b6e.2.1775601673987;
        Tue, 07 Apr 2026 15:41:13 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46fde16d9f0sm7027771b6e.16.2026.04.07.15.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:41:13 -0700 (PDT)
Date: Tue, 7 Apr 2026 17:41:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, peff@peff.net, 
	luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
Message-ID: <adWGjWNTXlR-glgt@denethor>
References: <20260407201730.2526914-1-jltobler@gmail.com>
 <xmqqo6ju31wx.fsf@gitster.g>
 <xmqqfr563099.fsf@gitster.g>
 <adV-NI-t6-jgJK7D@denethor>
 <xmqq7bqi2yux.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bqi2yux.fsf@gitster.g>

On 26/04/07 03:24PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 26/04/07 02:53PM, Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >> 
> >> > I'd appreciate it if you can give your eyeballs to the attached to
> >> > see if that is how you would fixed the bug in the original context
> >> > of v2.52 track.  If everything looks OK, then there is no need to
> >> > spend time backporting on your side.  We have everything necessary.
> >> 
> >> Another thing.  Your jt/odb-transaction-write topic (in 'seen')
> >> already addresses this issue, so we may merge this single patch down
> >> to 'next' and 'master' first, but the merge that brings in the topic
> >> can just supersede this patch, perhaps keeping the test added to
> >> t1517.
> >
> > That would work :)
> >
> >> Do I understand correctly?  The t1517 part of the patch, when
> >> applied to 'seen', does indicate that the problem is not there.
> >
> > Yes, that is correct. The jt/odb-transaction-write topic indeed already
> > fixes this issue. The patch here is just a slimmed down version of a
> > patch from that series.
> >
> > I can also send a follow up version for the topic built on top of this
> > patch if that would be preferred. Otherwise, replacing the patch with
> > the original topic and keeping the test as you suggested would work just
> > fine.
> 
> OK.  I think I am almost done preparing for tonight's pushout, so
> please double check, and complain if you see something that is
> questionable, when it happens.  It probably will happen in 2 hours
> or so.

Thanks, I'll make sure to double check.

I'm not sure if you already included an update for the test per Peff's
comments, but if not we can do something like below. If you would like I
can send another version with it included too.

Thanks,
-Justin

--- >8 ---
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c1dbc6359a..e1d35170de 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -93,12 +93,12 @@ test_expect_success 'diff outside repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'diff files exceeding bigFileThreshold outside repository' '
-	cd non-repo &&
-	echo foo >foo &&
-	echo bar >bar &&
-	test_must_fail git -c core.bigFileThreshold=1 diff -- foo bar >actual &&
-	test_grep "diff --git a/foo b/bar" actual
+test_expect_success 'hash object exceeding bigFileThreshold outside repository' '
+	(
+		cd non-repo &&
+		echo foo >foo &&
+		git -c core.bigFileThreshold=1 hash-object --stdin <foo
+	)
 '
 
 test_expect_success 'stripspace outside repository' '

