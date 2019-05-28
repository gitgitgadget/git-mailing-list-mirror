Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F9D1F462
	for <e@80x24.org>; Tue, 28 May 2019 01:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfE1B4Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 21:56:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58608 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfE1B4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 21:56:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BE241434D8;
        Mon, 27 May 2019 21:56:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=aaVQyo/CaHQ3g
        G0jz/MJwjP/AZE=; b=jOPPRGeL3scZoLgRLql0FNKy29tBsS9r/Tl9UjE/tL1ns
        67x8uMS0yqbo5YAq+GxYpYXgzeDyWfx1z/7aAiz7ncYldCq/nRLbPUHbDqP6UH5j
        fkL8BqHBCf3jDB2Q2X4O/LHGPLamejb93XauHPJqYYhT+pzxqqD+wn6olsYt8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=T5QIbHS
        5TZpZAXaPvbdz3ZcxjjVnhCU9mbg+4gHBcJelVPvLDTwlutHMCob/BtcHbEZ2dd/
        Y2l1d2cBNHW2P/7KMG3goOBpJrfPXPUpkL4JIatgjyObNbgBzgS3b2DhlPKCgvVN
        8zQ7mVE6HjEzrvTLwje6DPT0nzk3O6UaFe/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 845ED1434D6;
        Mon, 27 May 2019 21:56:24 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEB5D1434D5;
        Mon, 27 May 2019 21:56:23 -0400 (EDT)
Date:   Mon, 27 May 2019 21:56:22 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Chris Mayo <aklhfex@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] send-email: remove documented requirement for
 Net::SMTP::SSL
Message-ID: <20190528015621.GZ3654@pobox.com>
References: <20190526172242.13000-1-aklhfex@gmail.com>
 <20190527193517.GA22013@dcvr>
 <20190528000544.GX3654@pobox.com>
 <20190528013128.ynvvci4ul2exiyef@dcvr>
 <87h89fmjzc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87h89fmjzc.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: CBEFCD38-80EB-11E9-876E-46F8B7964D18-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry I missed your earlier reply which also mentioned using
$obj->can() =C6var.  That's what I get for typing a reply and
then walking away for a few hours before hitting send. ;)

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> Same, but to bikeshed a bit, at this point we can just do:
>    =20
>     diff --git a/git-send-email.perl b/git-send-email.perl
>     index 24859a7bc3..4ad2091a49 100755
>     --- a/git-send-email.perl
>     +++ b/git-send-email.perl
>     @@ -1468 +1467,0 @@ sub send_message {
>     -               my $use_net_smtp_ssl =3D version->parse($Net::SMTP:=
:VERSION) < version->parse("2.34");
>     @@ -1485 +1484 @@ sub send_message {
>     -                       if ($use_net_smtp_ssl) {
>     +                       if (Net::SMTP->can('starttls')) {
>     @@ -1507 +1506 @@ sub send_message {
>     -                               if ($use_net_smtp_ssl) {
>     +                               if (Net::SMTP->can('starttls')) {
>=20

I think we'd need to use 'if ! ...' there, or more likely,
switch the blocks which follow because the code following
'if ($use_net_smtp_ssl)' is for Net::SMTP::SSL with the
'else' block handling the case where Net::SMTP has ssl/tls
support.  Right?

I know I read the $use_net_smtp_ssl bit backwards the first
time or two as well.

--=20
Todd
