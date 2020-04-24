Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBFCC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281D620767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBoSVrCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgDXEjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgDXEjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 00:39:43 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727CC09B045
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:39:43 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 72so10329957otu.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=P1QqLbmC+6rwFJcnVsg+JzyKaWdKoZcMLNUxgbQGeLo=;
        b=dBoSVrCSNV0bowk2zYiunyyEq496IDJwUm54zdPfUn0Kd025MyvwB4/DfkvJ5M52kp
         gqoc4NWR7WM5mvcFyIwilDUAggy3bNSV94UrZT8DovP8sgM47yPKHzbiH0wxMYlxcsCg
         pMfajA9kvPj1aOA99OW0+ci7WTZGGxrYErhDrhBYr6lKaNBSVcQaFmEqyzagvn+UojKU
         krjA7AfNtrWs26D2ibPcgTSa8W7xOhohyBIsV3C7gs5NtXgJsba2cn+ln/WJa+FKvYHi
         Sc1Y41v2gkIP2TtV2kZgRaE83mB0I4mp+i75QuiAE20GXAqz84dUMjJB5aV17u/eoY0D
         pSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=P1QqLbmC+6rwFJcnVsg+JzyKaWdKoZcMLNUxgbQGeLo=;
        b=WnSFyqarHhki+o/qpSu8Ek+O8wIbqv+JpzcHOWI+WJECXc1UBeN+WE2Qw6diXyDCcE
         6wS3NB+6yZ8+b1d1lg0futYIkXT6m17+6AxWK1C/ER2XZQ2DR0Ez855/9pMRSAJS6wHm
         qRL5IQg9V8MLX4psEIKbIy3j5GNeUUtCY/f4xvD5omXRGYZavF+OPi0vMPSwqunIrk/+
         740PwYmcdBExakdv3hMRh42xja9bdibGvXew2Ia4R1OHmUlK0IbwOSUe9lUtN61W1t+A
         CdCBIUzoP5YUWMPMBllsgTvH16p0XM1gS2UK0lkEDZJleY8ftAYEFqO7CG6lKgfMgvv1
         5HQw==
X-Gm-Message-State: AGi0PuYuhXAnn/coV6VhUY+PIyISfvyPmcjnOFYdrztXP4kbVPikSSFR
        JtZDvL4uTXN15bpKYTxvzAQEyLaiUndffsPjar+Z3E6u1FM=
X-Google-Smtp-Source: APiQypJHkXlijS0dN4ev4O9CRUMs8mqPZcBH97HRfCNUhqoFWmpNQYdJjmtRV9rLU+wmHPqSnbq3nMfukXp/Z53a14I=
X-Received: by 2002:a9d:4102:: with SMTP id o2mr6200791ote.98.1587703182655;
 Thu, 23 Apr 2020 21:39:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: lars.fricke@googlemail.com
From:   Lars Fricke <lars.fricke@gmail.com>
Date:   Fri, 24 Apr 2020 06:39:32 +0200
Message-ID: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
Subject: p4merge no longer working after upgrade to 2.26.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git community,

I recently upgraded to git 2.26.0 and this broke my merge/difftool p4merge.

This is my config with regards to the mergetool

merge.tool=p4merge
mergetool.p4merge.path=/opt/perforce/bin/p4merge
mergetool.p4merge.prompt=false

and this is the error message I am getting. Funnily enough p4merge is
mentioned in the alternatives

git config option merge.tool set to unknown tool: p4merge
Resetting to default...This message is displayed because 'merge.tool'
is not configured.
See 'git mergetool --tool-help' or 'git help config' for more details.
'git mergetool' will now attempt to use one of the following tools:
opendiff kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff diffuse
diffmerge ecmerge p4merge araxis bc codecompare smerge emerge vimdiff

Colleagues of mine reported that it is still working in 2.25.4

Kind regards

Lars Fricke
