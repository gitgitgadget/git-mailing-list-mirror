Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E0C1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeI1Ek7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:40:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54890 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeI1Ek7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:40:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id c14-v6so337004wmb.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/U188lGvK3VUTvb+R590KnrB7BJRflCPO8loce3X7r4=;
        b=tUwH1lAdlylp2XXL49xSYBBzTYhRRj2dBGH2e09idvEwVJnvmPTBL/4Ykfg+Lc9wUJ
         2/PyCJeLE/CvEf+4X219YiJJJcjZ3gdgQc4YwBSnn97ZI9xjO/5ktLlOvqGjKaahiZtE
         84GA+YpF6QK/BEw9xNeEbZk39eAfmEe9eF0i/pOEE85p5xlqrD8yGL1Ig9W8l/R45W7L
         ok6znaVkZYfV37cRbSTnd7Lsj2dAYhhoUB+uVi2h/Ddg1NXN5wdi1SCyFTfZOgfxx569
         wFiOKa6CyxVuYlSUqEIB8C8rkV4qsA4Z+0F631wRWrxM77Ljj1/wGlt2PItQYvpVFAlm
         ARJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/U188lGvK3VUTvb+R590KnrB7BJRflCPO8loce3X7r4=;
        b=jK7OsRPQYsUqacCoKucxmwaPTrZndT9OyNnNQdWLXh5ZbaQ4X2KXVDfdk0/zwfQ6qD
         XOvSYPyJnmR8VQqwZIJo256UryvPkUZaup2QQxNMh8bZn7Scxcpt4TvGpK7uE+zBBMPs
         aC2lboD3/fygGrpiMzlrkCmw+HfZ2Eyd74/28ATjotWsJmEtgnfhM2ORlAx6zO8EU1zQ
         247Zoc9Qnihke7nZTjdYSNz3/VujAFOEKBB6WC+tQiQa/S9Hwz40z78g4uCK5BEUS0aJ
         /hRpgNFTEOa+NAK9C7zTB4w7zzniHczGeyEiAFbnz+/uKw2mvEq7mNWXGmxaOnE3yHJa
         /zKA==
X-Gm-Message-State: ABuFfoj7NaY1MA4BQ4fTcRIj1yA9dcJGDqjqWHK1CoYHL0nOhaz8xGg8
        8+3YfVyUX6io0cTSxE31B1I=
X-Google-Smtp-Source: ACcGV62fSfAfljpKPHif5gbiXZf0yn2HAgIXf/L0BYwVvBPA/Ihzep1eTS3YhItd04dzACdGivGXmQ==
X-Received: by 2002:a1c:34d2:: with SMTP id b201-v6mr324172wma.115.1538086828419;
        Thu, 27 Sep 2018 15:20:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h8-v6sm3028815wre.15.2018.09.27.15.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:20:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Josh Steadmon <steadmon@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Add proto v2 archive command with HTTP support
References: <20180912053519.31085-1-steadmon@google.com>
        <20180927012455.234876-1-steadmon@google.com>
        <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
        <20180927183017.GD112066@aiede.svl.corp.google.com>
Date:   Thu, 27 Sep 2018 15:20:27 -0700
In-Reply-To: <20180927183017.GD112066@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 27 Sep 2018 11:30:17 -0700")
Message-ID: <xmqq1s9efuqc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>  1. Clients sending version=2 when they do not, in fact, speak protocol
>     v2 for a service is a (serious) bug.  (Separately from this
>     series) we should fix it.
>
>  2. That bug is already in the wild, alas.  Fortunately the semantics of
>     GIT_PROTOCOL as a list of key/value pairs is well defined.  So we
>     have choices of (a) bump version to version=3 (b) pass another
>     value 'version=2:yesreallyversion=2' (c) etc.
>
>  3. This is likely to affect push, too.

Do you mean that existing "git push", "git fetch" and "git archive"
sends version=2 even when they are not capable of speaking protocol
v2?  I thought that "git archive [--remote]" was left outside of the
protocol update (that was the reason why the earlier attempt took a
hacky route of "shallow clone followed by local archive"), so there
is no "git archive" in the wild that can even say "version=$n"
(which requires you to be at least version=1)?
