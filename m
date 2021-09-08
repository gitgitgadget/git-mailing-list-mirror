Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3575460F6C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbhIHTNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:13:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:56489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345251AbhIHTM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631128297;
        bh=JecNp87opHi2vZlMpTqwU6r//uxZtiF/Z6rJost1EGE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ePRzl3OMSB6cjYoQ7zFHUt/93egYBtAgn8fpk48yv37bplApsa/0tQO77dKF47zu0
         8U9nsHDJOVW7+DCtOyLsWvULOYlm3zI4gnGmzqzJiNColIdsTnWBLJpJXU/MCr6y6k
         v9XmcdpHz7/KS4g7cRMoj+Yz1jP6g5MqcLE6BA0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1mA4LW1CP9-00HNDJ; Wed, 08
 Sep 2021 21:11:37 +0200
Date:   Wed, 8 Sep 2021 21:11:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 07/15] scalar: implement 'scalar list'
In-Reply-To: <7d68dc36-81b3-1c8e-61d7-c656aee8c1fb@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109082111360.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com> <fb7c931ddb3a248542bc6a03d09189e937315d0c.1630691688.git.gitgitgadget@gmail.com> <7d68dc36-81b3-1c8e-61d7-c656aee8c1fb@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9rdSHit8PJf5DdLhMB3vL8IWvGV3WAqBydyoOwOrV4ZdduBXbsj
 JZXqWLE2gfc+9+NOMwhFVhhhtOn/vT+6zxOmUl4yjNj4BD7y9dAimxWiIm9RqvnAgf+45yT
 M8pMgSo14kLI/fkhKnV1CnUu54GcIEwevIXFRwooqHUh69nkfWHf0S7VbCaP15iRsLwZD5/
 R+MTkbfb/5LIVOwJ39WZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NAnDx5Ln4Jo=:WJa8QLp5d1QyT47+C77Mv1
 bqmbVwN+s2opEeIcppXmLA1VNlUjruaNZK6oQTeLXTL5BvrEyz9ffRrTikNtOWSuQMiu79ko/
 GWX2i7SLd+I57tbB1P9Xkc1JyRzk+M77k0Wx7dyn6S8/fCDylzV+jhSa0Kdu8C89iHdSdigtt
 +orwdzZhjGR2uJj1jWkY2bXQ67rupdseYoTUqBdMR2eVOqeph9RaZbcm+RYKTR7c6vTO3WLDs
 Xp3TS6XDcocj/h78l5d4zeBKDEaVTfOeUBVIoEagFBc5AmM95QnA/jjv/sdawAIDZjYJ/q0jD
 7uWbjhDiRdwpDVD7QGPq8Jf4q/FAoC38hYRdn7XHU7DmwGZj2DuaRjq07bbx5ID3HbJ+tZKa3
 Vqbj8l7cJmZxsLPQDQvbqnmyC+g3PByoMBrCGj9A/kWEueGrIvuIGtHHODfK2ffXhwjzQmdu9
 vqLn5nNrpEDKwRZKnrKVkweLyvDIfchXaxfvPDUU0TYOcnFEVqA3q6DA/69gnbWlrIlGoWSLy
 2RJsxBFETHAlVb4LBGd8rBMPDEZuBhYo2+/Xinqk+QN/O4CE9NKceXsjZv9XkeH/iDrmVg9LM
 fR0WAaQxBTW4KDx+hgblL3883lca5IzQW3yOQfUNx06llFaq1hkjw7k8p9ma/4xGVky/KGh7H
 /3Y+1IUCfemhG31Kb8IVA5WX9JwAs6fUTsjvRM35XlpYZ9gKr7le3Z+0xsnYi6Sd/tuyEqqkM
 RPDLh9d3G8i6fIPjdWGVDy5fErVTuut6mi3jd4Q7TbjMRZ/zgKwqmUxL6lOFMygNESmg4dOJf
 rWhmFcHjS3jThv2eI6lZBT/CzJXTZdtDMNTSsv9hH25WngG0GhmhEOnZbdjABi0r8cGrjWuiV
 tpq4OCDCCMG4tMkNlReIjBA7zdXGiqHrDsmR2b2hXcZVw5CZ0oabUP/CCdWQQcE/Ee9HxkuHr
 HirsWXpQmXNk9iV9g+8EWS8D1nn1BboUBMLmvxCG3pOTv+aIPho6MdrhZfS2pOViDP7hXpgLy
 uNpC9i8IP+WtfgYSMSJRhSjQ3tDZUZab4wac4PTwMIO+AjW6r+8xjc76tsPtKPtCnbzkQKQyE
 74L3c5AAZaTQwM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Sat, 4 Sep 2021, Bagas Sanjaya wrote:

> On 04/09/21 00.54, Derrick Stolee via GitGitGadget wrote:
> > +List
> > +~~~~
> > +
> > +list::
> > +	To see which repositories are currently registered by the service, r=
un
> > +	`scalar list`. This subcommand does not need to be run inside a Scal=
ar
> > +	enlistment.
> > +
>
> I think the man-page-style wording should be:
>
> > list::
> >  List enlistments that are currently registered by Scalar. This
> >  subcommand does not need to be run inside an enlistment.

Thank you, I adopted that wording.

Ciao,
Dscho
