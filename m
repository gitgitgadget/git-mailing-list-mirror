Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92DD81F597
	for <e@80x24.org>; Sun, 29 Jul 2018 03:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeG2EmN (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 00:42:13 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33420 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeG2EmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 00:42:12 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so3531591ybb.0
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 20:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBdZ6r9rC/h3IQH7srOYy66c+090w0D+rH7TYKuXehU=;
        b=GtakR4N/vwGGB2ZGSMLCHiwkFXOixsbW1lxh0IzN0gy5ABvTLOB+bzYV8EANVbsHxy
         7+mzroysaGC+qsVo+jGYktEvViJQ1M17hFVxdiLTpRvSfC7SbumRBzUPNWlBC/h0i1UK
         6WVoqzo3hHjZbMAiq5om+1beKmuNkiOZ9XIM5eW/KVCjmMLvAaesXuAVa38XB95PccZT
         r6T6OLED+Py3o7r0/0TDdEjUMN75n2yKCpWcN5AyNvskjKJcb3CEC/AUs4TgutQU71cG
         Psc8V3m0Tl855NfvSyp3x8Z/WVLWiVzdOU3aKrkQyM/mx/2rRCm6EsM5QP2s3ZpZRaRZ
         dIuA==
X-Gm-Message-State: AOUpUlFJmcFZPFOUBWcadQUvLq/ie/iISahfT+AfYHzm/CIv0NzUo/wn
        sugWp2bjti5nGYGR2iUVoyYrk07AgqlK3FYw6+I=
X-Google-Smtp-Source: AAOMgpfqjuhPwtFpSi0DIbZLDvkxd9XIT41eYfBWGwBZCFHHbPjAbVUbqF6B6U4TGaoJ4xA754NchVEVrbYbwnfScZA=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr6718683yba.263.1532834004755;
 Sat, 28 Jul 2018 20:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <c5b2a072-5058-0d3e-8fb0-52b84bfcdfa9@ramsayjones.plus.com>
In-Reply-To: <c5b2a072-5058-0d3e-8fb0-52b84bfcdfa9@ramsayjones.plus.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Jul 2018 23:13:13 -0400
Message-ID: <CAPig+cSCsOXi4e8idXwLo41rjDREvvtG5P_bNtEWybUbAZj9Hg@mail.gmail.com>
Subject: Re: [PATCH] t5562: avoid non-portable "export FOO=bar" construct
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Max Kirillov <max@max630.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 6:51 PM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> Commit 6c213e863a ("http-backend: respect CONTENT_LENGTH for
> receive-pack", 2018-07-27) adds a test which uses the non-portable
> export construct. Replace it with "FOO=bar && export FOO" instead.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> Could you please put this on top of the 'mk/http-backend-content-length'
> branch. This test tickles the new "export FOO=bar" check, so the test
> suite does not run otherwise.

The "export FOO=bar" check comes from 9968ffff0d (test-lint: detect
'export FOO=bar', 2013-07-08), so is not exactly new.

Perhaps you were thinking of [1] a0a630192d
(t/check-non-portable-shell: detect "FOO=bar shell_func", 2018-07-13),
when you wrote this, though it is not related to "export FOO=bar"
detection.

The patch itself looks fine, by the way.

[1]: https://public-inbox.org/git/20180713055205.32351-5-sunshine@sunshineco.com/
