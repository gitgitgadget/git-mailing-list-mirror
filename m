Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65A01F461
	for <e@80x24.org>; Mon, 26 Aug 2019 21:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfHZV0v (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 17:26:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:50753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfHZV0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 17:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566854799;
        bh=8sltO7voQyvbPvRMgJDKhUUyTO09RvWvwnBhKSePuMg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BPHWdxf/qHuBr1RXasXffqeFL8F4aajVJwodOEiviyuz66s3oaH51LauB+AbwQ+2H
         SsWJIPLZiqiwt5ZHQeWS5PXzgZKrfKdNZvb63/HKpy9429896F00lSqc9gDVaV60Bi
         8TZT0fBjYOKMEnNqRdsTbmdu1Mq4uWxVfI+EEs6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1i2MVa3Qe0-0004D9; Mon, 26
 Aug 2019 23:26:39 +0200
Date:   Mon, 26 Aug 2019 23:26:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/11] Start to implement a built-in version of `git
 add --interactive`
In-Reply-To: <xmqq1ry6qeg2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908262317250.46@tvgsbejvaqbjf.bet>
References: <pull.170.v2.git.gitgitgadget@gmail.com> <pull.170.v3.git.gitgitgadget@gmail.com> <0a5ec9345d2f9cc6cd348231219d4af428a28e94.1563289115.git.gitgitgadget@gmail.com> <xmqq1ry6qeg2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vTwEbl/iQR9gMVswL+QzD4cVrx65LUkam1eYqN6IiHhVDp31HFh
 /YJBWSctlzNPjRda4eyk6s5qI9EfS5TYHlpO/pXwQDl/7fD3YsGeNV++Fbm1bDWQX1f+tNh
 CKYyu5sa43GIZ9KIcImxJIX/PyoB8SW64CiJ+q+EhK4TjQ17W2EE018eZZrjwMuPoUD0ze5
 ZM73nsJkVSXfPf3z0wi2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4uCmxj9vuyE=:wUbNS/hZgRCaifS0xj0TlJ
 +cZijZoreEPmEmzjW6axTz691WCiQpZpFUYP4CFI6HIyEq+BT/9RSWR89wEmqqepgll5TP3da
 fbGWPSy7JscypqbClpt8kfSttysoHZPWyLK3RrZQLGLf9dpEwzBdS0fpiwommgvQ605vyq1Tp
 x/PsKSvjSvmGbt5OE2PnCOVpZscid+y+hX4U1nWnt7t0raGPbKMBxPx+9b9Pga2BAC8kUmH1H
 eEeE7U8KhhbY28hs+Cm16nGKKdJgiZDhDGhJGSwcNfUaZhA4zAWe6XShkBi4C7P/VUjKZz+of
 RFkyjabcqeitEjiEWdXQNMhnuGRgdEigLH37V+Gu13uOh4fTdF6g/dPWTVPTbrifViGpEM/lU
 bGg1fw1VQNV4DTl9E++vL2DVmgmsPeuPfjmBGRRUJANCMTiYW0JxRSjkxT73/VQeNbbTyDFQn
 ca445ZpBTVotesi3Ai49OStE0UiHIkufGO1D/lMYkwtZiNTSZgMSUvh9cVc8aWxoYw/c9wwml
 MQDywJEdQgsYcMEVFDUwlT/SGC1716qi5Q5iBbAbJluVbuCvo6W2BSiioQkNHZ6ZTpY204fyK
 jLfRbhAO+zu9e+IELgYCF/J26haBZ9VfzIsCWc+ycXNRoQoBck79dr5cAydwSgpkS8lfcm8qx
 Bqs3QigemsgZibG0mlVPO5BdX4aIWPjNmocan9GE4Vf4PBhRfGamvFWEGwYvnQfFd+j/JFDsq
 C1T5pBaA6jJzIB0/JxgVoVTcsEBWV12tApxhivJYnBWio9gs6YcF46n9rGm5ujPEJnMyLhb8/
 oJia/gMD8y2miuagX2vvlOML7pOt7Z2XAOY6AchNc5ZKPA0JVs9f0M2otLV68OrRcncYoJFwN
 wjUDdkVWBT6SiEO+7LqgRKhv41WPOyH35M/hKz5dB4S5EOMEdpXsr/0alG8Yv7iKacunkWn+0
 Op3dA1yUp3bHrgzWNOfvKf4H7mL+1GjcM2qFNcuVivW5rqQ9e1Z9zNDZZk9uLjpjesbXMDr36
 mecZj2yFDTzt8pH300IYKKY++TngezygY9ReRNYmRv2SoeZFH+/HundNpQMZLD6rDAoEt3RaY
 g0SVT3JGhWHAHs1ZGb3CIMuXx8JAd7k06cEB/bqUNLs/ZikwKJ09bwJAL6Ju4ksg7WKWQNaIR
 ykW8w=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Jul 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +add.interactive.useBuiltin::
>
> I am not sure if three-level name is a good thing to use here.
>
> If we have end-user controllable (like branch or remote names)
> unbounded number of subcommand/submode to "add", and "interactive"
> is merely one of it, then three-level name is a perfect fit, but
> otherwise, not.

Well, my thinking was that `add.useBuiltin` would be misleading (because
the non-interactive part of `git add` is _already_ built-in, even `git
add -e` is built-in). And `addInteractive.useBuiltin`, to me, would
pretend that `add-interactive` is the name of the command.

Besides, I really hope that this would be only temporary, as I already
have a fully-built-in `git add -i` and `git add -p` in Git for Windows,
as an experimental opt-in, and so far it looks like it could replace the
scripted version relatively soon, so maybe that particular part is not
worth all that much worry ;-)

> > @@ -185,6 +186,14 @@ int run_add_interactive(const char *revision, con=
st char *patch_mode,
> >  {
> >  	int status, i;
> >  	struct argv_array argv =3D ARGV_ARRAY_INIT;
> > +	int use_builtin_add_i =3D
> > +		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
> > +	if (use_builtin_add_i < 0)
> > +		git_config_get_bool("add.interactive.usebuiltin",
> > +				    &use_builtin_add_i);
> > +
> > +	if (use_builtin_add_i =3D=3D 1 && !patch_mode)
> > +		return !!run_add_i(the_repository, pathspec);
>
> I am hoping that eventually "add -p" will also be routed to the new
> codepath.  Would it make sense to have "&& !patch_mode" here,
> especially at this step where run_add_i() won't do anything useful
> anyway yet?

The `&& !patch_mode` is here to allow for a gradual adoption of the
built-in parts. I don't want users who opted in to using the built-in
`git add -i` to be stopped from using `git add -p`, so I don't want to
print even a warning, let alone an error message, when the patch mode
needs to run under `add.interactive.useBuiltin =3D true`, even if that
part is still scripted-only.

Of course, eventually this will be handled. See
https://github.com/gitgitgadget/git/pull/173 for the
yet-to-be-contributed patch series.

I just don't want to send a multi-dozen patch series. I really don't
think there is any effective way to review such a long patch series,
let alone an efficient way to develop it incrementally based on feedback
on the mailing list, hance I broke things up into 6 separate patch
series (as indicated by the cover letter), and this one is the first of
them.

> > @@ -319,6 +328,7 @@ static int add_config(const char *var, const char =
*value, void *cb)
> >  		ignore_add_errors =3D git_config_bool(var, value);
> >  		return 0;
> >  	}
> > +
> >  	return git_default_config(var, value, cb);
> >  }
>
> Good addition while at it.

:-)

This was actually an oversight, sorry... But since you're in favor ;-)

Ciao,
Dscho
