Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB70BC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 10:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B1F2067C
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 10:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MfIrGqf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHQKOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:14:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:37921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQKOc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 06:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597659263;
        bh=J9Rx3rGqBg5py1Lx8Tbhxc262JYSxJ6LBZqxtZVEZbg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MfIrGqf3nIhGYnDJjP5+z8YfUZm19i4G3mc0euO5E+8wbQ3BEi8Gnx/L9OhXbYkii
         TFywjXOOt7J2biH1hvZV9znU3rdKfCMkf6wP1+VdOuMyUhf/gcjHQb3Fr/Psl/0jXM
         /tCM+zLkEdoTeB7uvAu3TrTQHMESbGQpbA7g9hqE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.215.233]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1jzgKG0wTv-00ApvK; Mon, 17
 Aug 2020 12:14:23 +0200
Date:   Mon, 17 Aug 2020 07:51:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] msvc: copy the correct `.pdb` files in the Makefile
 target `install`
In-Reply-To: <20200817092431.GA1259595@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008170750090.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com> <120d2bb3e461717e5248bb4c97feab86d4e45c9d.1597655273.git.gitgitgadget@gmail.com> <20200817092431.GA1259595@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0GrYg+MkjeLWsZnX2hrKgzD0Uf1051hlVqdfAvIJT55MzyS7Fqr
 crMuVmvE5M6T/uccwlOqBF93fZzEi0d5osXGqrcdQbm77PmUcp/yqSRDxnaNjU9fscODEod
 6AV37oLpcBVuRrr9CmTwTTumlDFFua3oK+qUSNV8mx5PdXINHETqalPolWQf36/jcAcevac
 XSFc+nDd/+X3YNG6wVcCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0xLp0lBHNQ=:5L5A7weq6g9lqVPka4DKJz
 y7Pbkss84quhwTAkI4V2gJi9iHfvL+B2pcG5BJh3iP3uveR+wEKwPkUHkfzFwXZ5grXofQxW/
 OewUgu0jZJtad5es8MwD9BuZWlK5b4tmdCFGXVWUtqTVGPgFsUk3wyxHTQDIFT0wS1Xe1D5jZ
 CxJluUrK3zzaUC5fAupgWLibaw6cT7l9SdnowmiHn48XFRyD8/lULN7hCp7k+5TWy0vUYBQbp
 51M10hSqRSeD80MtCo908o0Sm+aF8GqIsOLySP5paSXXcB6d2D0lY/ErSPLSmmhSz1OB8Y67e
 +G/g6YKcmr1xLrmAH0aBNV/UURg/W+Nz2IHd2jekzBwJp4SpvMkooESdZ2Xkvmf3h5mnZ4p9Y
 DuitSupnWinFhbNLg62Y/v/l5tgs6nO/TGrJNGeZ2to0SecWHIcJSlAKzfhKWwMkGkX2orhzl
 wn5e0c6DO8MO1ulrHCk3LEo+3CO5o6sMR/wZQCAX+KK2lg4JfSmORitI4Ci6W2BBReeJeENLB
 Js1av4xft8v/SON9XPIWFnxTrlFcrjSYe0IvmKwwXZJ8SdOKih7dlYT1kryuvDuStv/DT8Etx
 EQXEloHy2KIdnySR6YbkQTqfjmSndPGo4ds2Ox4ZFZ7k+BAudjG07CaILCnNTf9W1HbNvkQzr
 QvMPzfD2yLXzh44cc5yar1vH2J+sFJ4LpkB8kmyqf05MH30+tnTAQZV4F26FE0CRtUNpE8L3m
 Klsq/D2qHk+/pJNiLjxGWbR+qGv1bzH7weetUkyzcYSzsdcTFRIXdRjEEmsA4OCx2UlE7rKM5
 JN0YXC1o7NeIzuvxPqCi6ivs51hDqV1namTVOSWiN/OdA27aJOIkHAm//RLV5H2ZyXAiPe6Xw
 XDgr5nhm10HaZ9Akx4xWmDUMwn7cfzWdk3ZHe2cGyEI9i/maD3OG4UA86S8f6FalHFQlByHis
 +ofgNQ9o0aa0J5JddIc9OV11wztR/e0t8NmFdHR1C5jeM67/L8hoYnrDEu1Cx2d30eZMofYAj
 hhd9dsNWO2O2OOsSwCCVv/UQyQ0DhzGbpCXOK78vi1MzlA9DCwBE+KV572Na1EJVR4u0NOcCt
 TNflHWPTXxQKe2wq0TkB5ngQ9q/ndT4vKR9tdvASp+zV/02/LCB5eodbVgUi5fK1DdwJJf01w
 Nh/2TJRLW4JH8uJ7wzNAMa2RQabSm81aiuGS2w080+PD/7YCtSZeA1J7QAriI27TrkYh/2jv6
 UQh7IsqF1vSV1oCekUtej5Lc7Xgp3M+e+gEX7FA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 17 Aug 2020, Jeff King wrote:

> On Mon, Aug 17, 2020 at 09:07:51AM +0000, Johannes Schindelin wrote:
>
> > -	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> > -	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> > -	$(INSTALL) git-upload-pack.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> > -	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_=
SQ)'
> > -	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -	$(INSTALL) git-http-fetch.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -	$(INSTALL) git-http-push.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -	$(INSTALL) git-imap-send.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -	$(INSTALL) git-remote-testsvn.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ=
)'
> > -	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir=
_SQ)'
> > -	$(INSTALL) git-show-index.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > +	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS),$(patsub=
st %,%$X,$(BINDIR_PROGRAMS_NEED_X)))) '$(DESTDIR_SQ)$(bindir_SQ)'
> > +	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS) $(REMOTE=
_CURL_ALIASES),$(PROGRAMS))) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>
> Oh, this is much better than what my patch does. :)
>
> The rest of the series looks like a good direction to me, but is outside
> the scope of my series. I'd be happy to pick this first patch up for a
> re-roll of mine (which would require tweaking the rest of the patches on
> top to stop removing things from the .pdb list). Or we could just leave
> this as a separate topic and deal with the merge conflict (which would
> obviously resolve in favor of yours).

Please feel totally free to cherry-pick my 1/3 as your 1/5 (but please do
fix up the author email address, if you don't mind).

I have no problem with my patch series depending on yours, to make merging
easier.

Ciao,
Dscho
