Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8703EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F0F206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="so/gHo22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLITQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:16:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50641 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:16:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D21D83EA5B;
        Mon,  9 Dec 2019 14:15:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D0tbWBhpFZ+X
        NEcrSotZUWveEy0=; b=so/gHo22A+XRhia5wAVE52CRZVj1J3LknXKTCHcyVUD2
        xAB1d8+ru1oJ8buMZJ805kMR1HMn2ziJggdpKELRFmz0IbQ5x/9BjXZamSG63xnk
        Ad+RZbCJBvLyoiofC97p+qas2JNzrAB1AFAIGZhKzulzRQwPQJo2K7pD6inXO8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AcTPwb
        KOKZ2AEaX1jYt9ZXCy4TsBtzTZ8tMvkPbwr1NhjktVQzL5T1kzAdCymTPxGD7c5t
        s70HC3bUeBYuwWpFtTA+H2wZSQcoMtJ7gkAv5Gv09mfIYmNLUBhc5I0tuLAkW/aj
        SdWdV30njhfyTpby+31p8CUzy3bol3Yyxq4+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8CE13EA59;
        Mon,  9 Dec 2019 14:15:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E6333EA58;
        Mon,  9 Dec 2019 14:15:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5Yqg6Jek5LiA?= =?utf-8?B?5Y2a?= <kato-k@ksysllc.co.jp>
Subject: Re: [PATCH] git gui: fix branch name encoding error on git gui
References: <20191207002842.32208-1-kato-k@ksysllc.co.jp>
Date:   Mon, 09 Dec 2019 11:15:55 -0800
In-Reply-To: <20191207002842.32208-1-kato-k@ksysllc.co.jp> (=?utf-8?B?Ig==?=
 =?utf-8?B?5Yqg6Jek5LiA5Y2aIidz?=
        message of "Sat, 7 Dec 2019 00:29:09 +0000")
Message-ID: <xmqqpngxux78.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 53DC6E5C-1AB8-11EA-8654-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=8A=A0=E8=97=A4=E4=B8=80=E5=8D=9A <kato-k@ksysllc.co.jp> writes:

> After "git checkout -b '=E6=BC=A2=E5=AD=97'" to create a branch with UT=
F-8
> character in it, "git gui" shows the branch name incorrectly,
> as it forgets to turn the bytes
> read from the "git for-each-ref" and
> read from "HEAD" file
> into Unicode characters.

Thanks.

Note to the git-gui mentainer.  The above may want to be
line-wrapped a bit.

> Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>
> ---
>  git-gui.sh     | 1 +
>  lib/branch.tcl | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 0d21f56..8f4a9ae 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -684,6 +684,7 @@ proc load_current_branch {} {
>  	global current_branch is_detached
> =20
>  	set fd [open [gitdir HEAD] r]
> +	fconfigure $fd -translation binary -encoding utf-8
>  	if {[gets $fd ref] < 1} {
>  		set ref {}
>  	}

A comment totally outside the scope of this fix to anybody
interested in further working on this code.

This piece of code is way too intimate with the implementation
details of HEAD and yet not intimate enough to know that HEAD can be
a symlink (in other words, it is a poor imitation of the real logic
implemented in git core).  A kosher way to implement this would be
to call

	git symbolic-ref --quiet --short HEAD

which would succeed and give the branch name to its standard output,
or would fail when the head is detached.  Set "current_branch" and
"is_detached" according to the outcome.

And yes, Kato-san's fconfigure fix in this patch will still be
relevant even after such a fix to the implementation of this proc.

> diff --git a/lib/branch.tcl b/lib/branch.tcl=20
> index 777eeb7..8b0c485 100644
> --- a/lib/branch.tcl
> +++ b/lib/branch.tcl
> @@ -8,6 +8,7 @@ proc load_all_heads {} {
>  	set rh_len [expr {[string length $rh] + 1}]
>  	set all_heads [list]
>  	set fd [git_read for-each-ref --format=3D%(refname) $rh]
> +	fconfigure $fd -translation binary -encoding utf-8
>  	while {[gets $fd line] > 0} {
>  		if {!$some_heads_tracking || ![is_tracking_branch $line]} {
>  			lappend all_heads [string range $line $rh_len end]
> @@ -24,6 +25,7 @@ proc load_all_tags {} {
>  		--sort=3D-taggerdate \
>  		--format=3D%(refname) \
>  		refs/tags]
> +	fconfigure $fd -translation binary -encoding utf-8
>  	while {[gets $fd line] > 0} {
>  		if {![regsub ^refs/tags/ $line {} name]} continue
>  		lappend all_tags $name
