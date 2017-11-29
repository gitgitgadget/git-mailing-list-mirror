Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F28020A40
	for <e@80x24.org>; Wed, 29 Nov 2017 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935228AbdK2R67 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 12:58:59 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40157 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935063AbdK2R6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 12:58:55 -0500
Received: by mail-wm0-f47.google.com with SMTP id v19so7674860wmh.5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 09:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A4BQ6P9s1S3mqMcHke439TkNSYyEEAp7HzPcvHuqujQ=;
        b=ihXtkBzvRP2tx6Axrp6y2vBcs4s2gANT/QKubJAYS0Ij+qLJAwTIX95OPt/J4mIKp9
         RoG5OPCFXy0wGb/RqdC/s4YiZczv5TYtLeL2+paOVDVZ7+KAD4JebJ7jBQLoiU92Ey20
         ZTmX4yF/ecOfe8ykJ3RBcSdL+Rx/9pso6gjduvbw+r/CLsZEDlGtM4iaHFwjWfXL82ep
         Hx1PlrrYTkMjR1Aul0eqb/EVsTx/gA6WrzPEwoNqroAVv+RC3O1k+r9hbxw2NJnUcS+A
         BgoH9QUrv/FhjYd41UBJsbPZp0qOaG4Sm00OzoNGmYM7iUydiMiSBdbQSZy3Q6SXAwp7
         Z85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A4BQ6P9s1S3mqMcHke439TkNSYyEEAp7HzPcvHuqujQ=;
        b=c81QMkIefQhA/edp5lJwp6vg/GYEa2EjENGW8rHqGOe8s9wAaBeE3Gndusrx/iwajG
         weOEkt02CXjMA8gwpP4JEyj5ViDrc7j4j3wKw8zWO7R6Tz+AaWDLfhnRM5E8r3OAYDi5
         MYBx5740oPgLPZYwdBRdXEEcnn7Mwite3QEVwzWKve7AwuRC7bteyr5ra2Boo40roItn
         rA1yIRZEuZfVROqjN6LYAs4snUGySfbyVXBCBowE1f0pApe2zpvj0Wan/XPQHx/nKBoU
         W9S64bA2lZg9u5LaQ39KUmcItTfenAruCj0OoUYsNJAZYFRyboyhqImTCScIsZMzHrYO
         9ETA==
X-Gm-Message-State: AJaThX7IRbooG7YCA1HzlSgi5ss7A/7Jl4hKq5tsz6ng7ZsNZP1v/vn1
        UGnzEYbw5kVMeGOxFhEDNwl6rDtqYrYVULwIkCJ9BfCe
X-Google-Smtp-Source: AGs4zMaxC8zdvofX1xTdKqBB2BRURQ2zB8UReuX+qbcxaXO/sZFaKzNqcawpWelrUDLu2M2k67cpJT0es+3Nyw15jwk=
X-Received: by 10.80.138.34 with SMTP id i31mr8901823edi.8.1511978333712; Wed,
 29 Nov 2017 09:58:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.160.135 with HTTP; Wed, 29 Nov 2017 09:58:53 -0800 (PST)
From:   =?UTF-8?Q?Rafa=C5=82_Treffler?= <tothamon@gmail.com>
Date:   Wed, 29 Nov 2017 18:58:53 +0100
Message-ID: <CAHY8k2DJSQjXrjTq6nysnifNppzLtSsORqseB2J0q1bYnkCF-A@mail.gmail.com>
Subject: Git filter clean not working when staging files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've got a question or maybe bug about Git clean filter.
According to documentation[1] clean should be run when staging files.
When I'm staging file I see my script was run (I'm logging execution
into /tmp), but file content is unmodified.
My script is reading stdin and writing to stdout.
Nothing breaks in the script, from logs I see the source and modified
content are proper and I'm returning 0 return code.

Is this behavior intended? What should I do to modify the content?

Smudge works as intended.
But I've also noticed that git status runs clean filter but does not
modify contents.
Is that also intended?

Maybe I'm missing something?

If this is not going to work,
is there other way to modify file content on commit? (so the fixed
content goes to local repo)
Any other options ?

[1] https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes#filters_b

-- 
Thanks for help,
Rafal
