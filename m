Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1761F600
	for <e@80x24.org>; Sat, 22 Jul 2017 11:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755197AbdGVLQq (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 07:16:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:61774 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755147AbdGVLQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 07:16:45 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgptO-1dvVe93Eu6-00oESB; Sat, 22
 Jul 2017 13:16:27 +0200
Date:   Sat, 22 Jul 2017 13:16:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: use access(), not lstat(), if possible
In-Reply-To: <xmqqbmoekce5.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707221309530.4271@virtualbox>
References: <alpine.DEB.2.21.1.1707191450570.4193@virtualbox>        <20170719171251.11906-1-jonathantanmy@google.com> <xmqqbmoekce5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8uGRmXXfiIh5j7wNsj2zsBPTAJPUx1pocQe7+tLQBhfK+HonOz/
 5qIBG0VWIWwfYTA2seYUmbzXvrbIUPVw5Ch1yIX3LTT//h2J5Vqof0IBiXinYu9TSfqlcyk
 sJaFMFnBCQH4EtQ0jszGUCcBSPYK5GYRI0wThXBXQYg60+4w+6q4pNCThopKrQPebHkWnOT
 Ss6aCvxd9U+b6PLlY1u0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tGJmK6AmUEM=:HlpBp1/sPF4+t/1XtGA3bu
 XirSRYALWy3eXkRdaNDmWWEnoxIdeh7iYB0Cti08h1kQw9wcl7eDhvDbM3oZeuQsE8CgDaR52
 RQFYLXMOXYrTz8zh0qHucG4Hne8SbArIill/qdSKU3eKM7mAwycmntMWN+MCYxn806VfQznN5
 noY8YHAifD3D8M2sAG0BY/Qb3EuE0ZiW2TPd2MDvlfTjO5pIaQ/1JsvJFcW1KUrMy8c3AZqor
 M63+KNcE9DZowCpQr/QpgTajWR1l/rV2FAIFBkVqE0++9Qig8U8aHZiTjVaEyWVC0oflwhKK9
 MAMCMlz0SQ/a58lr2kikZ6G08o44lvEI7T4+AP7Rp1H/SmYNndJaJxTPKpGdBuIp1vcUp57Iw
 T8O1ZkDzwWIZ8r4GcoT5yDUcxibt694IRTrapVhOABH6JyDmvl1H6DCADidjauTPoFgmKwIWj
 os9Lw8bUt0GUFsDgMmWEaC/nlxbNLRd51sCGnW06EF+b8XM77cPJHuVfz4ZboImJz8jCrANfK
 X+xa3j6DVrGRPmsQSBL5wvi3ER8n8oPnlqDntv4PAmtB2WIeG0yWm0A5DEh7W5nVi/pZ6ZFAi
 izEajIoh7sMYKl0iHyvSz+GtL2j/k5mEhgMm4SYHyv3l4NVnRgtFYVASPZVfI6MuF8TIeYDId
 rl6A018QdkAqfNUJbT17LhsRMf0O5EIQ1ZDmGuV2Se+xwXx7DQJUJxajS/8b1apdvI6PeX9Y9
 hz6UhiEvpqs95rQsSGQwCIzXJssUixnbJ1aTpOfr8+nx/Jn4RZX5AvX28IiyjkclBg90ROMP9
 NOQvj68/o/dKUv0LEEcYs82BaYGlnxWtH5UQwjHJPUKuuVC6Uk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 20 Jul 2017, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > In sha1_loose_object_info(), use access() (indirectly invoked through
> > has_loose_object()) instead of lstat() if we do not need the on-disk
> > size, as it should be faster on Windows [1].
> 
> That sounds as if Windows is the only thing that matters.  "It is
> faster in general, and is much faster on Windows" would have been
> more convincing, and "It isn't slower, and is much faster on
> Windows" would also have been OK.  Do we have any measurement, or
> this patch does not yield any measuable gain?  
> 
> By the way, the special casing of disk_sizep (which is only used by
> the batch-check feature of cat-file) is somewhat annoying with or
> without this patch, but this change makes it even more so by adding
> an extra indentation level.  I do not think of a way to make it less
> annoying offhand, and I do not think this change needs to address it
> in any way, but I am mentioning this as a hint to bystanders who may
> want to find something small that can be cleaned up ;-)

I actually found a separate piece of information in the meantime:

https://blogs.msdn.microsoft.com/oldnewthing/20071023-00/?p=24713#comment-562083

i.e. _waccess() is implemented in the same way our mingw_lstat()
implementation is: by calling the very same GetFileAttributes() code path.
So it has exactly the same performance characteristics, and I was wrong.

But this whole thread taps into a gripe I have with parts of Git's code
base: part of the code is not clear at all in its intent by virtue of
calling whatever POSIX function may seem to give the answer for the
intended question, instead of implementing a function whose name says
precisely what question is asked.

In this instance, we do not call a helper get_file_size(). Oh no. That
would make it too obvious. We call lstat() instead -- under the assumption
that the whole world runs on Linux, really, because let's be honest about
it: lstat() implementations all differ in subtle ways and we really only
test on Linux.

The obviousness of something like get_file_size() would be so refreshing
to these tired eyes.

Oh, and it would make it much easier to maintain ports to other Operating
Systems, most notably Windows.

Ciao,
Dscho
