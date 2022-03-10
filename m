Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03ECC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiCJRxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbiCJRxH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:53:07 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60E18E415
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:52:05 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B3E0189DEE;
        Thu, 10 Mar 2022 12:52:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YsYbx62AzsT1
        HaQQF6TC6bjH8Ts28m1pY0u1Uk+oIrU=; b=dSRIt9PdQlgMIoUrt8jTlbaAX21r
        P25bfAbU+3A6apQ+k2IBNlFh9t4XecIJ+KQUmpj2Lnkq4V/1Ofy9kLAqnKUlSpYR
        nTC7tLoulQQamNnIRifGK4hcy6TqqCfp1/Wtky/hMVckmqMfdERVRf+kwhJKruKa
        J+8Y7EJQSqohP6w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83202189DED;
        Thu, 10 Mar 2022 12:52:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01543189DEC;
        Thu, 10 Mar 2022 12:52:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: git notes question
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
        <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
        <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
        <xmqqee3bm2b8.fsf@gitster.g>
        <f5be5b264f30f689546db3883b4b64c88ba00cb3.camel@gmail.com>
Date:   Thu, 10 Mar 2022 09:52:01 -0800
In-Reply-To: <f5be5b264f30f689546db3883b4b64c88ba00cb3.camel@gmail.com>
 ("Nuno
        =?utf-8?Q?S=C3=A1=22's?= message of "Thu, 10 Mar 2022 09:37:18 +0100")
Message-ID: <xmqqlexhg0fy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CAD820E0-A09A-11EC-BB61-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nuno S=C3=A1 <noname.nuno@gmail.com> writes:

>> Well, this time it was "Notes:" label, but the next person who
>> wants to see a deviation from the canned "email" format would want a
>> deviation different from yours.=C2=A0 Perhaps they want a different wa=
y
>
> I'm surely missing something but I'm not sure this is specific to the
> email format? It's just that git-notes by default will always either
> append the "Notes:" or "Notes (<refname>):" independent of the
> predefined format you use. The only way to stop it from doing that is,
> apparently, by using your own --format=3D<template>...
> ...
> What I was asking was just if there was a way to not use these default
> strings. I don't think this would open all kind of deviations.

Not limited to the email format.  "git log" will always prefix
"Author: " before the commit author name, "Date: " date with extra
paddingbefore the author, indents the log message by 4 spaces, adds
"Notes (refname):" before notes, and indentation is given before the
contents of the notes.  There are many things, other than the
presence of the "Notes" label, that people may want to customize in
the output from the commands in the "git log" family, including "git
format-patch".

I think you were too focused on "Notes" tree to lose the view of the
forest.  A line is drawn not to special case "Notes" prefix, because
there is no reason to do so without allowing all other things to
also be tweaked, and it will "open all kind of deviations".
