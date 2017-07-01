Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46FBB20209
	for <e@80x24.org>; Sat,  1 Jul 2017 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdGAUMw (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 16:12:52 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38538 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbdGAUMv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 16:12:51 -0400
Received: by mail-it0-f41.google.com with SMTP id k192so39932968ith.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bN6UerKUHuNx761e/WHDVK6xTPnWw+klI7MwLeB/BIw=;
        b=EwkYGqW19pu5mJV2CT8Og5Z2Ct3IxIBiCD4uNGAeX2QwpLdUN5uWiRkq/pilsGJvhE
         5x5lBhCnrHDsI5ksMflYLeLzVGnZIF/bIO+yeT5D3rZTRzN5RHxCbMZRWPqOk1th9282
         sZ1B876iV04ZgfPBN97ZQtGCPXBvg+rjTVUFNM6OMOCnUrntKSyyhHMDWrlDfjbi9kHe
         z/Lr70JFgcDzGp+vebYDIDfmcMMvVJztT6Hc3u4jS8f2+v452RYi4XN1QOno2UF8IT1/
         4fBW8YQdjQBRdA99yZfuubIlNjTF1hR95qRSFGX/WF0SRwc77A2vQZUfVh262GTrITA8
         N3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bN6UerKUHuNx761e/WHDVK6xTPnWw+klI7MwLeB/BIw=;
        b=QKruDOly0laAmkukxnktOYFzyMJZvw+maKIPnWa2yYbOoBeDjMraT8UQCFIRb4bMe2
         lFPVA0gPlk5/mo7mdaIfWORxgzkk1Fb63Y8I9qCR8nMeFAkxCSRxJ7eNmit+JvFafgb2
         0ZGqDZAZ/V3dPmCw+pqWW8C2dKmtFGUF2130Y9hGuX+duFWbP1i0OGOhb0tGHCIjxcQY
         gn7SKBnMMi8SvL0iQczP/79dIoQT9Q2NLTphp+VFdrndn0R/QkDp4kR6zdaskMZIOMM6
         Mo/PmzHCXHDh5WpKJ2PRbfoVSui07wV8tenGqla9KeNBicXJURdQVI28t/vBwWs2RvBQ
         1Frg==
X-Gm-Message-State: AIVw112bJi+0kerk3x8mVoEOCSPwqnyzQxRqi2vwa7tGQMbwtGKYA9fN
        Zc1WJIp6u646EssP5E+7bU9sCJrscA==
X-Received: by 10.36.33.210 with SMTP id e201mr2172455ita.112.1498939970720;
 Sat, 01 Jul 2017 13:12:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Sat, 1 Jul 2017 13:12:50 -0700 (PDT)
In-Reply-To: <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
 <4be750af-b093-6644-7f0e-82983327766a@gmail.com> <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Jul 2017 22:12:50 +0200
Message-ID: <CAP8UFD1mec5yf8Xoujw876w+_LsKDZk3dEzL5V1fhR65PkY26w@mail.gmail.com>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 1, 2017 at 9:41 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Jun 23, 2017 at 8:24 PM, Ben Peart <peartben@gmail.com> wrote:

>> The fact that "git clone is taught a --initial-refspec" option" indicates
>> this isn't just an ODB implementation detail.  Is there a general capability
>> that is missing from the ODB interface that needs to be addressed here?
>
> Technically you don't need to teach `git clone` the --initial-refspec
> option to make it work.
> It can work like this:
>
> $ git init
> $ git remote add origin <originurl>
> $ git fetch origin <odbrefspec>
> $ git config odb.<odbname>.command <helper>
> $ git fetch origin
>
> But it is much simpler for the user to instead just do:
>
> $ git clone -c odb.<odbname>.command=<helper> --initial-refspec
> <odbrefspec> <originurl>
>
> I also think that the --initial-refspec option could perhaps be useful
> for other kinds of refs for example tags, notes or replace refs, to
> make sure that those refs are fetched first and that hooks can use
> them when fetching other refs like branches in the later part of the
> clone.

Actually I am not sure that it's possible to setup hooks per se before
or while cloning, but perhaps there are other kind of scripts or git
commands that could trigger and use the refs that have been fetched
first.
