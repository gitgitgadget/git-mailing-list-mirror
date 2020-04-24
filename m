Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D65C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDBB20700
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H6Z/M71r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXLei (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:34:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:35161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDXLei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587728056;
        bh=75Rf0D09+L5PAD2Ir4zr/pbcMkm8smBSVL/i8h6Gk9A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H6Z/M71rHLw+NlU6BxGd0whweIHc5a0gCNkzlCJo+5q8R4xvw4ECp7LT29WcB1EHv
         gQb4oP9cFLC2K5ImBWQxeTb44U/XbZSuSzUW08N5AxPxyCiVVMOxiRiGXtM0sLGrHO
         5tUsPHP1glsvv6ZYzdZ4LylvMRo8ZUS3/XKz2TeE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.1]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mzhj9-1jEpcc36Bd-00vfJ8; Fri, 24 Apr 2020 13:34:15 +0200
Date:   Fri, 24 Apr 2020 13:34:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
In-Reply-To: <20200424003926.GC20669@Carlos-MBP>
Message-ID: <nycvar.QRO.7.76.6.2004241331180.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <pull.615.v2.git.1587685397.gitgitgadget@gmail.com> <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com> <20200424000558.GB20669@Carlos-MBP>
 <nycvar.QRO.7.76.6.2004240215100.18039@tvgsbejvaqbjf.bet> <20200424003926.GC20669@Carlos-MBP>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1868818274-1587728056=:18039"
X-Provags-ID: V03:K1:mAbXhzDG7UXcBiF7nw1WBsGb2AJfyLjt5bMzBheDB82fO3c5aUS
 ZFv6BAvAO9RFQKMg8HOGVQhgO1ST8kUVLs+D7DnqRKF/FBd3bwVDfuP0JdiSnN0xXsfEpVI
 wS/PiVUDN2SmKyEQj+hPE9jTU7RO2GVLFmcRG+6B/IqRomdDyg/P5a9B1S33VC7T08bGIQI
 Is7uapRHZaqMnvzyWr8rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+s7Hl0cMS8=:cpAhdQajOKzH4wrTE38DfM
 adGN/Mbnmqr8R6KyU+y+N9xScALajbxATtSxfBA7qOVDPd+xlhpgIFlhK51vHQHw3guCxTEpe
 W+cpsrPzpqrCQADlB55kvLz7DSm8SWPyCW0bK8/utLQwI34/47WWALQzWiIvzAL/oV1HuappE
 e30CpSwF8uHfsuRsJqpNA67ZOLN34PnjFdjlXTTXbLxgajznaFd+JBCAcVIHdKhiJmiSR3fFJ
 ZKu+hYbKouLODev9CLriG2L7iUZlUE3NM1sefdMZLvLKr22OVx2MDABXnnkSAEvpDg6adqH4H
 HAxogbbECig3wj64b3M2tntrc2JZh8LjgBtURen0GV+cASRcPTC6yTg692R3rNie1ftI6JsMX
 Krhh9sAAERCH1sfoiXzQf2ehul/8K2fLy2lMCpWYNyeBoyKu8iGj+S28jFzU8ipXqJCm82940
 UAXSrnf9fQbmtvmAkshyTD4lkBOH5Ja1LWg8mj6VrUjgzRYgas6HDsfxveyTEAuSjrc1t8fTp
 Y6I2U049QUoahSoAnRPvuAEXGiwNGhTZor61lMl0HD+Pbx5lZdLG+9Ads2zkEpe1se2IYuK2R
 75KGO5jmd+EoJEtqU6wed7WchChd8Ntm/yuQNMb/ympkq9aq+asIWoWXeswPiK05gkbrRSHdO
 Tplaxy3kZBBsz8O8W79sCT8mepEEz7WDTVie3pp3CI4N4L3Z32AyyuTQd4wUeUQyheIWDw4S8
 Z+w51wCeVx8kjbDnT6fmDbF1MHNRuloE+v2vxa4FgnomnkdacWWv00KFFgo9qZaMnGMlW2HWW
 F3rHDf09UKGqdip8nGbalX5Bw7hbB9SRL3s2BMfXA0idUHdkGp0p4q+3Ebwj9SANvCbMLbrGl
 PyU9kaMFgd6IRr/OiwWChSIbZh7XTiRQjwMHOFpXilThVmzD1a/cOP/AtL+T0ip/upqxJA/ED
 xaAKFjPEWScnOUWEi/65jCkb0u+gMLbL65lt2CK9O4gH29Q7Olwd7ZyAYntcjkr08dpS7zKpa
 i4RktbljnB5E4n/FAdOcvNCLo94FTsDj9sNNku2BAW/eoDfNdJZWQad/EXjOW+7hUSQPrmn9a
 7UYKDvto5kshCoz8D7rywnEeoZo1vUVShm5jqwBzIDcjT3fwOXj15Y3etZVkMps/ojj1jQvSI
 jFH8fgCe26gwqsAw8d2s+onViyOJO+mz/qJV7iRmqJsWIxLVTaVt0wqKJKKjS73VmfgPENe/z
 ulbuUtoiSB65+AFZ7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1868818274-1587728056=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 23 Apr 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Fri, Apr 24, 2020 at 02:16:45AM +0200, Johannes Schindelin wrote:
> > On Thu, 23 Apr 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > > On Thu, Apr 23, 2020 at 11:43:17PM +0000, Johannes Schindelin via Gi=
tGitGadget wrote:
> > > > diff --git a/credential.c b/credential.c
> > > > index 52965a5122c..3505f6356d8 100644
> > > > --- a/credential.c
> > > > +++ b/credential.c
> > > > @@ -53,7 +53,13 @@ static int credential_config_callback(const cha=
r *var, const char *value,
> > > >  		char *url =3D xmemdupz(key, dot - key);
> > > >  		int matched;
> > > >
> > > > -		credential_from_url(&want, url);
> > > > +		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
> > >
> > > definitely not worth a reroll, but just wondering if would make sens=
e to call
> > > credential_from_url_gently(!quiet) here, just for consistency?
> >
> > We don't have any `quiet` variable here.
>
> my bad, should had been more explicit as it is confusing with all those
> booleans at the end without a flags parameter.
>
> I mean the call should be instead :
>
>   if (credential_from_url_gently(&want, url, 1, 1) < 0) {
>
> since we want to warn if the configuration is not supported just like is
> done after this check.

Since Junio expressed support for Jonathan's idea of using separate
functions that wrap one helper function, I went with that instead.

> > > other than that this series is looking great, under the assumption t=
hat there
> > > is going to be some more followup with non essential changes.
> >
> > I am sure I don't follow. What non-essential changes are you assuming =
will
> > follow up?
>
> the ones that were discussed with Jonathan in a differen thread :
>
> * using a flags parameter instead of two ints
> * whatever will be needed so it also works in master and maint

Oy, I am still under water just trying to get the MinGit for Windows
backports updated so that users can upgrade instead of complaining on bug
trackers and on Twitter...

But yes, that will be the next step. Now that I have a comprehensive test
case, it should be relatively easy.

> > > will chip in with an test helper for that series so we can hopefully=
 keep our
> > > sanity next time someone touches that function again.
> >
> > Are the tests I added to t0300 not enough? Or do you think it will nee=
d a
> > native test helper that is included in `t/helper/test-tool` and exerci=
sed
> > in the test suite somehow?
>
> I think they are enough, it is only that is easier to quickly iterate wi=
th
> possible bad input with a helper. which is what I was offering for the n=
ext
> thread since its need is orthogonal to what you are trying to accomplish=
.

Usually I would agree with you. It's quicker to iterate, and a ton faster
to run (especially on Windows).

In this instance, I am going for a regression test case rather than a unit
test, though, because I really need to ensure that what end users are
trying to do on their machines will work (and continue to work).

Ciao,
Dscho

--8323328-1868818274-1587728056=:18039--
