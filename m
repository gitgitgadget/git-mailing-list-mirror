Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64170202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755896AbdGKNqK (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:46:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33291 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755296AbdGKNqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:46:09 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so13585pfh.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FgHGbZ9ThbKQou2UO4ET0HmIOl3txfAnVF3vFPrvMfc=;
        b=JG1XKEuqi1KynRyoC27J2q/lhqXtCT+D91XScphE6PS+TlTIJ8DUrh04bFAuwrdS2l
         ej1hpkomwnnU62j/0DR5qXGSRzKy4NgmdPkJsM/yczovc6yEJrKfy1TffJVHbLoGLQ2Q
         Pkel7uBNbR87BdoUNrvar+3Wj+i1aT7syadOCN8Xy4PK07xp/YgizQbDWcH3iBKNbU/A
         RRRKdJR9xtESV6rU2HUmNU/Br3DESRmPw2tR69jmZVAeptmblxx3b4X4k4OmjGJyC1mO
         DP7RCyLx4JTzZJYvUJf+7KwoR4f1NflJkcCstPM8sgm6tO/jV7OUpLhYOMIw7nd6Dkhe
         Tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FgHGbZ9ThbKQou2UO4ET0HmIOl3txfAnVF3vFPrvMfc=;
        b=EvhAdLXCMjzrQ4xnY5wSFVmcuPVrKwUJVHp+iCz/BlCK9CCHGW5ijLsBxHVYMGLRW7
         Ws/HBFTtKew7z3FBGuf4NZiVulv2eX9NNjLtki04VMjouJzHsQ0bj57GseM/rinrwyAx
         Ly5vo+vpzBxPypmkdia20g46f/BwF/saYUvx9cx405Eaop9+wx8+x6yYHH0gWkKURqpU
         ZCQIWHHY3IwMQd3Dzhjx4oc30BaI8xX3ELvwkGzt/a8elQ0Y6HjItNhR3z56tLv3WUci
         1wRhL695wdBFo1fQXbTFtaGIivzIpm61PuoHZMLBNMi95oPY4MrkoOMHwfav0xXTUX/r
         3bxA==
X-Gm-Message-State: AIVw112hPLqZaCr2V3xAh5H63uFqJiyK4yPi1lzNFG6jMLgyHxUQd/BA
        9amQZofpFJUZ9gbrO0SOm346AuLzBQ==
X-Received: by 10.84.225.19 with SMTP id t19mr23740155plj.238.1499780768659;
 Tue, 11 Jul 2017 06:46:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Tue, 11 Jul 2017 06:46:08 -0700 (PDT)
In-Reply-To: <20170711102451.27r3yaa2mgjgk4qv@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com> <62a5a588d880d1a41d6cdd54cd92ee577a0451fa.1499723297.git.martin.agren@gmail.com>
 <20170711102451.27r3yaa2mgjgk4qv@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 Jul 2017 15:46:08 +0200
Message-ID: <CAN0heSqLX1WNk3KC9U3f=qem0SYV-g=-HU+XHepi_CbuHatCOg@mail.gmail.com>
Subject: Re: [PATCH 2/7] git.c: let builtins opt for handling `pager.foo` themselves
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 July 2017 at 12:24, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 10, 2017 at 11:55:15PM +0200, Martin =C3=85gren wrote:
>
>> To allow individual builtins to make more informed decisions about when
>> to respect `pager.foo`, introduce a flag IGNORE_PAGER_CONFIG. If the fla=
g
>> is set, do not check `pager.foo`. This applies to two code-paths -- one
>> in run_builtin() and one in execv_dashed_external().
>
> Can this ever trigger in execv_dashed_external()? We should only get
> there if get_builtin() returned NULL in the first place. Otherwise, we'd
> run and exited via handle_builtin().

I can trigger it with this:

$ git -c pager.tag=3D"echo paging" -c pager.tag.list=3Dno -c alias.t=3Dtag =
t -l

where the alias is what triggers it and the two pager-configurations
demonstrate the effect.

> So I think this hunk:
>
>> @@ -543,11 +550,14 @@ static void execv_dashed_external(const char **arg=
v)
>>  {
>>       struct child_process cmd =3D CHILD_PROCESS_INIT;
>>       int status;
>> +     struct cmd_struct *builtin;
>>
>>       if (get_super_prefix())
>>               die("%s doesn't support --super-prefix", argv[0]);
>>
>> -     if (use_pager =3D=3D -1)
>> +     builtin =3D get_builtin(argv[0]);
>> +     if (use_pager =3D=3D -1 &&
>> +         !(builtin && builtin->option & IGNORE_PAGER_CONFIG))
>>               use_pager =3D check_pager_config(argv[0]);
>>       commit_pager_choice();
>
> ...can just go away.

If I remove this, the call I gave above will page although it
shouldn't, and it doesn't if I keep this hunk. There's this in
run_argv: "If we tried alias and futzed with our environment, it no
longer is safe to invoke builtins directly in general.  We have to
spawn them as dashed externals." There's also a NEEDSWORK.

Although, thinking about it, I'm not sure why when I remove this hunk,
the child process doesn't set up the paging correctly. Maybe something
related to my using "-c", or something about the launching of child
processes. Those are both areas where I lack knowledge. Will look into
it.

Martin
