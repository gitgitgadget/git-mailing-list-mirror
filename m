Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A9C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9B42082E
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Pzmrdkhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfK3WHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:07:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:52481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfK3WHT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 17:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575151632;
        bh=t5R71RNoiQENxoSUtTZnFSyPnRLKk1fY8fcMvWWtQrQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PzmrdkhxQPTCbQMB39t6klCsSTKe7LdXFCmwFG2k4QVO2GBMhah0EFUBRi3J0jYLz
         1nDS5kel3hq1Apoy8IKs6wBw9rHbmesicOej/SxJtV9k/8z+xB+lyajyG3dytBQlw2
         t1JwmpgYgFiclU/V/jHlFcHUgBvf69x2y6iMeaik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1i0Rm308yN-00qesm; Sat, 30
 Nov 2019 23:07:12 +0100
Date:   Sat, 30 Nov 2019 23:06:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: do set `errno` correctly when trying to
 restrict handle inheritance
In-Reply-To: <52f2fe39-6a71-a327-8aea-ba757b7eec18@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1911302303510.31080@tvgsbejvaqbjf.bet>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com> <685360f735e35e837bc9ef684cbde33564c81666.1575063876.git.gitgitgadget@gmail.com> <52f2fe39-6a71-a327-8aea-ba757b7eec18@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:X0mSIMqLHff3B1t0JQ9GoYJJuxLlDh0XUo0Gu6QU8I87to7aJIH
 c7p93l8NIQpf0E2xlq3xwyeNNKiIRFx7L38BAdMRtFTobJbKXtEJhkg8rIgUUzjez0wGIF8
 5AHg/6KmKguQKFAjoJQHia2JdiEL+BDexG6zx8jBwYBfYW3XOeZrVu0ixVhYDzY0pSTVsds
 Sz5ZUHeu3WdYOyGCruGJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xxt79srLYy4=:57G0oHICwE5oCYKy0yTHx7
 FL0EMUTJeAb6s4DQbrmuhrk2K464jpIcVfbeYVJxXy0mReHaXhSy5jTyFmUVWWdlwJzfmz3DC
 bOD47+EgqnVrWdsLWtGx0muDj3aI/lRWSyS/TKF9tzEdY2uCFm6mb/38uqYWs2fdQ3425ZsFd
 /mtuab9oJwVmHX8h5hajCDyawmrsxmGr3t8QeC20BGUfQTEMbIHu2i6QXbUtFZZFzFDfGAKHP
 6H+kUfYPxwI3lTFYSkam0SsvyJv0oZSJon6cXGkoqgkyhmJFeci2zCCvXity03u5c5PDoQT5k
 xJ618aIEcRf7L4xwU/B451nC1C02jeSexVlqwgsanBCVQho54CvYTYRI0TqHOYWMSTjN/G1mB
 3oWwVxA/X6FLfDgCzA4N3dIWgvHWy9phYMVURGbsMml8TMOzOoxvLetxz2K0z9pO6BNlBkx11
 pPjZKDreYhkAopUqSn/VGdmktOkv75OJSnt/2Xyqtf7dUpsy1iB0mXeWwdGIrzmtQ+MJp7g7r
 wuoiIiiG/z1dJXUsRxznyjMEtblh73lxouz4KVPqndFhCx5LmgGWv21xQsjLNBrczfRnmbvAf
 fXsttk9fqEf4DzeGxZJWx7vHnxnJ6/bYot/+P7QG1Mh/K0/UQ7JmMy8Belk+VinKgCoiqNUI+
 g2UFXtSPT3Nm3UH7j0Md7IjStejYbMujYaf7RU7SMDGf+XDY/eXA3MOpyiWDFudkoV8pqNapJ
 vgQ+wOl1T6CEGAgB12fewZJo5szfPRh8PBIk3pIu3OykzquqHliovR2WaD8qy9rnAJValid/+
 NJnIeDhELcePdL+u0Bf1yo4T3wqYIc5dkHcA8tkep4WDGitYGbzSrvOKgJ/Hk0eN08nzKH0CD
 Qwr+Nn7Dpdg50D2JuCVrZn5ghFGUZs1un3lTyFQ6D9jMQIpvnp0FegyOgJ2xOAPRW+fwgNweK
 g2PDCRZnVIOTWNjsr5aSUT+bPhUoz3NY1Yft1j63lQRh80w83HZUucZDNQvsD7JTZP1ZSmcCI
 UC7iOuhY09hnsy86UqKKs5itaCcYC588T1cQVdzuiYQAQol6om8mqu+WOZouQ5zvlLcy8hmTE
 SDC6PVasskjsYqbBW6fXYuj9X5YwGyukvBz+FGBNaBXUAom1WRUAqB2lpsEJgXn7D975tBPVz
 9GFyjNmqJWglJ6Z/eTK017tgeznjzlh+uYOIz5+wamzH5WtDM41P2rTXYqpwpQ+fb8VTbLr/C
 NrGgwSL5FWLC/hxTmIR0oMnP1GTRuVhGJMVA7S0F19LXfzEwQbWn8Tc3ei1k=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sat, 30 Nov 2019, Johannes Sixt wrote:

> Am 29.11.19 um 22:44 schrieb Johannes Schindelin via GitGitGadget:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 9a780a384de (mingw: spawned processes need to inherit only standard
> > handles, 2019-11-22), we taught the Windows-specific part to restrict
> > which file handles are passed on to the spawned processes.
> >
> > Since this logic seemed to be a bit fragile across Windows versions (w=
e
> > _still_ support Windows Vista in Git for Windows, for example), a
> > fall-back was added to try spawning the process again, this time witho=
ut
> > restricting which file handles are to be inherited by the spawned
> > process.
> >
> > In the common case (i.e. when the process could not be spawned for
> > reasons _other_ than the file handle inheritance), the fall-back attem=
pt
> > would still fail, of course.
> >
> > Crucially, one thing we missed in that code path was to set `errno`
> > appropriately.
> >
> > This should have been caught by t0061.2 which expected `errno` to be
> > `ENOENT` after trying to start a process for a non-existing executable=
,
> > but `errno` was set to `ENOENT` prior to the `CreateProcessW()` call:
> > while looking for the config settings for trace2, Git tries to access
> > `xdg_config` and `user_config` via `access_or_die()`, and as neither o=
f
> > those config files exists when running the test case (because in Git's
> > test suite, `HOME` points to the test directory), the `errno` has the
> > expected value, but for the wrong reasons.
> >
> > Let's fix that by making sure that `errno` is set correctly.
> >
> > It would be nice if we could somehow fix t0061 to make sure that this
> > does not regress again. One approach that seemed like it should work,
> > but did not, was to set `errno` to 0 in the test helper that is used b=
y
> > t0061.2.
> >
> > However, when `mingw_spawnvpe()` wants to see whether the file in
> > question is a script, it calls `parse_interpreter()`, which in turn
> > tries to `open()` the file.0/compat/mingw.c#L1134. Obviously,
>
> Copy-and-paste garbage?

Yes :-(

> > this call fails, and sets `errno` to `ENOENT`, deep inside the call
> > chain started from that test helper.
> >
> > Instead, we force re-set `errno` at the beginning of the function
> > `mingw_spawnve_fd()`, which _should_ be safe given that callers of tha=
t
> > function will want to look at `errno` if -1 was returned. And if that
> > `errno` is 0 ("No error"), regression tests like t0061.2 will kick in.
> >
> > Reported-by: Johannes Sixt <j6t@kdbg.org>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  compat/mingw.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 2b6eca2f56..bb4eb4211a 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1423,6 +1423,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, c=
onst char **argv, char **deltaen
> >  	const char *(*quote_arg)(const char *arg) =3D
> >  		is_msys2_sh(*argv) ? quote_arg_msys2 : quote_arg_msvc;
> >
> > +	/* Make sure to override previous errors, if any */
> > +	errno =3D 0;
> > +
> >  	if (restrict_handle_inheritance < 0)
> >  		restrict_handle_inheritance =3D core_restrict_inherited_handles;
> >  	/*
> > @@ -1580,8 +1583,8 @@ static pid_t mingw_spawnve_fd(const char *cmd, c=
onst char **argv, char **deltaen
> >  		ret =3D CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
> >  				     TRUE, flags, wenvblk, dir ? wdir : NULL,
> >  				     &si.StartupInfo, &pi);
> > +		errno =3D err_win_to_posix(GetLastError());
>
> I think this should be protected by 'if (!ret)' because
> err_win_to_posix() does not handle ERROR_SUCCESS and turns it into
> ENOSYS. It's not that bad because in the case of success we do not
> guarantee any value of errno anyway.

Ah, that's the reason!

Are you building with `NO_GETTEXT` perchance? I ask because gettext
overrides `vsnprintf()` with their own version, which is obviously quite
different from the version MSVCRT provides... and the former version is
what I use, and what all those CI/PR builds use.

> >  		if (ret && buf.len) {
> > -			errno =3D err_win_to_posix(GetLastError());
> >  			warning("failed to restrict file handles (%ld)\n\n%s",
> >  				err, buf.buf);
> >  		}
> >
>
> That said, this fixes the failure.

Thanks,
Dscho
