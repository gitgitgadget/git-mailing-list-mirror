Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF54DC47247
	for <git@archiver.kernel.org>; Fri,  1 May 2020 01:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8082020873
	for <git@archiver.kernel.org>; Fri,  1 May 2020 01:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KWcVSkMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgEABkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:40:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55671 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgEABkz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 21:40:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DD625397A;
        Thu, 30 Apr 2020 21:40:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bGTtL2YHldVP
        0AZJpAQ7pTRiJKw=; b=KWcVSkMH+7/nR7oAeE5f1EyNAU97H7DjmnzXXan7CEs3
        0ZjVTFJkawwsSF4FP+VU3KHD+rgveqA3KWFZVO1wB7tnqc8crWxZJBCVj77whwhE
        vAwXXlhMcophIyK2nARWVnwuGvpZvXwBQzjWcZZzWRf3RQ3DzvmXGUYxodjlrTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I3wcUg
        /uS4UW76+C6lXwu8C0of/A2NjiMd9inT6hxtsc37hVufRVqHswmQHQOtkSsBMLrx
        u29+a6nKwSyBjvvx4qoVUCMO09ElnzjRLXIaEHODLUIiuocOUBseYxAZaVrn6xkC
        2T/kFlIkoO9evJPS+wNOkTMVv1/yuZdWJJq4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0490F53978;
        Thu, 30 Apr 2020 21:40:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 792D053976;
        Thu, 30 Apr 2020 21:40:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus lines from store
References: <20200430011959.70597-1-carenas@gmail.com>
        <20200430160642.90096-1-carenas@gmail.com>
        <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
        <20200501003041.GD33264@Carlos-MBP>
Date:   Thu, 30 Apr 2020 18:40:48 -0700
In-Reply-To: <20200501003041.GD33264@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 30 Apr 2020 17:30:41 -0700")
Message-ID: <xmqqimhgph3z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C90EC878-8B4C-11EA-AC25-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> the problem is that practically speaking, if users in Windows and Macs
> edited the file they "might" had saved lines with the wrong line ending=
 (*)
> (part of the reason I added a warning about "encoding" to the documenta=
tion),
> and those are difficult to "see" as invalid.
>
> using the non _lf() version ensures any trailing '\r' character would
> get removed from the credential and allow us to use them, instead of
> silently failing.

You are forgetting why we are fixing credential-store, aren't you?

It is primarily to help those who damaged their files by editing,
and introducing cruft that cannot be parsed, from a stricter parsing
introduced recently in 2.17.4 and above.  Without the fix, they
cannot operate with the store they already have.

Now, think about those users who saved their file, after adding CR
at the end of each line, but didn't do any other edit (like adding a
blank line or "# comment").  It may have happened 3 years ago.  What
did they see from the system back then?  It may have happened 3
minutes ago.  What would they see with the stricter parser now?

With or without the recent parser change, they would have seen that
these lines no longer match the URLs they wanted to match, but the
credential store does not die on them for malformed lines, no?

In other words, the stricter parsing did nothing to these users.

In fact, those users who added CR at the end of each line 3 years
ago may have even depended on the disappearance of these entries for
all these years.  Maybe lines that record their ancient passwords
for sites are still buried in the later parts of the file, with CR,
but doing no harm because these lines do not match anything.  These
users may have changed their password since then and wrote new
records with "credential store", and these new records are stored
without CR at the end of the line, so they match the URLs.

By using the non _lf() variant, you are suddenly resurrecting these
old records that the users thought are already gone and have been
causing no harm to them.  Do we know that resurrecting these old
records is a good thing to do?  I don't.  For example, once the user
decides to "sort" the file (after all, we are talking about users
who edit the file, so we cannot assume they won't do so), they would
end up with duplicate records that record two passwords to the same
site and they cannot tell which one is current, as you even lost the
CR at the end of line that would have told you which ones are
broken.

In short, you wouldn't know what ramification it has by suddenly
using non _lf() variant.  And it has nothing to do with the fix we
are trying to make.

When fixing something, it is tempting to see if you can cover a bit
more area with the same change.  But you should make it a habit to
stick to the absolute minimum first for safety.  When contemplating
to step out of the absolute minimum, you need to think twice to see
if that extra "fix" really fixes, or if it potentially harms.

And I am not convinced that turning CRLF into LF in this case is a
good change.  In any case, it certainly does not belong to the same
commit as the one that fixes the fallout from stricter parser
introduced in 2.17.4 and above.

Thanks.
