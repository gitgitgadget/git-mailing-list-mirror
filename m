Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC16C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36B12073B
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="so88YhHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbgAYAjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:39:14 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42306 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbgAYAjN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:13 -0500
Received: by mail-vs1-f65.google.com with SMTP id b79so2405735vsd.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 16:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFfIDu+ZSobdf4rbRlzkHFUvjYmggNaKf5YuGI1MajQ=;
        b=so88YhHKwmITpkm/evh74BIniRXSrIxJCKEHRcMsJQnZ+FsTqyqnW0I9tZukfhIVf1
         qQvBtFSTWspj16eqqOhBTeTcs69pNJpwi5/q853l1IXSyjTupgcTUrfYllPGUAt2v79u
         H+0UhRS/pEWKlWGDHoh+C/xHOTtNUvJzkNVocxObxhabEQIo3dMjZqKUMarvvajan2CI
         RWmPwSsKwLY4ORINi/l2UHnyZZ4BhGJFLigghtscevQ1FiCnNFBlRTIUB75BbJG5G0X9
         6pDF8T+XC6srCmFqjyzfY02T8a71FixkWRl7zhfvBDsLjQaSMaMDT1kYjg2wbYER9Wy2
         TZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFfIDu+ZSobdf4rbRlzkHFUvjYmggNaKf5YuGI1MajQ=;
        b=DATTZct0VV81WzR3MJYIwdrutdUq2TNE5T5CwG6HVl2adYJDfF+y+lMXpS7I3bBpLA
         okNjZvyiu466XDLrNXC1Yhu1ucKhwD1byaZQ7E1KHsoTj2h5L1ZuYyO66+7LGGtUDE7w
         ndkHqinynKWUeLUctO0vKualjwZWv7cAVFQ43pJpFodTISQtfatRF/LqcWq1IG3tQdeI
         DHlO1gNOl4FKl+klmky2KJnQ3QGDl6Vg+0q6IQIZg2mRAO9iFO9F6Qf+c9rqnNW+Jpag
         Tej3v1eDhhfzKZuOQsK0NB55tmxoINdZq8wK/F9597N3ZzitFo+v/10zunhy5L66zCJ7
         WU9w==
X-Gm-Message-State: APjAAAXUEr8vOP6zFNkGaHwpI4FvT7k8n+RCe87avnCXr6A85NiopvmM
        5ugQHAKKdq38MgWafzTV0SKj4tDHiySNOdjgLB4=
X-Google-Smtp-Source: APXvYqxP/ECwCM53HaVHbx/sjVktCUAZNiTOYLzRPxCGtom8WPvKGSzy3AIM/kzhHxrpnQTuF9PaStDycbSRmOtBEzI=
X-Received: by 2002:a67:f847:: with SMTP id b7mr4011846vsp.40.1579912752729;
 Fri, 24 Jan 2020 16:39:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579857394.git.bert.wesarg@googlemail.com> <xmqq36c4zi0x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36c4zi0x.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 24 Jan 2020 19:39:00 -0500
Message-ID: <CAOjrSZtT0bX=hhH=OZdA80T_Thgn9drG66xcVMYjo7Q=5Cw_Bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] remote rename/remove: improve handling of
 configuration values
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah, I just resubmitted so you should be good to go

On Fri, Jan 24, 2020 at 4:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> All steps looked quite sensibly done.
>
> >  - patch 5 will be replaced by/rebased on Matthew's work in 'config: allow user to
> >    know scope of config options', once 'config_scope_name' is available
>
> I expect that Matthew's topic would become solid enough after one
> more reroll to name the function back to config_scope_name(); after
> that, let's drop the step and instead fork this topic off of Matthew's
> topic to queue the remaining patches on top.
>
> Thanks.



-- 
Matthew Rogers
