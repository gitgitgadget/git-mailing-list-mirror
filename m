Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14CC63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1702A24656
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAPjNXW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgKQVgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQVgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:36:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4EC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a15so24077765edy.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQX/fKMTrDol6X+MB/MGmrZUareNJhPLajdsjFvskbk=;
        b=rAPjNXW/Yb85Rc3YBlFCu8q7zq2fuicjDH2bvCQ8mKQ51a9DsPVB4KXhckIquWjd2+
         ++MeQkWcxFme1zKfLQdiFAXbP1vyWimT/j/dm0t5leZ7r2gC6HP8jLa63IKajYG6Uy5b
         rpkWrw4RaZEalsl4x0waordbLruGrbsMg8AaM9AYE/x+uAy0SlHgdi5O5QefMIviZ0f0
         ao0Fjb2o+8iHaC/EB90Bk3D2U0TziA3Kj0fwjL74msAfnWDaPNEUx3x7vQI7HeXW8pu7
         cXBuq+BcwVhncCu50Suw+MrrSUTf8jEDTp/+2/dV3JMpFYSSMilkpsUiYkECgjJGoFCv
         YXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQX/fKMTrDol6X+MB/MGmrZUareNJhPLajdsjFvskbk=;
        b=ZnyAT2SZAUfNgwor/FYV7WCtKm3EWlUlrnvV5RktCMqkOvDKZBDFWWhcOSRjVb+Yzy
         sPI+0F7XSy1DTC162P47u+VGaQFQ6IOpUuEGVi+3TxI63QCX7NLi1TKcNDrDGt3RhwSE
         51UFOG2wXYCT8zuYFSGUBh44oF/joEFn6cPu8rwlGBMjChPT6Q+yHWVfhXpGP3cvV1av
         y2kb1Iz+yjDLeQLQCAw2Hc/78++NXfHer+nzGl9GOzmXkCMZfFarqmZPzadOuu+A8Syx
         ZXiP7s5MjVU0eWRhNXP+nmdNCNZjdYXpTKk6Zt4FfUMdMGi/US/d/9Sqwhuie/tp3Gxm
         B9Dg==
X-Gm-Message-State: AOAM533rytxHl79fBvOxwL26i4wGIqlu7o69tHRBw83CsSaE8PwgzdHf
        n/VvuW6yxgaoCyjBjRQsD5NxLG464rQ6nQ==
X-Google-Smtp-Source: ABdhPJwFkRLgoa8lFnVt7KLbjRYrwkw37lDKOq0e+9bURisfdktDKmAxQXdjhBWG9lsW8Ub6ewCRNQ==
X-Received: by 2002:a50:ec10:: with SMTP id g16mr23582597edr.63.1605648961578;
        Tue, 17 Nov 2020 13:36:01 -0800 (PST)
Received: from localhost.localdomain (178.115.129.143.wireless.dyn.drei.com. [178.115.129.143])
        by smtp.gmail.com with ESMTPSA id by8sm12623417edb.49.2020.11.17.13.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:36:01 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Subject: Re: range-diff should suppress context-only changes?
Date:   Tue, 17 Nov 2020 22:35:48 +0100
Message-Id: <20201117213551.2539438-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <xmqqmtzvikwi.fsf@gitster.c.googlers.com>
References: <xmqqmtzvikwi.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I wonder if it would be reasonable to suppress range-diff hunks in which
> > all of the changed lines are context lines.
> 
> Sounds like a reasonable thing to do.  As we know the shape of what
> is compared in the outer diff we should be able to accurately notice
> where hunk boundaries are and a hunk whose change is only on context
> lines.

Here are patches to ignore context-only changes in range-diff's output.
I'm not completely happy with the changes, they feel a bit too hacky.
Maybe someone has better ideas.

This still gives output like this one, that could be improved in future

	1:  7a3dac8 ! 1:  119bc78 Change
	    @@ some-other-file
	      7
	      8
	      9
	    - Old context line
	    + New context line

	    -## file ##
	    +## file => renamed-file ##
	     @@
	      1
	     -2


I think it should be

	1:  7a3dac8 ! 1:  119bc78 Change
	    -## file ##
	    +## file => renamed-file ##
	     @@
	      1
	     -2

I'm not sure if this is a feasible improvement.

"## <filename> ##" normally is a diff
section header (hence the "@@ some-other-file" hunk above) but here the
section header itself is changed..


