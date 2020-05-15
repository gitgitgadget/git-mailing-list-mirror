Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8B2C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DB62073E
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bw8FR3SN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEORXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:23:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55366 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEORXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 13:23:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E9A86599E;
        Fri, 15 May 2020 13:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+CrQcav+kOlh
        D0RjAlCmDcyFmYg=; b=bw8FR3SNs4rxlETXZ3uXKI/3HB54ZwmpsIOjqb41J0ST
        E79NTs6OiJF1bm2SFuVY7hHDzUi3AmGz+5mvlHTtDYNyzlvBPSxPcKw+b6+IjbQj
        cK/SgVE4FzxkQRupxcN8QOwTOr0r2aDQVONjJS/tlp+rwfbf8PpUXcv4uubO9lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rkm8+a
        KGH2/r8oIWOpnSZo7K1hAFlo5o0G5+yX+bg6xHEUD4Unyi+zNbZSPPhY/6/ScRMH
        UdELfOTK9SrbVYgGneXbEw3Lg8DnACaYhvLQ74Q1Iqly9W4T1DP1AiHmfEnSGU4h
        hqbTCZLncxNcKvD33xp+hFQDvCY9FGyiaiAOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 962716599D;
        Fri, 15 May 2020 13:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17F536599C;
        Fri, 15 May 2020 13:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
        <20200515150041.22873-1-carenas@gmail.com>
        <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com>
        <20200515154539.GB61200@Carlos-MBP>
        <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
        <20200515171428.GC61200@Carlos-MBP>
Date:   Fri, 15 May 2020 10:23:39 -0700
In-Reply-To: <20200515171428.GC61200@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 May 2020 10:14:28 -0700")
Message-ID: <xmqq3681m7s4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D18BE668-96D0-11EA-8CC2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Fri, May 15, 2020 at 09:50:38AM -0700, Junio C Hamano wrote:
>>=20
>> At this late stage in the cycle, would it be a safer change to
>> revert the whole thing, I wonder, rather than piling fixes on top of
>> fixes to the initial breakage?
>>=20
>> 303775a2 (t/test_lib: avoid naked bash arrays in file_lineno, 2020-05-=
07)
>> 662f9cf1 (tests: when run in Bash, annotate test failures with file na=
me/line number, 2020-04-11)
>
> will also need:
>
>   676eb0c1ce (ci: add a problem matcher for GitHub Actions, 2020-04-11)

Yeah, I think that is a good idea.  I suspect that leaving it there
won't cause problems, though---it would be just nothing is found to
be clicked and that's the end of it, no?

Will add a revert to the series anyway.

Thanks.
