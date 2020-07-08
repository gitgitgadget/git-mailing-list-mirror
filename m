Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02FCC433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 01:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C8D20774
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 01:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lrthZJwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgGHBvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:51:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65404 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGHBvu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 21:51:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AF16D706B;
        Tue,  7 Jul 2020 21:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S03jOD8KM4QU
        nbKF6EBiNovja8M=; b=lrthZJwt89dvhL5gz8uw8Br5HH6GCkWR+JvBB+D0WbK4
        o4p/uyRks+hyYvJxP8a8MyrvuWm72zGrtAOD7Ax8hO3bps0pt7UxyBmXkgKZfHrY
        +tOV4zquXmNRgGLBWiXAk8Fqwp1PP9i/9/+IpVVEFZ4Qu5zs0uQXdRPzGWCp2GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qg4ah/
        9NTRaMcF6gsF7Lky0DXESJPAEuQxYK73wQL3iKS1ol0RhrUGb4nRfrtYCvEYGBig
        j/wicq+42J3zbCk/qg7XgXKE7tgynUgA5ppEtzL6nV6XYuFUicbp8vidIC6A6A+H
        SReh8keJYH0uP8MoU969qJBHXGugJ8ocRlB7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6457CD7069;
        Tue,  7 Jul 2020 21:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF0A2D7067;
        Tue,  7 Jul 2020 21:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <lin.sun@zoom.us>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
Subject: Re: [PATCH v9] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>
        <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
        <xmqqzh8c8eda.fsf@gitster.c.googlers.com>
        <31ab701d65428$b7ca6cd0$275f4670$@zoom.us>
        <xmqqmu4b5l8l.fsf@gitster.c.googlers.com>
        <04e201d654c6$016bfb40$0443f1c0$@zoom.us>
Date:   Tue, 07 Jul 2020 18:51:42 -0700
In-Reply-To: <04e201d654c6$016bfb40$0443f1c0$@zoom.us> (lin sun's message of
        "Wed, 8 Jul 2020 09:20:40 +0800")
Message-ID: <xmqqeepm3hap.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 93AF751E-C0BD-11EA-B96F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<lin.sun@zoom.us> writes:

> if meld_use_auto_merge_option =3D` git config --bool ...`
> then
> 	# success, maybe "(empty)"/true/false
> 	if test -z "$ meld_use_auto_merge_option"
> 	then
> 		meld_use_auto_merge_option=3Dfalse
> 	fi

The inner test does not make any sense to me; I doubt that you can
get an empty output from a "git config --bool" that succeeds.

     $ cat >config <<\EOF
     [x] a
         b=3Dtrue
         c=3D1
         d=3Dfalse
         e=3Dno
	 f=3Dbogus
     EOF
     $ for i in a b c d e f
       do
         if v=3D$(git config --file=3Dconfig --bool x.$i 2>/dev/null)
         then
           echo "succeeds (x.$i) =3D> '$v'"
         else
           echo "fails (x.$i) =3D> '$v'"
         fi
       done

You should see

succeeds (x.a) =3D> 'true'
succeeds (x.b) =3D> 'true'
succeeds (x.c) =3D> 'true'
succeeds (x.d) =3D> 'false'
succeeds (x.e) =3D> 'false'
fails (x.f) =3D> ''

if you run the above.  The most interesting is how all boolean
values are normalized to true and false regardless of how they are
originally spelled.

> else
> 	# failed, the option is not empty or Boolean
> 	if test "auto" =3D ` git config `
> 	then
> 		# detect the "--auto-merge" option
> 	else
> 		meld_use_auto_merge_option=3Dfalse

I think review by =C4=90o=C3=A0n pointed out that we would want to warn/f=
ail
loudly in this "else" case, as it is likely a misspelt configuration
value?

To recap, I think something along the following lines would be the
most readable and acceptably efficient with a short-cut for the
common cases.

    var=3Dmergetool.meld.whatever
    val=3D$(git config $var)
    case "$val" in
    true | false)
	# we can take a short-cut without asking config --bool
        ... use $val ...
	;;
    auto)
	... auto detect ...
	;;
    *)
	if val=3D$(git config --bool $var 2>/dev/null)
	then
		# succeeded, so val must be a normalized boolean
		... use $val ...
	else
		die cannot parse $var
	fi
    easc

Thanks.
