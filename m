Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6182C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiBXPLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiBXPLh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:11:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51AC19F440
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645715456;
        bh=QRMrBEAVZv1gIYu4d6LYNBlO8Zn9TFpjFu9MVHxgG+U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dULKZBN/jW9UfZTEtzawmct/7U+GuTVUfeU8LWQNnD/fhJVYDzSQu9FSXacF0ZQTS
         +mj8OvZqWWXZJYRBuQjSRKdIMcrue9mILnQOhsALy2GjEkxaFPWFmblCnonpb1imyk
         QmVWIvOu/MaIyr9n9FL4cD+3au9tJfE95FbSoa9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1nuwcv20yD-00ajsx; Thu, 24
 Feb 2022 16:10:56 +0100
Date:   Thu, 24 Feb 2022 16:10:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 15/30] compat/fsmonitor/fsm-listen-win32: implement
 FSMonitor backend on Windows
In-Reply-To: <98c5adf8ca0112ebf729970a0f15302d55806bd2.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241605140.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <98c5adf8ca0112ebf729970a0f15302d55806bd2.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q1tzeVkAXMJEnXiQJJgJy+fUzVm2eejn/X64Tqk48IjOr4gcl0b
 +yMJQUdTScDaM47FvEgrDZQcabvQ5fpYQIy8GvjKMfT4xoPTijc5YXMqKU6FVxR8GGh0/+0
 tCiOzpIbefvvoIcHqX7nD+fep5DGgDlUqPojhStq8hz4ynEZeUbMajpwrP6ANwB+am2BInm
 RdBQ8/dnWxaqre79xntYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lM76atgqjB4=:qmRMq+ofAMIDC0NDQd1rSZ
 H3w7PDaUtWa5d/6/QdRM/3UyzkdqUMXqY+Fg9aMiUnOLAicDmPMBEsEEh6nsK4xzixXKfGtYu
 7PC0Ch1frwjs+9aS4HX1foushSKAY0U89s9RLveY3q57m4vMPdJB+EEDhnnay8HG6ZdwVKT/s
 qAmSiV0lGsQut43mR+Yjr1VLPiwxr8RaHyhSh+OuxMauIrUzTypmj6IRxdwy9mu93JE5w6fkC
 PMh38rB9+dtn0l5aPM828YYqKD8b0rKt0pI812OZTS0qdWs/kw8nAMIQypZY9PdxuJ3Ac2ZHY
 DuEphyeT4v/iYQIMCuiPc9OhgiRMywc0wNII2aQ6QyJZkYcPe6spAQQ+Ae3AS5yZwG5TdmLkQ
 aLt5GYtbsu5ADVkNgFmwhIDuJ/5Dmdf6WaIUPLVyh2GOSJWLRIzG9p9c2WZ0dB1JCTJwDSyvY
 9IBlZyfzKJwmYeCc6u8UejDflzhPuc01rkAHRCfwrIhi9homNTAr6zMPvcz2AWK2JIsR8gUzp
 VhLFOBsQDljwRRLHPX+cMtwNaT4ak2uAtNzZkBT3emp1C8njdn3GmnaUH4eMvZLbZLQ2vPHq7
 lQGuE48N+Uspgxy3Wqg+Rf4hGEuEtQqF8X9jz3c3TA/NLrj+mAURE+vlZm7UIgOwcsdKgk2gM
 8O8OLj5gMhmvWLVbZ6S8KR5OIBjt4V2MRN4WiNnuEqPV2XTZ8Cna79VJ9+Uj2jHWFAqsmIPHI
 uXhgOMlzPwfWMTRVXL2C7kjSsZxHz1ZmW6rvs6NyXqtiZbAn4eB1f1v2Qq9dWcs1XLfiBUuVk
 R3r8GCVJlDDPDQAyL/K6StQ8hlHycRtFu3KwaYA9Tw2V+UASANu8OHPGOfRkQkmG/igto83Vk
 E6b2ikIRqsFDHQA6/WObXKcTNxfCfktXfEYBaQ4NWsyR3zWmR6GGmpwlqa9jlBVEBqe7n+cKS
 E/lWZc/xAlBgC3LVBwLQi7DTMGX42U3Rw6+S33FY0+myu2TO7ZCGXVAH1dQxaAxEWWlnUj+xn
 /evIzZONd/AyS1kLkn75qiIJ1IILCHW5Hy05O63aztLt1c6vAigUDu2Me0107ShSR0YyiUFQB
 U7Q07/RQ3JpwD8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

merely a comment:

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> +/*
> + * Convert the WCHAR path from the notification into UTF8 and
> + * then normalize it.
> + */
> +static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
> +				  struct strbuf *normalized_path)
> +{
> +	int reserve;
> +	int len = 0;
> +
> +	strbuf_reset(normalized_path);
> +	if (!info->FileNameLength)
> +		goto normalize;
> +
> +	/*
> +	 * Pre-reserve enough space in the UTF8 buffer for
> +	 * each Unicode WCHAR character to be mapped into a
> +	 * sequence of 2 UTF8 characters.  That should let us
> +	 * avoid ERROR_INSUFFICIENT_BUFFER 99.9+% of the time.
> +	 */
> +	reserve = info->FileNameLength + 1;
> +	strbuf_grow(normalized_path, reserve);
> +
> +	for (;;) {
> +		len = WideCharToMultiByte(CP_UTF8, 0, info->FileName,
> +					  info->FileNameLength / sizeof(WCHAR),
> +					  normalized_path->buf,
> +					  strbuf_avail(normalized_path) - 1,
> +					  NULL, NULL);
> +		if (len > 0)
> +			goto normalize;
> +		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
> +			error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
> +			      GetLastError(),
> +			      (int)(info->FileNameLength / sizeof(WCHAR)),
> +			      info->FileName);
> +			return -1;
> +		}
> +
> +		strbuf_grow(normalized_path,
> +			    strbuf_avail(normalized_path) + reserve);
> +	}
> +
> +normalize:
> +	strbuf_setlen(normalized_path, len);
> +	return strbuf_normalize_path(normalized_path);
> +}

There are Unicode pages that require quite a few more bytes per wide
character (IIRC it can blow up to six bytes), but it should be good enough
for now, and we can always revisit this easily enough at a later stage.

I really like this patch, as it makes the complexities of handling two
watches and the complexities of handling overlapped (and asynchronous)
results look easy.

Thank you!
Dscho
