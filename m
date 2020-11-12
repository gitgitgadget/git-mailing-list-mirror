Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68322C4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5E6205ED
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPxkarNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKLBcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgKLBCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 20:02:38 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD137C0617A6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 17:02:36 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y17so3754395ilg.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 17:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gJuqwYfjHYyCliKP87dxTMSBRIPJwH72iXRkFTsmJs4=;
        b=fPxkarNI71Huiz04Cnq/Bo90/oenEzumAnI0xs2X4wJFnasQ0EFlAfZAenp5DHtHoD
         IkUknuzi93ovYkpasWEwxcmCGu9ITMC4IZgAVb55ptgJ4ruRX82kwbTYkkovuZj6hzk7
         RZXPTfKapN8fP+2yN0kldC1EOt9gE4jtk2nS2Zl4sstvQ2sM1+4UgxmsOmXQAkR05a+5
         7IaddwNGtdqdHl6gBsfYM/oRg2CmGD/glcn9oErGbdGG2Fv8bISVZgsCFVzG9Cd6UBlZ
         r9I5Ftm3vPBiIvR/Aci9zR7xjnkQKoBc398TCn9/qoEE9ALL2eyAZH1Hc2QO81OvM/eH
         OU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gJuqwYfjHYyCliKP87dxTMSBRIPJwH72iXRkFTsmJs4=;
        b=DhT1k6HTsV968lRrjssRk5mc6Tn2DMEnDBpoqcqzyL5qouqKonQ1Q+uY0VzkMf+TJM
         wZDCHNAAgBhaa/49cM/mr+fMAAGHasS+DH2KwaOzZvk91+WKvKnWVhNktasJqy3brUjT
         MOGogyxMWnO/WkGsqfX+qkRzr+Ce1vGNOSOffYu1a9zDRr+ZC3gH5J2PBmwZ51ZCefE0
         fI2kya6wulW08SQfbOAYcdOQuIdqXfhd4xi44uFYMSTVhEmwuHwDYlT2K2Rb6GSdC9OG
         TJ+FTT4nVXXbkr5bvZ0pYEsoDNUDihXkQY9aA7oX2x2pzM2pJE0VZQCPd5cG4xrXgeBN
         td4g==
X-Gm-Message-State: AOAM53027QXhdauUTfUSaQvYpWvxANkv2RFCYtiCiVh1B2nHe5W+g3iO
        UnxvpzKMVWX3lqVLdPQHffrRMILrQ6We6kURmI8tcQubt+I=
X-Google-Smtp-Source: ABdhPJw5fQOKjYIgggoO6aYy4dqF4C2+lwcy0tWqiEh2ZG1JLKYxuBWnPAlgx16PsvIX7WvsKlkr5ljm5toqifSuu0I=
X-Received: by 2002:a92:2811:: with SMTP id l17mr21844354ilf.238.1605142955507;
 Wed, 11 Nov 2020 17:02:35 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:00 -0500
Message-ID: <CAH8yC8mR0zvaQgtqjKB-je_ezhZXr+ixSg=5ogOimu1dY7Q+OQ@mail.gmail.com>
Subject: Git 2.29.2 is OK on antique PowerMac
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Git 2.29.2 completed its self tests on an antique PowerMac. The
triplet is powerpc-apple-darwin9.8.0.

for f in 'test-results'/t*-*.counts; do \
                echo "$f"; \
        done | '/bin/sh' ./aggregate-results.sh
fixed   0
success 21983
failed  0
broken  238
total   22616

Jeff
