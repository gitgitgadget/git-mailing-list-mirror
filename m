Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07351F4B6
	for <e@80x24.org>; Thu, 20 Jun 2019 22:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfFTWyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 18:54:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50840 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfFTWyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 18:54:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61467168762;
        Thu, 20 Jun 2019 18:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P6o76GbjJIqv
        OV6kHEob/sbzjcE=; b=omPp+/9iwTKQ3y3S0lwFTBat6bQ1MoXg1as8o0iluexW
        P5Be7aKmzbsR1BitG5Y5ascxSxdGSVABC+RCynieNbOQRdMU6z7eF5NItvnMHvvs
        ZjUN7/1l6Qv5RlgKA5zmAGyAZ6l8ijaymx0HMzqe9Vo23W0tDn2NAi7AZ5VAtXU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59627168761;
        Thu, 20 Jun 2019 18:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type:content-transfer-encoding; s=mesmtp; bh=LYsSslgIZFL2Uw1ETF8eYMudqjCF/29wE9dFgix1fOg=; b=rhEArhhZoZZD2IIwXLZ072UYraMn7hFeKxuA1rtJipLf5SnWviKqPCd+dWLcZw9bXmUQ4Slb0FoDZxbinvBQoGJY9L+S/CZkbC/PVutAJA9dOAEms7ImUM6VFSsLMrkJZmqebTDU/kLXUitjYw8qgcFZY56ogRbzMXYLAnYUTkg=
Received: from localhost (unknown [71.233.97.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8620168760;
        Thu, 20 Jun 2019 18:54:12 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     "Boettger\, Heiko" <Heiko.Boettger@karlstorz.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: specifying revision - how to enforce matching a tag/branch-name or revision only
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
Date:   Thu, 20 Jun 2019 18:54:11 -0400
In-Reply-To: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
        (Heiko Boettger's message of "Thu, 20 Jun 2019 14:32:29 +0000")
Message-ID: <87sgs3rhpo.fsf@kyleam.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Pobox-Relay-ID: 527CBBE8-93AE-11E9-8F44-72EEE64BB12D-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

"Boettger, Heiko" <Heiko.Boettger@karlstorz.com> writes:

> Hi,
>
> I discovered an interesting problem when using `git checkout` to which
> I couldn't find a good solution. We have an automatic system trying to
> checkout a branch only when it exists. To do so we check whether `git
> rev-parse` finds a commit for given branch name:
>
> git rev-parse "${BRANCH_NAME}"=C2=A0 || git rev-parse "refs/remotes/${UPS=
TREAM}/${BRANCH_NAME}"
>
> Unfortunately somebody used the branch name "add-gcc10" and `git rev-pars=
e` which didn't exist on one repository. However `git rev-parse`
> also supports to parse the `git-describe` format which resulted in checko=
ut a commit starting with "cc10".

Can't you prepend "refs/heads/" to BRANCH_NAME to disambiguate?

--=20
Kyle
