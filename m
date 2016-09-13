Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EA820984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758646AbcIMQmT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:42:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63025 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754894AbcIMQmP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:42:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3CDF3DD85;
        Tue, 13 Sep 2016 12:42:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pO3lQiCACnlH
        5/XxJiEWbJfpbFQ=; b=siBXrh0e5TLf065/JRK5ONIA7nhv4t+NGQDYLYpifMV4
        7j9P370nd/xpxrpyzldtmCcm+XARU/wZUxjM+7p2Kd1r+l7021lKgN55Kzf+6AHS
        c1GOyuLqcDMvkWkbrmF9YtWuDxSQSejvLte9gO3myUYKySuid891Q3ejXHF2AbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uyrqEN
        l721a7TRn5nUtFJPeu2yW5yEsZWY0wee5KRrrWGXVs4gU1aWrgXFORGVjN7ZZRWL
        4l3CfncIhYKpbTS7BmP+OMq9eNeSW6F/eWlDVOOQn7nNOf3KjFOt3bRMmo4y1+xJ
        cCh5RwpnbB/BzyyPWeaiBWxMJAzrrO4Sj1wD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E989B3DD84;
        Tue, 13 Sep 2016 12:42:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E1403DD83;
        Tue, 13 Sep 2016 12:42:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, jacob.keller@gmail.com
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-11-larsxschneider@gmail.com>
        <20160910062919.GB11001@tb-raspi>
        <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com>
        <96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de>
Date:   Tue, 13 Sep 2016 09:42:11 -0700
In-Reply-To: <96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 13 Sep 2016 16:44:18
 +0200")
Message-ID: <xmqqvaxzvjj0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05E362E0-79D1-11E6-9035-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I would really consider to treat pathnames as binary, and not add a tra=
iling '\n',
> are there other opinions ?

It would be the most consistent if the same format as
write_name_quoted() is used for this, I would think.
