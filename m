Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B478820A26
	for <e@80x24.org>; Wed, 27 Sep 2017 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032894AbdI0AyC (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 20:54:02 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:57096 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032887AbdI0AyA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 20:54:00 -0400
Received: by mail-pf0-f180.google.com with SMTP id g65so6380033pfe.13
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=XgZYbo77cD/cRa80GsTo435taN8J/jRms/jq6dXKp38=;
        b=vapBVYHGdqc0y1c99OJGa0JZ3t4+DUPShrmMI9AaVoXqCmIuLE6UyjU2v7C3JxCZ91
         bicW5XwayIjfSpYpJQ0wSbPPvpi8JKCMiPUHsI09iF12veiXQWsFbGides2jb7UvDm6K
         pcOeiZzelhJm4NuR2TZONSw6Xi40vKTI/iel76N8TH8FFKn4R10K/vpGEo/PV5OA08Pu
         EV4TIumYKODsdCj/CbRbEaQ9psxmzs/aBfYJSoBltc3V/EEconUnztdBS7n519qovUZt
         prsKu90rPUnrBjqZa0tWjvfV3I/a3WVD8p+U2vgFWCE4VT881YMziEmQxTU1PcSuCriw
         TXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=XgZYbo77cD/cRa80GsTo435taN8J/jRms/jq6dXKp38=;
        b=XcptCaq7l4iqwltoox+yXe6+mRK9ze/GuSNEJyZeng7GAORZciogls8NeJB6XsB22/
         tHZG+5rLnZlXI0f2Nz1TrDLrUFO3dcdv1mLYjziQeL/w1I2aCpwrYYT9nhR2xwbz/5pV
         qKcx2ol43eg8Y41FfF2DWZOh6M/w85gjLUUg7MSIIw4RzDgCj8jw6X555WibT+YuFv0z
         oMFWQaEIDeIPncEAvTMNdeqcmkT/PLrhZaNTK0KR1SBhKoW0CYD4I7ceD00imMUbJc5R
         j9vPWUI65mv4eeGXvtObzlpe+kEGVgMDvY/nkqPnX0WH11BaRqbU1bp4eo7v64yB2h8u
         bLIA==
X-Gm-Message-State: AHPjjUi/ULg7P+dywaxrhPRmT/mvisF9aiPezyds/Qo0N2vIp+P3LSsy
        SUjji/D66304JVZ90RMU7avM/9hF
X-Google-Smtp-Source: AOwi7QAQ8tl1insjn3H9OfjXTjZEqaP32O/UYKord1Gla3qmq4QE7LwVlHXgh71nFk4477wE5VPKkw==
X-Received: by 10.98.70.90 with SMTP id t87mr12112255pfa.114.1506473639638;
        Tue, 26 Sep 2017 17:53:59 -0700 (PDT)
Received: from debian-x1 (adsl-99-178-242-129.dsl.pltn13.sbcglobal.net. [99.178.242.129])
        by smtp.gmail.com with ESMTPSA id q73sm19424517pfl.147.2017.09.26.17.53.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 17:53:58 -0700 (PDT)
From:   Ernesto Alfonso <erjoalgo@gmail.com>
To:     git@vger.kernel.org
Subject: git apply fails silently when on the wrong directory
Date:   Tue, 26 Sep 2017 17:53:55 -0700
Message-ID: <87k20lt10c.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently ran into a similar issue as described here:

https://stackoverflow.com/questions/24821431/git-apply-patch-fails-silently-no-errors-but-nothing-happens

I was using the alias:

alias ganw='git diff -U0 -w --no-color "$@" | git apply --cached --ignore-whitespace --unidiff-zero -'

to stage non-whitespace changes, but I was not in the root directory and
the changes were not being applied. I broke down the command to discover
the 'git apply' part of the pipe was silently failing to apply anything,
exiting 0 without even a warning.

The exit status and lack of warning is terribly misleading, I imagine
this would be the cause of subtle bugs in automated scripts. 

Is this expected behaviour?

Thanks,

Ernesto
