Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C652018F
	for <e@80x24.org>; Sun, 17 Jul 2016 12:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbcGQMlz (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 08:41:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:52394 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbcGQMlx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 08:41:53 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MWkZL-1bqPQs3mSB-00XttT; Sun, 17 Jul 2016 14:41:49
 +0200
Date:	Sun, 17 Jul 2016 14:41:48 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Josh Triplett <josh@joshtriplett.org>
cc:	git@vger.kernel.org
Subject: Re: format-patch with pager.format-patch=true gets very confused
In-Reply-To: <20160717025642.GA30640@x>
Message-ID: <alpine.DEB.2.20.1607171438030.28832@virtualbox>
References: <20160717025642.GA30640@x>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:X9Gx9IYtiYFSw4TPgrLi0EaELK1/gP07cAZJA6Cp9yI65oqXHkz
 ebGV3E2uMjd3i8H0JYMeGsPkjo6L0BYZWoxh5HM7/AaUtcsEkhjiSm2dLQ6JaOqyBlJXpzi
 8jicrZXXNAVeGCvXLjIKhiYhHMzwnORynM8VKM3aASSuzW7IdgKoLqp/QsmgqYHvxwG0Ugd
 DDr8IVCOGSW9faKhs/dtw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:rqgK9YUVDOk=:JWg/bQOqvfO2qHlhCIeMH1
 56m1zUN4UVniMlzSVvQV6j9Yqm8rt2cod2W2LhMj0GEag5Qwea8RGToLm4+5dGsRXdIFPVep5
 1EntdTR4PtpviI5oKWV3RE6FUxyIrMKxElvTcCW9aVjNCh4dYrYbUcFNoMsVgONRMpOzm0pmJ
 jLRYJ1NBoXbB2Wdc4S/nlOP26TXW+IqiybZik+bJm0v1SJzOCZXTHpHOmmjTjNtFK9N1cE/q2
 keX8F53MKFn6bU4iax7In9lufyY+tYkKNVlakc6TQYk2wZKCNh0M64/gmQ7neMhQW/efk51bU
 rpUmklKYlPOEicpjwiUj1FGaFGLyVBBmUpIq8fZuIMil0QpU/vpIydnh+mnfxmqMmYPdjRmg/
 ShWFB8T+fYnakKWqEBRWrhWSb4dgychnnkToH6YYnhkRtZrIEWud4D8UNjajI2pM29fBpf6He
 5OjCZFo3j5Fs+rcL0kQM+egAfCDFrzqhQIGyVurYpLkzG0pa2t06Wsn2pkThYON2i/0yA+grc
 ye/Zg/+nyb16bvgc6as6l1sMFTi26t4Hj0+//cBFBJTIArq9LRy1SeRxVpcjspNQ02wu/oasx
 8BhmFp+X7vklMnSFnuBp77S6DYTN8KlUVBNMfaMgAf4v7WsioqtAOgortZJZrzH99HnY0xPfr
 hCRK1GOVQklYcYfA2rHoIW/SHUUjV0/0AA1ZRHAaUFU751pBLIH0HoyFF54eQO2wXlVapkEtL
 oOT/baIyFVg+KNk0mOGGZUt97q+slWWSTeDYJINREUzmeIU/X0frJJoUDDOQCuy8DN2R1jdII
 sfaNrIC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Josh,

On Sat, 16 Jul 2016, Josh Triplett wrote:

> git-config(1) documents the ability to enable or disable the pager (or
> set a command-specific pager) for any command by setting
> pager.<cmd>=true.  For most commands, this seems to work as expected.
> However, setting pager.format-patch=true (or setting it to any specific
> pager) breaks badly: the pager spawns, with no output in it, and the
> pager doesn't respond to keystrokes (which makes it difficult to quit).
> 
> I think this may occur because format-patch's "reopen_stdout" interacts
> badly with the pager.
> 
> I think it makes sense for "format-patch --stdout" to respect
> pager.format-patch, but for format-patch *without* stdout to ignore
> pager.* and *never* spawn a pager, given that its only output (the list
> of patch files) goes to "realstdout".

As per http://article.gmane.org/gmane.comp.version-control.git/299451,
the `js/log-to-diffopt-file` patch series will be merged to `master` soon.
This patch series avoids the reopen() altogether and should fix the
problem you experience.

Since it is already in `next`, it should be relatively easy for you to
build and confirm. Would you kindly do that?

Thanks,
Johannes
