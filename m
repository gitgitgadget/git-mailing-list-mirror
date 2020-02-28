Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1833CC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4180246A3
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FfprrY9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1SYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:24:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64406 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1SYk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 13:24:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C32E9A8364;
        Fri, 28 Feb 2020 13:24:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qsp916hHO+saZqkRMzqEEPk7iFU=; b=FfprrY
        9xtyWe2o6rFJTj2a95rfv3DWCTHSyY7VbAnjlTvCyB8FPg+w0OD0EWiKSKZNgh5U
        fw1Tnr/zs2KIIUA7udmAk3vH45yf5IoQLbxIbLfQYBxgGbirwc3j0KjtsX7fi7Wz
        4HOqTYzRiRad1LA/sEFyo/tiLJDvrmO76coz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s0Newb0SROyn47XI9owrNPKP3Zx40GHC
        yA3+Gf6DV6YOyS7+IC0+mwQ+6AYz/qTDigRwVr6nNnLlVJuwbbYSrX+2Cc+fUIOT
        ks5On5bBQdEdQl6KdKkInOFw9+dRr3lfzqG9U3SAwPkR9s6sx37aGpxLzqn/7jR/
        H9vJNfPrdkY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BADE6A8362;
        Fri, 28 Feb 2020 13:24:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E84B1A8361;
        Fri, 28 Feb 2020 13:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Signed commit regression?
References: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com>
        <CAHk-=whg3uip_N1EjLEzaZNMvS8v+5u2GGueE9Wm2xnY87D+-A@mail.gmail.com>
        <xmqqpndyeim1.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 28 Feb 2020 10:24:33 -0800
In-Reply-To: <xmqqpndyeim1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 28 Feb 2020 09:17:58 -0800")
Message-ID: <xmqqlfomefj2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92CB7CC8-5A57-11EA-B8E5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Fri, Feb 28, 2020 at 8:44 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> I suspect it's due to this commit:
>>>
>>>   72b006f4bf ("gpg-interface: prefer check_signature() for GPG verification")
>>>
>>> but as mentioned I don't have the ability to really dig deeper right now.
>>
>> Never mind - I did a mindless "just revert that and test", and it
>> indeed is that commit.
>>
>> Please revert it in upstream git. The "No signature" message really is
>> horribly wrong. It's both technically entirely wrong, but it's wrong
>> from a UI standpoint too since you really need to show what the
>> missing key was.
>
> True---the messages that told you the missing piece of information
> with the original code came directly from gnupg, and the problematic
> change stopped showing that and replaced it with the generic (and
> wrong) "We tried to verify signature and it failed---it must be that
> the input did not have signature" message.
>
> It is in v2.25 already, so we'd need to revert it out of 'maint'; it
> seems to have a minimum fallout on a topic in flight, but it looks
> manageable.

I've prepared a topic to revert that commit and it is now in the
middle of 'pu'; it will get merged down to 'next', 'master' and
'maint' in due course as other topics.

Brian's SHA-256 (1/4) topic had a couple of changes that depended on
the GPG interface API from 72b006f4 ("gpg-interface: prefer
check_signature() for GPG verification", 2019-11-27), so I ejected
them out of the topic for now:

    - tag: store SHA-256 signatures in a header
    - gpg-interface: improve interface for parsing tags

In the longer term, however, we do want an updated GPG interface
layer that lets us achieve 72b006f4 wanted to, namely

 - have a single entry point into GPG interface API, so that the
   changes in the future can be centralized;

 - not to depend _too_ heavily on the GnuPG's behaviour.  The pieces
   of information that was lost from our output and made Linus upset
   was given to the end-user by us parrotting what gpg said without
   the code really understanding what is being said, and we should
   instead make our code aware of _why_ verify_signed_buffer() or
   check_signature() have failed, and make sure we report that to
   the callers.

I'd expect that there may be another round of attempt to update the
GPG interface.  Let's make sure we won't lose info given to the
end-users while doing so.

Thanks.
