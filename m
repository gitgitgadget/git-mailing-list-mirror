Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0B111F404
	for <e@80x24.org>; Thu, 14 Dec 2017 23:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbdLNXBF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:01:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754069AbdLNXBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:01:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE5E0CAFBA;
        Thu, 14 Dec 2017 18:01:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=jXwWnrlyDX0EBj/6QYv65m/bUU4=; b=Bzl2D+H9G/vGlz9qFjw6
        mVCEmATGZ7vZsQELSxqrCcYmWKj04tLR9eddLhtDCbfzG1nGDhjoPhvQkiPxmY2c
        dwzh+JB+9ZZdbrFAyf3ZebfJgkhxJpRTGn1iEf8MLZyIK9V4eCPEDuv7jCVRuBF6
        AHbgjZhD9inF9GuaSnNDVt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=qDR/5KC9xLL+C6BDr0iSfKsElLw8ccj5IVrM/D86XIcbtA
        XEXsVZ9E6DC6efiDSuVnp4EWdepRIF+8ROLXTwAQBZq08UUQ3h9QkctGNqx1tZPT
        sC817Ak2GWsXpKfS0W7vJYQwycoaHj+7qUNY7+XMKyrSTUDS5v1RugQNIQ9lo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5CEBCAFB9;
        Thu, 14 Dec 2017 18:01:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41C00CAFB8;
        Thu, 14 Dec 2017 18:01:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>, patrick@luehne.de
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
        <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
        <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
        <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com>
        <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org>
        <F571AAED-C325-4151-9566-6BA249C1B3D4@gmail.com>
        <xmqq1sjz3frf.fsf@gitster.mtv.corp.google.com>
        <D2973852-BDF4-4251-8DE3-CE6AAD303A5F@gmail.com>
        <xmqqzi6mwlai.fsf@gitster.mtv.corp.google.com>
        <C062CB10-9885-46B4-9614-65A39BD5FBE8@gmail.com>
Date:   Thu, 14 Dec 2017 15:01:02 -0800
Message-ID: <xmqq7etosymp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8B2068E-E122-11E7-AB27-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> That way you could control the encoding for a text file specific
> for each path similar to the "mode bits". That also means you could
> change the encoding of a file while the blob content stays the same.

That is exactly why I said that I doubt it makes sense.

When you have the same blob object (that is in UTF-8) appear at two
places in a tree (or two different subtrees inside a single tree)
and the two tree entries that point at the blob tells contradicting
story, you would have a checkout of the same contents in two
different encodings.  If you have the same blob object appear in two
adjacent commits at the same path, with one commit's tree recording
its encoding differently from the other's, you would switch
encodings when you switch branches.  I doubt these are "features",
but sources of confusion.

Be it a feature, or a misfeature, it is shared with the existing
solution which is .gitattributes embedded in the tree, so you are
not making anything better or worse by moving the information to
tree entry.

What I actually expected to hear when somebody talks about "ideal"
(which may not even be achievable given existing user base) was to
make blob object declare its desired external representation.  That
would remove the two possible confusion cited above, because once
you have a blob, you have everything needed to externalize it.

In any case, I do not think we'd go there anyway, so ...
