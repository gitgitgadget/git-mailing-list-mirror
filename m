Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF558202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 15:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbdGGPPl (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 11:15:41 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35613 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdGGPPk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 11:15:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so4453435pgc.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8UUp4uFhfL2W7ccphns3wAMyIyTO1xSOpNnR4gVMkzA=;
        b=LATiF1bh+NYkhh4llZP6yQ2BHmiaXqdDcvrTR9jD0YdbPJd03FVWW/5UoMsUPPxuX/
         SpDlgknkoxnABtJ/7z99QugT8utsGQsSc91tyEea3AOgjRVUbSJbDL1NkXSbYGiMHED8
         q2G3HkkxWxl/UVsXinOKiV0xPP1xkSg4wR9b7VcAYXtOu05izN7fE9xcEFKYiceQYjhk
         SknaSBKhxmka0OK5wYxE6aXpfTuNh2JMSGuMoJg2OvsCflkmsOjGCe8Ds9lsxsws3iAN
         X1CPG5Jy9WruvzHR7bGx+Jq2fC+w85By+BNeo2kzvZqUq817aTJH4OchALe3elmS5fFn
         gxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8UUp4uFhfL2W7ccphns3wAMyIyTO1xSOpNnR4gVMkzA=;
        b=ZqiS9Fs2dL2GsUfQBE+YhL7JHHymY+XvlycOxERFGJMSKXTv8SuIvVOYrfzVGXCAEI
         bYDQC3fuyi3/ZIujE49umB3AJGl6cLk2lNDsEkv/qGcm4wxz0Urm4BkmbtDAPcDP2+s7
         G/lT3QsxJH4DgBqQdhN22DdAcGFiEbF+cmuS8pfxIDEQsR0CvvW+5SvAJyUSvJuGOUug
         wORCKDrgHNwi1hnJ3p2FFEaPFmOQgDEmB5Gba8fvxYAGbncvUPKDmXozglSYOVYBp6At
         2hHfDWYhIfl5KC1akYjHm3iQ4i2RMlC65DtvHrX/ZWaCrcp0YIvpKFIniJHb6bbNj+i2
         WnJQ==
X-Gm-Message-State: AIVw112JJc8QTD1IRzTlCTBgQk9pU/htJdY5u6oqIe8SUk5pKX9hPt1m
        g85TLO68GbcX8w==
X-Received: by 10.99.121.1 with SMTP id u1mr2098182pgc.20.1499440534552;
        Fri, 07 Jul 2017 08:15:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id s123sm7513448pgs.2.2017.07.07.08.15.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 08:15:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
References: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
        <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de>
        <8760f4bmig.fsf@gmail.com>
Date:   Fri, 07 Jul 2017 08:15:32 -0700
In-Reply-To: <8760f4bmig.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Fri, 07 Jul 2017 11:54:15 +0200")
Message-ID: <xmqqlgo0cm7f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Which is why I think we should take Francesco's patch (with fixes from
> feedback), instead of Junio's.

The patch in this discussion is not meant as a replacement for the
one from Francesco.  It was meant as a companion patch.  

As I view the form of the option that relies on the stability of
remote-tracking branches strictly worse than the honest "--force"
that loudly advertises itself as dangerous (as opposed to being
advertised as a safer option, when it isn't), I consider the change
to require users to opt into relying on remote-tracking branches as
a prerequisite before we can recommend the form as a safer version
of "--force".
