Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD419C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 16:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiJMQ76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJMQ74 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 12:59:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC4718B2A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 09:59:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so5245109ejc.8
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wX/+Knh4vFPqlSe0m1Ggz60SulVFFC0QcsVIJXmAv0Q=;
        b=PhBWsEcdlX2G+dBZfyVsJtvTD/6f18sr3hWr9LHnPhXeTc9vDp28MKK9PD+oiLMDoB
         YBSeJtso2eNdFTZX58Vgk62KzIFnSC9W0ov1VlOydi9ohdB3jnXa0q80TbyoGbxaio/4
         vt5igCx9qiRwrwmkzgpHuQ+2j9fIMPBt90vpyIAVO86kTCkkit2CaGsGvJHRG/M1/SkP
         dXGQfz4gxNLeK14Ai31mREjZ2b7CEUDHecCGCeybZ+79LjkxEzaqn1Hv8K011DXa+Z0x
         BD51PqohGERbxQZyB89bsPRl3LkArJLdm4v/2A+aPq5M++bu5dtwuRanjwwcQ6YgjovF
         ONXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wX/+Knh4vFPqlSe0m1Ggz60SulVFFC0QcsVIJXmAv0Q=;
        b=eS02E2lNQMneiKhr27o5crsR5w5TMtLd6JJD4hVpeF+Hnjbzb3pDGqeKXpQ47pI60C
         7m+yg7SbBQAvMJo73O+zX6LC/9B9My+LJfGPTcuG2bdXA+JgU8MRrlGOCvzuF48l/z/3
         3t2GU2tZyZIdBiQb1n6p+5itN3uTWo8pdw01LT4fKGVycZEJrdBUiCAaZsMeRCJooLAj
         zXrwmMnX0XwDba5XSZ+d6Y02jWEpKVfxuEoXsgNEerfOxxjR4YqY6Rc1B2BYpp8Vi7uX
         mlXCnjMjU4m3tGM+2S/mHvsa/0Fmrv01u2PrtxVvzSB9D4yO0urBfU5vAjtD4va+9AXt
         TLuw==
X-Gm-Message-State: ACrzQf1g85gVw6y4A3ragpELIj9usIDWIJtGLYN+JM6SZQC6cmYsJtFc
        g/uVx6jcsnIxmNsJYn/VoZs=
X-Google-Smtp-Source: AMsMyM6CzhUMvEpl8lUdp7cmC4DQktERujMBL9JLcT4ku63hT4satF4lroDJa8Af2gQozvRbCxOFTA==
X-Received: by 2002:a17:906:3e01:b0:781:6462:700f with SMTP id k1-20020a1709063e0100b007816462700fmr506575eji.307.1665680391202;
        Thu, 13 Oct 2022 09:59:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906944500b007262a5e2204sm100641ejx.153.2022.10.13.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:59:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oj1Yj-004uJ2-1a;
        Thu, 13 Oct 2022 18:59:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
Date:   Thu, 13 Oct 2022 18:57:44 +0200
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <xmqq7d14k9uh.fsf@gitster.g> <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
 <xmqq35briuel.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq35briuel.fsf@gitster.g>
Message-ID: <221013.86k053lkvu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> In apply.c's parse_fragment() we seem to only care that we find a
>> "\"-line that's at least the length of "\ No newline...".
>
> If I recall correctly, this was done very much on purpose back in
> 2005 on top of what I and Linus did originally (which was specific
> to "No newline" written in C locale).  Because the input from "git
> apply" may not necessarily be the output from "git diff", and in the
> older days, "git diff" spawned platform "diff" to show diff, it would
> have been subject to l10n.
>
> With GNU diff, I can do
>
>     $ echo -n one >/var/tmp/1; echo -n two >/var/tmp/2
>     $ LC_ALL=3Dja_JP.utf8 diff -u /var/tmp/[12]
>     --- /var/tmp/1  2022-10-13 08:40:55.393209930 -0700
>     +++ /var/tmp/2  2022-10-13 08:40:59.269538397 -0700
>     @@ -1 +1 @@
>     -one
>     \ =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AB=E5=B0=BE=E3=81=AB=E6=
=94=B9=E8=A1=8C=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93
>     +two
>     \ =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AB=E5=B0=BE=E3=81=AB=E6=
=94=B9=E8=A1=8C=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93
>
> As it does not consider a file that ends with an incomplete line a
> text file [*], I do not think POSIX says anything about lines that
> begin with "\" in the "diff" output, but I would be surprised if GNU
> patch (or anybody else's, for that matter) did not ignore text on
> the line, because all of them must be able to parse the above
> output.

That's really informative, thanks.

>> I wonder what (if any) compatibility issues we'd have if we emitted
>> e.g.:
>>
>> 	\ The filename pointed to by the symlink does not end in a newline
>
> While I do not think it would break anybody, I doubt it would give
> us much value.  One line above that output is a line that any user,
> who is vaguely familiar with the contents being compared, can
> recognize as giving a pathname, the contents of the symbolic link.

Clearly it confused the initial reporter upthread :) I'm not going to
pursue it, but it seems to me that we're being sloppy here in including
a message that makes more sense for a normal diff when we could consider
the mode(s) involved, as it's not abnormal for a filename to be missing
a trailing "\n" (having a "\n" being the odd case).

Anyway, I'm not going to pursue changing the message, but maybe if
someone else is interested the above compatibility notes would be
valuable, thanks!
