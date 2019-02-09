Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568D81F453
	for <e@80x24.org>; Sat,  9 Feb 2019 19:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfBIT0h (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 14:26:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35135 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfBIT0h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 14:26:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so9388747wmt.0
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=narcLa+2OVPycDWvsMVBtlPQWBwqLoipfhAadb2eLOI=;
        b=bNdtu5dz6cwl+d9mM1B4hsAgVdtWV2F10KApNrRcmo0LMUXXFHvlQEooc7LAZK2BcD
         XnErGCDVUy424x/kUWQMxtM74R51SZ/PoiDqM7fS9KIIQt0NO93AQCZyE7nhosxwyeMj
         XTUVLAZ+kN8sr1jHLFWEkdLPXfEgInAnC/CFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=narcLa+2OVPycDWvsMVBtlPQWBwqLoipfhAadb2eLOI=;
        b=o+zpb1jVj0B5l5qbdCXrmci5+rEJpSPYUATZcx8zxatKoTods8Vy/Qu9ZfZUJlPzZh
         Hhrnj4zier7+s/5JHXkz+Emu5gDa3zoo6DU/oNCLxiafyGKZ08Zp40FKu0YdrcSff9P2
         UVe9OhP0bWpgnP79LxEIO0XRAyYuwa3EyYV4ed9QAY75d2GsIiGKF7ZALOBG9J326bJf
         JRw4yIV4o1N5vX7KghetZM28RzsaIb6scX150PTw4kTbO95QbHdBlmzF6OGVjSDNKLXL
         9aoRjyhTe64cDZkuIA6vTu7MsNJp7ZRyKppLaevLCw3zmpZn0GtiCqgFHSYxjI1jhfoR
         IntQ==
X-Gm-Message-State: AHQUAub2qu+uu8/kWpGS3qu0faA3cH9fLYnjTcfVrRqDsJfOAO+kjhx5
        KpVSeplV/lWbLWJ1viRq0Vr7bKH649SUHMEtq5UThw==
X-Google-Smtp-Source: AHgI3IZ/4NAH43PIc5cUW+gCK3lUQLEM8jUZTDaJ4iHNoWVDYcfJ2NGWfKa/3ypuUEj9j+8Ge+i0dSswDh5F9X94WLs=
X-Received: by 2002:a5d:5004:: with SMTP id e4mr23149725wrt.59.1549740394952;
 Sat, 09 Feb 2019 11:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20190208190231.8134-1-luke@diamand.org> <20190208201445.GB10587@szeder.dev>
 <xmqq4l9ckfab.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l9ckfab.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 9 Feb 2019 19:26:24 +0000
Message-ID: <CAE5ih7_UTONAK5YCj_xYAa-d3zts8RUSkaAFtixa9exnxG8acg@mail.gmail.com>
Subject: Re: [PATCHv2] git-p4: ticket expiry test: use a fake p4 to avoid use
 of 'sleep'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <ldiamand@roku.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 9 Feb 2019 at 18:06, Junio C Hamano <gitster@pobox.com> wrote:
>
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > On Fri, Feb 08, 2019 at 07:02:31PM +0000, Luke Diamand wrote:
> >> +# create a fake version of "p4" which returns a TicketExpiration base=
d
> >> +# on $EXPIRY, for testing login expiration
> >> +create_fake_p4() {
> >> +    (
> >> +            cd "$git" && mkdir expire-p4 &&
> >> +            cat >>expire-p4/p4 <<-EOF &&
> >> +            #!/usr/bin/python
> >
> > I think this should be $PYTHON_PATH.
>
> OK.
>
> Luke, I think our mails / work crossed and the tip of 'master'
> already has a removal.  Please make this into a separate patch that
> adds (or, resurrects with an improved version) the test for the next
> cycle.

OK, thanks!
