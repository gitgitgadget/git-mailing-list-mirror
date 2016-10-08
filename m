Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1A020986
	for <e@80x24.org>; Sat,  8 Oct 2016 00:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbcJHAcn (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 20:32:43 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35033 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932714AbcJHAcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 20:32:43 -0400
Received: by mail-io0-f178.google.com with SMTP id i202so62400153ioi.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nobkAmo+aZjqs2y4lL6YMzGxFlhbTukwFQBE1ocWdeM=;
        b=jyvZheagFCdsPf8WXJXsftkh9HCAftbWT3jhFhIAHIXTLsBXaM0sVPA2uDOIJf1xrf
         0vUpwjWpudkkbBKj+yHR6UJFOg+fOzEJnnml+bbIBrepfWDloBiuZjfld5PeSAvX92w3
         7B82TjC9Cpl1I0U5pDlWtJbIYX3aiYND47xJxkPk8PSjw3kvzqxtKhY96j7kN6eP67A1
         CqbtRKi2zDRKryASn4ec7xTeMPomx4ZRX685HQ0x1AhxlRQLcqyHQ/mYHl6MjZ5FsMke
         QjK88EISxUE7pFsswcy5T7vMXU6g0LTc746JSF2jxIRsm5STI8vv4Rjmw6airg8bHAcX
         /PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nobkAmo+aZjqs2y4lL6YMzGxFlhbTukwFQBE1ocWdeM=;
        b=WUFkTdxek3uH031cWzbKseqixX/lmHdTo95PS4v4vSPVt7sPa69Oni4X7B3GC4mJS2
         B8/DBHhQrk/BmpBeAMEIVjZzIvvTJxEquqma1ZP/7CCAYKz1tGq7d9XqutIFh2p/jfvZ
         /p0cHAIRJ3T4bNryqIUN/gDrmsF1ivSZGhhcm4c++P7NFsIXvo32Mk72iuzmtv1YCBdi
         X4YZgwqpAXuw2AFx4EcecgCeqJeUxXSCZ9C2BEqOS/Y+v5W8suiVIQM7fhI1z8goeneu
         b6YqM/4LETXYR7c2trg9408EGymfSOPaiYHjf9KupTmeIsYQcMh2yWm13cof9/iwju3j
         cIGQ==
X-Gm-Message-State: AA6/9RmZcHWCY2bQqV8sESi6yB7wbj2vZRIHVPKQXcsgWKxKgZUAu4I596gZWMV8Obl3EwhI5TOOTIu/g4ix2Q==
X-Received: by 10.107.59.6 with SMTP id i6mr21517000ioa.176.1475886762059;
 Fri, 07 Oct 2016 17:32:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Fri, 7 Oct 2016 17:32:11 -0700 (PDT)
In-Reply-To: <f41a1371-7771-1960-27e0-cba0ee5b1461@gmail.com>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox> <e1b432bc-97b4-15be-aa44-71921c64cd15@gmail.com>
 <alpine.DEB.2.20.1610071616390.35196@virtualbox> <f41a1371-7771-1960-27e0-cba0ee5b1461@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Oct 2016 07:32:11 +0700
Message-ID: <CACsJy8Bip0mscutDHib-2O1g+eN2twO0m+OyOg2BTUudjOdwfw@mail.gmail.com>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 10:55 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 07.10.2016 o 16:19, Johannes Schindelin pisze:
>> On Fri, 7 Oct 2016, Jakub Nar=C4=99bski wrote:
>
>>> Note that we would have to teach git completion about new syntax;
>>> or new configuration variable if we go that route.
>>
>> Why would we? Git's completion does not expand aliases, it only complete=
s
>> the aliases' names, not their values.
>
> Because Git completion finds out which _options_ and _arguments_
> to complete for an alias based on its expansion.
>
> Yes, this is nice bit of trickery...

It's c63437c (bash: improve aliased command recognition - 2010-02-23)
isn't it? This may favor j6t's approach [1] because retrieving alias
attributes is much easier.

[1] https://public-inbox.org/git/20161006190720.4ecf3ptl6msztoya@sigill.int=
ra.peff.net/T/#mb1d7b8f31d595b05105b8ea2137756761e13dbf4
--=20
Duy
