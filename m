Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6523C35250
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 10:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8881322522
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 10:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UipEcy7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgBHKz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 05:55:26 -0500
Received: from mout.web.de ([212.227.17.12]:50715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgBHKz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 05:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581159324;
        bh=mOAf09b4jvuwhk5+4FHMQ5D0mbYWv7no2Dh7c6u6PsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UipEcy7IZMJPH62+AkZW9Oz4pBlPXf3FAP2Lvo4l9wVBIx58mQSatrXoI4vnt23Ey
         pZNYdhvs7WFkShOVnKEh+VDuJnJIYh8PJ8ZRulI2QyHRzqHK9WaVaUdJBQUjcPIE0W
         x2+tWrcWO+IGmofMMHbysn/w1/oylG04WhYvSKzc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEmc2-1ikSOn3Ymg-00G4Qw; Sat, 08
 Feb 2020 11:55:23 +0100
Subject: Re: [PATCH v3 04/13] run-command: make `exists_in_PATH()` non-static
To:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
 <20200208090704.26506-5-mirucam@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4550b9a5-74ef-2739-990b-6f41f3319129@web.de>
Date:   Sat, 8 Feb 2020 11:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200208090704.26506-5-mirucam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yI9LSaQlou+KgFNMuXDnR7UMhaGn6RH7JQO3uf4wfZPu0Y1z0ht
 zkexmU/VO1+uoJQHGh2QRxLx6hUZJjE1uv6J66+UeJVPWTApGf3E2BdbUSBOGxIYSXRryU6
 rfjn0stzCIMuVNpOhvlkbeAXs0Ak4b/vq8Ir/3imP5oHYxvMrdyfphob1Ihubv/gNz6XfZX
 v0Ka7AWpELQ51Cp38ZAww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XXtPkg7tC/c=:qnLscGQT0EgrUiJQ9bWdVY
 VbvtACT+pWucO/7tqa9IlRNVOJpyriOLZo6JpysmMWtbbWkXd6NGWRUx9i6hdng+oLKYcabpp
 ayF01uWPOwRpXkurlYGjgArEZ/l61HkULZYIAxjvqNg6NgGavaDheiQEANzI3BUxs+I86Y6Fq
 H5upwFm5PXK3wBeJogMXIPVtCEjPlcyon98fDtU9M3YOFF4aSHxvvB4pClgdIs2qKNOujO7ZF
 29b/6i8gJ2Td0ubL90OTo3uvZ73BKOJj41Nc0qeYZwBU6co0kzrLeQBCi1ztnZ7BrF1B+JMox
 YfOHhlfyW9acd/W0YMRVTQsIFI3lbKmxPVCZJeTYWNRCSzW4C0g4bYFNK7/0GMZ5JYeSSLOYU
 oiQL+D+ldzJC+YnhmCReIbWzb1jPFnyGCiVrSvxLfqPVbfWxBjXspILS5jFfmHFmRMa9sKVj2
 WCl/tlV19XQqn0LDz4eEGnXjZhqJqR0GhjQCLb8VEwoMzPBp1Bevv9HDbSJatjU1Fx1gSx3fH
 yRcw1jwwMZyd7gJuzRDwKANSqxkFcvcpUXGvDAzTNteN7WjdxYkGsGStkhg0/kZd+krVedXtl
 1K8bOCKmuXRWuZomXR/Hj1EYa2HP7VUsoF+BFSoEwlsPWBqf4uYRgGpUBqdF9Wku33z80WGHm
 8SMSPFgVQHs6ho5k+cTkm7nqnvhFxVNeqGZPm7DBr/vtQkRU2Btk8L3hRMRX2X74NGaiXy5D5
 5FDNK03PrbxYs6Wj6wIL52KajAe2gEzOkk3xC6DHimGQJcCqujEIkQsCD4FZvaHqlHWasYkNv
 hwBTzWxQ3FCpc1hvvKD3JgGdWq8cRONGoPyrPEIWLzUDRUq7Ky9Y9ZC8DfvSXTGF0Ar4mFrdQ
 yaRNpUVvi1FbSpKsE84k5XMEGm2n5J3k4A20ARHDxny8MqOu7Kv/rbKflps6GmRXbxsNqhSiC
 FLJkUvSDp9gvtVNA9kZuE4HxlmjapvGjwOVnNzAzR1J1TbWlZS+Fd+jjaModyOQqeGPwAU2sS
 fk/Sl0Qm9wMBg8ETMrK2NWD8J6zDnVzeAwlkAKCLSA8bDv9wLu7UiojbZfhbYS5EJwdGNMmvH
 oG3Y17jTtE3hkkApA3MZj+YqX8xgnoaBZON6zu8LWdEd9uUFxpR1K98UxCrvJOz0m1pA4d0BR
 Dh3VK+wLvPe/bgZXzCHbDwwsyYriNh7Byxid7D5Gt002+MxUrt4s9PIpccM3B6x3QTmlUvuXD
 DmSjcuBK1Lk/pCzuZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.02.20 um 10:06 schrieb Miriam Rubio:
> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Removes the `static` keyword from `exists_in_PATH()` function
> and declares the function in `run-command.h` file.
> The function will be used in bisect_visualize() in a later
> commit.

I couldn't find the mentioned later commit in this series.  Do you
actually still need to export exists_in_PATH()?

And if yes: locate_in_PATH() splits PATH by colon.  That means it
doesn't work on Windows, where the paths are separated by semicolons.
exists_in_PATH() wraps it, so it shares that limitation.  Wouldn't that
cause issues for your use?

Ren=C3=A9
