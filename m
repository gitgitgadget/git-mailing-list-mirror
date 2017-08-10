Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9F81F667
	for <e@80x24.org>; Thu, 10 Aug 2017 22:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbdHJWXs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 18:23:48 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:59954 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753089AbdHJWXr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 18:23:47 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 8C61A3C000740;
        Thu, 10 Aug 2017 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=E
        7x9mD7NZKmXtXHwnNtkNc1qKRI=; b=FGsVz63wq+uEgHyoCBiAds2cfREivtggh
        lllrEq8leSqYzd6+bRkYOHooAWbUi1UVm5kduHub7SZ8YcW5CPc3trc4/Fk5WyWc
        1BNUDCZHJ4FIMPzSZlW+yGvWI0UfUL+YRhb/NJ1pR8zoY6pmDGVzKSq2FJGS63gW
        aJ8PCgXOGk=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 259F23C001C18;
        Thu, 10 Aug 2017 15:23:46 -0700 (PDT)
Received: from odin.tgcnet.jupiterrise.com (router.tgcnet.jupiterrise.com [192.168.20.58])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 64D81605EE;
        Fri, 11 Aug 2017 00:23:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by odin.tgcnet.jupiterrise.com (Postfix) with ESMTP id C209CE8017C;
        Fri, 11 Aug 2017 00:23:42 +0200 (CEST)
Subject: Re: [PATCH 0/4] dropping support for older curl
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
 <873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com>
 <20170810213236.dej4ibsag2lxf5w2@sigill.intra.peff.net>
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <fbd7e636-0087-9c2b-746f-e2413c6d2133@jupiterrise.com>
Date:   Fri, 11 Aug 2017 00:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170810213236.dej4ibsag2lxf5w2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GH
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/17 23:32, Jeff King wrote:
> On Thu, Aug 10, 2017 at 10:33:18PM +0200, Tom G. Christensen wrote:
>=20
>>> You've totally ignored the argument I made back then[1], and which I
>>> reiterated in this thread. So I'll say it one more time: the more
>>> compelling reason is not the #ifdefs, but the fact that the older
>>> versions are totally untested.
>>
>> Perhaps you forgot but I stated in the original thread that I build RP=
MS for
>> RHEL/CentOS 3, 4, 5, 6 and 7. I still do and I run the testsuite every
>> single time.
>=20
> I didn't forget. I actually double-checked the patches you sent at the
> time, but I didn't see one for the CURLPROTO issue. And indeed, it is
> still broken for me:
>=20
>    $ cd /path/to/curl/repo
>    $ git checkout curl-7_15_5
>    $ ./buildconf && ./configure --prefix=3D/tmp/foo && make install
>    $ cd /path/to/git
>    $ git checkout v2.14.0
>    $ make CURLDIR=3D/tmp/foo V=3D1 http.o
>    gcc -o http.o -c -MF ./.depend/http.o.d -MQ http.o -MMD -MP   -g -O0=
 -Wall -Werror -Wdeclaration-after-statement -Wpointer-arith -Wstrict-pro=
totypes -Wvla -Wold-style-declaration -Wold-style-definition -Wno-error -=
Wno-cpp -Wno-unused-value -Wno-strict-prototypes  -I. -DUSE_LIBPCRE1 -DHA=
VE_ALLOCA_H -I/tmp/foo/include -DUSE_CURL_FOR_IMAP_SEND -DNO_GETTEXT -DSH=
A1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -=
DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_TRAILING_IN=
CLUDE_SHA1_C=3D"\"sha1dc_git.c\"" -DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H=
=3D"\"sha1dc_git.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat=
-util.h\""  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLO=
CK_MONOTONIC -DHAVE_GETDELIM  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSH=
ELL_PATH=3D'
>   "/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"'  http.c
>    http.c: In function =E2=80=98get_curl_allowed_protocols=E2=80=99:
>    http.c:685:24: error: =E2=80=98CURLPROTO_HTTP=E2=80=99 undeclared (f=
irst use in this function); did you mean =E2=80=98CURLPROXY_HTTP=E2=80=99=
?
>       allowed_protocols |=3D CURLPROTO_HTTP;
>                            ^~~~~~~~~~~~~~
>                            CURLPROXY_HTTP
>    [and so on]
>=20
>> I just built a pristine 2.14.0 on CentOS 5 with curl 7.15.5. No proble=
ms at
>> all neither with building nor with running the testsuite.
>=20
> As you can see, this does not compile for me. What's going on?
>
The call site for get_curl_allowed_protocols() in http.c is still=20
protected by an #if:
#if LIBCURL_VERSION_NUM >=3D 0x071304
         curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
                          get_curl_allowed_protocols(0));
         curl_easy_setopt(result, CURLOPT_PROTOCOLS,
                          get_curl_allowed_protocols(-1));
#else
         warning("protocol restrictions not applied to curl redirects=20
because\n"
                 "your curl version is too old (>=3D 7.19.4)");
#endif

> I don't see how it could work, as CURLPROTO_HTTP is not defined at all
> in that version of curl.=20

Indeed but the #if will handle that.

> Can you please double-check that you're
> building against the correct version of curl, and that you are building
> the HTTP parts of Git (which _are_ optional, and the test suite will
> pass without them).
>=20

I use a mock buildroot and there is no other curl than the vendor=20
supplied 7.15.5 installed:
# pwd
/var/lib/mock/jrpms-el5-x86_64/root
# find . -name 'curlver.h'
./usr/include/curl/curlver.h
# grep LIBCURL_VERSION_NUM ./usr/include/curl/curlver.h
    parsing and comparions by programs. The LIBCURL_VERSION_NUM define wi=
ll
#define LIBCURL_VERSION_NUM 0x070f05
#

[root@c5-32bit-01 ~]# rpm -q git
git-2.14.1-1.el5.jr
[root@c5-32bit-01 ~]# ldd /usr/libexec/git-core/git-http-fetch |grep libc=
url
         libcurl.so.3 =3D> /usr/lib/libcurl.so.3 (0x001e7000)
[root@c5-32bit-01 ~]# rpm -qf /usr/lib/libcurl.so.3
curl-7.15.5-17.el5_9
[root@c5-32bit-01 ~]# git --version
git version 2.14.1
[root@c5-32bit-01 ~]# git clone=20
https://github.com/tgc/tgcware-for-solaris.git
Cloning into 'tgcware-for-solaris'...
warning: protocol restrictions not applied to curl redirects because
your curl version is too old (>=3D 7.19.4)
remote: Counting objects: 2793, done.
remote: Total 2793 (delta 0), reused 0 (delta 0), pack-reused 2793
Receiving objects: 100% (2793/2793), 780.88 KiB | 639.00 KiB/s, done.
Resolving deltas: 100% (1233/1233), done.
[root@c5-32bit-01 ~]#

<snip>

> I also won't claim any absolutes. I think we all agree this is a
> cost/benefit tradeoff. But there are a lot of options for building on a
> very old system. For instance, building without http if you don't need
> it. Or building a more recent libcurl (and even linking statically for
> simplicity).
>=20

Of course that is always an option but it does complicate things.

> I'd find arguments against the latter more compelling if recent curl
> were hard to compile on old systems. I don't know whether that's the
> case (certainly on a modern system, it's much easier to get newer
> versions of curl to compile than older ones).
>=20

I have no experience with building curl on older Linux systems. I know=20
that I can build it on old Solaris releases but that is not quite the=20
same since there I am also building against recent versions of curls=20
dependecies (openssl etc.).

>> Also FWIW Red Hat continues to support RHEL 5 with the Extended Life-c=
ycle
>> Support program until 2020-11-30.
>=20
> I saw that, too. But as I understand it, they provide no code updates:
> no bugfixes and no security updates. They just promise to answer the
> phone and help you with troubleshooting. It's possible my perception is
> wrong, though; I'm certainly not one of their customers.
>=20

I am refering to the Extended Life-cycle Support product (ELS), which=20
promises:
"the ELS Add-On delivers certain critical-impact security fixes and=20
selected urgent priority bug fixes and troubleshooting for the last=20
minor release"

The full description is here:
https://access.redhat.com/support/policy/updates/errata#Extended_Life_Cyc=
le_Phase

-tgc
