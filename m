Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D89202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 19:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935341AbdIYTOa (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 15:14:30 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:47812 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934555AbdIYTO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 15:14:29 -0400
Received: by mail-yw0-f172.google.com with SMTP id t127so5466972ywg.4
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=85QaqBGQVOlO8JrjdMmQ6fM9XOmKrStdEzAAPd6Mdds=;
        b=ZYRAQ4SJYdiqKxJ7IFtaKpArbLKJOZWBG9eJTV0eGPU5Um6qFBTFe+WLTSQHQqSe3V
         wgNk1m/AkO6HWOplv61RjT6hwt+GDp3eU0YtV88gxWw1zrfdWxq1S6m6g5b0aPj877EK
         nYoPlp6dR4eVogRhM4armQzL0gRQ8D/qaQGI3WblIFyz8szZvncwIFjxQeT+2pmQthUl
         oILPeRu/mxj73to5TN1fyO2BuoT19oJz7qJJkZr7FNPRJ/MpMZ/gnsrG2kcaZ06H8+gN
         L5PQk4Pj6DnRG4i5N+m1HeOgIYHPsq6yHEJqeREuBVyRq3vP+I76uZR8wKKVOUjMLOZt
         TQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=85QaqBGQVOlO8JrjdMmQ6fM9XOmKrStdEzAAPd6Mdds=;
        b=Pl+7WH1ej+Ahlt1xPCqQb60C5YGOWyxReB3q8OlxG3y5oAne8PR+YdCy9btn5S8BsL
         HYn96/p6key8egEIFriyVsD4qP03I2YKdAk4ZmW8AQc75M2kSFv+DkcGaJC1PTKS4izT
         smU7T+3PyNy3T2SZtaMA39jj+tounF01reczC93V1J8tUy4hyU67S610pEg3HvNdrj62
         6qKugSAPN1oGGu+NExn81Kk9cETkDPc0HqZRCaEipjh9GFByxGePKDB8BJObS0mPZKE8
         spkCl95NBh78qccKo7KcGF7/iHBRwyznFjWbysZyBYZKZEYrxtcceOd1LnFo8SPqg5rA
         piSQ==
X-Gm-Message-State: AHPjjUhWXYcSDNpv6IZl/vg0Hqo0aN2zKk7713ZanDGqCJ3k4ZlDPj3P
        ovvL7kvRxfKkRYaoF74IMhQLwwKExQQ4tAcKWGs=
X-Google-Smtp-Source: AOwi7QDj/Pc0ZTnvAww3NxXIMvYMQfiVAMJu7rJX1/vVUkVShXpnjH4x45e/+maMAy2iNjMIEkBfqMePl/qgHZEfYEI=
X-Received: by 10.37.230.87 with SMTP id d84mr5072257ybh.201.1506366868956;
 Mon, 25 Sep 2017 12:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.230.85 with HTTP; Mon, 25 Sep 2017 12:14:28 -0700 (PDT)
From:   Roy Wellington <deathanatos@gmail.com>
Date:   Mon, 25 Sep 2017 12:14:28 -0700
Message-ID: <CAF5E6=pqGZt_BUDRDeN2uAQK7qBTeO+zcR8NsvSPg-rLjbsqdQ@mail.gmail.com>
Subject: git ls-tree -d doesn't work if the specified path is the repository root?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When I run `git ls-tree -d HEAD -- subdir` from the root of my
repository, where `subdir` is a subdirectory in that root, I get the
treehash of that subdirectory. This is what I expect.

However, if I merely replace `subdir` with `.` (the root of the
repository), (i.e., `git ls-tree -d HEAD -- .`) git ls-tree returns
the treehashes of the /children/ of the root, instead of the root
itself, contrary to the documented behavior of -d.

Is there some reason for this? This behavior seems like a bug to me:
it means that prior to calling ls-tree I need to check if the
referenced path happens to be the root, and if so, find some other
means (rev-parse?) of converting it to a treehash.

Thanks,
=E2=80=94Roy
