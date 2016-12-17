Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D97C1FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 00:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757933AbcLQA22 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 19:28:28 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:32806 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757702AbcLQA20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 19:28:26 -0500
Received: by mail-io0-f179.google.com with SMTP id d9so111119094ioe.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 16:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=D94Q8sV/CssdUmZH6qZDmrq3u1xm4lhOQAkiweI0jsQ=;
        b=DPuhiMpUeW45+sP1/6BhESfLk0vKAAREJoEJQMkLdPuQSLGxzlvUeIl9yiJYUSqaEb
         KX91qbGm9T1BDjVAEPjjL0qk30wWxpvX3WJJ3T/SBwPN2sEU/Zetoh9s799sFvbGD+wa
         Rdc1aYKLv7hZuGFR43YV6oxRNU2rQzDc09uVcQnGi4snSaezeuaLCTBbjYKS5190I3Lt
         ELHb7RTolmvtVn2lbvWsdcZJAJdOM+AW+PtZsKPcdxNwhMY2awI8wle54EQElPXmjzcB
         1pT74EpJL8+pyNGXqnuTDZnPsQslg7hY04CI3mc6oOQ1APyCgmUEdrVykxTcdtMgOM4J
         kEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D94Q8sV/CssdUmZH6qZDmrq3u1xm4lhOQAkiweI0jsQ=;
        b=kiSN2mP9WubaSEBHkil3cQWKBToW1DTFsc6csLOgCdTEDYPaRhtDYNZwdG/0rQXkOS
         FfETDToX8v6b0cG3bEcThInR9lt+tk7yYVUOJeelgOq6VK/YwamSzmkH31KVj6i8NsVc
         DeiaWUKg9Q5J4hgOMxXSIpnGCpExsCXpHsa8QHWfpe2FFGPHQlAmegljURUJ4CW4vEEe
         Oprd5FQreH4rOGvcUDoG/cZzrU/748D0W5Sp2itN+28BMPQLpx6OgVjDb+0gjSUdbYf3
         jkoWwRqtU0ayMhr5jQanLj95ej0Omw4NdRq5chQvIMMPMwiQED+LCz8NG0f8jabOkdph
         F1jQ==
X-Gm-Message-State: AIkVDXL03D5+v0TwkEE5epva3Xo22QK28chjabTtFLT5lG+/ZnTpmRRB8/B6KRRKk/ld/gXM5wwmyShf/dkQbw==
X-Received: by 10.107.179.195 with SMTP id c186mr5331554iof.35.1481934504924;
 Fri, 16 Dec 2016 16:28:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.163 with HTTP; Fri, 16 Dec 2016 16:28:24 -0800 (PST)
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Fri, 16 Dec 2016 16:28:24 -0800
Message-ID: <CAM+g_NsDLKxWLZCDOgrh2O3W23PRP8Zxf-Zzf_twSw5VX3=G=A@mail.gmail.com>
Subject: indent-heuristic, compaction-heuristic combination
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I started using compaction-heuristic with 2.9, and then also (or so I
thought) enabled indent-heuristic with 2.11.
Only after reading a comment in "Git rev news" I realized that these 2
options are mutually exclusive.  I then
checked the Git source code and saw that Git first checks the new
indent-heuristic and then the old compaction-heuristic.
Therefore, anyone who is as stupid as me and enabled both will always
(and silently) end up with the older of the
two.

Apart from better documentation (I know that both are marked
experimental, but nevertheless): could we not swap the
order in which they are tested so that the newer heuristic wins?

</nk>
