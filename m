Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B1C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716472073A
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c1JWHCe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDVRfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:35:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:42125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVRfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 13:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587576945;
        bh=2pRp2P3jhjcOyDW4wTcCenyafEJFOuxdBZh6PpL6O1M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c1JWHCe/UhUC/UCFucE4hxqPbsserDJOEdV/ekk6BblTaYcbeG0/Trh/2KSSWBcQn
         No94h6B3PeCAoRrTbtF7TUHnQwSnwdS/6b74zmKZVcZHl5fm9mS1MQG+IPWDLJdfVx
         FtM9igLiEfCaR+EGd/jgQHG0EensIWgvET3/Nr4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.165]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N63VY-1j7VEn2s92-016S3R; Wed, 22 Apr 2020 19:35:45 +0200
Date:   Wed, 22 Apr 2020 19:35:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v9 09/10] Add reftable library
In-Reply-To: <xmqqeeshrev2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004221334070.46@tvgsbejvaqbjf.bet>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>        <a30001ad1e8f94a0f3901c1694c3dd660ba1e7c0.1587417295.git.gitgitgadget@gmail.com> <xmqqeeshrev2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UfNvNhvkv1oW1y8l+kqaT0l3IjNTf9V2yxG0ZqKYRzifNLcli0o
 Ynei+Hnr/z+Oc8lN8mvnspS15Lt6Yow0Uyfq36Atap+RlIW6N9qs5VgXjbv11MXc4kDqwiK
 OdpI9233GFl2lq3Vnd2bizlO8MEKLg92d9tQQ8sE44DahoLiIkMZ9Nl4dwGAKvO4TSM9Dhp
 hyBfU5N0aLxpbAk3C40Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8SmqR/+24iU=:+f6DmEsbzDw7UxeWDKeT0e
 /1gZS30SA1Chz++zv/dp+2FNrQy/R+Ov+/hxy7x+bycdawkjvK4OCa98VadmwKm+SUeDG/sbZ
 +P86BiCRG3luCQEOkkYkyOgpED2wmQ0vLTwz19u5n7WFAmOnweh8rqQ0I+GccKGcOaTc37kZL
 NOuFV1oiwdmNJYtxLiyo4ZxxIXmBh9iXoGWOPyJYCoy3GvL5oGHF069Vpl0FgIHg+BVTa4UHm
 g7A+9T7AJUgFk6TY1Xs0l7mdXJ/znmiLvfIzsnvicOo+mfj18Eftx2NwNbhLTyLewBWOcV+hv
 I//Xjch7n0gJMshcS+4E+x0cD+UrCAQ3dyU5iCb9QP7glvjjnEOQ3zKMXw9HLfVUqy8wm/PLU
 lGgnao9S4HNe4x5Gd10tGAf/zYqh4lhPbwvU/rrMLso1ib1uKLu182jjSfsQMAeVXjE/DmiUA
 JNe6i5/IVkjs+hVCaWjJsufzKDTiaOuMEozsaDIzB7GRoSEXzKkiA5DU8gB5+xOhTWy0fZNlD
 iRxFkKYCEHLv/ITRxazcx+YO9+FHmGpDlllVSp2XsZEu0LcPPDJblJaOGFETr+RGsMXCtSs77
 lnCX/6XRamij5+r4cpPKfAP7ZJp1y15/2soKpa5K/UjrC9nviLH+3qrZmrd6FNJ7B2RFG0h7P
 ghu3qHj+elKXpojQJMj0cQuD/lRj7zGVOoMbtq9OMKIc2PMThCSelYbIpYIS/olptkCIQBQ8N
 ezQ+Ea2SRNFeOy+X2XWA+17bCHYzy14kYc65+T/UHDgyB3umqfJ+TH7G4ynatvFr9BD3RBuj4
 Fr9JILcX+qXnjFb4VBW2Mf85765mM5srTSSaypMGfEt6WmP7nBZv0vjjq0NRYLcoUvSZopTEM
 z+IYJMM4xjDwZVWkHNhCEjgT0ZwCGWGSv9ytI16o+bt9s4cp9+pdX8A5o8G+WzBMYHsIhqPDy
 Yn/H1anuSQpsYg2VYkaKpufBS1QJyjk+1uHZY/YoDgP4F4LN3clMg31J9xR/ZTt3UWR93eE2C
 YUh64JEFEKg0GvD/ss/3Wh/Kg6rmnKw+RoYEi3kXvhAobxl5PybmQoCEtnFSv2eA4Uk1JtqXO
 VpYJdtRLFDTGz91aAu0HptuGO1OjnXXHXJXMiKcx/4d+lqyrcfuRhYNRTmmSiI59m9sC9f9Zf
 kf3SBJ3Sxb6RcqDPjXc8Phm4mhxI9k8Gv6K2R5atE9O41iquXCL4oUofdEQqu537fB4aDagFw
 QFo4lodskzdcVJb4R
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 20 Apr 2020, Junio C Hamano wrote:

> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/reftable/update.sh b/reftable/update.sh
> > new file mode 100644
>
> Shouldn't this be executable, even though the readme tells the
> reader to run "sh update.sh"?

Do we really want to have such a shell script? To be honest, I'd rather do
a subtree merge. In my mind, this should make it easier to maintain this
code elsewhere, yet debug and fix it in git.git (because there is no doubt
whatsoever in my mind that the vast majority of bug fixes in this code
will come in via git.git, which _does_ make me wonder whether it makes
sense to keep the reftable library separate, as if it was truly an
independent part of Git: it is absolutely not).

Of course, this would make it even more desirable to do away with code
that reads like Java (and is probably a silent, defiant protest against
Git's requirement to have no declarations after statements), e.g.

	int block_iter_next(struct block_iter *it, struct record rec)
	{
		if (it->next_off >=3D it->br->block_len) {
			return 1;
		}

		{
			struct slice in =3D {
				.buf =3D it->br->block.data + it->next_off,
				.len =3D it->br->block_len - it->next_off,
			};
			struct slice start =3D in;
			struct slice key =3D { 0 };
			byte extra;
			int n =3D decode_key(&key, &extra, it->last_key, in);
			if (n < 0) {
				return -1;
			}

			[...]
		}
	}

The fact that this code uses a coding style that is very different from
Git's, on purpose, makes it quite awkward to even so much as debug, say,
the segmentation fault that was caused by my rewrite of the test script
(which _also_ looks _very_ different from the existing test cases, adding
to the awkwardness):

	test_expect_success 'basic operation of reftable storage' '
		rm -rf .git &&
		git init --ref-storage=3Dreftable &&
		mv .git/hooks .git/hooks-disabled &&
		test_commit file &&
		test_write_lines HEAD refs/heads/master refs/tags/file >expect &&
		git show-ref &&
		git show-ref | cut -f2 -d" " > actual &&
		test_cmp actual expect &&
		for count in $(test_seq 1 10)
		do
			test_commit "number $count" file.t $count number-$count ||
			return 1
		done &&
		git gc &&
		ls -1 .git/reftable >table-files &&
		test_line_count =3D 2 table-files &&
		git reflog refs/heads/master >output &&
		test_line_count =3D 11 output &&
		grep "commit (initial): first post" output &&
		grep "commit: number 10" output
	'

The fact that this rather trivial usage can still cause a segmentation
fault makes me believe that this rationale for the purposefully-different
coding style implies a fundamental fallacy (see
https://github.com/git-for-windows/git/commit/00eb1fd4496ef763f840878fb524=
9507ae83af43#commitcomment-38614650):

	Each time you use an unitialized variable, you put another mental burden
	on the reader to check that it is actually OK in that place, and the Git
	source code (which puts the declaration and use) far apart makes this
	harder to verify.

The major challenge with writing C code these days, especially when you
come from a background of Java or other languages that take care of memory
management "for you" is that you _do_ have to manage memory in C,
explicitly. And if you already start not paying attention to the
initialization of local variables, you go down the path where all of a
sudden you end up with a segmentation fault and have no idea where it is
coming from, and the most likely explanation is that the memory was
managed incorrectly.

So I would recommend to actually not get sloppy with confusing declaration
and initialization and initializing unnecessarily and trying to get cute
with introducing code blocks "just to introduce a narrower scope for local
variables".

Instead, I would suggest to stick with the style Git developed; We have
gotten relatively good with keeping our memory management straight that
way.

Ciao,
Dscho
