Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CEC1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 23:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDKX25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 19:28:57 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:37238 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDKX24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 19:28:56 -0400
Received: by mail-wr0-f174.google.com with SMTP id l49so3324170wrl.4
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sz9ijSERpE12hz4vMV0x8sVNs6eUetQk+6oYBZcUtF4=;
        b=MsB4cHqfgmEJKHd74JWE316i3EiO1xgL0j9hs1fimui3Rmhg0GimLA5dAh/1womwdy
         2LAdNbc2CgOlG7kfAI9OjNd1YAXGt7jbvcHSEZwdZEnvY8f46JeG0/oktCawZAszz5pW
         rudXkHXtqB5OLNUqk3E9l7Ex44TDvahl2U0OAdcJExWh9ZiqwPPQ83LEdtsXMhIj7EXO
         HYB0/w4t5GhAxfFjA4+z2ok9/7RLia12OzRzQj0PFXmZvd2QGjhtS6AIMl183vet6NSu
         sJ9wj54l4D5/q9I00OK8uXgK2uZVBGK+m6SNi8782KvLyThXsh/GOlaGvonWYeCcNIDy
         ebvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sz9ijSERpE12hz4vMV0x8sVNs6eUetQk+6oYBZcUtF4=;
        b=DvfCvu/Ve894dD6HDCTnr6EfntBvBCNsbeLYtBjcrMWqo1Auv5J2HfWpUBlhhS7rQp
         c21Ux8djVpFyOTPtgbjCyQgiWUFj2pDVY60sFkv5P4n7OmCqMjvqv6bt0O0dXsWY4lkm
         TAtZDiQgpL84VJIuVopR60DctReTp4Ec+x/sY/2qTWYW35p2y28/vMZ1ZO+hxPKZXt/F
         J6KSLqQ6D9Ue/PL5Dp+xrmKANkdv1kvnY/nYpK+nncYhWr+S0XZl2sxQC6dZgTLJ9p3B
         RGaoq2anVaxslkLN/h75WJPXmo76FSi+Tg2/3VW0gEgd7Nfk1qb7i1EpRCF41ZzBDg25
         AhDg==
X-Gm-Message-State: ALQs6tCi1hIj22tEGziNpGB8hau4an15L2MkQuDuRIDlLynu1K7n5lzZ
        ge/IcjHvsZIqbvG7bpPWf78=
X-Google-Smtp-Source: AIpwx4/jCRheVoipHK9XMR9byeuhIHM4NiGiHTHiQYHUWemHjTXMjP2mui6Q5+M35ZNdC9TSkI40OA==
X-Received: by 10.223.169.232 with SMTP id b95mr4858821wrd.96.1523489335107;
        Wed, 11 Apr 2018 16:28:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t76sm3850471wme.17.2018.04.11.16.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 16:28:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>
Subject: Re: [PATCH v2 03/10] commit: add generation number to struct commmit
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180409164131.37312-1-dstolee@microsoft.com>
        <20180409164131.37312-4-dstolee@microsoft.com>
        <xmqqefjmzd67.fsf@gitster-ct.c.googlers.com>
        <01c8d95b-e444-4b69-f083-9832023978a0@gmail.com>
Date:   Thu, 12 Apr 2018 08:28:53 +0900
In-Reply-To: <01c8d95b-e444-4b69-f083-9832023978a0@gmail.com> (Derrick
        Stolee's message of "Wed, 11 Apr 2018 08:57:05 -0400")
Message-ID: <xmqqy3ht2uh6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> How about we do a slightly different
> arrangement for these overflow commits?
>
> Instead of storing the commits in the commit-graph file as "0" (which
> currently means "written by a version of git that did not compute
> generation numbers") we could let GENERATION_NUMBER_MAX be the maximum
> generation of a commit in the commit-graph, and if a commit would have
> larger generation, we collapse it down to that value.

Sure.  Any value we can tell that it is special is fine.  Thanks.
