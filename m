Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F2C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 04:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6C220772
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 04:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CV3c3FcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgGCEyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:54:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60390 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCEyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 00:54:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08CCC763DA;
        Fri,  3 Jul 2020 00:54:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=illGRcpBpnaF6OQrMHTvMduL3Hw=; b=CV3c3F
        cUEttlI5d3i//76xno0xirMeStW3ohT5RS0eOUAIgQ9LpOD8m7R4IW219r0ecT99
        wLFgs9G0/dFn0or0FP7vZ7aE/WMh5HqmuUyayrthEkx+2GAfulSFyr40ihn4UpRj
        KCtRsKF+bz7oatGfKbtgIpSWbvaiXnsNDBQzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=twJL5cbje49Wso9ay02p0rGp5duSZTV/
        hD8JKnaTLgahMhkT/36CIodndDN623VaoML1Fabt/HAwZgvLKck74sVrnXFbNpPP
        28eHcYtqIR+2GPYsD3Alpdf1U5ZWMnnr6L1C7wwEPmRWt3ifbs1VtyBuKCqDE+/I
        ur3snE2Mga0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F26E9763D9;
        Fri,  3 Jul 2020 00:54:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C542763D7;
        Fri,  3 Jul 2020 00:54:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tomas <correo@tomaszubiri.com>
Cc:     "git" <git@vger.kernel.org>
Subject: Re: commiting a change from command line with newlines.
References: <17312e90c37.fefa495d137526.1559287962218705021@tomaszubiri.com>
Date:   Thu, 02 Jul 2020 21:54:05 -0700
In-Reply-To: <17312e90c37.fefa495d137526.1559287962218705021@tomaszubiri.com>
        (Tomas's message of "Fri, 03 Jul 2020 01:22:09 -0300")
Message-ID: <xmqqk0zlb3ma.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 396FCC16-BCE9-11EA-8A96-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tomas <correo@tomaszubiri.com> writes:

> I'm trying to write stanzas in my commit message, and naturally
> the ASCII newline character is the best tool for this, beautifully
> integrated throughout my whole system, from my keyboard to my
> screen.
>
> My question is, how can I add a newline from the git command line
> without opening an external program like vi, atom, notepad, word
> etc...

Just like you pass any command an argument that has newline(s) in
it, e.g.

    $ git commit -s -m 'area: teach gostak to distim doshes[ENTER]
    > [ENTER]
    > Gostaks inherently want to distim doshes, so let them do so[ENTER]
    > freely.' -a[ENTER]

you can give such a string to "git commit" as an argument to its
"-m" option.



