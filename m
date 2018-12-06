Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25811211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeLFRak (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 12:30:40 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40817 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFRak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 12:30:40 -0500
Received: by mail-wm1-f52.google.com with SMTP id q26so1888423wmf.5
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PaXAxv9R755hLv9nYBVXsypXnV4iZenaNc1B6hHg/Y8=;
        b=rbkAGDiVk6jL0vV0LBk/R1NrR/Jk+rC7LdueK5RIblgCTmYcc0093ucLVy4Pzi71eH
         1tcqKWmNbt9TBpx4ok0dvi5lxKHMhBkgrIQJ5CwL+nCneX/haoJU7dUOcNr69pRwdu78
         eSLXgBpPyLZpBKUWZzcL7fSIqgKfmeC1ObfcV2E3Li7nuFkTL0nmu5c+jHiMv+yWARqZ
         vtDNRW+QC3ZqACM5BSgs0Oudpn76yLOtdtu3ZPRZruVWHflPDxa5Na20ptks/ZTlIIKI
         XRs0cbAbi6ZX/K7AY+HT+hQ9Jubi+ssx2k+uawCQriIHrQwOZIQWqU/K2fs+HMI12B30
         6swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PaXAxv9R755hLv9nYBVXsypXnV4iZenaNc1B6hHg/Y8=;
        b=iEA53lM71ORltQtzSUVXI+99ZRgWa2QFH0JgWa+yTXEbwEPg1Is5cNjyVLMEawJjWi
         VCjl2Du8fpgS9vuXi3/AvdO5PG7ZHG4vYKuxV9aKP9KIETWGkvDm1mQcNc7Z8W7D8tsa
         vWXigIpLKX9DXy7UBzGvcPV6vQAu4yItBKlFJbzIIiHZLZZ++fZ0sUOMKtxpIfTVvAvi
         qhCN5uCQaun9ctAyvcPX5aB+36US9DcaAB6kD4f8GJmUtsju0+aBbizEg4grdsyExMiN
         87sBrUzIwKXorij3dqduOrYg3YQyhVO9wNhyeu8jwpeDLKy3Tvl6r2hlfMujm5/kUFTS
         47kg==
X-Gm-Message-State: AA+aEWaow3uWBjh2wOsCA6aTMZf0l/lbqXX685OF0VmMdAAjByDIU+dr
        qJ5DX+SKo2Ovue4JFuXQhWrRfigla4s=
X-Google-Smtp-Source: AFSGD/Vo4kO2B/ysRNqSQxu6qPFcp64XM1A/2TZ29sjaitOutOcciT9HZj15QfBAxrrlChnmVs3ddw==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr21719883wmg.42.1544117438562;
        Thu, 06 Dec 2018 09:30:38 -0800 (PST)
Received: from kinodont-arch (ip-89-103-14-213.net.upcbroadband.cz. [89.103.14.213])
        by smtp.gmail.com with ESMTPSA id j8sm2125970wmd.0.2018.12.06.09.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:30:37 -0800 (PST)
Message-ID: <5ab4e3fb2e22097753bde7702e67d6ce924283a2.camel@gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
From:   =?UTF-8?Q?Luk=C3=A1=C5=A1_Krej=C4=8D=C3=AD?= <lskrejci@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Date:   Thu, 06 Dec 2018 18:30:35 +0100
In-Reply-To: <CAP8UFD3VCzEdtfRqi_d2ibPtTN0uocGW+CshY_5m16TW1_YUdw@mail.gmail.com>
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
         <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com>
         <f9f644daa705c78ef348a4a808d88bc01e7bdbd4.camel@gmail.com>
         <CAP8UFD3cD5KtvPJK5WkWGVUT6grbL=xL2MV1YWNJGpOjD3uRiQ@mail.gmail.com>
         <278123655fbdb565aed16bba804711774716c554.camel@gmail.com>
         <CAP8UFD3VCzEdtfRqi_d2ibPtTN0uocGW+CshY_5m16TW1_YUdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2018-12-06 at 17:31 +0100, Christian Couder wrote:
> > When Git replays the bisect log, it only updates refs/bisect/bad,
> > refs/bisect/good-*, refs/bisect/skip-* and reconstructs the log in
> > .git/BISECT_LOG. After that check_good_are_ancestors_of_bad() verifies
> > that all good commits are ancestors of the bad commit, and if not, the
> > message "Bisecting: a merge base must be tested" is printed and the
> > branch is switched to the merge base of the bad and all the good
> > commits.
> 
> I am not sure if you are talking about running `git bisect replay` or
> sourcing the log in the above.

I am talking about `git bisect replay`. The shell script, as far as I
can see, only updates the references (ref/bisect/*) and never checks if
the revisions marked as 'good' are ancestors of the 'bad' one.
Therefore, $GIT_DIR/BISECT_ANCESTORS_OK file is never created.

The first time the ancestors are checked is in the helper (`git-bisect-
-help --next-all`) that has only limited information from refs/bisect*.

