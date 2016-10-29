Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A0D2022A
	for <e@80x24.org>; Sat, 29 Oct 2016 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbcJ2WkW (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 18:40:22 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35328 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbcJ2WkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 18:40:21 -0400
Received: by mail-lf0-f48.google.com with SMTP id f134so75102242lfg.2
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9WKYI+NzsLMlxHlnNIn6Gw0zxZJjaPIkDIBTYN91sns=;
        b=Ypp9Msypk8DoNH1SDmSnZdP0sYPOAMF3mpNWW044vZk+o13i3UjiCttRXvTuzSGj5q
         eI9u8djHWoYkWny/eCzhAsPQH+pPpm5KWLBXWoc7ILKPM1O2/DhJEOFp7rFDFpoHbbHJ
         1RyFdBgd/vJnWWf2/zloY1YBlZlqbtqn5MM6oHGQTzHvohh1K6yuJ3d2Kgpp10XFt7HZ
         OFjX7NSbAGNcRrZTyWh5fyUpHhOnvCJBVNzvsPPhcBCCI6UIHOSxWuxpgtvttkf9E72k
         tJzOYH+01u1o/aylRn1+/p1zQNPMrk402+7vgT6zYzjH1jobzq0tVqrTRGqRl+hz+ny9
         CMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9WKYI+NzsLMlxHlnNIn6Gw0zxZJjaPIkDIBTYN91sns=;
        b=j/woj8N9n+6n22wBciapc4UrybNmLiH7nGc7eK02TtXHvEJlPSqeVu6Ic9ZCNyEkfa
         zeei29Qjd1oKIdvzlN1zGTF7mNrdzZY4L5ITU8emUpfFwaD8QjVQowN3vLEFbAk8Xbkj
         TDPfZwV3H3OeOF8/2Bp3aJvbnqb6harH6THShB7tDXSfd/HlOuCWTrkqsma+Qod/MwDe
         qWuL8rjMpIvhrt1VPt2zJPuR5biUfqlWdnCot0aipaE2eVw4ocJe62HHbzWQTwecy1U3
         ZRo48qh2uw5xJ/5wcsE/+SNug3fuzzOAanAMFHkgpNNH1C92e8SUoADaq7sXUIDl2Xge
         Oe7g==
X-Gm-Message-State: ABUngvfsN4FxNT+LFfKlcyjJ9HVdp73eceXxDfBzOcuV6YnTGHhODnJ7CNGUPzb1LQvEyD3zPSB6wlB9s7CBSQ==
X-Received: by 10.25.24.39 with SMTP id o39mr12169354lfi.151.1477780819921;
 Sat, 29 Oct 2016 15:40:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 29 Oct 2016 15:40:19 -0700 (PDT)
In-Reply-To: <c30212bd-c454-f1a1-d01c-d6a12d20d17d@ramsayjones.plus.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-11-chriscool@tuxfamily.org> <c30212bd-c454-f1a1-d01c-d6a12d20d17d@ramsayjones.plus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Oct 2016 00:40:19 +0200
Message-ID: <CAP8UFD28w6+kzsq3wdu-iKfYsLc4w6kNVj0Fk+aB6d3g3AoUzQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/19] read-cache: regenerate shared index if necessary
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 6:07 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>>
>> +int too_many_not_shared_entries(struct index_state *istate)
>
> This function is a file-loacal symbol; could you please make it
> a static function.

Ok, it will be in the next version.

Thanks,
Christian.
