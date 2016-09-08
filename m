Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631E81F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbcIHUDI (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:03:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752115AbcIHUDH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:03:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F2423C293;
        Thu,  8 Sep 2016 16:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hFvEHyn1jZhc
        CaWCHZ7JfH7BFaE=; b=VniNCGuWXmqqNb9eFzCWf/TcPs3Kbwn5HZ+K5VxKunp+
        4oVabXxzYpnGvdjEJw+QrQTFfRrwivHhTPOU6/MRKibhtSFWui8pk10Wv3Aa91wd
        Alqctqs07QvZf04pto7b+vIDWQQmWaSQWu+s3m6l/KlM/oxuIZyD6g+LvhfbdDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LgxsU+
        0XMzvx/y323sT5TKXrWWpr2ViQnibOOVIfYScMscDGvUSZKaFdR+SVSjvoXNolDq
        KbMfiwIFLfy2CRBjlj5qQYEN7TF/JnYjfA1mBRU/4Eb6iQT3rKnadxYoTLQWWCPE
        +tDVjL2x5oAprOpSHmYyX5Ds1XapAWvy5Mnfc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 583343C292;
        Thu,  8 Sep 2016 16:03:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3FCD3C291;
        Thu,  8 Sep 2016 16:03:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] checkout.txt: document a common case that ignores ambiguation rules
References: <20160822123502.3521-1-pclouds@gmail.com>
        <20160907111941.2342-1-pclouds@gmail.com>
        <20160907111941.2342-3-pclouds@gmail.com>
Date:   Thu, 08 Sep 2016 13:03:03 -0700
In-Reply-To: <20160907111941.2342-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 7 Sep 2016 18:19:40 +0700")
Message-ID: <xmqq7famgnwo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 419615A6-75FF-11E6-A6BB-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Normally we err on the safe side: if something can be seen as both an
> SHA1 and a pathspec, we stop and scream. In checkout, there is one
> exception added in 859fdab (git-checkout: improve error messages, detec=
t
> ambiguities. - 2008-07-23), to allow the common case "git checkout
> branch". Let's document this exception.

Good idea, but...

> +ARGUMENT AMBIGUATION
> +--------------------
> +
> +When there is only one argument given and it is not `--` (e.g. "git
> +checkout abc"), "abc" could be seen as either a `<tree-ish>` or a
> +`<pathspec>`, but Git will assume the argument is a `<tree-ish>`, whic=
h is
> +a common case for switching branches. Use `git checkout -- <pathspec>`
> +form if you mean it to be a pathspec.

... this is far from reasonable.  I'd read "but Git will assume the
argument is a tree-ish" to mean "git checkout Makefile" would
attempt to checkout the Makefile branch and fail.

    When there is only one argument given and it is not `--` (e.g. "git
    checkout abc"), and when the argument is both a valid `<tree-ish>`
    (e.g. a branch "abc" exists) and a valid `<pathspec>` (e.g. a file
    or a directory whose name is "abc" exists), Git would usually ask
    you to disambiguate.  Because checking out a branch is so common an
    operation, however, "git checkout abc" takes "abc" as a `<tree-ish>`
    in such situation.  Use `git checkout -- <pathspec>` if you want to
    checkout these paths out of the index.

or something like that?
