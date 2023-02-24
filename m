Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F8AC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 13:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBXNyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 08:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBXNyY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 08:54:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EFA3A95
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677246856; i=johannes.schindelin@gmx.de;
        bh=hmWA16hPIHVnJEr2lTc2RTEPgAf7CXjEEdwoG9RxluY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=nIw2gAi4bCA807/snkYA2POmJ59u4V8Vhej0z6cN+WRlkIrQQ6W/CS6fwkhxdyClo
         qyo5Eecku4sOjuw0fJ1vevnqQQCwEXGldrzYCvzR1X5aerr+WGzH7c4Wky2okuKxyZ
         4aDCpGW1ggaHXhYi2cHaOEAAIjhotrHPou1/tpvntCXST0Fr25sHxIF2KUVbQCQEfT
         c5FDlK8PKG79y4k32CGRQmlbYI+ayfDjTDKATMXj7W3uBtr8O7La9hSBaQRun3mSP8
         dHjtGGU82ZXVpACmAtTs8HXqIYxJsMjVF6qY8dj6kwXd2Vm9fTMHaAO3lxIgAHNn4l
         +vCrmNTXZ/mqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.113.48] ([213.196.212.111]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1pN45B1VNR-009AmA; Fri, 24
 Feb 2023 14:54:16 +0100
Date:   Fri, 24 Feb 2023 14:54:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com, sorganov@gmail.com
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
In-Reply-To: <20230223053410.644503-2-alexhenrie24@gmail.com>
Message-ID: <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
References: <20230223053410.644503-1-alexhenrie24@gmail.com> <20230223053410.644503-2-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YXS8ok/P3QNoCwy1ROmaJLQmRfnWFThzxtw42iOfWt10Xlh4bjy
 iKacSsjbs8bVW1vNwpAAN1pLuyMZ2NIvPJSSusrL0iJ7eaYgHALgK0MLIXOc4LBk1jDG+fx
 uKrSSdDKSpx/2ATevR4LkATDWqBrdJxXBrz40/hCXh9JFKo24sLjYY25daQP9aar6O+psCG
 8jkC4vMHEQa3JVmiuD+Xw==
UI-OutboundReport: notjunk:1;M01:P0:9G6xuP+Cct0=;ttWhDbUR0tauExGQTcI3OE8AwMN
 pHw7RhLlmqTr/QgQiO/QZxWzBCB4cjRhspVOaTRQodLDW7E0LHJR88RH8H3crDn5NwyKLadDq
 GCZBpuE1cAbcmhO8/r9VnUcP5Y/nN2LTwi4TCYVCKeYlit5FN3tyyc/m490jeAHArmcMLoUfh
 CvdkT8wftNku1oQABGpbIcUAQJjvzBjuzbNSaTQ+Xz6I96PcaHCcDQzO8kuwIQb0MrToF3kfp
 PQuQo+fS62N5diPzNua/fKfLZAar9aK8raoi0xnJlIHPAcJJ3dEDYujo4PkKjzHG9weNLllj+
 LDV1nQNZYX4VfOZ5mvtXCdqr3PFLHswpaA7BB7r/aNxV+yRhNeV4+O1H31djynoplUk67Rj5b
 RsTLKfARWhOEFCc+K20fWOme+w/sxN1eccWv98Fr2YK8VmeegJ2pPK34JNyGQO/AVX503Pub0
 9iQtaMQHE2LBJu1VMH8vw8UDgcBpp2c1dQHs6ZO6RkxuzPJUsW/etWxfCQcU8RGwJLK5g8zSi
 2cCYupaXgfYyzHnpuIecxVYvJ2D3EwapGUN1l65TTr/D0DfIYTB7cB7lTQjbwXYlMoaVOnY8x
 Aukg6BtEQEKztwk+iTbK39WQIwiLFEcsI/QL/AWY64t+Ce63NJAUJqOG4A+FjqEO9vAB/ZG18
 KnS9DzrGFe08w5dYr4yQeRIEfuNouCPEXhSCRfkIAD89K9UMv0QwGU9nrdyHsqI0O39I4aZVH
 OlIQe/Co5c2uvteTvycG29KnxZg5u2VoI0TcS342SZZJ08gx0r+APqgGnI+2l/+BZjmszDnXh
 jIFwiHlRIFrFISfuQpu1Ia/BWy3YhFXG1hLlW3c/aEXFW7JMSdDvIbCkVSE23q4LV1a/dGe5z
 0aTQwlToNh+WZbb8Nf04Zh6tr8xes0yCDGkLxEo4LFezeagBNTWitMHYihe2W0Sfl+tPfIveo
 3gbaVat5QOS1nYclAvbs2mwzJcs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Wed, 22 Feb 2023, Alex Henrie wrote:

> The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
> empty string argument) has been an undocumented synonym of
> --rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
> confusion when a rebase.merges config option is introduced, where
> rebase.merges="" will be equivalent to not passing --rebase-merges.

Being undocumented and obscure might be a good reason for some to consider
this a bug; I do not. You could deprecate it, but there are probably
better ideas than to remove it without prior warning.

If all you want to do is to support `rebase.merges=`, you can do that
without having to change the meaning of `--rebase-merges=`.

Ciao,
Johannes
