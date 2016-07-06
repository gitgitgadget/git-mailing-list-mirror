Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97EE620705
	for <e@80x24.org>; Wed,  6 Jul 2016 08:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbcGFIYJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 04:24:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:51950 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbcGFIYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 04:24:08 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mchyv-1b3Jra0nEP-00HvPy; Wed, 06 Jul 2016 10:23:59
 +0200
Date:	Wed, 6 Jul 2016 10:20:03 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	David Turner <novalis@novalis.org>
cc:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 15/21] index-helper: kill mode
In-Reply-To: <1467532693-20017-16-git-send-email-novalis@novalis.org>
Message-ID: <alpine.DEB.2.20.1607061016330.6426@virtualbox>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org> <1467532693-20017-16-git-send-email-novalis@novalis.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:88AsQ3QQ/ifawjMlDMP6k2aokMjE4GAmompS4l3sMxtSALrK7id
 lbB7+L974ONrOOoNsEnxv/CbpxU93YHiznm6JakJ27kLThKujptND05XA7pbFgE9WVkzw+7
 RnGA98Vyz5XEhQ5KpeHvNQHmra3Aq0uUXL3zupL1kLR2CGoHcv7Lq9JYoluPTb2rKhMBKNB
 qgB+pMOr2vxHZhpbVJKvQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:unTZ8nLvavU=:RCES5gO9uaPmXnIs+H/ip/
 MCFfAg0F1gfnvNCHJMn75Lx2aDhPyMvih9TLsptU5N4HotlLnVOv6C7KVJ4+ie/y7P5XKjTpR
 /LABHRzVgC2Xw15lwcHcdU6MbTMcWLPrc33J7Ex5BcTuYNAV/7uLrHELkeI0/JKARaxHd6mdt
 iIrnt7wKWN26THSEqYT9vKoU86Qk8v0lclPCPeUMAIr4pUtABFH/qHerdKDhpXS8ocIXz2s48
 P94T0SwTWCstjRqZPs0t+ARLpzbcpSfRnF7f2/qRb1c346zs9VOuyAPhAg7siRO2gvHXrzYc/
 7TWvcVrIaOITFIodyteNwtliNzhv9gB4qMt8yNHKe5W1p8yA/CIzMVpAkMsiDyvbUFZQI2XOf
 fh+FtaHYi2hkHUyQ6Z8W7IBJGquAVy2QPvjAO4D+dPzU4T/yi06P+Q2QhhgCXtNfGZySp4Iel
 tWfpH+m28DeFBqNb1ajF6u34xfyAa1UlcMG8HVR2cupqE/xmoJS3bk1iP4LouTHh9by2NQql3
 3VAL2uh6abxNjuI2bowFkR+0Kyns2cL5Fc4j81LSEe8YnQwNeZgNz5shdFkfsCiiBLmCaHoiu
 DNYc8hdPIcWVhBZh3wdLh8twgZqEVHVP8EWq1CFn5jcennh4e3aQzAzigsEnIgF8/t8hjXiSF
 QZsa8KS7yUHZIauQ6f3uonUwyC+iQS4YPX24NLDa5irnViv8WTQZLJH9PkRvWOqe8Q96iqhRA
 qFvzwOlJXHqt/JGjwL+KR9ryjIJ2oaDeCE4lovwLTolRFYvXJvVqP/7rLfi0efaLAKexkIrP7
 Cv6rzXW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Dave,

On Sun, 3 Jul 2016, David Turner wrote:

> @@ -357,10 +359,29 @@ static const char * const usage_text[] = {
>  	NULL
>  };
>  
> +static void request_kill(void)
> +{
> +	int fd = unix_stream_connect(git_path("index-helper.sock"));
> +
> +	if (fd >= 0) {
> +		write_in_full(fd, "die", 4);

I believe that this is incorrect. When I interrupt t7900 after the 3rd
test case, it says

	fatal: protocol error: bad line length character: die

twice, suggesting that this write_in_full() actually needs to be a
packet_write(fd, "die") instead, seeing as loop() uses the packet_read()
call to read the messages.

BTW I am in the middle of trying to abstract out a "simple server" that
will allow me to back the inter-process communication by a pure Windows
solution (named pipes) instead of the Unix sockets. It turns out to be
much more difficult than I hoped: the code is really relying on Unix
sockets currently.

Will keep you posted,
Dscho
