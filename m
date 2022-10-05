Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48098C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJEVVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJEVVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 17:21:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA855AC45
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 14:21:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so3146934pjo.4
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNCv4S5r6SvIRiuWa54YxUZoRwxP+OUW/zxE4Edbaoo=;
        b=gooqvvkHylQv4dURKQ76BtETOVl/qI3+geBdkb/uBguz0++r3UuLEECNizXoJDYaSl
         IQegeXzJqDV1T1nDaAl8C5jxCPucme5v30YHRqgazJFgbXN3jocwTHl+z7cvuN533pAB
         9Ejd/yV2pVajnzPGulGbjKCQuzbgnspcJEYV0B/yWHkMrLAeLiiA0knJ9WyFQszAxjUB
         E7fGAtad1lhAgpkjrgsFI8VdFHNUMDD2QnjsZEd1N65k+ItcraF1zgnxAj7pI/8LNDpp
         fCIt4xCGy92nvaMFHKxEBki9jV8SBAwRbAMa5V2mVl6H0YvtZ60ACeOYPSJD8xb6NmY0
         6NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNCv4S5r6SvIRiuWa54YxUZoRwxP+OUW/zxE4Edbaoo=;
        b=2w07/RATKME0LHjHI5guRE3Do63QxR3zeyUm72q3gnV1fyrTparhxvizKZ3Qh2q4+W
         rJJ+RoW1v8kfaLnO7tv7NhFo8lJ3pfB30QJIDn6hfTenBvYPmy06F6+URMok25m3KlAW
         AFWlbWv5jYrESk3nRFvb12d9koSLyXiIxgE6rTDiIgi1VF0S75FrqK/sxUTRakQUvDCa
         kr5z6mgSlaz7tE7Rvh+WV4tuwOY3w5VDtsFX1d8U8F3tUxccOPpyDcjpOXYtyk9+/W2W
         RfdACcBAjEWAkPQXiUb3kQJQNn9sKgnpa1hn/KHhtr9RseUECVBl74UUuuxx86QlwnWm
         IVDw==
X-Gm-Message-State: ACrzQf2nYqaA7zpz1lS6T77T98NFYjm1Si9EjwLi8pziWDDFOFHIx5Fa
        sWn5GTAtL5z1pD45vpBoK7K6uK8JZS0Euw==
X-Google-Smtp-Source: AMsMyM5L0EsFJGZyK60+/rJLNnyoI4Ww1IOTL/r7jmZ+yU6wgrXXu47sqyK81Js7BEmShLa3+BSSvg==
X-Received: by 2002:a17:90b:3ec1:b0:203:7c2a:af00 with SMTP id rm1-20020a17090b3ec100b002037c2aaf00mr1658734pjb.246.1665004871298;
        Wed, 05 Oct 2022 14:21:11 -0700 (PDT)
Received: from localhost (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id e29-20020a056a0000dd00b005625f08116esm643136pfj.68.2022.10.05.14.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 14:21:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     darkdragon <darkdragon-001@web.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: Install-prefix when building should not be hardcoded
References: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
        <YzvnadnAYce0dIpi@danh.dev> <xmqqczb6oyie.fsf@gitster.g>
        <CAAOCJVAAwgECsJPfm7eHOMmKPewJzxHTKhjwacxPRYWJkSpX_g@mail.gmail.com>
Date:   Wed, 05 Oct 2022 14:21:10 -0700
In-Reply-To: <CAAOCJVAAwgECsJPfm7eHOMmKPewJzxHTKhjwacxPRYWJkSpX_g@mail.gmail.com>
        (darkdragon's message of "Wed, 5 Oct 2022 22:23:40 +0200")
Message-ID: <xmqqpmf6nf09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

darkdragon <darkdragon-001@web.de> writes:

> On Wed, Oct 5, 2022 at 9:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
>>
>> > On 2022-10-04 09:38:24+0200, darkdragon <darkdragon-001@web.de> wrote:
>> >> Even though in Makefile, it is stated that git will figure out
>> >> gitexecdir at runtime based on the path to the executable, there are
>> >> many output files where $(prefix) will be hardcoded. Even git
>> >> --exec-path will print out $(compile_prefix)/libexec/git-core instead
>> >> of using run_prefix.
>> >
>> > I'm not sure about this part.
>>
>> Perhaps it is related to the use of RUNTIME_PREFIX (which I don't
>> use myself)?
>
> This seems to do the trick! Thanks a lot!

I guess somebody needs to send a patch to the Makefile to clarify
the comment that led us confused in this thread.  Volunteers?

Thanks.
