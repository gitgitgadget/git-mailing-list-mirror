Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42071F453
	for <e@80x24.org>; Thu, 25 Oct 2018 15:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJZAAC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:00:02 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:39879 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZAAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:00:02 -0400
Received: by mail-qt1-f179.google.com with SMTP id g10-v6so10327840qtq.6
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4wJVYx2sIANKFnbQ+tDHbb1EK0XJzAtJzPfzVaTV2/k=;
        b=g3llybmKy4uugbmzlYDobAySEO+PKMxzaHcWRbEyXz/1a7ED7jFBY0OmKCrW63XLCX
         Q0echuQQuYdrzlKfET7T6gB7UKwezgVlSpCBb1csSg/EJblPg6FpaDm6wJCRgsi1/bmA
         Zo9yFsZ1pojiObgtPNwlufgPv1CqF6M1UdpWqGNGxV5ptT1d3IIgT2XovFptZdnQkRdL
         p84+fysAhXth8ESFgv1sjXAAfMH/kKyeZPT0igDrttjl1XEem033ZA3ZwpyTnBgH72wI
         ofJXtpGy9Cy8440iTwfspCGf2H0qLEszN3KC072jMVoFzNECJNjYTtQEhGDJEKDu6vLQ
         9Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4wJVYx2sIANKFnbQ+tDHbb1EK0XJzAtJzPfzVaTV2/k=;
        b=lB0OJ/LMoRL35B7QkBQAdvEIrZyuV/GmQ76bD1aXqsR7PxAD7o2Cqmh9KjHDN8AWHc
         ckdVXdT/E/L7pzho04aux0pjr+zMtBZSCSn3UtWs3mRUOebFiieyaXKiYGwy6XGFrGQN
         +bvjCzNlc50uUD8MRMO3TZE5r9oIiZ5TiTyEenmMEiBGNHUpaUJH4TdcSG+1XaeNkxpD
         TJr2+vt8WI6IzdxH0yu0ChawXG4bApOs9ASCQrbUIOUWNodDJI6BCl0is9tGJfd6YGam
         A/SosLA8YN9hY83ZYUd5tX9uLB7p9lKPzYAm/xOtfQMG8kjyOI38TTzb42TXHaOTG3zE
         /8lw==
X-Gm-Message-State: AGRZ1gLFDrOoDtfzJO5NL06m/jJQO6e5w7o3tUmMiYFDCiZczisgIg97
        pWM87/3FbZ51ej6EWVjOezVGv6sGrbVYs7ZPNlQmQY4=
X-Google-Smtp-Source: AJdET5fz19iicovIg/BzvkJLIzNk4A+DV6nlLJa1svjiyCOJiMeVB/pGLN6dIhuq8MEgl+BQJfSBGVmmqBNBPXGX0ok=
X-Received: by 2002:aed:2705:: with SMTP id n5-v6mr1962178qtd.216.1540481206309;
 Thu, 25 Oct 2018 08:26:46 -0700 (PDT)
MIME-Version: 1.0
From:   buckmartin <buckmartin@gmail.com>
Date:   Thu, 25 Oct 2018 17:26:35 +0200
Message-ID: <CAJCHkCHPpZVPX2zeHQZWGKyCpHdFFHvNqn1Db0hsAPfTdjV-+A@mail.gmail.com>
Subject: Bug: git log changes output depending on how the output is used
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that the piped output still prints the (HEAD -> ) :



git log --pretty=format:"%d*%B" --decorate-refs='refs/tags/*'

*bar
(tag: "123")*foo





git log --pretty=format:"%d*%B" --decorate-refs='refs/tags/*' > tmp.tmp

(HEAD -> branch)*bar
(tag: "123")*foo



I would expect the output that is printed to console, not what's
present in tmp.tmp
