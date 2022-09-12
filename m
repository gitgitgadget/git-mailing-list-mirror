Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470D3C6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 21:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiILVSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiILVSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 17:18:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FF45063
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 14:18:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z14-20020a05600c0a0e00b003b486df42a3so2973300wmp.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=S4RLjSO+URqUjSKMKIlJ0zLnSpVhRMuR0nY4qSwBGy8=;
        b=BlGheN3EjEu50XL0naeJ3jdQPIeeiN9sXCPOnGSPL7JZ24BvW6E1cds8zTwf0Z+uXq
         S8oGOXCs2hewA0WgX891mnfGSHNXbj1RyGZ6xfbJyxespQkvdw4ITBCHj7AFUEuBHPe/
         ri9dHKYSVscofK6Isgbk4PZGQxlcIbaKy58KQ7zBDxQvvHA4dOM1HGYxmhEQrRMDqi7y
         ABxij40holjnKyLU36eQTJKh6KQ6+DVezxBIMqwG4FckCcQPtSOEsdA2HeLXFoxcZFC8
         x5312QgIgXqd3csaRr2WtlrFUxu2waYhLH5lK3x6Rnq1kM+Hf1yyG4o1sLj2odJMvtKy
         6maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S4RLjSO+URqUjSKMKIlJ0zLnSpVhRMuR0nY4qSwBGy8=;
        b=Yp8z1RAvcJulnp7l5HgW7v6T1R4LjEHPnFxNX/1475qgh6u8kcoYrczrE/SzjP0flp
         K/gRCWmmu7ePmZ7OzeMRHrcynyjUoZo++5K8RO6ryyG8juxmQYMS4/14c8SReJm2GY62
         7/FUgUjlKuCAFXg+jUMGfqEepfRJt5ZdiU+lecyySE/URLKAr2A6YM7dGivezAWKTMcA
         P0SDoZp1hAVq+BpTKifv/ctiEGMIW+091/q4lTmjOyY8w/ENHxzz9wB1IfvbkCB0UVK7
         aaxLyxwqY0HZRgm57DCw88RSk3NHke5NpfpcLkdZuE5m1Vb075nAkRIDHrt/6WaJSVaI
         13/A==
X-Gm-Message-State: ACgBeo1D+DctCIaUj9aA396LC7N+hlDwMiM6hQGJcGofK6SKONG/c1Ml
        Uam98v3J03HjdBPD+U28kLZ0bSb/tDY=
X-Google-Smtp-Source: AA6agR6gL1+6cu8heEKzdVpYvwi9hMV4mg8FrXdE1yvP6qRHzAlp+A2/ptbnZu5w0bEC9+EZdPC9+A==
X-Received: by 2002:a7b:c84f:0:b0:3b4:84c1:1e7 with SMTP id c15-20020a7bc84f000000b003b484c101e7mr211348wml.12.1663017511495;
        Mon, 12 Sep 2022 14:18:31 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id i12-20020a1c540c000000b003b47ff3807fsm6326699wmb.5.2022.09.12.14.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 14:18:31 -0700 (PDT)
Subject: Re: [PATCH v4] branch: allow "-" as a shortcut for "previous branch"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <dbc0b0d8-4b0a-8d4c-1bfa-8bdcd99310e7@gmail.com> <xmqqedwgfpkr.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <74f12788-154a-d5f3-bb81-a00e7492e99f@gmail.com>
Date:   Mon, 12 Sep 2022 23:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqedwgfpkr.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> I am sorry that this is now at v4, but let's not do this.

Fair enough.

> Thanks.  I think your other "git branch -d @{-1}" thing is sound,
> though.
 
Just to be sure. I'm assuming you're referring to the patch for the other
branch options: "-edit-description", "-set-upstream-to" and
"-unset-upstream". Routing their arguments through strbuf_branchname to
allow the expansion of @{-N}, @{u}...  Option "-d" is fine with this.
Otherwise please let me know.


Rubén.
