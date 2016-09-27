Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB99F20986
	for <e@80x24.org>; Tue, 27 Sep 2016 16:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934185AbcI0Qb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 12:31:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54726 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752565AbcI0Qb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 12:31:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C2043C4C9;
        Tue, 27 Sep 2016 12:31:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MG4ItvwzcMnSG4WtbRyLd75MOtg=; b=Evk8xR
        z0WymscdCRZZEzvgeoQhkrGYIv+CDWI3S/jzXQWgfpFs5/gX3f5Bong0u8M9PuPP
        VFV5fHKZh+Cm9lmPesMsFa53CDbKqIOtM3uHlPq4GPavc0PiJK4U0j3sHdZDxuZY
        sRRsNARlURtny3exqZ87OIGj+CZy6mD5HQsF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QJSXdSq/zAEwyHPX6ggKK3ei+bxsMk5N
        OZkqCTjf63I7/9fd0pwHi7Bg3ix+wWM07KHThYcI3lJzcLdkcBNB2kVgyhhGkzIB
        9JVCNBTy3xYY1ctfEAb8ugiI6Qfp8h1XdqGxvbs14NUseoWPHXDbW+WHGAxW15Cr
        yHQBIHGkbkA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 630B03C4C8;
        Tue, 27 Sep 2016 12:31:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E09633C4C7;
        Tue, 27 Sep 2016 12:31:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
        <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com>
        <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
        <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
        <CAGHpTB+Fnu4x1bV9TSNo8pYdOzJzRsXA9r3CwxVz64mjW_qsGw@mail.gmail.com>
        <xmqqmviupcpx.fsf@gitster.mtv.corp.google.com>
        <CAGHpTBLPvQDD4hhMKiOFdhxug-joi-38mNozuzm3=EJCnS9UEA@mail.gmail.com>
Date:   Tue, 27 Sep 2016 09:31:22 -0700
In-Reply-To: <CAGHpTBLPvQDD4hhMKiOFdhxug-joi-38mNozuzm3=EJCnS9UEA@mail.gmail.com>
        (Orgad Shaneh's message of "Tue, 27 Sep 2016 10:22:19 +0300")
Message-ID: <xmqqd1jpqp7p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D51432C0-84CF-11E6-B2B5-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad Shaneh <orgads@gmail.com> writes:

> On Tue, Sep 27, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Orgad Shaneh <orgads@gmail.com> writes:
>>
> I actually see that there is a problem with it:
> https://github.com/git-for-windows/git/issues/761
>
> I'll try to revise it and resubmit.

Are you by chance volunteering to be git-gui maintainer?
