Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85901F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeGVKKy (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:10:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54248 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeGVKKy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:10:54 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so20129656itw.3
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQV+WXvkaGcDTOdGuu6kSjkPXE6Pog4NtnZSzzc50sU=;
        b=kvFmG0vTTE70oQP/rn+EbooEQIgTwfI/WKBO7+L/DpmouO3zu4hQi6MfqRQq2V6OsR
         WueFM5jnMLcJU02pEhkafRhBXHyD0AUkKdQL4g9/ezx6kPURmcQIMtzlZRqTEodyWiF8
         10bSZFtJX7q/6DrRperqQEgW91MlKq2CU2DTOuao1mLb9T00QuafTBntNk0BHJAYVuTH
         EEGV6eGI35GSX1W1Ifks20AT7apNELwrbTuGAcm67EdFXAP2EmTQnDU6VJpSWT7WInvI
         JYI6ewGS+0z/FZeNZ4QYj106OFnbiLrAb0gCGN6UvCCUBTXNuwAxLuHlXzB9iSSpoKNY
         YQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQV+WXvkaGcDTOdGuu6kSjkPXE6Pog4NtnZSzzc50sU=;
        b=m6zUb6/7y9FfOePEtsjPskzEP1cz2/crjWtfTCxjse2IfFeoWkkpA1D2QduQLfQgB6
         yIskrTjn6zRC0U3dBVfWI4clb9fEaNBBSDorUltgz0H5TJ9gF+gwTi/IC+LbOOTD3Cf4
         iwlQhBOxvTZY6iRaXsGu3+ThcbU7lcj0Sum5ywQ4/mceBBddE5JsMLhtwnLQXYl34zGB
         BVvZG+twj1Cf3clVVXRzvs/jI3Qnkrv3aNvZassbAX72fbUwGZztYkNjmKIcVX1in2Un
         RFcEwQcPIbmpnckyzEleOsbvKtzX5NLuOOR+fxyY1Xkf1BDPFCTor8TzZsD+aDfUXOP+
         8FcA==
X-Gm-Message-State: AOUpUlGaScFt3209Y+O+1V5TGPoz+t4nC1kr8/vOabYbdXcHxIS5FGR9
        uCMltPuF8/nabMMlNZfMx0M6YZu0AGL0CxVgh0A=
X-Google-Smtp-Source: AAOMgpdgUI7INoDWXCbILX3f0AoJ9YFVICreg9WuDg1I0/czDt9DXPGgeSnbS6kP7YlNAwtVdBMUwGoAFTyCBWX7Cpg=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr7029804itc.68.1532250892381;
 Sun, 22 Jul 2018 02:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com> <20180708180104.17921-2-predatoramigo@gmail.com>
In-Reply-To: <20180708180104.17921-2-predatoramigo@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 11:14:26 +0200
Message-ID: <CACsJy8D9mX4imSgQUdPgQEuj_CsuPwSUc9zLKjDTp4-q+Jnwkg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] rebase: start implementing it as a builtin
To:     predatoramigo@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, alban.gruin@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 8:03 PM Pratik Karki <predatoramigo@gmail.com> wrote:
> +int cmd_rebase(int argc, const char **argv, const char *prefix)
> +{
> +       /*
> +        * NEEDSWORK: Once the builtin rebase has been tested enough
> +        * and git-legacy-rebase.sh is retired to contrib/, this preamble
> +        * can be removed.
> +        */
> +
> +       if (!use_builtin_rebase()) {
> +               const char *path = mkpath("%s/git-legacy-rebase",
> +                                         git_exec_path());
> +
> +               if (sane_execvp(path, (char **)argv) < 0)
> +                       die_errno("could not exec %s", path);

Please wrap all user visible strings in thi series in _().

> +               else
> +                       die("sane_execvp() returned???");

or if it's definitely a bug in the code, go with BUG()
-- 
Duy
