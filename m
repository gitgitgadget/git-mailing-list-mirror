Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6851FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932606AbdJ3R1t (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:27:49 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:48137 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbdJ3R1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:27:48 -0400
Received: by mail-qt0-f181.google.com with SMTP id f8so17382559qta.5
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mCDJxhqFkdxzxxUmuQQLcJRPX7KEozFuQigJ4VjobHs=;
        b=GrUwJOHTYQ9CGTVc/f70MOY1RN6B0q9xGSmtRNxcAI3K7rqhk037vjUV52yeq/7Aao
         QW5rcuaEcZ5Jvkev8/SEnlGLjRFXZ1tv9bXgwhFedRFyRzznZNmJqnAOWX2meg/KNMFv
         GLyDeN830P8HXdxdjckJgwLakn4cAfkv+HaYK02aGmAr3cLbF44PlKCMaE9atLp5Kl0J
         iYL2cdK1CJxbVGjCdj/qW1wfLgP4kMkOFYbp6r6KtRIvFMdxQ3Tnzb1AbNQk8gGQMOZH
         tFTNI248VWnYX/XTA3utrfE2PaUb/clo7BVPB44unrXdxYnDqZS6RmbMEMw1rBY/Sa1F
         mkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mCDJxhqFkdxzxxUmuQQLcJRPX7KEozFuQigJ4VjobHs=;
        b=Zzo6awCqYsl7kiPtg6hlT+/AtA+KRzD/BWExK7YMm9GC+H7whBstvbZAnk5a+dHaFP
         ZAzls50mWffKbKm/i+SoHwPKZw+yANx9u2TKFmQ/RrFe4SAO5+bF7X9fkoIqsTubDorG
         4kbcxSl+UATd4IGEMoKlIX4JZuJFBaUBZFMnkKgrLbd1pA3okAZtDz8n0WFTgRycbKWc
         CYZ/ZFB6HsMW/8Ff6C7KxzGwps3Ieu8AiEouMLW0TjOroArSsmBTFRpKcqgOaauOv1vW
         oiFO2nrusesHgde5ePZ8UTuDE7jTORXl0OrSIsx28u5ObmDPOO+7HoDXsyTww1m4fPwq
         wvXg==
X-Gm-Message-State: AMCzsaXjDeiR1F26yzNmEnKLsRmESiV+KSQtzpIaeseb8C/1xu/p2Dd3
        OZZ7NZ2Zp1li15LWLAB96T1CP8y3rZQ7nnxh4yw=
X-Google-Smtp-Source: ABhQp+SpU8Kz3DKFVgjLuZazUvRPsawBO9DYJNtkq96AHFwFabut1akPlTAGvpCJRJcvr3/aKIHek0meRmVbNxwwmIg=
X-Received: by 10.237.59.198 with SMTP id s6mr15502991qte.281.1509384467703;
 Mon, 30 Oct 2017 10:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:27:47 -0700 (PDT)
In-Reply-To: <7d978e14-2eec-23b9-c25f-e6b361101b03@gmx.net>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <7d978e14-2eec-23b9-c25f-e6b361101b03@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 22:57:47 +0530
Message-ID: <CAFZEwPN2GpFy6r1vRpS6oB-qC0r5ymGB_q0AJWueLPyGj7-uvw@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 1/8] bisect--helper: `bisect_reset` shell
 function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Mon, Oct 30, 2017 at 6:52 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Pranit,
>> +static int bisect_reset(const char *commit)
>> +{
>> +     struct strbuf branch = STRBUF_INIT;
>> +
>> +     if (!commit) {
>> +             if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
>> +                     return !printf(_("We are not bisecting.\n"));
>
> This is weird; I had to look up the return value of printf first before
> I could understand what you are doing ;) I think that it is meant as a
> shortcut for
>
>         printf(_("We are not bisecting.\n"));
>         return 0;
>
> but please also express it with these two lines. (Or what is the point
> of returning a non-zero value only in the case when nothing could be
> printed?)

I was just being a little lazy I suppose. I will stick to doing it in
two lines and avoiding fancy things.

Regards,
Pranit Bauva
