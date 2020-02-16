Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A13C2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CB32084E
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcpHUGWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgBPN2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:28:10 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34394 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgBPN2K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 08:28:10 -0500
Received: by mail-lf1-f50.google.com with SMTP id l18so9948608lfc.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 05:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ubSamxlswvPFne75KwKkiCwT9+pwrzSXdo3SIEPCl8M=;
        b=OcpHUGWjQvfvI4yEeo3YhUayAdaxVl1CZMinWNq/d/c8AkpC+ZmxPdJ9NFToH+nmbp
         pam9Zt3bgLp1gd6MHLVG57VvhMOW4BnVP7p0dY2Xz5cA9hTcwBjVJQkeIYb0Rmg555FV
         X5YeXtKkba8ceD1KDJlbq3lBsHcAZrj70BdvUsCsHUTWrVIciM5s1JwIN/gYYpGjPeb9
         C2ewDoN+UmJGmnVFUdFnqBZSmlKpqQPBU+DR9gBq8KpT2WwQ83ScsTDDUA9wMPUh9R7v
         RajnbmsUCaZQJceU89IRZi3YMyAUBn7NB4bUnSO449A9OMXQd9lsP3sAfH0IEpbfpn7l
         I7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ubSamxlswvPFne75KwKkiCwT9+pwrzSXdo3SIEPCl8M=;
        b=mWdUjsCiyt/wS8xYYtzvrizD7prUH4mwCz+R2h2ipDQIuxQMik+3SbUQpSNOkWNCN5
         6cIVvwetx0m6iqfSnx0eyuNsZHwhMiwp64X8rv70Cn8rI30eoN/hjpyhALz0ecZW2ZDZ
         SofLLjEwTpT8APEpH1O4S1N5IGyaE+hBU/NTf7QQZryG3k3V8mk44NLuC95tqgvyP5oh
         mdxNu4ECoQTdL+lUw6jgq1HUHtb5jAfgIz2jHfh2ecUYwwDQnKUOOtQFGEkPor+jEKLR
         THaFYXsYaRZsURsqTU4tQlrDY22G9TulcvBd5dR3rEZ2TVeG7LMpjJbo1XjmzBzHfD9K
         69ZA==
X-Gm-Message-State: APjAAAX6WpyJ8emq2ELoIJ3GKMkLaW+wBVspHjtSTIUPE/TRt0uIgRYv
        wY80/lG4pKxavuLf4kLHNY+wn/KVDeoT0AOOQxw=
X-Google-Smtp-Source: APXvYqwPU7pklffk+QYvj9bwHS/VRiTa6WQLipH3aKTmUL6p6cLP+7Afb81M6Tl3UlQJGJ0gy82u6scC5DgiLH8MTi8=
X-Received: by 2002:a19:cb95:: with SMTP id b143mr5806359lfg.158.1581859688350;
 Sun, 16 Feb 2020 05:28:08 -0800 (PST)
MIME-Version: 1.0
References: <CAN=yFFn8GOobGpo2d3N8una4EE3L9nFTckH3D7rZ=G4d=MTmnQ@mail.gmail.com>
In-Reply-To: <CAN=yFFn8GOobGpo2d3N8una4EE3L9nFTckH3D7rZ=G4d=MTmnQ@mail.gmail.com>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Sun, 16 Feb 2020 13:27:32 +0000
Message-ID: <CAPMsMoD+i_xnSWOY7PY92GSn8GfbBcpfZzec-Zj3B=tdGM_H5w@mail.gmail.com>
Subject: Re: Error 500 from git-scm.com
To:     Giovanni Tirloni <giovanni.tirloni@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for reporting the problem Giovanni.

Just saw a bunch of 500 on the heroku dashboard. I see some memory
warning, not sure why yet, but just re-deployed the app and it seems
to have fixed. Will try to better understand the problem and post it
here

Thanks

Giovanni Tirloni <giovanni.tirloni@gmail.com> escreveu no dia domingo,
16/02/2020 =C3=A0(s) 13:17:
>
> Hello,
>
> I'm currently getting HTTP error 500 from various links in the
> git-scm.com website:
>
> https://git-scm.com/about
> https://git-scm.com/downloads
> https://git-scm.com/community
> https://git-scm.com/download/gui/win
> https://git-scm.com/about/small-and-fast
> https://git-scm.com/about/branching-and-merging
> https://git-scm.com/about/free-and-open-source
>
> Regards,
> Giovanni



--=20
Obrigado,

Pedro Rijo
