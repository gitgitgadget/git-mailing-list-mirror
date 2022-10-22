Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4BDC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJVAHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJVAG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:06:59 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA70558D9
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:06:28 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id hh9so2646954qtb.13
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4IqrOl7IHigKECcxD2l4ySl2mSO0YSSr51FRxwRJVs=;
        b=J1LeC4lAPIwUwgpna2yIdseIXpEMySibnL4I+nsPcMm22P62BLs9Kw/hIi8FTGwoPs
         5GspHgJKlis+N/6oGulas4E6jpe4PO0F9b2bhqLZR/d4/leM1PHONggUuapx1cfN54Q8
         jD+v1ixteUk5KqdIV/vqx+KCwPtSm9gdA/Gx2vGb+uNLsnYDuoSbxJhaoLS1KGVI2jjC
         LrCIausBRS2QucSHnyrRfPKHR/FSOEnLh3xwoxIOKNi1TrcGHixzm7zpSkLdhEUnF385
         +UqUpZ4GimjPOY4gOchBSTMwf5F/XugO9VNRBwSRlgMXOUuONE8LMjrw3vJEHQJVMOHJ
         GnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4IqrOl7IHigKECcxD2l4ySl2mSO0YSSr51FRxwRJVs=;
        b=PR9bpJA0KCMyG6Ka0kf3/lSBNHFUovm6/VhZ/emH3aCh4KYn+LO+HG/05f1VQRHihi
         azp8+nkmEoHzN2jl8bJNFt+/n1LsiFJWwqjocGMcfvxqcdXEPvQpiL56JvQjKK91o4yi
         nH8dm33KRNloJqD1PJ2Dja1M97eIjDUSZES1AX80jpyLqiHU448myjDJFLfEwWzPfggR
         XqQx+WcKEPD3tjMFrQLBLoyaA0rjL0jHrChJCVan4CnBIfCGsCZi1ocOLtSAZKPs5F93
         15+WBOUsb+VSxM5Zy+cwdX0zrmOTTe/ysyvNTddN5PPPbI4mOLuset9WKGTEco/M1VQE
         iXAg==
X-Gm-Message-State: ACrzQf1v5Moc78sdXLqLNFrB1/uSQDJyE4/WWgdZp6uFsFbA+iSq+2xR
        hm+D9CWR8fKR9TZRvuFv1TCzF0kYxE4=
X-Google-Smtp-Source: AMsMyM78y69TvdHhrMkBrN0y6Pc/NjtLHtH0XIyxEjVcJfQ8ClpxUy+mwHplcpIONx0OkDghiJa0Tg==
X-Received: by 2002:a05:620a:40d5:b0:6ee:e3f8:20d2 with SMTP id g21-20020a05620a40d500b006eee3f820d2mr15913168qko.14.1666397129915;
        Fri, 21 Oct 2022 17:05:29 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:ce00:1638:c0d0:e2bf:adb8:2d8e])
        by smtp.gmail.com with ESMTPSA id h24-20020ac85158000000b00304fe5247bfsm8727110qtn.36.2022.10.21.17.05.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Oct 2022 17:05:29 -0700 (PDT)
From:   "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>
X-Google-Original-From: "W. Ekkehard Blanz" <Ekkehard.Blanz@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Cloning remotely under git for Windows not working
In-Reply-To: <CA+JQ7M-7qEu8ooQp_g1+5pownA13VbPvJQSb-snKP3=7yfyCEw@mail.gmail.com>
Date:   Fri, 21 Oct 2022 17:05:27 -0700
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC894A81-467B-4F16-8E81-B092A692ED06@gmail.com>
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
 <CA+JQ7M-NA9UYafMurb9MAo5bp6djdzRP7ChAbdmzU+nmrkXTNw@mail.gmail.com>
 <DB5611E0-6B1C-4711-BB9F-72F6E8F39506@gmail.com>
 <CA+JQ7M92x03FPWM6qWjG=FYPxCYs8xcC_HRWLnkwj4iqA9KK=w@mail.gmail.com>
 <46A1CB40-BBEE-43FC-9626-588718518B4A@gmail.com>
 <CA+JQ7M-7qEu8ooQp_g1+5pownA13VbPvJQSb-snKP3=7yfyCEw@mail.gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You're a genius, Erik!

Adding the String Value =
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe for =
DefaultShell under HKEY_LOCAL_MACHINE\SOFTWARE\OpenSSH in the registry =
did the trick (DefaultShell needs to be created there first - it doesn't =
exist yet). =20

Clearly that left me with a working solution.  But now I got =
adventurous: I directed ssh to use the bash.exe that came with giit (in =
the Git/bin directory) as the DefaultShell.  This worked too.  I thought =
maybe git will be happier in its "native" bash environment for potential =
future issues.  But either one will work for cloning repositories from a =
Windows box.

Now the remaining question (for you maintainer guys): Do you want to =
call that a fix or a workaround?  If it is the latter (which would get =
my vote), then someone would still need to touch git under Windows to =
make it also work with cmd.exe, not just bash.exe or powershell.exe; in =
other words, this case is then not closed, even though everything is now =
working for me.  Having the user change registry entries doesn't seem =
like a good solution to me - neither does changing the registry entries =
of a different program (OpenSSH in this case) during installation of git =
for Windows.  But that's obviously not my call - just voicing my =
opinion.  I am not familiar with your Change Request Management =
process/etiquette.

Most important of all, however: Thank you Erik for sharing your valuable =
experience and getting me up and running again - it is very highly =
appreciated!!!

Ekkehard

> On Oct 20, 2022, at 23:06, Erik Cervin Edin <erik@cervined.in> wrote:
>=20
> On Fri, Oct 21, 2022 at 12:00 AM W. Ekkehard Blanz
> <ekkehard.blanz@gmail.com> wrote:
>>=20
>> How do I convince git to use Powershell as its shell of choice when =
it arrives over ssh at my target Windows box?  Unfortunately,
>>    git help clone
>> Does not give me any indication how to do that.
>=20
> AFAIK, the remote choses the default shell of ssh sessions so you
> either change that or somehow launch a different subshell with the
> client. The former should be easier
> =
https://learn.microsoft.com/en-us/windows-server/administration/openssh/op=
enssh_server_configuration
> the latter is talked about somewhere in here
> https://github.com/PowerShell/Win32-OpenSSH/issues/752
> if my memory serves me correctly. I chose the former

