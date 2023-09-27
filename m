Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECDE7F14F
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 23:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjI0XUl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Sep 2023 19:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0XUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 19:20:41 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A244102
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 16:20:39 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-64cca551ae2so70726836d6.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 16:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695856838; x=1696461638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKCANqwPPMXEYj0lMnol/5P087UUDJvWF63xvCp0GSU=;
        b=B3E81y+YiLh68StGIwtioQAhHpxvgVpIaO/mTQjzyFwoM+xFurbJb0fAmrTbV/IP6O
         3ZQSr3d858vXzzkLjhzBzOfioi4dKBqBKTCm03GW8CS5eK7e7WAJMnAke4tn3CCGZzI3
         l1nQ1ju2pdtbvzf6EzbemDoMgwWZ+0Th/RT1zk6wpS8ojCAEtg/RwCtISOmch/yLJ2rK
         mEdlte5nnh2cr3OnxJtP9hDXkqe59Z5SLcuizmzC6/z6csIlHSPCz5xyO8aSigFQiwIm
         ocQIQAFFRsX4lqyGRUHWMyQ5d+Ga4o4Q3II8yC8mARQgnCsBqFyW3kXVzaU2sGYcPhee
         lr5A==
X-Gm-Message-State: AOJu0YyvtH1E+6T9lSSH/Fvv6Pp+oQajQNF9tZkJSdr1UwhhRT3xeyZp
        RiYYfmWNoaUFIBd2D2FFMvITQ0Xqisp5BPZkeAQ=
X-Google-Smtp-Source: AGHT+IExfd3cs7OfICZ0b308SSyt8WjeFSlh279TzTcOPFBk0Om9Vf10XkYFXF5Q9tH93EsdOVuv2c9d45gyxT0law8=
X-Received: by 2002:a05:6214:1a11:b0:64f:6199:a8e with SMTP id
 fh17-20020a0562141a1100b0064f61990a8emr3780042qvb.23.1695856838542; Wed, 27
 Sep 2023 16:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org> <20230927195537.1682-2-ebiederm@gmail.com>
In-Reply-To: <20230927195537.1682-2-ebiederm@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Sep 2023 19:20:27 -0400
Message-ID: <CAPig+cR5mGZ7-4t1YBW-=j3FyWGvBRBN7eogQb1BYiw8QM1UKA@mail.gmail.com>
Subject: Re: [PATCH 02/30] oid-array: Teach oid-array to handle multiple kinds
 of oids
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2023 at 3:55 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> While looking at how to handle input of both SHA-1 and SHA-256 oids in
> get_oid_with_context, I realized that the oid_array in
> repo_for_each_abbrev might have more than one kind of oid stored in it
> simulataneously.

s/simulataneously/simultaneously/

> Update to oid_array_append to ensure that oids added to an oid array
> always have an algorithm set.
>
> Update void_hashcmp to first verify two oids use the same hash algorithm
> before comparing them to each other.
>
> With that oid-array should be safe to use with differnt kinds of
> oids simultaneously.

s/differnt/different/

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
