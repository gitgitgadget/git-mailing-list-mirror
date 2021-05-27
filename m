Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C36C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4209B61073
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhE0E6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 00:58:19 -0400
Received: from mout.web.de ([212.227.17.11]:35985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233424AbhE0E6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 00:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622091390;
        bh=B4LJe0tB66z9m8+JIcM5M6C9+szmMQkxS4bUTKez36E=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=p6QwoIDWpyidw+6vxbHmYdiXf5ENNuuKI+2Oay81qwjOlsvpUlkolNC/Z2+KPAwV2
         73Opjiv81hoZEdF16locjb9galqalDzKyd3PjLyp74FPSizODO6wsc0kUQi73CB7Nf
         ePVXxJnU1A5ew2DVbdRfS7TVUWDIHFma2ZYPo3Ew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1lBPfn3nK2-00b1wq; Thu, 27
 May 2021 06:56:29 +0200
Date:   Thu, 27 May 2021 06:56:28 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Yuri <yuri@rawbw.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
Message-ID: <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g>
 <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:YJtLDDyb1V5+mlQopkpkVd9Bx3PFSsAH8qgRiEJrJec4/UL66dW
 NSle0J34oH5+ILK0YhW7uAQ0ZhYJ8TUGvaguVcjdBf02ftkqYIYKeLxu0iYQ5YDVjRpyOgE
 pQR4BwDELfenGQdL23732ZdZ4qRIIegQ0MXaktyO1Ta9huw4sPbKBb3PqThion/myVY4tB0
 CTKdTxcm06SWCcTTzI2MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MTowzCrO0Cs=:6qrScjgFqtfLeX7mxASf6b
 xebUJ+Z4Xpvfm2+RMdbnMHztX5YKeiGRAGrjVUyZ1HFxGUzIB7fKebZudPaGC6r2/MfMzyLAb
 Bu7TaJfwkMNAP4tsxrK6Xp+jEht+dFluRitqhFvhjgcYgOmB0vC3bAmTAPqTTBwLovs7kWRBS
 jt2xblJhwFlYrmPouLmMwrRoKZ51BL/+erxpFTv5S8eSchOg5DKSjBBamw4ToAeS36nTg8SwF
 5augSK8oiDOquNeTH4ZtowGtBiAsGnIS3mdb2QVrt0BqDm7d0Ql64xauIHuGDpxpJ95oo/+z0
 dzSsz82H5guTn+qBz8r1xnTWwBHwhOZO6bSYiIZHWnxzVz0IHlYkyMnRysWyBEA1bdl6KeJEM
 x17T+DY5LT29IF1BTLKkh8TmOXyrL8oyBzT6X9Q8ypWLrVAOMO66mifNd2z5uOqIPJsz1u+23
 WKV/0mYjgXpmzY6dMxdJFFKh4rEqbN5JsHv7CF+Onfsogw70vO7yHJJnclfvYCjFxQZSVCu91
 J2P08RVZEqw90SItTPcXEPjSeFgguf69KgXgt/fsSnhZttkf8TFtxJ3J06V5iYuiInRftNA3X
 xYeA6UVYuSqwA2CTKBhbD9BIt0LP2G7akWeWp7V0BcD55MXAt72Ma2aRYzUTsTPoKf6JhG5Iy
 LWAyLXMpRyK28Vby83juLdPT5xI2tfuSeK1eZvFCPflY0x4YevOpHXRp9RJAvR8d1nTOIa4PN
 UamOdv19aJrb/kYk1Ln0WiRKd826S/1RKfI6V7l9kg01Kx9dlyVvFcAwecQ8vgaxBeveMnF9b
 hV3oJaaOnGrueNEwGJNH5YgXcvY9LBW6EGExxtXrCFB9mkhy5nRa79uKtnzelj6DjR6ujpaO4
 R+LyI8ygALQDHUWvlWzwZZHrc2jlDs+UyjWIULwFMgMEeqfQmFEMhfimQvI4+1jNY5YMKxb8y
 KH1wW0JIB38FIc27ztkbn/WBUykM0jrElwu4A8T0boQSnW+45Aq2E0k7aWaiqWPaRjS1J3L9+
 M5Lbx+mIX53P9OrM6rTQVRbgtpKn9VdE5bdqKHzzSvbvhvB9C8+ZytGXsNS/P2g+zUKLij5gx
 R3biqLBnQPrHugnaWN2J4mlaevyfwV3EUsb
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 04:41:38PM -0700, Yuri wrote:
> On 5/26/21 4:32 PM, Junio C Hamano wrote:
> > "git config core.quotepath no"?
>
>
> I didn't have the 'core.quotepath' value set. 'git config core.quotepath=
 no'
> changed the behavior to no quoting.
>
> So it looks like the default value of 'core.quotepath' is incorrect: it
> should be based on terminal capabilities.
>

This are 2 different things.
If you are in a project where only ASCII names are allowed (for whatever r=
eason),
you may want `git config core.quotepath no`, regardless what the terminal =
can do.

(Beside that, are ther terminals that don't handle UTF-8 these days?)

Any, if you prefer UTF-8 as a default,

git config --global core.quotepath yes

is your friend (like mine)

