Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F8C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 13:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjEJNkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjEJNkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 09:40:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C9130
        for <git@vger.kernel.org>; Wed, 10 May 2023 06:40:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso8195886e87.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683726037; x=1686318037;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58LoSHALH3Ra5MoQBovAIyJKkJxU0VcSfXFqqIJSZpc=;
        b=GoayVY3WGsy4+swA3MIBnMeFJqIpuHMl8lC6J59dO+a8AP7J/r/5wV1unXvrkQlQko
         0AeblgLnIlV7ob1n2FFGDLPtZyP4MKjrtq6p4yx4NfnZVnMaatssFWB7BeV40tpXeJmn
         CYXSAah7obxX9rfMrYbbN9rWE+wYlzUk9aoLlZq9UdloBXSfAOzbGC1zkUNSbc26gKbb
         AHqTpS4Yc0VSjG6rBYzx/cGV68m0WEkmQO2VF5rm3CVkE1stZ9ssE7NB00L+TF112MRQ
         aTZGmbg01MEvP0d1/KTErOFLwYrkMD09mjy/64dFitkMtBtSv/PU5Byx+dEuqFU/9aHu
         x0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726037; x=1686318037;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58LoSHALH3Ra5MoQBovAIyJKkJxU0VcSfXFqqIJSZpc=;
        b=BjpVI0AabX+9XJ1y7jJ3c9xfukgTeB5SgxhlF4eNFzy3jMIQIknO57eSrvBSd2Vz2k
         6YKCivKbyX5dmzyfJDFB/ErCc+rrWsTYL7jPmxEM6NxlJW3yBhS9qiSt7+uIzompyEYF
         Fsgugf7hAKrk/X56zIXKEFERXurZAKFlZUU6yWzvWsohA6fnjaixlW96Bf7i8VfMO7X2
         CYNSba2QJqfBjW0AL5Y2pcO/olD3d9DcyxReazuE3YVk5ky17aglSTqdePVhESBXATjd
         alVyVfo5M3/8n7H+BZBdPI9EEjbshY5L9DTZViztlihZXkwWeIwI02tk+WZebhrXwpb/
         gxdQ==
X-Gm-Message-State: AC+VfDxJqziZg2ut6zAYi1h27xn81LczpB3UaSE8GyapvUPWnlo2f8zn
        2mhNbaK+UO7WkCXrQLmygSiBTHvPEnY=
X-Google-Smtp-Source: ACHHUZ78244FwnLO2FT1/JKfMPjSFRiSfx7t88YRFMrRRtcip0AtDoVsvzLW67ajzPRUmyptZECMyQ==
X-Received: by 2002:a05:6512:946:b0:4ec:844e:7b85 with SMTP id u6-20020a056512094600b004ec844e7b85mr1843778lft.25.1683726036855;
        Wed, 10 May 2023 06:40:36 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x23-20020ac25dd7000000b004f150011dafsm738861lfq.265.2023.05.10.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 06:40:36 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <xmqq1qjwj7go.fsf@gitster.g>
        <64599cc234708_7c6829426@chronos.notmuch>
Date:   Wed, 10 May 2023 16:40:35 +0300
In-Reply-To: <64599cc234708_7c6829426@chronos.notmuch> (Felipe Contreras's
        message of "Mon, 08 May 2023 19:07:14 -0600")
Message-ID: <87wn1ggv8s.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> > Sergey Organov <sorganov@gmail.com> writes:
>> >
>> >> --patch followed by --no-patch is to be a no-op according to the "git
>> >> log" manual page.
>> >
>> > I briefly wondered if it is a bug in the documentation.
>> > ... when "git log -p --raw" shows both patch and raw, I do not
>> > think of a reason why "git log -p --raw --no-patch" should not
>> > behave similarly.
>> 
>> So, to tie the loose ends, "log -p --raw --no-patch" and "log -p
>> --stat --no-patch" do behave similarly.  Where my reaction was
>> mistaken was that I did not read the manual page myself that clearly
>> said it is the same as "-s" that suppresses diff output (where "diff
>> output" is not limited to "patch"---diffstat is also output of "diff"),
>> and incorrectly thought that "--no-patch" would countermand only
>> "--patch" and nothing else.
>
> If Sergey, you, and me all agreed on what `--no-patch` should do
> (without reading the manpage), isn't that an indication that that is the
> expected behavior?
>
> The fact that the documentation documents some unexpected behavior,
> doesn't mean it isn't a bug.
>
> I would say it's a documented bug.

Yep, it is. Chances are this will end-up in the "won't fix" category
though, similar to unfortunate '-m'. In which case I think it's better
to explicitly mark it in the documentation as such: won't fix.

Thanks,
-- Sergey Organov
