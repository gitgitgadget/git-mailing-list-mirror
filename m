Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A67EC04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D3B20720
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Xh1bzgAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBGPpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:45:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:44891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgBGPpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 10:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581090347;
        bh=IB3H8A/j8Uzc8fAL0at/6HJfEryVQi7nYZRdBbEfAC0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Xh1bzgAUvDdNxK+50AIQsJx9BoQlX9ne7RMpBIVthj6FjaBAP7HUYP4DgTet2az31
         9d7S71UdYMr53m3qWgBttb20cEVYGtLeR4CdpY9Qfy2/ULBFBHot4cOlJyEJXVRUcO
         nH0cCU/Lz+VVgPiu1VkZwg0eyHHAgRkSA+tlFJsA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.114.111.241]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1jdwpU1e9j-0152hH; Fri, 07
 Feb 2020 16:45:47 +0100
Date:   Fri, 7 Feb 2020 16:45:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Markus Klein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Markus Klein <masmiseim@gmx.de>
Subject: Re: [PATCH v2] clone: use submodules.recurse option for automatically
 clone submodules
In-Reply-To: <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002071621160.3718@tvgsbejvaqbjf.bet>
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>        <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com> <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c9LAnRqy0VaUZxCKTDnfObqacPImk40QSvDQPLsZLBzIIj7NvU1
 FxjOEiW3/tbR+tYO+QBfAbKYMlrTa1t0DULCDWSbx1PXWk49cp6mVdq9zSMl24dc1lB8fSZ
 HN20KhrYALJmJ9/LWsy+Fcwph/w5bulqrBPL0ceTdTVWoVhHk6joYL+l458ZrlpgmDLBgXB
 fMnSD4xcz8qP8w2UgL/dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dza8qgBOB+Q=:8IaD6uaeJGw3JS91MPUERO
 T3RPje5TZgaINU91XHhsaEuLCUzCsp8tTAfJpShkWTYvxEn6mj693PjrjYMX6RFCNXvXS/lqf
 mkxZjBq8QGV9c7JQuw3O2nDMBmNksObQ0f9IBnwvw760h7zIx9kxMRAb/hbpBweUBXLsEVDAS
 loBEM067EGHRwaz2Oq4JZIvJ491LsO4dGK8VJkTtqeldBDLE6+KwtH+Z4Zs1I/7h9cx/NB+sE
 nqeDGS5OEWM8euPQaxu+VQjFgDKepW+1OTF/t/QPc7jGlmt0xPW/CarNzybbpzGEjTjioU9yk
 1imiwTAFBNdrzr64hul6BS02WfxSN/VigpJaD/v/c0KNYoMgQ2WDsPxWyH0A2mub9LSbCvBl4
 V4ot7N/s4DUG+bdNORlhihCQsJe4VlBz51fr0SoxfjHUiO6ZwfKZKrdLoXdtoh3FzPOG7OsTi
 qEpgmP4kXB+JDdB5NEI3MA3GiEh5r0OkARAgqahFrHyVNmrweE4ZCMz/x0nM9xXzeNJHB+J60
 ppVxeIN5KYew2G7TQ9/RqrsCFGVZjwe5310UDDaHRd8dLtzoYwx48oG1/xvsPf4DjfOBSRFgO
 IiYc5Is9AyIHGsptmv67WDtASvnfs3gLX+KH4moNqlNwlKea6eVZkRi8UZlPeToExnQiQDuqV
 SAoXalVhv5JokCO45VDGtv4oo7/Rjvg95d5nzwqLG3+m122T247KjKp1zcAVxPV/sKRrpHd59
 0h/urKyJ2jKNX036MkNJtyuCG5APKfzbSmEgsHAGtJHC+UuMrvxam8qEu4Z0wuJc1XvopW3/X
 zoUu/64bOEzAoIYWPvZu4StxUeEiV6XXxe+anMUU9Wy5xeFvo3/VloVHUyk3hUkvOOXW1A0W8
 rvRuda2zTZZm6c3HZRXAxYvw+NDF9lT34oG/oYUvd0Y2+tGtqe+CvOe0+YevCQjLFuhV/kysh
 dUyR0EBBqxxY04GaqmzardlpXgUoipO+eAkc4vqCjGudid/iDSSQsQJqFNVskHaiMkQ+Cw/ZF
 vuCnEjzd615FtFwPNpi+uOFvf51mc8191cUDhKd5Sgu55txOx144CetTtzqd7LlSyBH+eOjJ9
 aSJLGce5mXswcHSjNSAaBFypK6lpsJB23m30KxaXonF83JlXvihqLLlFFmxN2JeoLyE47FheB
 i4YwTIax2nNbi4Odm7SKSvlbpun6Vfi+8T/ffU0JtJjYYB4XR+9vzcw/275wJ+58LAqAE6bvB
 cq+l8K80GNn0Gn3WG
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 6 Feb 2020, Junio C Hamano wrote:

> "Markus Klein via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static int git_clone_config(const char *var, const char *value, void =
*cb)
> > +{
> > +	if (!strcmp(var, "submodule.recurse") && git_config_bool(var, value)=
) {
> > +		string_list_append(&option_recurse_submodules, "true");
> > +		return 0;
>
> The breakage of this is not apparent, but this is misleading.  If
> submodule.recurse is set to a value that git_config_bool() would say
> "false", the if statement is skipped, and you end up calling
> git_default_config() with "submodule.recurse", even though you are
> supposed to have already dealt with the setting.
>
> 	if (!strcmp(var, "submodule.recurse")) {
> 		if (git_config_bool(var, value))
> 			...
> 		return 0; /* done with the variable either way */
> 	}
>
> is more appropriate.

Good catch, and I think you will have to do even more: in the "else" case,
it is possible that the user overrode a `submodule.recurse` from the
system config in their user-wide config, so we must _undo_ the
`string_list_append().

Further, it is probably not a good idea to append "true" _twice_ if
multiple configs in the chain specify `submodule.recurse =3D true`.

> I still do not know what this code is trying to do by appending "true"
> as many times as submodule.recurse appears in the configuration file(s),
> though.
>
> When given from the command line, i.e.
>
> 	git clone --no-recurse-submodules ...
> 	git clone --recurse-submodules    ...
> 	git clone --recurse-submodules=3D<something> ...
>
> recurse_submodules_cb() reacts to them by
>
>  (1) clearing what have been accumulated so far,
>  (2) appending the match-all "." pathspec, and
>  (3) appending the <something> string
>
> to option_recurse_submodules string list.  But given that
> submodule.recurse is not (and will not be without an involved
> transition plan) a pathspec but merely a boolean, I would think
> appending hardcoded string constant "true" makes little sense.
> After sorting the list, these values become values of the
> submodule.active configuration variable whose values are pathspec
> elements in cmd_clone(); see the part of the code before it makes a
> call to init_db().

Indeed, I think I even pointed out that "true" is not an appropriate value
to use here: https://github.com/git/git/pull/695/#discussion_r367866708

Ciao,
Dscho
