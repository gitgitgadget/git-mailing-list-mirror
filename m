Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BC720248
	for <e@80x24.org>; Tue,  9 Apr 2019 08:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfDIIN5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 04:13:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35519 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIIN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 04:13:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so19647580wrp.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gcBPIZW2emtLk+3DCkgIdk5yeScIQ9g/lHv7Uz047SU=;
        b=uXHJHIIe3wr4Vsp/SRBYIhEgqkTQ3qQfJGq/PvAboTb2s6uoEwsGG/5/Spu69rby74
         kz6CE+LWnyqpTxlk4FmK13QF9+8x8lO1Bu/HvyMQShIKAulOMOkcxgWFfpD2ZAJGllT8
         aY9GkEm7bu81I0/0E2/L6hJ0Ez53EFPSyPdkhBvoa5Uf7V5c+MkLgdiAyjVXbM+R+F6u
         fH6o5xSZM6ToQZPwcCc0UyeLE2aVqUdfceIadVFsHT8Kj/n4Mqs1m1qEBeE13AKK10aT
         +JtW8q+qIy07N9xrOzAokndgAvMYnOr8UbUaIAZFYXpG7uiO2sIURzx6TqbEbi7Ck544
         HZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gcBPIZW2emtLk+3DCkgIdk5yeScIQ9g/lHv7Uz047SU=;
        b=YdBfF1i0JzzPjQ2IgBfO/ZEMtOdMVBMZZqf53F3slYKC1nmdK6nF8cIv2SpvyOivRy
         cTlQotahPvXYTXawB1o+p85hinKWQax+cIryhDiFKiiDqnXq/Lv1/KutaH0wew5hl5OB
         aGSbug/JdEl/ctssYzmrBg+BcF5UwZnFKEqS+fnaiP6KCz57kp/7HpZ3dQC75eYGUS1I
         mwUAFQUGvYsbXodWU6O4LVakdOpR6RrNSUes1PTzfm+m4ZCW9B6Og+AMYpSOc+8z3ORR
         59NCq1rdSyCG6A+YFmpkK0Qirwp+usnndpKuMaWmanWEVrUCieYCNMj3OZaBzFyg1shh
         uOlA==
X-Gm-Message-State: APjAAAVfQGrpXlKb6eccbaEEeqXlDY7h72TFFWhzgST6Az+9krK5F0ZX
        JNQw2be5cs8DVRAJNfzWh6Y=
X-Google-Smtp-Source: APXvYqw7bcZea8R08MHBbZQFXzme/P17oPEiiiUGSJIqsFuTodsmAOtllE5HR6KxRGdZxp+R9nuRyA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr22386939wrm.225.1554797634837;
        Tue, 09 Apr 2019 01:13:54 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o12sm34172473wrx.92.2019.04.09.01.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 01:13:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] blame: default to HEAD in a bare repo when no start commit is given
References: <20190407234327.25617-1-szeder.dev@gmail.com>
        <878swkacok.fsf@evledraar.gmail.com>
Date:   Tue, 09 Apr 2019 17:13:53 +0900
In-Reply-To: <878swkacok.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 08 Apr 2019 14:44:59 +0200")
Message-ID: <xmqqmukz7fzy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> There was the explicit decision not to fall back to HEAD in 1cfe77333f
> ("git-blame: no rev means start from the working tree file.",
> 2007-01-30). This change makes sense to me, but perhaps some discussion
> or reference to the previous commit is warranted?

Yes.  That is a good suggestion.  I do not think the original meant
to say that no rev should error out in a bare repository because no
rev must mean 'start from te working tree' and there is no way to
satisify it in a bare repository.

> Both are bad & misleading, perhaps we can instead say something like:
>
>     die(_("in a bare repository you must specify a ref to blame from, we tried and failed to implicitly use HEAD"));

Sounds like an easy-to-understand message, albeit way too looong.

> Along with a test for what we do in bare repos without a HEAD....?
> ...
> ....just 'git update-ref -d HEAD` after this and a test for 'git blame
> <file>' here would test bare without HEAD.

That's a cute way to bring us on an unborn branch, but let's not
promote it too much.  Doing so while on detached HEAD will render
your repository corrupt.
