Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2941F404
	for <e@80x24.org>; Fri, 13 Apr 2018 22:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDMWXe (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 18:23:34 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:37514 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeDMWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 18:23:33 -0400
Received: by mail-ua0-f172.google.com with SMTP id d3so6410677uae.4
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CsaIR6o0FneVhTfJYfzIRqF7Y1DLuXTWlMJNoQl+5kM=;
        b=bn/z5FBmW+sGIWxfGCe7+qZbVCTVKF7WEDXzHoJjmC466Fy/jpsWh/SjYerCOWb1gi
         sJNacmHXagX4DI612GDHiKWgJ0E1uVLbDSyKKnK/X14JhvpETdtfmMub0Tg9bmJy8V0z
         WtYEcBj0pstsEweufvRh70AYTnEzBNmF0vXbVyp//3Z4gsDuMu7Md1Y6nbM/pt0qpYfd
         0IG3BXc60swVTMOcgyhcXo3M+guJeW7XlSgq3jPEJFQjSp1DFMKo4cGjfXeKOro41xhr
         UJbp2OlRUjJcL1N53x8rftAO/56brzRXhQjerYl9QF4B3T+xB4Or/7TkqmAwZNgkBZRm
         H6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CsaIR6o0FneVhTfJYfzIRqF7Y1DLuXTWlMJNoQl+5kM=;
        b=ajAR/iv3d1VnoMKL4MBD2QJgw0ilTaK151Y/RA6JlGqRnBnu0Pdis5FWv72i+UFDoq
         zpbgAZ7vq4yO7cSSlWfIDxJIkOWtUhDSYgmoA9aGJvVY8d2HkzQqV/Hq194itweH6Q/2
         TEGGafrd2vXEUteilCxBLHCd7OL7qUD9XoS6yQ24piGG7Eq/eCiwk4IQYub+XshjBf5d
         KQ0lVFucpWSXv+ZLFmfpbUX5NxNtPWvUAAVwiByhnhKp+HNnNvkKFTn/d0tSq3ojv3da
         p893/fu4j8x1rDbrQqU5Vs89Zts6rE3kiYZxokvnQzSfqJLHAxkn2Dim4TIYcr558M2N
         +vsQ==
X-Gm-Message-State: ALQs6tAJNnEov8ZPwfgs6k359Ruq1F1iz55WXaJc9JPJzdhjAAUOtham
        uSpieYYdpT+KwoYcSsbMdznbt6/D+ksb/y1g4L8=
X-Google-Smtp-Source: AIpwx49lsXtd/BRM4A7m8vVRhfEulOdcN/Jr9Uwj7Vnu18ZF7t0r/s7G56/JnjGW49liK5KkKuWiStbIQU9RIVNg8e4=
X-Received: by 10.159.33.227 with SMTP id 90mr5573043uac.48.1523658213037;
 Fri, 13 Apr 2018 15:23:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Fri, 13 Apr 2018 15:23:32 -0700 (PDT)
In-Reply-To: <86604un5mz.fsf@gmail.com>
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
 <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 14 Apr 2018 00:23:32 +0200
Message-ID: <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com>
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 13, 2018 at 11:44 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
>> builtin command, which lists the same variables, but without a
>> pipeline and 'sed' it can do so with lower overhead.
>
> What about ZSH?

Nothing, ZSH is unaffected by this patch.
