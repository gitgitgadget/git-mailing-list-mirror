Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53639C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 11:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A346207D8
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 11:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EI7HgnbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLL4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:56:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:56545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFLL4C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 07:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591962948;
        bh=xVZ0jLTHPZ3CdJVKd+w3Twt1N/yQCtwTtsOisRZPDYQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EI7HgnbW9U+ODuIpF0gfOmGYkgkZza1Iq4t9gJ0tmsvh4w8fg/y5vnULNEVJCdl5k
         yJZYxkbDwwgyYn17pCUI4/Pbjr9d+0So/X5VKNCRNJ0WPdinfVzzZ9VsUN12PcWnzO
         CPHJxjpLWG06H8LS1C4+J0KC8yjOoabLsqIormzU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1jbhPa3Vun-00AGHM; Fri, 12
 Jun 2020 13:55:47 +0200
Date:   Fri, 12 Jun 2020 13:55:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <be09ffbb-4e38-5b67-54da-0b60d5e2d8c3@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006121308030.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <be09ffbb-4e38-5b67-54da-0b60d5e2d8c3@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:npwT8yTn5HLKP6msDC3uz7XdmqqHTCHtCk/FAsO44CiK5SWVIiS
 Nrr+nufBh9C2zObHCheMy9rD2D7ItHuJUaRS8tQsGcMQkjbYXXeDPIAmpyDWkfS5MTytDhq
 KdiCvovE0OaHEw41/nPDb/l8PE2LL449O0ozwp2rP7aeTIbzhVriW64YOHxZszoq4an8xJx
 mxtOPD2xmzJwBTZWfdnHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zvpOCM6t0jM=:uJn8kwWLIGtPZeyi/7JGH4
 k8yngtmpTw1kIsUtqMj3Clt7pdqy8NexfrBQ4hfX7KdGbxuWuAd3H40WDU9WNnlkoM0hE+FW9
 PW56jaShrU+7pOjAYla076vw24nSfGmfIw9butgv9rXKupkjm+6VRc93u+bba3zyq1jE6S5nb
 cOsSPNK6+2gmf9Eo01FEE37n6Cena5nLfHYIHGZPs1tRlHVtiH+hpOnc/EDLIMLMtYePWim73
 D5Mx0Msn5wdn2XZu9Ux1pjGKjZir5/s+d17hNXKUrq5h+D+OZWszf2T5YGpVxbWWntWiwHnmC
 6/c2EAWOuzlPZqGWwluowK3hYkLMLxouSizb7VOt1WdHwiUMPrf8ONo3H1b6J2C35AUmLA1wO
 FCAHHKI0I6GnCIy3Dzlcgp/oH1mjAjYCTktsih5z37tcL8dig0Xq0BNfRyGWMqG7Lk5J/0/qg
 xwbCCBg6YWkxRZboOdqcUr2gey1+hdE0y0wJDJFnsXoDU72YSCnP6fZGgU+d1dp/gYYS1vuK8
 Q8/YbRg+6cecwpbsvtalwzFFXaYh7xvlsq5w4jp09/hAEJK2baS7/LApdMKIwIUDJ3Is4gY+r
 YySgqiYBiEvFZUsd717D7jrBmCMv5MPqlj8czvpMdxK9tdxcrE8DsZzqDC7wS+iPBTBLffCpE
 XU/mfzeJk89UY7cprCOB0SLbjskNgLKEu16LK8HpDMOXJ4Kh7cFY5NsFJkdLJElSmrBg3W1N2
 CwXMbhNL82KtscogCcPXYHRYzem6w/aDMFYVsEpZrVbNd7il55InslHzJBHipJZhdUbYyI85z
 aIaX2AS8sRvDZJrS57XR9d3bGBFY79pv00/wq4mmOVDdnlxozyzqC9epCQ9Z3ie3sDmYyDZU2
 x5Q7KsnYfOOixhYi9yzqaX+iU210elDyoIlHhqsZKk4QDLBKSVngTXCrkTSeYp1sOfuw/lgdL
 uhKaG0SbEJCzgZGz67fj4LRUusIClVaLj1mPoaNjQZY8oiK6wrs9nqT3icgrAxGMqmi2rIlNJ
 9ejIKeLQ3ILMulcYd4D3UbPwwcjUJlOO21mjtkc3YpRqTgbYU+SjR3zXEEvNaKwghhsPNPaaH
 XV1Pbkv4o1oktoTzwCG0ChwJ0b6ztt8suPuSJhTkFjSX0EBEigHkY1IrnCxFhUa4JzOw9YMxo
 BjvQAune9kKsFDh2/g4v8VfVD3tk0GTUn8Dvth5cB+mffw/Ztw+yq+kYbcoQkqM0dUFziV3qu
 ZmDjiei+6RZ8ai/52
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 11 Jun 2020, Phillip Wood wrote:

> On 10/06/2020 22:19, Don Goodman-Wilson via GitGitGadget wrote:
> > From: Don Goodman-Wilson <don@goodman-wilson.com>
> >
> > There is a growing number of projects trying to avoid the non-inclusiv=
e
> > name `master` in their repositories.
>
> I think it would be helpful to explain why 'master' is no-inclusive even
> if it originates from the concept of a master copy. i.e. it suggests
> master/slave even if git is not based on that concept.

Unfortunately, we do not even have that defense: the term `master` was
copied from BitKeeper, which firmly uses it in the `master/slave` context.
See e.g.
https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html

I added a _brief_ extension to the context to the first commit's commit
message. However, I do not want to go into details here because _this_
patch series is only about empowering users to change their default main
branch name.

> Have you got some examples of projects that have changed and the names
> that they are using?

Yes, there are plenty examples, and I do not want to pick a tiny subset to
demonstrate that. A more useful resource is probably this post:
https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMasterT=
oMain.aspx

> I think it would be helpful if we can agree on a replacement for master
> - if every repository uses a different name for its main branch it adds
> an extra complication for new contributors to those projects.

Sure, and that's what I thought we'd discuss, too, maybe at the meeting I
proposed elsewhere (Emily started a new thread about it:
https://lore.kernel.org/git/20200610222719.GE148632@google.com/).

> >  For existing repositories, this
> > requires manual work. For new repositories, the only way to do that
> > automatically is by copying all of Git's template directory, then
> > hard-coding the desired default branch name into the `.git/HEAD` file,
> > and then configuring `init.templateDir` to point to those copied
> > template files.
> >
> > To make this process much less cumbersome, let's introduce support for
> > `core.defaultBranchName`. That way, users won't need to keep their
> > copied template files up to date, and won't interfere with default hoo=
ks
> > installed by their administrators.
> >
> > While at it, also let users set the default branch name via the
> > environment variable `GIT_TEST_DEFAULT_BRANCH_NAME`,
>
> I'm not sure we usually promote the use of GIT_TEST_... environment
> variables outside of the test suite.

True. Together with Alban's suggestion to make this purely work in the
test suite (i.e. not even adjust the C code to respect that environment
variable), you convinced me to (re-)move that part of the commit.

> > diff --git a/refs.c b/refs.c
> > index 224ff66c7bb..8499b3865cb 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -560,6 +560,40 @@ void expand_ref_prefix(struct argv_array *prefixe=
s, const char *prefix)
> >  		argv_array_pushf(prefixes, *p, len, prefix);
> >  }
> >
> > +char *git_default_branch_name(int short_name)
> > +{
> > +	const char *branch_name =3D getenv("GIT_TEST_DEFAULT_BRANCH_NAME");
> > +	char *from_config =3D NULL, *prefixed;
> > +
> > +	/*
> > +	 * If the default branch name was not specified via the environment
> > +	 * variable GIT_TEST_DEFAULT_BRANCH_NAME, retrieve it from the confi=
g
> > +	 * setting core.defaultBranchName. If neither are set, fall back to =
the
> > +	 * hard-coded default.
> > +	 */
> > +	if (!branch_name || !*branch_name) {
> > +		if (git_config_get_string("core.defaultbranchname",
> > +					  &from_config) < 0)
> > +			die(_("Could not retrieve `core.defaultBranchName`"));
> > +
> > +		if (from_config)
> > +			branch_name =3D from_config;
> > +		else
> > +			branch_name =3D "master";
> > +	}
> > +
> > +	if (short_name)
> > +		return from_config ? from_config : xstrdup(branch_name);
>
> If short_name is set we return without validating the name is that
> intentional?

No, unintentional. Thank you for pointing this out. It will be fixed in v2
(still working on it).

> > +
> > +	/* prepend "refs/heads/" to the branch name */
> > +	prefixed =3D xstrfmt("refs/heads/%s", branch_name);
> > +	if (check_refname_format(prefixed, 0))
> > +		die(_("invalid default branch name: '%s'"), branch_name);
> > +
> > +	free(from_config);
> > +	return prefixed;
> > +}
> > +
> >  /*
> >   * *string and *len will only be substituted, and *string returned (f=
or
> >   * later free()ing) if the string passed in is a magic short-hand for=
m
> > diff --git a/refs.h b/refs.h
> > index a92d2c74c83..e8d4f6e2f13 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -154,6 +154,12 @@ int repo_dwim_log(struct repository *r, const cha=
r *str, int len, struct object_
> >  int dwim_ref(const char *str, int len, struct object_id *oid, char **=
ref);
> >  int dwim_log(const char *str, int len, struct object_id *oid, char **=
ref);
> >
> > +/*
> > + * Retrieves the name of the default branch. If `short_name` is non-z=
ero, the
> > + * branch name will be prefixed with "refs/heads/".
>
> Isn't the other way around - the branch name is prefixed with
> "refs/heads/" if short is zero.

Absolutely. Thank you for your careful review, I read past this at least
half a dozen times.

> > + */
> > +char *git_default_branch_name(int short_name);
> > +
> >  /*
> >   * A ref_transaction represents a collection of reference updates tha=
t
> >   * should succeed or fail together.
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index 1edd5aeb8f0..b144cd8f46b 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -464,4 +464,24 @@ test_expect_success MINGW 'redirect std handles' =
'
> >  	grep "Needed a single revision" output.txt
> >  '
> >
> > +test_expect_success 'custom default branch name from config' '
> > +	git config --global core.defaultbranchname nmb &&
>
> In tests we usually use 'test_config' rather than 'git config' as the
> former automatically cleans up the config at the end of the test.

Right, and in this instance it is `test_config_global`.

> > +	GIT_TEST_DEFAULT_BRANCH_NAME=3D git init custom-config &&
> > +	git config --global --unset core.defaultbranchname &&
> > +	git -C custom-config symbolic-ref HEAD >actual &&
> > +	grep nmb actual
> > +'
> > +
> > +test_expect_success 'custom default branch name from env' '
> > +	GIT_TEST_DEFAULT_BRANCH_NAME=3Dnmb git init custom-env &&
>
> It would be good to test that this overrides the config setting

Except that we'll make this a thing that is internal to the test suite
now. So this test case can go.

Thank you for helping me improve the patch series!
Dscho
