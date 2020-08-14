Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F7C433E4
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6520838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVCx++6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHNOFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgHNOF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:05:26 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D538C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:05:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id q68so2684339uaq.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yumsInUH2qMiNnry75/GqmuZ9/RxQES3oqxXgNg0sJM=;
        b=EVCx++6sHZL3S6mI/lF9swz4WB8BNMa5TPOhERJCrvvs9CQFA6iVuBpirN0zgS4RU5
         2K4eW+WbwKerCI840NIEzoPWSKcWvV31UvGENwtb80usHJPXk1tqZQefyDxTijv65sq0
         sdxqdLfhcg1KMBxe4FOt/xVgP16AVkYeKpD66Y8yJGXBZ7jnFYInXMSE5yqKdGaKWYCP
         E6UAv3I3Sh7ugZeGseXcJeNKq0TE/S8rQklD0PWal4BXlQSuOv0lo4E7MA6QPHNVJrAi
         1ZKoEbUNtKXB6uE6Om8E2IxcRspmWAgXLaP+M/qysvEBRbc+ZMmtNvxqJY/mrLFBUd0K
         t91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yumsInUH2qMiNnry75/GqmuZ9/RxQES3oqxXgNg0sJM=;
        b=Lo4br9xP7PYbJ0QBlH0LecspdO9lvKDIsgg5XFpepDD3pZzo1/Sok5ZiYjSVe2Kdzl
         XpdJvZ5BLDW70bgWFkmxIE0kBs0eNA9HLWLf5uMwLBrGkPa4GAbfw/KJu6/KcKck3LFl
         vlpJcFu9ebQZ/JLJ+JNICkQY1TqwQPkOKSYV0pG22hlSyfY7yCHW0THm+sIJNrx+HiQY
         3rhO73vpCMIvzfTBoZ3t6/okEsZIYINgSASS5ykC4P6z2a6dNAJO18TWwh6kxfJ63aJl
         3jnnwdyNCZma1DD4g4ie22LGsIhrC2nNiaqEKDhMgGJjuXlBOirUgXYuqM6uw8BBmPjB
         OCKA==
X-Gm-Message-State: AOAM530IIXirfoubUPyAvL9BnwOR4r1L3TeoLaYdxKaKR6637McAIqQW
        ZSt6eMUNlAwc3akstpth5xi18QuYZwPGVHyPiVzgRNhBzFE=
X-Google-Smtp-Source: ABdhPJzpQg+IMqh4a+fkaeWg5/PSdiv3Q9YHyiWTt91gmTaX+4bLLw7kYI/AL2hwFmjs2PtMbGY8LcoBxSD9F2trge0=
X-Received: by 2002:ab0:462:: with SMTP id 89mr1448146uav.34.1597413925683;
 Fri, 14 Aug 2020 07:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com> <e811455d55cdb222a85d880f3cf3d5e28a8d4c91.1597406877.git.martin.agren@gmail.com>
 <e9963ef1-cecd-cdf8-a5cf-2be884d8ced6@gmail.com>
In-Reply-To: <e9963ef1-cecd-cdf8-a5cf-2be884d8ced6@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 16:05:11 +0200
Message-ID: <CAN0heSrOyLJ-fpjJMY9tYXjnz5s8tAdcGMnef8WfJBUgAU1f_A@mail.gmail.com>
Subject: Re: [PATCH 2/5] index-format.txt: document SHA-256 index format
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Aug 2020 at 14:28, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/14/2020 8:21 AM, Martin =C3=85gren wrote:
> > -   - 160-bit SHA-1 over the content of the index file before this
> > +   - 160-bit hash checksum over the content of the index file before t=
his
> >       checksum.
>
> If this hash is flexible, then "160-bit" is not correct anymore, right?
>
> > -  160-bit SHA-1 for the represented object
> > +  160-bit object name for the represented object
>
> Same here. The later instances of "160-bit" were dropped.

Thanks for pointing out these errors.


Martin
