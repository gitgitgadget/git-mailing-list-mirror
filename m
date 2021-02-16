Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A8C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 02:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFE764D9D
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 02:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBPCP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 21:15:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61904 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBPCP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 21:15:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC3E811111B;
        Mon, 15 Feb 2021 21:14:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FkXSRgGARI3y
        m2nhn4Kuiy0HsE8=; b=Ym82562X/1SjPprjMpscPd4icuxUIlWuelZjSwJx42Wu
        qVoa/5EuBm698ijEovuhvcH23jrxaHTWFdP2MHrB4OcMJ4ieRdZD00ZRWYkVlV9x
        E8xcQL4bY8ZZjcW74hBz2AUxymm5C0MnlX6YeqP/YSJpDokQCIy4VifagalpTyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nsYdwG
        3/rrqLpAHMAdNgftbxQa3m02ee3ZPBzW561icnusXsNnSc/phxh+d5GWDuifFO8p
        FgoOJfiZA+1aY+l61jbCAnokIRWeSncUJk4S35NZk/C5bBYOLW/5MUd5bQyPhPZT
        PDeuGLyrpTA71bKyUj8K1DcLAy6rHVwyDzSg8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B47AC11111A;
        Mon, 15 Feb 2021 21:14:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05D5F111119;
        Mon, 15 Feb 2021 21:14:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-send-email: smtpserver in $HOME
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
Date:   Mon, 15 Feb 2021 18:14:39 -0800
In-Reply-To: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
        ("Jan =?utf-8?Q?=E2=80=9CKhardix=E2=80=9D_Stan=C4=9Bk=22's?= message of
 "Mon, 15 Feb 2021 06:07:30
        -0800")
Message-ID: <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BABDF68C-6FFC-11EB-906D-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan =E2=80=9CKhardix=E2=80=9D Stan=C4=9Bk  <khardix@gmail.com> writes:

> Would it be feasible to treat the `smtpserver` as path option
> and expand `~`/`~user` paths?
> Would it break anything
> (i.e., is `~` a valid character for beginning of a hostname)?

I haven't given too much thought, but offhand do not think of a
reason why a change like the attached would break things.



 git-send-email.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/git-send-email.perl w/git-send-email.perl
index 1f425c0809..ff58ac5046 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -1006,6 +1006,8 @@ sub expand_one_alias {
 		}
 	}
 	$smtp_server ||=3D 'localhost'; # could be 127.0.0.1, too... *shrug*
+} elsif ($smtp_server =3D~ /^~/) {
+	$smtp_server =3D glob($smtp_server);
 }
=20
 if ($compose && $compose > 0) {
