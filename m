Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C74C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiF3Se7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbiF3Se5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:34:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8ED39824
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:34:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 199621A78BB;
        Thu, 30 Jun 2022 14:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V0/0TGnBYV1U
        R3XrOl9CFYjJgQCX3GRWuutFfhqQFqc=; b=KzTD8VbguGB4+LHasNlrlZl7YaTT
        96kC5WRiaDr8xiLHNi/FgYnQfIclLc3h0sxGIVsrHWzJMr8J6SEuIDxWZ8og0u6D
        D5PQ6Mg/HoER+z5920K1co1JwWROBmCBYe2vM2ifZgu4GfFkezRa6lNnnvMjocS2
        aqFsQrAmc8H1hNA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12E791A78BA;
        Thu, 30 Jun 2022 14:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B4E61A78B7;
        Thu, 30 Jun 2022 14:34:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ian Whitlock <ian@theknown.net>, Git List <git@vger.kernel.org>
Subject: Re: Bug: "git-remote ls -h"
References: <d2a7caa9-e2ba-457d-9fe9-92b29b5ee47a@www.fastmail.com>
        <CAPig+cSnhbruJE_WBpmmypE_vzEQForooOu8KqbJ=dbaUrKKcg@mail.gmail.com>
Date:   Thu, 30 Jun 2022 11:34:51 -0700
In-Reply-To: <CAPig+cSnhbruJE_WBpmmypE_vzEQForooOu8KqbJ=dbaUrKKcg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 29 Jun 2022 12:29:53 -0400")
Message-ID: <xmqqpmiqdmpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 54BA55C0-F8A3-11EC-9031-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jun 29, 2022 at 11:39 AM Ian Whitlock <ian@theknown.net> wrote:
>> I found a bug and couldn't find another way to report it. I hope this =
is okay.
>> The help output for `git ls-remote` shows that `-h` should display rem=
ote HEADs, but instead the help output is displayed!
>
> Thanks for the report.
>
>>  =E2=9E=9C git ls-remote -h
>> usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<exe=
c>]
>>                      [-q | --quiet] [--exit-code] [--get-url]
>>                      [--symref] [<repository> [<refs>...]]
>
> This is a known and documented behavior. The description of the `-h`
> option in the `ls-remote` help page:
>
>     Limit to only refs/heads and refs/tags, respectively. These
>     options are not mutually exclusive; when given both, references
>     stored in refs/heads and refs/tags are displayed. Note that git
>     ls-remote -h used without anything else on the command line gives
>     help, consistent with other git subcommands.

Correct.

I do not mind a patch that teaches ls-remote to emit an extra line
of hint after giving the standard short-help-usage text, telling the
user that "git ls-remote -h origin" (replace 'origin' with whatever
the default remote is) can be used to learn the branches at the
remote.

Thanks.



