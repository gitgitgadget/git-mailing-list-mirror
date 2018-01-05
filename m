Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29B01F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeAETKV (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:10:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60332 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeAETKU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:10:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E1F3C560E;
        Fri,  5 Jan 2018 14:10:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OgVP5EM8H4V6
        /WL+SZH7xcOp3Y4=; b=UQU6vjD1/XrrWvZAStP28B5/+OYVUAAFd3jZdWdc2lhG
        Y0Tm0ie0RV0B4w6/Qa+/t9S/IwmaGTMfxeSLV9sjbqt261I9RFp11fcFNqvW0edC
        VdAcCoyk7EG+nguTGhdRdsjp6jtsxDMegPAOgNVyyHKutvU+21HgMncz5xQT42o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ijJ9Lc
        SugDGSeWOgp7ysaohlERvS8lYE46Q1yDQ7Z17oPI7cmY2jlkWxATjdowyZFIbwAz
        GKPX36G1irbxZ25rbED2ZUMNih28wQng+hv5gGmpeecQwH+2xdNxqtYHLfEo0OFI
        BfaUDhJB5dprFyVIjt2S2c5JW7E1qb6MyMS+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56872C560D;
        Fri,  5 Jan 2018 14:10:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A2C0C560C;
        Fri,  5 Jan 2018 14:10:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
        <df39f62558314cf6a9d9df3e23f31dd8@OS2PR01MB1147.jpnprd01.prod.outlook.com>
        <5A4B2DA5.907@hiroshima-u.ac.jp>
        <59a1fc058278463996ed68c970a5e08a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
        <955dae095d504b00b3e1c8a956ba852a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
        <5A4D9089.3050209@hiroshima-u.ac.jp>
        <f7654cd9-2cd0-0775-3b10-8e3dc1a66dae@web.de>
        <xmqqmv1tfpqh.fsf@gitster.mtv.corp.google.com>
        <ee76246b-579c-fe01-eb9c-d400061b47b6@web.de>
Date:   Fri, 05 Jan 2018 11:10:18 -0800
In-Reply-To: <ee76246b-579c-fe01-eb9c-d400061b47b6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 5 Jan 2018 14:54:33 +0100")
Message-ID: <xmqqtvw0ceat.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 124B314E-F24C-11E7-AFE0-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> One practical problem is that users who do this
>>=20
>>      $ git archive HEAD Documentation/ | tar tf -
>>=20
>> would be expecting (at least) two different things, depending on the
>> situation they are in.
>>=20
>> So at least you'd need an "--include-untracked" option, I guess.
>
> Right, this breaks down with directories -- most build artifacts (e.g.
> .o files) are probably not meant to end up in archives.

I agree that it is unwise to overload the pathspec for this purpose.
Perhaps bulk of the documentation of a project is in javadoc in its
source code and extracted into some directory, where the user would
want to include untracked things as well as tracked ones, while
untracked contents of other directories are all not meant to be
packaged.  As "git archive" is primarily about freezing the contents
of a set of paths in a single revision into an archive, and
including untracked things is secondary, perhaps the right way to do
so would be to:

 (1) leave pathspec as-is---they mean "only this area of the named
     revision goes into the resulting archive", and=20

 (2) introduce a new "--add-untracked=3D<wildmatch>" option, that can
     be multiply given, is cumulative, and is used to specify which
     untracked paths to be included in the result from the working
     tree contents.

So

	git archive \
		--add-untracked=3D./configure \
		--add-untracked=3D'Documentation/**/*.html' \
		--add-untracked=3D'Documentation/*.[1-9]' \
		HEAD -- . ':!contrib/' ':t/'

might be a way to package up sources we use without tests but
include the built documentation files.
