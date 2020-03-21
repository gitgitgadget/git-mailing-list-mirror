Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9422AC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DA920714
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAUmUhA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgCUKj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:39:29 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45352 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgCUKj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 06:39:29 -0400
Received: by mail-yb1-f196.google.com with SMTP id k132so3997735ybf.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gf8xpVS2jkrX0+EhpSUYQiXy1J6kOx/zJ3Nj973YNVo=;
        b=gAUmUhA6ekuwsBXWb7Ek4wlY0TB5ZBPkG5iJLKxRRXyLGHl6AZ++t3sUublzw9D39p
         z6HmpfVlQ5WKB6Dpa/0hXwPl/7u0buI6iqzthf7QFILGmL4+VXbAjnoGtrwVLW1QY+my
         a62+Vbni26+fLPW6yqxPveNRsmqoxZYjI12kopUP6/XFq6eCfjY3Y0rP0cjLg7pxS0oK
         aESwvpy1S6Wr10WOfDRVPb+DE9ilxDCDI+Gg4VxXTgxaIMZPB/HvEGHi2+qH1PIZVUVj
         jwCgZAJk8HcXol6S5wk4EiGV4yjWztY5kbbrLJa8W1gVuxo6DB0hV8B9lJo04ndLWnl4
         ++UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gf8xpVS2jkrX0+EhpSUYQiXy1J6kOx/zJ3Nj973YNVo=;
        b=F0ON3U92ktYVh0bB3aci/8/Mx3V2ENZoF88ORn/raPEjljK3ScorOUa91NNNTbJzpN
         4aMmU8ckAQP+NquO0NzRPa7puruVFamczVmvDwbHnKZ3KJ1ZkBQJaD+uWdMcDS4ujL82
         YoIayO9yLq3qgfqvMyQdV3HnOFDUcwmuifK3bEP3D+T3wR+tKEXZTpfF6dIjbkU401+H
         SUICl8WCvc6sIu4Y0ON3GXJzHgT7hwHt0kxJuBlDdf5v8CzrsD8dI2/DEmChT0BwyTtQ
         3/15sPV7Tj4hh7gs/tuH3qVIt81Fc1kVIi3ALDBj/WSpgoIwZ5UlumBzx87QvuH619O8
         b+ag==
X-Gm-Message-State: ANhLgQ3z867a1Cd627dYoHpryhoSNiuG5DRLMyT0iOJxwFc471KlYv/v
        YqU4cSbW5gVmSMHuKPeLnj6y4X6Rsub1/inkQWk=
X-Google-Smtp-Source: ADFU+vuoBLffmq5a8GExQM1SghZXSEWQW69CipaNo9F5PyiUi9IRs89eeaFwDofk4WLruw2T/lCDf6eeYqzFPA4x8fI=
X-Received: by 2002:a25:d6d2:: with SMTP id n201mr11983810ybg.478.1584787167368;
 Sat, 21 Mar 2020 03:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200321102328.20755-1-zhiyou.jx@alibaba-inc.com>
In-Reply-To: <20200321102328.20755-1-zhiyou.jx@alibaba-inc.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 21 Mar 2020 18:39:16 +0800
Message-ID: <CANYiYbEWWxgNThWPf08tbQ4zd3zY1+ZKR_RyBprOP7BZxOQ5PA@mail.gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.26.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        =?UTF-8?Q?Emir_Sar=C4=B1?= <bitigchi@me.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8821=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=886:23=E5=86=99=E9=81=93=EF=BC=9A
> 13 files changed, 53994 insertions(+), 26252 deletions(-)
> create mode 100755 po/tr.po

File "po/tr.po" has a wrong file mode, which should be 644 instead of 755.
I will add a new checkpoint for this.

Please pull tag "l10n-2.26.0-rnd2.1".

---

This is the pull request for git 2.26.0. During this round, there are 11
l10n teams made their contributions, and Emir SARI contributed Turkish
translations, which is a new l10n language support for Git.

The following changes since commit b4374e96c84ed9394fed363973eb540da308ed4f=
:

  Git 2.26-rc1 (2020-03-09 11:21:21 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.26.0-rnd2.1

for you to fetch changes up to 1557364fb485603dcabea23a84fae8d2038dc27c:

  l10n: tr.po: change file mode to 644 (2020-03-21 18:26:56 +0800)

----------------------------------------------------------------
l10n-2.26.0-rnd2.1

----------------------------------------------------------------
Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.26.0 round 1
      l10n: it.po: update the Italian translation for Git 2.26.0 round 2

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (4835t)
      l10n: bg.po: Updated Bulgarian translation (4839t)

Christopher Diaz Riveros (1):
      l10n: es: 2.26.0 round#2

Emir Sar=C4=B1 (5):
      l10n: tr: Add Turkish translation team info
      l10n: tr: Add Turkish translations
      l10n: tr: Add glossary for Turkish translations
      l10n: tr: v2.26.0 round 2
      l10n: tr: Fix a couple of ambiguities

Fangyi Zhou (1):
      l10n: zh_CN: Revise v2.26.0 translation

Jean-No=C3=ABl Avila (2):
      l10n: fr v2.26.0 rnd1
      l10n: fr : v2.26.0 rnd 2

Jiang Xin (12):
      Merge branch 'master' of github.com:git-l10n/git-po
      l10n: git.pot: v2.26.0 round 1 (73 new, 38 removed)
      Merge branch of github.com:alshopov/git-po into master
      Merge branch 'fr_2.26.0' of github.com:jnavila/git
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:git/git into git-po-master
      l10n: git.pot: v2.26.0 round 2 (7 new, 2 removed)
      Merge branch of github.com:bitigchi/git-po into master
      Merge branch of github.com:alshopov/git-po into master
      Merge branch of github.com:ChrisADR/git-po into master
      l10n: zh_CN: for git v2.26.0 l10n round 1 and 2
      l10n: tr.po: change file mode to 644

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Matthias R=C3=BCster (1):
      l10n: de.po: Update German translation for Git 2.26.0

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4835t0f0u)
      l10n: sv.po: Update Swedish translation (4839t0f0u)

Ralf Thielow (1):
      l10n: de.po: add missing space

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi(4839t): Updated Vietnamese translation for v2.26.0

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.26.0 round 1 (11 untranslated)
      l10n: zh_TW.po: v2.26.0 round 2 (0 untranslated)

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (1):
      l10n: vi: fix translation + grammar

 po/TEAMS    |     4 +
 po/bg.po    |  5404 +++++++------
 po/ca.po    |   517 +-
 po/de.po    |  5664 +++++++-------
 po/es.po    |  5529 +++++++------
 po/fr.po    |  5490 +++++++------
 po/git.pot  |  5228 +++++++------
 po/it.po    |  5631 +++++++-------
 po/sv.po    |  5559 +++++++------
 po/tr.po    | 24563 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 po/vi.po    |  5560 +++++++------
 po/zh_CN.po |  5387 +++++++------
 po/zh_TW.po |  5710 +++++++-------
 13 files changed, 53994 insertions(+), 26252 deletions(-)
 create mode 100644 po/tr.po

--
Jiang Xin
