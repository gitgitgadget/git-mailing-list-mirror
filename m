Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926FAC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6221E20754
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="UjViY03G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgCUWgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:36:06 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34444 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgCUWgG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 18:36:06 -0400
Received: by mail-lf1-f53.google.com with SMTP id i1so6621975lfo.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWri25mHJEPnrlYM3VJ2mriG0nf/HTk7FLX9gYSsMMA=;
        b=UjViY03G++wPn/CurJ0sCx1ZJfB/ppfLzR0f5cVwWNjUzFXou4awHZb3ZjMdtUejEC
         mibIKCGVUjiVEDlhYzP/WIx0jkaFrq4BV2O1b29UP8r/IspAf3WcZJg7fUDZPoq8GkD2
         lFk4I5Ho23KlFeo7QkNP8Z5CaJELBX+VyVY90NmTYWeJEx+uGznXgeZsKkT3vj3Mf75Z
         stkh3xFXxDWI3zsGlvthAgSvOOMqk6MWk53SReOdyU0uszrh4GTjEZcdy2UMPmja3ERg
         b3HbzIItyCDO+GsZ8oGEhBYwjGAbUrdQQItyLWi+jL6rPjrUaMrEls203yl22TauXgB5
         L2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWri25mHJEPnrlYM3VJ2mriG0nf/HTk7FLX9gYSsMMA=;
        b=iO6iqRoiZwohaOQRKhOtezdCJKyxKlCRGCXGITPNq4s44J4jre1bY2DKbh9+sjQlGu
         tAEJy49iAnCN0ZoLddF9/IGB/ZoDb497gNNlIMlfBTA6VrNLSifKOw1O3t4EdJXSyj3M
         mHwtxMrncTj40+Y05rGzIg23IqGeUxFhzrPxu81ifIs37Q1dpPOZ5j5bnlcIguInGgqE
         qAUgD+AJkzdSzN79VUBZjs4/8Ghmu4gthnbkDUNcyvXnISOzvrBfiRQ3lhPakLZJ5lML
         mAGMM0y0N5kdMFfF4DWwh2sGLb+6gjIQUnKiG3dQ0Wnk8KCs+7ZTg4YjkZ/DMHtgJ1zE
         tfGQ==
X-Gm-Message-State: ANhLgQ1mbHZmTs0URHX7i1uZZuyMEhSALR8GQK7z+8sHKmINC4lYK8Xb
        oB4bzx9saF0dbZGGnV+NYW/7t15MPKMKiIGmIpvcuQ==
X-Google-Smtp-Source: ADFU+vtVDSjo7c2lDnQyt1vpk58z2Ew1BhowmpYmQT1w5hWm75X1mUcZS0PIiFNu513dWgdGWHNfC7goXS+i9csDUT8=
X-Received: by 2002:a19:ccd3:: with SMTP id c202mr5052528lfg.103.1584830164540;
 Sat, 21 Mar 2020 15:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfnt8k47.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfnt8k47.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 21 Mar 2020 19:35:53 -0300
Message-ID: <CAHd-oW7B+Q+hGfAkbu8PYjhQ+-81u9L-swk-iHzasHuJOh5GLA@mail.gmail.com>
Subject: Re: macOS builds having trouble at travis-ci.org?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 6:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Starting sometime yeserday, it appears that macOS builds of our
> branches at travis-ci.org are having trouble in an undiagnosable
> way.  All you see on their webpage is a helpful message "An error
> occurred while generating the build script." and nothing else.

It might be a problem at the travis-ci infrastructure. They reported
an issue with macOS builds failing two days ago[1]. The issue is
marked as solved, but there are still some reports[2] from people
getting the same error message we are experiencing in git.git.

[1]: https://www.traviscistatus.com/incidents/9861dc7dtsb0
[2]: https://twitter.com/traviscistatus/status/1240759726905815040
