Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C96EB64DC
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 04:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGOEbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 00:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGOEbi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 00:31:38 -0400
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AA35AD
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 21:31:37 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689395493;
        bh=srnIETGGBoaor04XhLDa5ZyMb1eeRqVPBXWnwbjliGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUZOoWOx0U0LLvoiAzfW6WWxZD2Kw9l90KEqyt/bGTDMWSTbDYu7P4GADnDE1y0Hx
         wd5Cn+01rAVmk1tk0ax7QKEPsVJRnM/rpsdd8gAF48egSva4nUkYHTG1ddVdFJDUTh
         MPtkWhnLng7a9akQpFn6KBRst7kgu8n6GudB/HCtGGk+pM/D/zPyc/4eBlzSF9QxqQ
         DUBF54CKEtvgTtRunLT8beLDJj6qGW9oVSFKW7fSFKfmloUtp7VHIj82FcI2vk9VLd
         JvDuUfxQTjTbb3sgp9c2xdbbYCiMNpiJYCXCCHxrL79pDeY91gblpKUFCBdWYen+Y+
         RYvY2qclP7UOg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Jul 2023 04:32:13 +0000
Message-Id: <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
From:   "nick" <nick@nicholasjohnson.ch>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g>
In-Reply-To: <xmqqbkgeqw6n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "nick" <nick@nicholasjohnson.ch> writes:
>
> > However, I think it is worth the effort for the time zones. Is there an=
y
> > reason Git doesn't automatically convert local time to UTC in timestamp=
s
> > to prevent leaking the developer's time zone?
>
> Actually it is the other way around, if I understand correctly.
>
> Git could have been designed to discard that information like
> previous version control systems, but it is another piece of
> interesting information and made a conscious design decision to keep
> it. In other words, "is there any reason why we do not discard the
> information?" is a wrong question to ask in the context of VCS.

I'll make my best case one last time and if it doesn't convince you,
then I have nothing else to offer.

Git leaks private information about developers publicly by design
through its precise timestamps. You mentioned this makes it easier to
deny copyright claims, but one could get more or less the same benefit
without sacrificing privacy by rounding commit times to the nearest day.
I'm not advocating making this behavior the default, just that
developers be given the option to do it.

The time zones reveal private information about developers and they
don't even serve a use case, as far as I'm aware. A backwards-compatible
way to solve this leak would be to convert timestamps to UTC by default
and have a Git config option to revert back to the current behavior.
