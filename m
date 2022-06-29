Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0DC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiF2Mki (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiF2Mkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 08:40:37 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7402A977
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:40:36 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id t16so24579554qvh.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zRuQuzbz+YHuBd77D6Js1Wd6U7AUZBwzCVuuDfYtm94=;
        b=YEUp8mAR2D06sPspRGm/y1954YwxkxowjHNQEJo01VL4fJjyQVIkUX56zN/AQFXd+8
         NYO4sXz1sIk9+dpalfqo8DSX1xwwDmRHbuKMr6NOiUEZ37Sjp0BuN6sSANGdQg8X67A+
         SweWLO5rr456RDbtd8ZIzoUj0xP9nJcz0oPwPIBsZ/G9o3nnocd+6Bw9v1CoQWfIQiUl
         ZDmuaw6H0aLd3f1HW39zPyTcYyk3A7MOKIdIy7XOxhP5IL30ezVrMiuW+Vj0D4JpjexD
         /NhoFBtgDq+Y+e0p+SII2UNGoOiiQUCGNgAV6ZuhVlpehoKGt7XzDZCNwNNEb0HZtwki
         ySAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zRuQuzbz+YHuBd77D6Js1Wd6U7AUZBwzCVuuDfYtm94=;
        b=PYx0XM5Al61fTa4ODMFxBM9GQA8aLNzdiIrKZf8Aib0ykZMUlrbabMPkRbgwqHGJK3
         69f+1DWVCZ34RTYmdp/TULxXo0k0Z8DJsdRHgEhViB38BbzLls7yF+u76teBnPn+8UXp
         c/AH5Y99x3ppUNxrp3KnJQncULCP7OHtkLA774gGAhlreFnXgXDtrl2Eabs2f0W5RIbD
         tD5mZOwGn/t0Yk2FXeqHDDtDWTahoDEvPsjwQuX9Uqw/Gi8sZTuId2x7wyWbl6gf+TkX
         DBMlWhZLlWsMWo+PV94pI61wE6DNBDu9t2KuGf4zuZOxbp7B4ZtK+yJQdKMLxVZQ/h3z
         229g==
X-Gm-Message-State: AJIora9xedEo6mjiwOkH8FSM4SJom+J8BGn0gAnXPEN6FWxIiuoHP5Vf
        ljrQj7og3YgvpHLe1vUNajX8xTqGx0jg
X-Google-Smtp-Source: AGRyM1spaI7kwBA2/PCSaEHG3SdNa30KUK7cqtkE/4hKyexIZQT/E2DvUIqk3bc4cYc4r+3yzjDWtQ==
X-Received: by 2002:a05:622a:1992:b0:319:cb47:b3a4 with SMTP id u18-20020a05622a199200b00319cb47b3a4mr2270547qtc.472.1656506435751;
        Wed, 29 Jun 2022 05:40:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id cm10-20020a05622a250a00b0031bed25394csm3445326qtb.3.2022.06.29.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 05:40:35 -0700 (PDT)
Message-ID: <c8f38fcc-09f5-3dcf-02bc-58d51de6a156@github.com>
Date:   Wed, 29 Jun 2022 08:40:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] git-rebase.txt: use back-ticks consistently
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
 <xmqqwnd0h30t.fsf@gitster.g> <6f229f4d-8ce8-beb5-e27c-2ea244a634a7@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6f229f4d-8ce8-beb5-e27c-2ea244a634a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/22 5:31 AM, Phillip Wood wrote:
> On 28/06/2022 22:49, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> @@ -537,7 +539,7 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>>>   -x <cmd>::
>>>   --exec <cmd>::
>>>       Append "exec <cmd>" after each line creating a commit in the
>>
>> I thought `exec <cmd>` was an improvement, just like ...
> 
> I'm not so sure, I thought we normally reserved backticks for command line options and this is talking about what gets added to the todo-list. I could see "exec `<cmd>`" being an improvement though. There are several other mentions of todo list commands in the documentation and I think they are all double quoted like this one.

This was my understanding based on the v1 feedback. I think it
would be OK to consider this change separately, perhaps as an
example case in a "recommended doc formatting" document.

Thanks,
-Stolee
