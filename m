Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D83020A21
	for <e@80x24.org>; Sat, 16 Sep 2017 07:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdIPHgY (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 03:36:24 -0400
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21031 "EHLO
        sender-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdIPHgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 03:36:24 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Sep 2017 03:36:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1505546472;
        s=zoho; d=shikherverma.com; i=root@shikherverma.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=5854; bh=+JX2QflKvjHaOs9Px0kH4NSkN/xQJ4bv+FmDObvoCsk=;
        b=HgdCGeP/XaZHmH365fKVBTt9QJNWAIIBtSJdnI1nVi4AO938mytphqjn4RIeRO6r
        Pq243UBtOBqjBG+3NB4vDZPhT8WxckEntwllCBW26/McGJj/Rt5yAfUtbBT0eHxNlxn
        vtSapB7VNJZnxFXUEMe4gJtZbjB0hiPq3KV0251E=
Received: from weakknees.security.iitk.ac.in (125.17.242.34 [125.17.242.34]) by mx.zohomail.com
        with SMTPS id 1505546472306995.9533139062825; Sat, 16 Sep 2017 00:21:12 -0700 (PDT)
Date:   Sat, 16 Sep 2017 12:51:06 +0530
From:   Shikher Verma <root@shikherverma.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>, gitster@pobox.com
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
Message-ID: <20170916072106.yxpwmndzif3lr2dp@weakknees.security.iitk.ac.in>
References: <20170906093913.21485-1-root@shikherverma.com>
 <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
 <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
 <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7btuo6kvmgeqpe7w"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
X-ZohoMail: Z_65354923 SPT_1 Z_50090816 SPT_1 SLF_D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7btuo6kvmgeqpe7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 05:43:19PM +0000, Stefan Beller wrote:
> On Thu, Sep 7, 2017 at 2:11 AM, Shikher Verma <root@shikherverma.com> wro=
te:
> > On Wed, Sep 06, 2017 at 02:31:49PM -0700, Stefan Beller wrote:
> >> On Wed, Sep 6, 2017 at 2:39 AM, Shikher Verma <root@shikherverma.com> =
wrote:
> >> > Currently, git only stores push certificates if there is a receive h=
ook
> >> > present. This may violate the principle of least surprise (e.g., I
> >> > pushed with --signed, and I don't see anything in upstream).
> >> > Additionally, push certificates could be more versatile if they are =
not
> >> > tightly bound to git hooks. Finally, it would be useful to verify the
> >> > signed pushes at later points of time with ease.
> >> >
> >> > A named ref is added for ease of access/tooling around push
> >> > certificates. If the last push was signed, ref/PUSH_CERT stores the
> >> > ref of the latest push cert otherwise it is empty.
> >> >
> >> > Sending patches as RFC since the documentation would have to be
> >> > updated and git gc might have to be patched to not garbage collect
> >> > the latest push certificate.
> >> >
> >> > This patch applies on master (3ec7d702a)
> >>
> >> What are performance implications for busy repositories at busy hosts?
> >> (think kernel.org / github) They may want to disable this new feature
> >> for performance reasons or because they don't want to clutter the
> >> object store. So at least a config option to turn it off would be usef=
ul.
> >
> > Any typical git push would write several objects to disk,
>=20
> (or just one pack file, [which may be renamed eventually, see 722ff7f8])
>=20
> > this patch
> > would only add one more object per push so I think the performance
> > penalty is not that high. But I agree that we can have a config to turn
> > it off.
>=20
> I personally do not run a high performance server, so I do not terribly m=
ind,
> but thought it would be nice for them to have at least an option ready ma=
de
> instead of a potential performance regression.
>=20
> >> On the ref to store the push certs:
> >> (a) Currently the ref points at the blob, I wonder if we'd rather want=
 to
> >> point at a commit? (Then we can build up a history of
> >> push certs, instead of relying on the reflog to show all
> >> push certs. Also the gc issue might be easier to solve using this)
> >
> > I am not sure how that would work. The ref points at the blob of push
> > certificate. Since each push can update multiple refs, each push
> > certificate can point to mutiple commits (tip of the updated refs).
> > Also if the named ref points at the commit then how will we get the
> > corresponding push certificate?
> >
> > I did think about keeping a history of push certificates but the problem
> > is new pushes can delete refs and commits which were pointed to by
> > previous push certificates. This makes it really difficult to decide
> > which push certificates to keep and which to gc. Also this history would
> > be different for different clones of the same repo. Since push
> > certificate are only meta data of the git workflow I think its best to
> > just keep the latest push certificate and gc the old ones. People can
> > use the recieve hook if they want to do advance things like logging a
> > history of push certificates. I think git should provide a builtin
> > solution for the simple case.
>=20
> What I had in mind was what would be achieved with a
> hook like this (untested):
>=20
>     #!/bin/sh
>     if test -z GIT_PUSH_CERT ; then
>         exit 0
>     fi
>=20
>     # add a new worktree 'tmp', checking out the magic ref:
>     git worktree add tmp refs/PUSH_CERT
>=20
>     cp $GIT_PUSH_CERT tmp/cert
>     git -C tmp add cert
>     git -C tmp commit -m "new push cert"
>     # maybe include GIT_PUSH_CERT_[NONCE_]STATUS
>     # in commit message?
>=20
>     # clean up, command doesn't exist yet:
>     git worktree delete tmp
>

This might be a good starting point for a sample hook if we choose to go
that way. As Junio suggested.
> This would not deal with concurrency as it re-uses the
> same worktree, but illustrates what I had in mind
> for the git history of that special ref.

I personally feel that we should decouple push certificates from hooks
and serve the push certificate whenever someone does
`git pull --signed important-ref`. That way we remove trust from
services like Github, Gitlab, Bitbucket. This could be done if git
stores a map of refs to last push certificate that updated that ref.

Push certificates are preventing MiTM attack between pusher and server.
If we start serving push certificates on pull, it would prevent MiTM
attack between pusher and puller! Compromise of server wouldn't mean
vulnerabilities in your project.

A sample hook solves the immediate problem of making push certs more
accessible. But going with `git pull --signed` make push certs
tremendously more accessible and useful. What are your thoughts on
having git signed pull?

What do you guys think I should do in regards to this patch series?

--7btuo6kvmgeqpe7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEk2wFAZFfZu/iUyvwDYiwhI/dSJsFAlm80OIACgkQDYiwhI/d
SJs8AAgAlrQfXLfgq3yHfq8jkITfe7HPySpnKgeyQDrj7LTbIUH9KOLvKetFwq4S
nfvfwEryjJaNhDN+ITDGmPgp8Ul3hN+axJmr9APvm4N7XRjmYEg4+jBcaF5Itl75
DDbD9TriauxIp2ViUof3vJtVV3aotoMaCgo/LV3OXSgvZRYIU4NppW4l4hq7cJFO
Sb+fGZApfDeUs1H5waJpalPRCG/OG6LgzaZLVRJltMgQOdOqxSpqH9Eews2f7KyI
QERAsOA5Je96wV3Pi1zMdxFGvK3CpBhaajLjDURmXnBWxfpTX04QaN0lE4ZtuwrZ
ZpVkNxFWBIA4E4UWH4VVWFjTp+wFkA==
=/rkt
-----END PGP SIGNATURE-----

--7btuo6kvmgeqpe7w--

