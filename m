Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7032DC4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1172420637
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m0UbSh8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgCUS7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:59:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58471 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUS7A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:59:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1DABBE2EA;
        Sat, 21 Mar 2020 14:58:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8uR5CoH1p94S
        /3bs5f2ZJ7lT9Do=; b=m0UbSh8Lj1fETY6VSGn51Jf2AWEaQfRfmj+5/ID6sR5u
        aVNvVD2riuaObe1uT0wkj3VM5JLi/8pn7WMUYHlTBFvktKgn03CsjRaHXrmRTdH3
        qC+g374cZSWlg4IZMJFrpFGirraTGJQpUU7rm/7h3dcjlNufO5/k8yZtpvS7MLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SWCvyw
        QPE4TP+a318TOHjpoQLbvKJ0vauE30kyAUjahLkwBkwvjBvS2Jb/GAGpSx2W2NM6
        ivihzCEbolreClAHe2LW28ExmiBfxp9PvlcMMU2Cbh3YU/X8rXI5xGISOprdKCde
        r1MD6Xog5BEogZonX6ntUaNE6VULOopH98XZo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7C27BE2E9;
        Sat, 21 Mar 2020 14:58:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12B2BBE2E6;
        Sat, 21 Mar 2020 14:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir =?utf-8?Q?Sar=C4=B1?= <bitigchi@me.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBR?= =?utf-8?B?dcOibg==?= 
        <vnwildman@gmail.com>, Vasco Almeida <vascomalmeida@sapo.pt>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.26.0 round 2
References: <20200321102328.20755-1-zhiyou.jx@alibaba-inc.com>
        <CANYiYbEWWxgNThWPf08tbQ4zd3zY1+ZKR_RyBprOP7BZxOQ5PA@mail.gmail.com>
Date:   Sat, 21 Mar 2020 11:58:53 -0700
In-Reply-To: <CANYiYbEWWxgNThWPf08tbQ4zd3zY1+ZKR_RyBprOP7BZxOQ5PA@mail.gmail.com>
        (Jiang Xin's message of "Sat, 21 Mar 2020 18:39:16 +0800")
Message-ID: <xmqq7dzda61e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0337A360-6BA6-11EA-B7DF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8821=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=886:23=E5=86=99=E9=81=93=EF=BC=
=9A
>> 13 files changed, 53994 insertions(+), 26252 deletions(-)
>> create mode 100755 po/tr.po
>
> File "po/tr.po" has a wrong file mode, which should be 644 instead of 7=
55.
> I will add a new checkpoint for this.
>
> Please pull tag "l10n-2.26.0-rnd2.1".

Will do.  Thanks.

> ---
>
> This is the pull request for git 2.26.0. During this round, there are 1=
1
> l10n teams made their contributions, and Emir SARI contributed Turkish
> translations, which is a new l10n language support for Git.
>
> The following changes since commit b4374e96c84ed9394fed363973eb540da308=
ed4f:
>
>   Git 2.26-rc1 (2020-03-09 11:21:21 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.26.0-rnd2.1
>
> for you to fetch changes up to 1557364fb485603dcabea23a84fae8d2038dc27c=
:
>
>   l10n: tr.po: change file mode to 644 (2020-03-21 18:26:56 +0800)
>
> ----------------------------------------------------------------
> l10n-2.26.0-rnd2.1
>
> ----------------------------------------------------------------
> Alessandro Menti (2):
>       l10n: it.po: update the Italian translation for Git 2.26.0 round =
1
>       l10n: it.po: update the Italian translation for Git 2.26.0 round =
2
>
> Alexander Shopov (2):
>       l10n: bg.po: Updated Bulgarian translation (4835t)
>       l10n: bg.po: Updated Bulgarian translation (4839t)
>
> Christopher Diaz Riveros (1):
>       l10n: es: 2.26.0 round#2
>
> Emir Sar=C4=B1 (5):
>       l10n: tr: Add Turkish translation team info
>       l10n: tr: Add Turkish translations
>       l10n: tr: Add glossary for Turkish translations
>       l10n: tr: v2.26.0 round 2
>       l10n: tr: Fix a couple of ambiguities
>
> Fangyi Zhou (1):
>       l10n: zh_CN: Revise v2.26.0 translation
>
> Jean-No=C3=ABl Avila (2):
>       l10n: fr v2.26.0 rnd1
>       l10n: fr : v2.26.0 rnd 2
>
> Jiang Xin (12):
>       Merge branch 'master' of github.com:git-l10n/git-po
>       l10n: git.pot: v2.26.0 round 1 (73 new, 38 removed)
>       Merge branch of github.com:alshopov/git-po into master
>       Merge branch 'fr_2.26.0' of github.com:jnavila/git
>       Merge branch 'master' of github.com:nafmo/git-l10n-sv
>       Merge branch 'master' of github.com:git/git into git-po-master
>       l10n: git.pot: v2.26.0 round 2 (7 new, 2 removed)
>       Merge branch of github.com:bitigchi/git-po into master
>       Merge branch of github.com:alshopov/git-po into master
>       Merge branch of github.com:ChrisADR/git-po into master
>       l10n: zh_CN: for git v2.26.0 l10n round 1 and 2
>       l10n: tr.po: change file mode to 644
>
> Jordi Mas (3):
>       l10n: Update Catalan translation
>       l10n: Update Catalan translation
>       l10n: Update Catalan translation
>
> Matthias R=C3=BCster (1):
>       l10n: de.po: Update German translation for Git 2.26.0
>
> Peter Krefting (2):
>       l10n: sv.po: Update Swedish translation (4835t0f0u)
>       l10n: sv.po: Update Swedish translation (4839t0f0u)
>
> Ralf Thielow (1):
>       l10n: de.po: add missing space
>
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
>       l10n: vi(4839t): Updated Vietnamese translation for v2.26.0
>
> Yi-Jyun Pan (2):
>       l10n: zh_TW.po: v2.26.0 round 1 (11 untranslated)
>       l10n: zh_TW.po: v2.26.0 round 2 (0 untranslated)
>
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (1):
>       l10n: vi: fix translation + grammar
>
>  po/TEAMS    |     4 +
>  po/bg.po    |  5404 +++++++------
>  po/ca.po    |   517 +-
>  po/de.po    |  5664 +++++++-------
>  po/es.po    |  5529 +++++++------
>  po/fr.po    |  5490 +++++++------
>  po/git.pot  |  5228 +++++++------
>  po/it.po    |  5631 +++++++-------
>  po/sv.po    |  5559 +++++++------
>  po/tr.po    | 24563 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  po/vi.po    |  5560 +++++++------
>  po/zh_CN.po |  5387 +++++++------
>  po/zh_TW.po |  5710 +++++++-------
>  13 files changed, 53994 insertions(+), 26252 deletions(-)
>  create mode 100644 po/tr.po
>
> --
> Jiang Xin
