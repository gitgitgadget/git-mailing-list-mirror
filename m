Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1FDC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 12:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6DF610F8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 12:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhJ1MLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:11:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:35969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhJ1MLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 08:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635422909;
        bh=8V39zAVnZyX/nA8Dwrwr6Qxul7VhaHy0PzVwi+EJDMM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PmKKCinzf8miUmN7auZ9E3ehufIssIrx08LMiOP6nkTSV3WDwpMQPujwFYmEGBFJ3
         NEYhEfrPkFgL/a/xygdryCCJu6PIOQGVRvIiUJr6xyotIUrAcPHdQzJLvMed5ZIrZa
         kabtqMzqfU2Qx7sNRJRODP2MrheZ9tLNigbfC/Cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.9.46] ([62.202.180.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1mfVyZ1qXy-000gWa; Thu, 28
 Oct 2021 14:08:29 +0200
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailinglist <git@vger.kernel.org>
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
 <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
From:   Peter Hunkeler <phunsoft@gmx.net>
Message-ID: <dd79e443-3bb9-8b83-746b-7db7c4997ee3@gmx.net>
Date:   Thu, 28 Oct 2021 14:08:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-CH
X-Provags-ID: V03:K1:AoUwcCtb6PIxcT8iJdZXk9cU2XmXGxQknimlnQ3Xx/w7orAA/Md
 u5/Nml9SnYNWe2ohXiWQGsQf+Jl7cuzDVdGuCu5lZpvaKRZsNvEvY+Fapvo9UYxbJDBi6Zr
 SDZZqbpWjX6AwmK9ujCV4T5wg8x7hacY7QEMEJjw7mRfY8BAMZtERryvIojtlG99+VUfChk
 WTIVPcbRc2u86ITkQfoig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GFhmVPbMUQg=:t0VX6ZRjdNm8e/JWZ59+Qc
 H5vr19+bAscfP5G3R5kz7RbHEi8RtPUYjtkyyhz/4/hX/flKLWnwX4JPPcYAZk0HjBPG2Rgdd
 DUAEP9I5m35BySUT3bjRSt1el8UhJ2H3cmFJ5B2x80VsRDAW8zGjfS9/x8wvwvx5oC78uvt+f
 8jXidJNOa5z5D7/n3ts3g+XSX/jZABv9+/L3oQjOsRVggdkhxEENK0NWTsnVSDRjCjy5Pi9/G
 pFFRZHJZyAjyrcBSrSmmEz2P/0fWqeIY5dPw+3KlaqsBh7c3ON3vKVX1+Ewet6bclfc36OnZD
 RCby0SeL+5KeNdvcwT+ObdwAHOyNqQc5KoVQvIfdJBRDE1/7tN7eZ4/fR4gLnU+P0OWpgUSs5
 M7KcVmIubL8L/NAXwKCcWnPMpMYIDt0eQzuN7OJUFKtKa8tf8acNFJZxB8q+n1YPtlwAIV31G
 6TrpB5qfbLhZuOup7FAOqMPKtgZHWNckvWw6I6UaIzgHjjtTk+LdmXYbtJTwwR6CpSHiZUGuF
 g0I9vrxc57Ap74sqD047HITNmeC/yjqwMobiLU2BN8mlkRbnQnHPM3qq6RIyI1QSoRs+Tb8vn
 8Kl9/NHjW10xvcygjsxoSteF0rSTiLZ9CJqv62foq2Swt0VmnLpKu8/NhYGcaUvNe6Y4M27TQ
 /g6qHndj7coWEBE5D+h/esjYRjBvCIIjYgdUiHg9ec7ABz/hm3599O+TtVoyrmrmfg8qpG8z3
 cXlvgPRbnU3tPEquRH9nKe31oqisjSglcYNhLoTZV9Y9Dk7BXyJpe5lyO96uoP6Xf7PoaH778
 Sx71IHpYBnbm0J7+fCXfSOvNk/IFWWEVFXDYlCIjknTFWE1CYe2T5nazgp27sjChl49SMd4AI
 6H21ihIIrvHwsibSV/kz+hxGLgmBa09A5AjueMcHZGbfTgJr7RyoJ4bPfcg/k5Gyg0qAGTggF
 wMS+eGJmj76j4/DttTrhrylY3cA6GQLSdjXCUn9x1HIikRkv/2OEFYpqAj+kGvrxQghmqCzAk
 x4e4qqhvdRHorcDEypR/EWnpbCclsnQWNdt2IFsWRBz+UueKJ90R3rARb799Fp7A1l5zUFtvz
 jcAmezpz//0M0s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.2021 um 00:07 schrieb brian m. carlson:
> I should point out here that it isn't intended for pre-commit hooks to
> be used this way; they're intended to verify that the commit meets some
> standards, not to modify it, although it is of course possible to do.
>
I can accept that comment. However:

- wouldn't you agree that git should work consistently? It does not in
this case. If there is anything to be commited in the index, then the
"git add" from within the pre-commit hook *is* respected in this commit.
If there is *nothing* to be commited, except from what was added by the
pre-commit exit, then it is ignored *for this commit*, but it is added
and will be commited next time. This is inconsistent behaviour.

- if the decision will be *not* to allow adding from within a pre-commit
hook, then the "git add" should be rejected. And the documentation
should say so.

I'll have to understand what all the comments from you and others mean
(still a git newbee).

> In general, you want to avoid adding automatically generated files to
> your repository.  That tends to bloat the repository needlessly and is a
> great way to lead to frequent, hard-to-resolve merge conflicts.
>
I'm trying to use git to keep track of changes to my website, which uses
some framework. The problem is: Some changes modify filesystem entities,
only, while other changes modify the content of some mysql tables. So I
need to pack an unload of those tables into the commit. I can do this
manually (and forget every now and then :-), or I thought the pre-commit
hook would be a good place to automate this. And, yes, it may well crete
merge conflicts.

I understand the pre-commit hook is a local thing, and I have to make
sure the same is active in all repositories. Definitely not something to
use in a widely shared project.

Thanks a lot
Peter
