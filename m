From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] completion: normalize increment/decrement style
Date: Wed, 22 Feb 2012 14:05:17 -0800
Message-ID: <7vvcmy8qxu.fsf@alter.siamese.dyndns.org>
References: <20120222001737.GB2228@goldbirke>
 <1329901093-24106-1-git-send-email-philip@foolip.org>
 <1329901093-24106-3-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0KJS-0002Gb-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab2BVWFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 17:05:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387Ab2BVWFU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:05:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6CCA7EAF;
	Wed, 22 Feb 2012 17:05:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pLvZyUq3P9Ey
	BtilmstdP005IF4=; b=HdOEp0jHYUaV9KXQFkTQW4yGAZf6IMaDl/vqcVf5KZxh
	Ubanhi7svXHq48T8drF+upPG/SH1DhbAz06AwXgBMvcIWQXlY8mV656lN+2i52Xv
	gB0x0IOwmWoOQvdIuOyLep48m9e9o9iFeU0Z4G8njFtx75kodx6KA88vWnUiKrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZZIQDl
	yEIPcEz5jVch7UweySc94OeGdL9l4GBObQ3cpOZeMoGId2CryTuW/lnsQuYi3FcP
	Oy4EQTwij4TXtCUOyK5aPnDW3fDnt+vI9CdF7TNoli9Ndh5jYvO4E6cqH1VRmEuT
	6C7HeRDlCqRv0I9QSfLrH1ArK8+w+Cgr+s97Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B93667EAE;
	Wed, 22 Feb 2012 17:05:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41C7F7EAD; Wed, 22 Feb 2012
 17:05:19 -0500 (EST)
In-Reply-To: <1329901093-24106-3-git-send-email-philip@foolip.org> ("Philip
 =?utf-8?Q?J=C3=A4genstedt=22's?= message of "Wed, 22 Feb 2012 09:58:11
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EEC5CA4-5DA1-11E1-B4A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191292>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> The style used for incrementing and decrementing variables was fairly
> inconsistenty and was normalized to use x++, or ((x++)) in contexts
> where the former would otherwise be interpreted as a command. This is=
 a
> bash-ism, but for obvious reasons this script is already bash-specifi=
c.
>
> Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>

I am not sure if the kind of changes seen in the following hunks are
necessary but I do not care too deeply about it.  Assuming that the
change does not make the emulation by zsh unhappy, will apply.

Please stop me if somebody has issues with this rewrite.

Thanks.

> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index c63a408..1903bc9 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -178,10 +178,8 @@ __git_ps1_show_upstream ()
>  			for commit in $commits
>  			do
>  				case "$commit" in
> -				"<"*) let ++behind
> -					;;
> -				*)    let ++ahead
> -					;;
> +				"<"*) ((behind++)) ;;
> +				*)    ((ahead++))  ;;
>  				esac
>  			done
>  			count=3D"$behind	$ahead"
> @@ -739,7 +737,7 @@ __git_complete_remote_or_refspec ()
>  	local cur_=3D"$cur" cmd=3D"${words[1]}"
>  	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
>  	if [ "$cmd" =3D "remote" ]; then
> -		c=3D$((++c))
> +		((c++))
>  	fi
>  	while [ $c -lt $cword ]; do
>  		i=3D"${words[c]}"
