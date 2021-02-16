Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01EC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F35364E76
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBPWPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBPWPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:15:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DAC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 14:14:22 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a9so4150958plh.8
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mail-followup-to:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=8uD3GBptMntvSXlmss3bBobNzVT/e6XtdP1b/9QitKs=;
        b=qbosQMtqF8/qZiHDo3yoGTKkV6VcTiySs3OduwD4RseBaYqlonfBeadogrz2CYO3xi
         XFW1AfY7H1ujN3PNTIfWdfbvAsnPzwbTWJ3DlxDBIr3OcrglajKXsltpvOSgufaiTjVW
         CDiOOVjxBIxtoaLC8s/GS1uUplv9DBD267PUufUe2GQsI2whvKR9NLlSlpPOXtlZgacO
         7QEW9G2ZEnIZKhINPGuTQpCGVPuAJ0IE8ZdougpxSm7SDy18HNuiH+mL8Hcpwk+PLk27
         +TQoAD9fIp3qvEE9KdQE4fMZIdGCjuXjDK0suaZJ0cDpA2phILcn8FHN7/sdpcU6DRhK
         EnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mail-followup-to:references:mime-version
         :in-reply-to:date:message-id:subject:to:cc;
        bh=8uD3GBptMntvSXlmss3bBobNzVT/e6XtdP1b/9QitKs=;
        b=Ahjyg+dkGlbwExTc2ceJs8LnmJl1pyDOJ0eVBWtMAiOfS80cPWaIqwzmhgrwPDZ4mp
         Q7zR3JK/tJa+Li0HUZkEJflKX9xMrUzYfDOZN3ny7x42AdrNiz2IIl9xsOqoah+oS5l6
         aKVGXeZsb0MJjjt2dXozHnWeAF3yZJIV0+cV+6LFaNXN6O60SuOA/+fbBwtT6e3bstyd
         r0o1mNROO0ERZ8vKIbhj9GVCUd+MTBTghrksk/pb1sbKDVXpftwF7XMwiksDrexsgjuS
         VcFoLUJ4ic1IBXLcaYMREimK//jK7rqJAIey6JbkWmmUu3nJdeVYus5ZD4fPszf+fBZM
         TfHA==
X-Gm-Message-State: AOAM531CdrZIk76ktJ9eisHO3WqLYq41VDzZuS+pCUVUFqvvugrTAM8n
        EKVRnbZWJ+X/WF8V84r0m9fI9+F7lK9EI41IUqg=
X-Google-Smtp-Source: ABdhPJw5SIa0ROzboepWFcKB1yzf4E5RM4XfgRUjXldsYbCWNZccOmg8D4yEKpdC1Do3vY89ugOS8BE8INF+V8i3G9A=
X-Received: by 2002:a17:90b:a58:: with SMTP id gw24mr6199083pjb.143.1613513662012;
 Tue, 16 Feb 2021 14:14:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Feb 2021 14:14:20 -0800
From:   =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= 
        <khardix@gmail.com>
Mail-Followup-To: =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= <khardix@gmail.com>, 
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
 <xmqqo8gksqr4.fsf@gitster.c.googlers.com> <CAG+K25NbifB9k9ugU5ZjLAOKxLyfEZcphfZXNS9_Whi6gZcBLA@mail.gmail.com>
 <xmqq7dn7rgi4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
In-Reply-To: <xmqq7dn7rgi4.fsf@gitster.c.googlers.com>
Date:   Tue, 16 Feb 2021 14:14:20 -0800
Message-ID: <CAG+K25NC3H7L5TpxmR_kCvmqR8GPdCEdTt740F34ON4TWoPCpg@mail.gmail.com>
Subject: Re: git-send-email: smtpserver in $HOME
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000aa39a505bb7b6cc7"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000aa39a505bb7b6cc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2021-02-16, Junio C Hamano wrote:
> Jan =E2=80=9CKhardix=E2=80=9D Stan=C4=9Bk  <khardix@gmail.com> writes:
> > This introduces a special case just for handling $smtp_server=E2=80=A6
>
> Yes, and that was very much deliberate, as I think
>
> 	git send-email --smtp-server=3D~/bin/my-phoney-sendmail
>
> won't be affected by %config_path_settings.  $smtp_ssl_cert_path has
> the same problem already, and I didn't want to make things worse (I
> think %config_path_settings is a mistake---it is fine to have a list
> of variables that can use ~tilde expansion, but I do not see why it
> makes sense to allow the ~tilde expansion when the value came from
> configureation files, and not from the command line).

Well, unless I'm missing something, shouldn't the tilde above be
expanded by the shell before actually being passed as argument?

$ echo simulate --smtp-server=3D~/bin/my-phoney-sendmail
simulate --smtp-server=3D/home/khardix/bin/my-phoney-sendmail

I assumed that only the config values are handled specially
because only they need that =E2=80=93 the CLI is handled by shell in advanc=
e.
Never played with $smtp_ssl_cert_path though,
so if there are known problems, just ignore me
=E2=80=93 or better, point me to the relevant issue/discussion,
if you can be bothered :) Thanks.

> > My concern was that if there is a SMTP server actually named
> > i.e. `~someone.example.org`, this change would break that.
>
> Can tilde appear in a valid DNS name?  I doubt it.

So I actually did my homework and skimmed through the relevant RFCs
(RFC952 and RFC1123); as it turns out, no, it cannot
=E2=80=93 only ASCII alphanumerics, '-' and '.' are valid characters.
--
Jan Stan=C4=9Bk =E2=80=93 Khardix

--000000000000aa39a505bb7b6cc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 376949fc523b33c1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUVZdjczM3Vsa24w
UVpmdWczS1hMeUEzc2tPMjBGQW1Bc1E3c0FDZ2tRS1hMeUEzc2sKTzIzaFlBLzlGaDlBQkZOSHln
V2dFTVU3enR3UWpRaStEUnJWV0RBbWV3MjNBL0VSVFZOb3puaklOT1Iyclp1Kwo2alBPakVSUEZZ
SkV4MFF5bHF1SFZoOTdZZ0U4R3VGVURWWGVuWDNFTkVtK0dSanZMaVFLRFBGRlRaQkg1MHJMCllv
TmluZGRwNCtSSEcwbXM4VktCN3pwL2Y1VjlJZHgyK3ZrMCtrcnk4WkxHYTlJb0hua3FXTHVvNS9r
ZXJodkIKa01rdHBnZHhZUU9PUHNLN1RucjBjdWppMXBaMDBnSk9MYXE1L0JSbXF6RVliYzJIazlN
NFRNUGttOE5QZVRkNQp4MzZFQWkyTnRKcDdMbGIwMDJYTGJId2VoN3ZWWnFSQW9lTWlEcXZlSG9U
OHRwUEcxelFwWmRTS2lJZVg0RHJiCjZVTHhybFpBSVZXWUt4T2MwQjZFeEZWVDRiUUxrTkY3QThs
RzBHVW1hcGhEWndFV1puUlEvRWN0QWt3UzVUOG0KTUcwL1pxTEtsdmpHWU81aGU4RENHdHgzSlVi
NWw2Tk9iczh4S3N1L3d3OHRYN3grcTR3TnFOOGlxWHBhMGgreAovOGszZVpRamFtVmppMmtrakk4
V1lKY2k1U2pYcW5IZkpSaWdaQ0U4T0tuRy9KWFlvaG96ZG1BMTd1b1lIeGk3CnRMa0lOV05XYzR2
VEdqNCtyYzlVbGQwcEdCd2cxcDRvWENFTUxUNnkya1NoaEZOVkVIQmY4bFJlQ0VyNDd4UjMKQjQr
VmpIWnZhYkZXQlN2YTUrWll5bjl4b3AwNHhFS21zLzlNWWFrUkNZUk1yTmZsK2JTUzFBd0JNOFdJ
WWhTTgpVaHlOaWZMd0Y2MkU5cHJjdlpDb3NONWRuL25GTHUvbW5HYU5WTWxlOC8xT1VwQzlGcEU9
Cj1LVVNvCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=
--000000000000aa39a505bb7b6cc7--
