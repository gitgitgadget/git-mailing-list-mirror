Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEE32021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbcKORmH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:42:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60313 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751199AbcKORmG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:42:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AB734CE9A;
        Tue, 15 Nov 2016 12:42:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ux73hv9CctdRL7eLSvxEJk+7tXw=; b=AFWp2Y
        tTQSbOvJ8WT7E3wzVNHr3VG28hyZQkmrzyskLtfqb4Xv1nP8AFctP8ue5aarWWqs
        fjo5aY5IsdrOc/jJkoh3+OzOZVCSQtHGr6GQWmb23c3o4IcWWCHXG2H36mwimzF/
        luCVENQvDb7Gvk2/7oy8eAdW3i6cnEa2458EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=upB25rYRVBJAb5xpJ28G+b816jwpgvG6
        WnHtlqRylvnn0KraG5WEWjhWIV2mioHHHdRqAsnmNZWsmOdhpDGzDNWfJHyQadxY
        FfMaCz2FJOc00NvXg6TcBSbzKtX5W7jx8hdhn28sIgplKblnQyDlbNYtiLReS3xJ
        je7H6XBGLyM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD1F4CE98;
        Tue, 15 Nov 2016 12:42:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B91AD4CE94;
        Tue, 15 Nov 2016 12:42:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-14-Karthik.188@gmail.com>
        <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
        <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
        <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
        <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
        <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
Date:   Tue, 15 Nov 2016 09:42:03 -0800
In-Reply-To: <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
        (Jacob Keller's message of "Mon, 14 Nov 2016 23:55:31 -0800")
Message-ID: <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D275FBDC-AB5A-11E6-9A7C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> dirname makes sense. What about implementing a reverse variant of
> strip, which you could perform stripping of right-most components and
> instead of stripping by a number, strip "to" a number, ie: keep the
> left N most components, and then you could use something like
> ...
> I think that would be more general purpose than basename, and less confusing?

I think you are going in the right direction.  I had a similar
thought but built around a different axis.  I.e. if strip=1 strips
one from the left, perhaps we want to have rstrip=1 that strips one
from the right, and also strip=-1 to mean strip everything except
one from the left and so on?.  I think this and your keep (and
perhaps you'll have rkeep for completeness) have the same expressive
power.  I do not offhand have a preference one over the other.

Somehow it sounds a bit strange to me to treat 'remotes' as the same
class of token as 'heads' and 'tags' (I'd expect 'heads' and
'remotes/origin' would be at the same level in end-user's mind), but
that is probably an unrelated tangent.  The reason this series wants
to introduce :base must be to emulate an existing feature, so that
existing feature is a concrete counter-example that argues against
my "it sounds a bit strange" reaction.
