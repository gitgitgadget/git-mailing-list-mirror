Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA89C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8DC20C56
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YOHIENJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437263AbgE2Djg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 23:39:36 -0400
Received: from mout.web.de ([212.227.15.3]:48993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436751AbgE2Djf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 23:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590723571;
        bh=n6oERA67vUvHuBGU4oRkONlyBDUYsY0823Rh4iIKA/M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YOHIENJTADXp4MhmBU7ywo0G287/xZLVJSJwVS3tg/91amashZsTftTsFWNcJuL0B
         afSBDrowTbCheP1qKWDY/oY/t2dms1TAeU/aswxoEOZ+eTetwQplmPT4OMRhTX3pdj
         ThJ4ErW7DXPnbcZivcCAgNK4CMq42GQolxsHk3vo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGiLB-1jjEoc39wP-00DbUc; Fri, 29
 May 2020 05:39:31 +0200
Date:   Fri, 29 May 2020 05:39:31 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hji@dyntopia.com
Subject: Re: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
Message-ID: <20200529033931.xb4jb4ewgdwtjknc@tb-raspi4>
References: <20200528083745.15273-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200528083745.15273-1-carenas@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:E+wrhPgeao9g50Ayl9zPBGerD8bCRblYdNQIbOft1wB+lPdDM3t
 uFQm3fgtLI9phFFdC+VTHwo6leqJ11EdvY5OScdnsNyEwBgGG8Dz+/ipHlg0Dbm1uYRiTsW
 2YWnmhx/3dwwlYNRUFCxkjVzN5gtnHmLt0NXicRFh3cMeiKANCfgy1t7uZ8SuSrkFdP7wEs
 lZEGZ3VdstI9M7BR7bOaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eEV666m3Xy8=:i5Iac8jnpC3/21CpfL//fs
 ad9P9zm9GZyF0L7gY6yo9J54HMR4Q1dX6IkxgkmLMvajLVgu7KHAg+o+eMAh/m1fm1RPI1vXl
 Pdt0K/vbfmg7kp/qRBnU7uIFLBy2s0xwltFDXEEdnh98F6nt47/57aprsIrlV+aJienZ5Tkqa
 LowAyJ9vP8VT1cbrZOyN1BI82I2LGr+XHN2Epe823OeiK61B9xbQOtoQQTigj+Wfdet45ubmw
 kEX5iPsfGWxiFek6kQRBK9JfgJU1UrwKEWBkzeBZEXTJZ9BfX8HfFrs9kQsDOqi+oU3c3Ahcm
 RChDbG30vlhvNAa4IbGmz9Evrgk9sJW7GXzBnq9Dx9yN7mkZEiiUogw98kE6ZZgvEahmvoMvg
 ui8MJmhcW+SWR1etCLEjHRjFRo8RIzFlV5V7BiHlXDf39V1zlcmV4ReYqWmxgU3/CO32A0S8p
 KoJgVelcw51Lcv27BLcJgzcqv3WNtI+2lmGRKFIQ2U8vv183PYSGtbOiJB3mR63m3YAv7UDoF
 TApbKTznAi5y6NqgA39c34/vabXYtFmMlF6rm5bMlEIwEHeImrMCpMpO3rJBc/fJX0has2KGF
 XN79Nn6YWluxjjxb8TlLEjbVjWam3a8nf3oyFdl0mdOsnvRm5xt3pjI6+qd7HsT3H9t4AVOuC
 a3W6ThL2KqPa5D7RuQsCLtbfy4RX2K8lzHa/nX4CJdO69NIAQhXeyR87x3sCXitApXwOCJ0eI
 eYy1UqZPsCNGR+tfypIiBrVw+HwAuEpMccRge24TYcclTx/GFveppqkPc4is0DH+y3aCPBCpK
 XtM7bSEx9zppNlKQFutT7zXcRpUaDovfXmpVzh8sEpFA2onyMdKaQJUMWwLTpXSq0jw69Bl/u
 hBMvqI4hdMj5cpnk/SIo582azeBy+4W4A2ZVRKVyRCAyJ0xzzg3bR1TGXrmxeqKzK6GNI6CWo
 rqJNmfsGoBcnpqMxG2EUAL5pyqhXml9Gt8uWSMXWyQ39ivHixABQfXFiRegVPUO509KdRRLYH
 yaCQ1kz8ZwEhX3hAtn5VrzeSLgh7BpOrjhebb+lyP3Vke9VSSXTieMHbUapQfCMgq9wbBF68s
 h6YGkF1Y7B4cWPWeTKnFXdPjIzHVA74xQb1yWSyHh1uqFEPHIuuF/iWJFWcZz9UdINZcJka6Z
 bsff4ktBNi57bm1X4be4iJKf49443Ol2LF9AtAYpkIwrDQ99d4gD6NoX82o1Aq5cp2DDNt/DY
 i53JQnhgrFZRk0iSG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 01:37:45AM -0700, Carlo Marcelo Arenas Bel=F3n wro=
te:
> Using and escaped '|' for alternations is allowed in some implementation=
s
        ^^^
Is this a typo ? "Using an escaped"...
And there are more typos and small things that deserve improvements.
> of grep (GNU and busybox, al least), but it is no suppored by POSIX[1]
> and therefore will fail in at least macOS and the BSD.

I don't think that macOS (or BSD) ever claimed to be be POSIX compliant.
How about something in this style:


Using an escaped '|' for alternations works only in some implementations
of grep (e.g. GNU and busybox).

It is not part of POSIX[1] and not supported by BSD, macOS
(and possibly other) non-GNU implementations.

Solution: Use =B4grep -E=B4.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.ht=
ml#tag_09_03


>
> Fixes: f1e3df3169 (t: increase test coverage of signature verification
>        output, 2020-03-04)
> Signed-off-by: Carlo Marcelo Arenas Bel=F3n <carenas@gmail.com>
> ---
>  t/t4202-log.sh           | 2 +-
>  t/t6200-fmt-merge-msg.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index f1ea7d97f5..a0930599aa 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1692,7 +1692,7 @@ test_expect_success GPG 'log --graph --show-signat=
ure for merged tag with missin
>  	GNUPGHOME=3D. git log --graph --show-signature -n1 plain-nokey >actual=
 &&
>  	grep "^|\\\  merged tag" actual &&
>  	grep "^| | gpg: Signature made" actual &&
> -	grep "^| | gpg: Can'"'"'t check signature: \(public key not found\|No =
public key\)" actual
> +	grep -E "^| | gpg: Can'"'"'t check signature: (public key not found|No=
 public key)" actual
>  '
>
>  test_expect_success GPG 'log --graph --show-signature for merged tag wi=
th bad signature' '
> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index b15582a7a2..e4c2a6eca4 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -103,7 +103,7 @@ test_expect_success GPG 'message for merging local t=
ag signed by unknown key' '
>  	GNUPGHOME=3D. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
>  	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
>  	grep "^# gpg: Signature made" actual &&
> -	grep "^# gpg: Can${apos}t check signature: \(public key not found\|No =
public key\)" actual
> +	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No=
 public key)" actual
>  '
>
>  test_expect_success 'message for merging external branch' '
> --
> 2.27.0.rc2.257.gaada2199e1
>
