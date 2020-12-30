Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FCFC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245E92222A
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 17:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgL3RUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 12:20:11 -0500
Received: from mout.web.de ([212.227.15.3]:34313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgL3RUK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 12:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609348696;
        bh=9c+UO04+XD1vntc228+2chPY5ijd+RLDQfw/+u8i8d4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rSjxLNeBMumZbqFsWpRU0FxCOs047U16Okhn4LRio7nlwyVrzozexVQj3DN3UzbXa
         KU8wqMoeEMpm1CQIiyutFHMWmCrYfgBkZZB4Pd9tGgJ4zuCRnB99aOfiyEr44B6Vmw
         s4H2dEqiQSBrqDrR9OLhXUmF0jDmSCIaKpinVc9Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1khEYa3beh-00NgKY; Wed, 30
 Dec 2020 18:18:15 +0100
Subject: Re: [PATCH v2 1/3] completion: bash: add __git_have_func helper
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
 <20201229170837.297857-2-felipe.contreras@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
Date:   Wed, 30 Dec 2020 18:17:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201229170837.297857-2-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2lg+3i3b8GOGlmUby8gOnUYLVHrIte/12TDeJglNgRkDBh6SEN
 Mv0jhaXm2GHWXE/nIdfhloZoNKUcvDud6eAzKtZi4yacvAkiq242VSjdjJ1/djeXyfX9paq
 BT8Qxn4e1Dn6hDb3isR6Ji2OApPRtzWgHe1UKJWnJRbx55T+nTuS9DpVCZloKpyCglnsmyn
 TCHs+gPPTrv1mRca+oI0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cL5hyE/Aolo=:Qs98dDobsS7+0UmQl4WVZN
 fu6zcDaJTwf60EixvIxR3sjS003EQ79jMONngYByKjbFWrik7UfEIxVGUgjKGcUsROLvKuSFP
 WUV//6L6J0O4bcxOJmJqDk3RsxzHnraahK3StBbC8yydV314VuaBJBm626LCf/DdqqdVqASbA
 /0m+V2NXwxLRJVLperhU+m0IG292bz5n4yvDmey3UTXZLWtmKuXHk0o/T7fYATJk/8mdfiSAt
 FllRIRG1RDheKncLVLsp42aJOSzxVWYsl8KxkPz+6fNxYFkU9uE4YJ7UJanB+szxBErA5Gu1c
 C5fDXUXxSpfns27wCQAeVvYqxuGemarlnKB4Bf8qSNh6NK/A/0JQkcNHzwr0vzNAnm/qlpnTV
 4KxRFgfxj0Xpi+4PA13WRukfbEn+vH7h1y0GMg6t9sJpAzfIAYBLPySUdCdpFODbJRFEkq/f+
 lMuBIucNluHoRHvVzCoRFTbdhI1SCrhMZdXG+pkAo8I4OWAb5k0h5gKce0/41C+p896ypuusJ
 +OCcZV+eS+BQ5yyYayJ3b9+d+K389TrTRCMURdJZKbIUVYiimXEGnFfNfdbsDBY0OzO44DDvf
 DVE0L84pzSApDaFe+o0K9EUfQAo404AlYVIPeym1BYfA/tDNE0LrlrXf6JNrBe1PUHUbRgkur
 Op/EkndADj8RrbkqOaIoqsEZmq9NObDveRmy/9rSawFm9N6D66Py2OmHS5Zkd+n53etRh74Im
 5QOqSuFwmh6EKS7kbRfcdO+3bjq8Na3YImYy7PxhN3BIzfJ4y9RU1pk0ltQxv301gvIaTG04w
 7XeKCEn3aipsSmqGfB14Lu6frFFGGTTMLJuG58xzk1w0n6fw/lkk8cW8M0Azg4almX7p5a+8V
 C3I4M0k3DQAEjlUPHWmw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.12.20 um 18:08 schrieb Felipe Contreras:
> This makes the code more readable, and also will help when new code
> wants to do similar checks.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
> index 463a3124da..869c73ee2c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3358,15 +3358,19 @@ __git_support_parseopt_helper () {
>  	esac
>  }
>
> +__git_have_func () {
> +	declare -f $1 >/dev/null 2>/dev/null

I stumbled slightly over the lack of quoting.  It doesn't matter for
the callers below, but new callers passing arbitrary strings could
cause strange effects:

	x() { echo x; }
	y() { echo y; }
	__git_have_func "x y" # succeeds

	__git_have_func -a # succeeds

I just skimmed patch 3, but it seems to call __git_have_func with
user-supplied strings, so this might become relevant.

And then I wondered why use declare -f, which prints the function's
body, when there is -F, which just prints the function's name.  And why
repeat /dev/null when redirecting stderr when the more shorter 2>&1
would do the same?  None of hat was introduced by you patch, of course.
Anyway, this seems to work for me:

	__git_have_func () {
		case "$1" in
		-*) return 1 ;;
		esac
		declare -F "$1" >/dev/null 2>&1
	}

> +}
> +
>  __git_complete_command () {
>  	local command=3D"$1"
>  	local completion_func=3D"_git_${command//-/_}"
> -	if ! declare -f $completion_func >/dev/null 2>/dev/null &&
> -		declare -f _completion_loader >/dev/null 2>/dev/null
> +	if ! __git_have_func $completion_func &&
> +		__git_have_func _completion_loader
>  	then
>  		_completion_loader "git-$command"
>  	fi
> -	if declare -f $completion_func >/dev/null 2>/dev/null
> +	if __git_have_func $completion_func
>  	then
>  		$completion_func
>  		return 0
>

