Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5551FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 16:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdBLQhd (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 11:37:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33654 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbdBLQhc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 11:37:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so14874251wmv.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 08:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yT37Eoty1b8QcfrETt1N4LsYm1g45Jg6AQvEj2+2F1s=;
        b=Mf2eyDl+lYePnrKdSqq/swGcq2fcifUW6hrqnMqRyXpB53+BbYPZt5UHk0WVywGrXd
         8WYCe64qtckgnymJpph1BNyx1MCEyGrLxS8bqYqFFx1URQ7hgYE/+7WYMvGKWUoGPOJf
         O4PYm43JBYIgtlYWmoNVOybftms8YxLrI/PDTagQMwbauHMt/3XrQIeX1SDWieLwnvG7
         lZfQMHBR2u5Y4ZdeKtkswlzGa7fGAPqQ95QRiVtt39zLiijDd70Ls9W9Rh3lhuMo3k1g
         lqM8AlC4qdITKhGEbXnWSff8PNnV6EpUYzJS6ymSuo9iBcAB0sYrlZaAHhCKKBJpPtjp
         zVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yT37Eoty1b8QcfrETt1N4LsYm1g45Jg6AQvEj2+2F1s=;
        b=l0pDKVcqDTMKGgVZJXiH/rMIG33zojCyDcaqFX5HKozlyHfLKu4uMZ5d3A/jNA9GZf
         iHqOgY5sqocHxUnT2Z6qMewXplwDk4MmZhIxJNd5NqLrGC8daFVHKbc8sH6Wwb0NuiSK
         76F3OIVW2OsbB9DB2G8PJ/qVXFBVEgvFsSNNqU0OZEDabAII298i8dBbEL7YOdAAGVwQ
         PMWE86a33dopcUoA5nThkmMRGNRJHbemrb+aF0t1xaD0fAPFhodIRuRa5pBZF+pmstYL
         bTAcvByqm3B3ZDX05I0di1/polhiTb7wgH83MQyXFKyCfZEgCN6YX1eDzaSra9etLra9
         b/qA==
X-Gm-Message-State: AMke39mooBGOXhYEt9jyrp/VJCqm2h7uR3R12zMnLqtsKET3sqGJghMfjeIG1vhsaJ00v6b3e0z8AbsLdCHVqQ==
X-Received: by 10.28.66.221 with SMTP id k90mr37256818wmi.90.1486917450900;
 Sun, 12 Feb 2017 08:37:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.174.1 with HTTP; Sun, 12 Feb 2017 08:37:30 -0800 (PST)
From:   =?UTF-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>
Date:   Sun, 12 Feb 2017 17:37:30 +0100
Message-ID: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
Subject: Confusing git messages when disk is full.
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I would like to report what I consider a bug in git, I hope I'm
doing it the right way.
I was trying to run `git pull` in  my repository and got the following
error: "git pull
Your configuration specifies to merge with the ref 'refs/heads/master'
from the remote, but no such ref was fetched."
Which was very confusing to me, I found some answers to what might be the c=
ause
but none was the right one. The actual cause was that the filesystem
had no more free space.
When I cleaned the space, `git pull` then gave the expected answer
("Already up-to-date.").
I think the message is confusing and git should be able to report to
the user that the cause
is full disk.
Regards, J=C3=A1chym Barv=C3=ADnek
