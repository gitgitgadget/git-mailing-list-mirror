Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8DAE1F404
	for <e@80x24.org>; Fri, 12 Jan 2018 09:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbeALJXq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 04:23:46 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35180 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbeALJXn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 04:23:43 -0500
Received: by mail-oi0-f48.google.com with SMTP id j139so508806oih.2
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 01:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T3fpxz8no87xC9UERTCmYqyCC6Smy1cPsMeHlqWxbpw=;
        b=Rk73oq49P+SWFtbQlaE4Q+MXNetPSYcXlJQthcP/5V85OBxsilA1qdumbtKRl/qn0w
         tq7L38Ey7tII2onZOOv8LwUClZNfy2pg4FeiTDP2Vi3wF57KAQuS/SoUP9U7lwbUeHt6
         4E/81ob3bmjt+tndiEpoS6JBOWlbcq7l2sOAit6hGcAqpixfxDgvUOf0t6R2UHr176e2
         0lRkH0+2okbltLmkq56HNTECv/CbhRj4W86tl2Bvver6lJjDDdCe3Tf19LXwA4mOUBZi
         r4T8aO8M1aEqLCFcDWbCNMbGz4TeHNlDSNE/mY5+wgM4+PYgeTQI5KtZDZZllSuaisH4
         gicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T3fpxz8no87xC9UERTCmYqyCC6Smy1cPsMeHlqWxbpw=;
        b=MP3cpcWdSEtL9154JmleDXsFVufOIL0kRP+jZLyK1Hk19ZYXXveb32K+h96h4/w8pj
         c/AuCkSS2cRO0Ute9Qvi80AXevWz40yhztveoN/1QitvW68R7gtTdbxuvh2+SyJVBYBl
         VjuonVFyr9/K0JOPlgJs0R10+CNmMigkD6OGXZVU6Cwyu/aahVT1gxSqvKM0ogF0oIIO
         n/3pqGMOyCPMYKQZNP4IIWzhuBK4a8WViN2a57DY3ZPUqEp4OBbn6X9sO/b/pCy7oFy2
         tFnAwmn5MDK/NZbzq61FEHsg/H8MicWP5Xs+jknPTU6ZdzeyYWT+xvYX+fltRVkgKQnI
         xCfA==
X-Gm-Message-State: AKwxytfwGrDvGttN8sU69MUG8Qez2bKkWUKvmk7i9XOAdedhDmDTGvZi
        taEie3EO29hMeVxyoz6td0MKazh/xAs6fAD6G58=
X-Google-Smtp-Source: ACJfBov3xq0/I8KYcWrvKkeDpj5PgMjm8KUdykHEdvLE/ofpaFcl+ir3zh8oBL7yL52WoFmA7xm3bZ5MELfSnBoymaI=
X-Received: by 10.202.76.214 with SMTP id z205mr4115148oia.183.1515749023221;
 Fri, 12 Jan 2018 01:23:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Fri, 12 Jan 2018 01:23:12 -0800 (PST)
In-Reply-To: <xmqq4lnsyz4l.fsf@gitster.mtv.corp.google.com>
References: <20180110104835.22905-1-pclouds@gmail.com> <20180111094712.2551-1-pclouds@gmail.com>
 <xmqq4lnsyz4l.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 12 Jan 2018 16:23:12 +0700
Message-ID: <CACsJy8BrLJiwoKugJQhFj-TvUBDG5tcdTeOGnYPZ=H=6kSHdzA@mail.gmail.com>
Subject: Re: [PATCH v2] run-command.c: print env vars when GIT_TRACE is set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 2:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I wonder how common it would be to attempt exporting a variable with
> the same value, and to attempt unsetting a variable that is not
> exported, which might help you reduce the clutter by hiding stuff
> that truly do not matter, while keeping what matters (possibly
> including the "unset" part).

It looks pretty good actually. This is with 'git status' and a repo
with submodule 'foo'.

trace: run_command: cd 'foo'; unset GIT_PREFIX; git 'status' '--porcelain=2'

Thanks for the suggestion.
-- 
Duy
