Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB5C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 10:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF409611BD
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 10:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFUKbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:31:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64975 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFUKaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 06:30:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C9AC13A4F4;
        Mon, 21 Jun 2021 06:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C7kEzAkRdYii
        EQyqS9nS+bbp7D0HWmPnVYWGNn43KBI=; b=FN0BMbCEXCt7vLWUZ/dNlk93gBH5
        toY9Y0BqhTWtWeaQByOJlEvpSUwF/XS2j1wIfqAgeDlqESYYkmZu1dfkxQx8WoA8
        G7wpW13AxZhIZMOmCV4IWklqhYXKy7a+SGZH59W/M/tvcEZgdBygqaQszrgdNvOa
        qGjd/JFb0tPb5hA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2667313A4F3;
        Mon, 21 Jun 2021 06:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D89913A4F2;
        Mon, 21 Jun 2021 06:28:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
References: <xmqq4ke8pig9.fsf@gitster.g>
        <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
Date:   Mon, 21 Jun 2021 19:28:36 +0900
In-Reply-To: <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Jun
 2021 10:34:00 +0200")
Message-ID: <xmqqfsxbika3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 71100872-D27B-11EB-A739-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> So, in order for this change to have any effect:
>
>  1. color.man=3Dtrue must be set in the config
>  2. The user must use less
>  3. Not have the same LESS_TERMCAP variables set (we call setenv(3) wit=
h overwrite=3D0)
>  4. Have color.ui enabled
>  5. Not have color.pager disabled
>  6. Not have git with stdout directed to a file
>
> 1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
> 2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
>
> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> On Tue, Jun 08 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I've been running with this on my personal git build since May 26th. =
I
>>> haven't had any issues with it, and I like the new coloring.
>>> ...
>>> I think this is a good example of a change that we're better off just
>>> merging down and then reverting if the wider audience of git users ha=
tes
>>> it, rather than trying to come to some perfect consensus here
>>> on-list.
>>
>> My impression was tht we already had a rough consensus here on-list
>> that it may be good to educate users who like this "new coloring"
>> like you do to configure their "less", so that they consistently get
>> the "new coloring" they like whether they are doing "git help git",
>> "man git", or even "man ls", and the approach the posted patch takes
>> will not help (it only affects "git help git" among these).
>>
>> I'd rather not to take it.
>
> Fair enough, here's a version I think you and others will find
> acceptable then. It allows users like me who like this to explicitly
> opt-in via color.man=3Dtrue.

Not really.

Since the implementation of the posted patch, as I understand it,
does not aim to affect both "git help -m foo" and "man git-foo"
identically, I think it would be easier to understand to end-users
if this were exposed as a new "mode", like "git help --web" and "git
help --info" are different modes from the "git help --man",
something like "git help --fancy-man" (or whatever is easy to type
and explain, and also add it to the variants help.format knows about
to make it easy to set the default).

One advantage of doing so is that we do not have to worry about "ah,
user has LESS_BLAH environment variable so we should disable this
new mode here" etc.  As long as the new mode is requested either via
the command line option or help.format configuration, it can
completely take it over.  That simplifies the necessary explanation
given to the users quite a lot, no?

> 	----
> 	git-config - Get and set [...]
>
> 	SYNOPSIS
> 	--------
> 	[...]
> 	'git config' [<file-option>] [...]
> 	[...]
> 	The `--type=3D<type>` option instructs 'git config' to ensure [...]
>
> Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
> config" and other '-quoted parts in BLUE UNDERLINE instead of
> UNDERLINE, and `--type=3D<type>` and other `-quoted parts in RED BOLD
> instead of BOLD. The "Standout" setting is then used for the user's
> own search bar (invoked with "/") and prompt. See [2] for more
> examples

There are BOLD RED and READ BOLD; are they differently rendered?
