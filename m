Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C3C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 21:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjAKVtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjAKVtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 16:49:00 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A204913F69
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673473736; bh=Xwo5ZH5HZzWU30ur0DvQpnPSzZvh/K7u7yCERS8e2WU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cdkXu/038a1FZt30LrKCxjOPhglmn/cu9reofdFMPuvq9fXXE9CFOWhAx8bYReuAc
         DczZr5+jNgo+zvQKktv/0JkxafUKDwHtlvVR1/3qEREybz03+wWTgs5j7bU/vFCK5L
         eeienmr13h5rSC3+qRTKn2ttxVt9ZOha+owDuVen2NT7kXNi/zC7//NyBqmaH7LS6V
         JRn0bJ9PfLJlxBKbgdrb1zP0ney6pdmNibv+8Ni6WxKEkA7ibbujGoZVioQKrOxT2N
         OZvEELyAygQ/lQwKDCBkdxbNSs3rPRYLeofHqKBuRlu4dYoNYXrQ/QzIhJBqzBHI1y
         dVpCJCDMymKYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1p1P1K2tpE-00EKo6; Wed, 11
 Jan 2023 22:43:38 +0100
Date:   Wed, 11 Jan 2023 22:43:37 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Arthur Milchior <arthur.milchior@gmail.com>, git@vger.kernel.org
Subject: Re: Misleading error message on a failed `git mv`
Message-ID: <20230111214337.ybrmiyeius5xzalf@tb-raspi4>
References: <CAEcbrFc=R=3aEwEE56EvZSPSV4+RWFxt=hm7csZ7oBTR8BDQzA@mail.gmail.com>
 <Y78I5E/BCr1QQ6aL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y78I5E/BCr1QQ6aL@coredump.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:TBEbGyZAyT0TkDHiqwE05GS4Ju6Fk59r5k2OpcpZsaNgWZxPvTX
 QxE3oHnbpft+oHOXX1+5mRz3135XEGQz61x/sdnZQ/GiLvDmH8siIQT3Lbceg2tKvwmVcwC
 WlfBVBkRT5DsCUKDeNG5vd1R90aOMlEsdgzj7J5W+D3CRKlpJSnce4XQhiYbA3BWwXFP9Vs
 okS2JE5BJEo44waCiXNGw==
UI-OutboundReport: notjunk:1;M01:P0:802fp2eeuVg=;rnt5g6JmY+IBRH30o1qbb9wjRCC
 JBFkCXAa3MSWcjz0BruLSdvel8tp+2i+87W3tLbOoVOMGUSEFSN72TFE3hcbmYueqAL9d3DnI
 cXfGLbNl4Q8Qh/yVLlmaC6fzW+FSTijEeegQPwW1ATpIPpOZ7/dKsQwMOARMa4GUBRp1VA6k2
 YsZJ/59pSyBz1nNEdnBLmrmGKXhAEr83Hu4C6J5VI3Hrn3/WWiNFh415br8YnxevNX8oe2Yh2
 IlQ0HlCMtp+C0ksRIpvnETDopr6exJvlayGgBCgnHmq+65/x9beOva//06O7NjHrmU4vb+sbQ
 M16F7fn3u93Euw4HIyY7z9ab+Tpawb995KhHygQY/5W5RGoL5AwcnaW5XF7KqsN7bpr7naRip
 pXxIHMajzKgjJQhg2qDvZ9yBfHM47Xu3+D13b2Ioq9dslf+d4mgOEfvpNWbTaLLT1m77uFOC0
 8yh1y/VX0C/0ApW0sKJCeM63/KbhlVeWfGVkhblQ/jAw5aqHGw0fwOJhGd8af6WxPo/Qhy+or
 KTLcPRGEKqLwKnlmFPJfW6EfvQaRsiXFv0P1rA3NFqLCK7OOZnOrW2hWmU6ikWdDnDhvrKfb8
 WR2+kYz+zS7Ayfc4wJDMGB/33p2GkhOJcKApLnlzSpwbGqrRV/qZhgldc0nyEVdBq1M/liuo8
 r0bjRoAZW1DjWDekEqGatT8TTYyA8rRtQlY2HGV/RTLJDoWtSS7rqt/r8vkwQ4XaV4ylkpnw1
 NEXv60es9Yobn2WAhmwfjCPHH04wLpdYam8XxJKsiccTZdtnxsgnX87lEiXusFE/V+nSW/Y0Q
 MDTRNozuPPgUA2XBObwSIQekmTyok+MOPT+YfNs0VGjRDiflHqLV1Q91kZSFCIL7whjrJFf1I
 OTj6kuktrMdIAEt0vxL1Hi/axN/Ctlt4fLbyThp+howkfeM7bk0cuYNvUV7zmdkIqycPQeRrw
 xYivt/3g17pyMx54TyCMjOQ2cco=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 02:07:16PM -0500, Jeff King wrote:
> On Wed, Jan 11, 2023 at 05:19:29AM +0100, Arthur Milchior wrote:
>
> > Error message is
> >
> > fatal: renaming 'file' failed: No such file or directory
> >
> >
> > What's different between what you expected and what actually happened?
> >
> > The error message seems to indicate that file does not exists. It
> > actually exists. The destination directory does not exists and is the
> > one that should be mentionned.
>
> I agree the message is not specific as to which case happened, but this
> is all we get from the kernel's error reporting. We called rename(), the
> syscall returned ENOENT, and we fed that to strerror() to get "No such
> file or directory". From the manpage for rename(2):
>
>   ENOENT The link named by oldpath does not exist; or, a directory
> 	 component in newpath does not exist; or, oldpath or newpath is
> 	 an empty string.
>
> If we wanted to be more specific, we'd have to go to extra work to
> diagnose each case. Most tools don't bother. For example:
>
>   $ touch foo
>   $ mv foo bar/foo
>   mv: cannot move 'foo' to 'bar/foo': No such file or directory
>
> It's quirky, for sure, but it's how most Unix tools behave here.
>
> -Peff

We may be able to inform the user that the destination is the problem,
and not the source.
Is this worth to do the following ?
Any thoughts ?



diff --git a/builtin/mv.c b/builtin/mv.c
index 19790ce38f..58e24889c0 100644
=2D-- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -452,8 +452,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
 		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
 		    rename(src, dst) < 0) {
+			struct stat st;
 			if (ignore_errors)
 				continue;
+			if (!lstat(src, &st)) {
+				die_errno(_("moving '%s' into destination '%s' failed"), src, dst);
+			}
 			die_errno(_("renaming '%s' failed"), src);
 		}
