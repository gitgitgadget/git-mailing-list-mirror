From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] commit: remove commit.ignoreIntentToAdd, assume it's
 always true
Date: Mon, 06 Feb 2012 12:05:44 -0800
Message-ID: <7v4nv37mnb.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:05:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUoy-0001p7-NE
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab2BFUFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 15:05:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2BFUFr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 15:05:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A256B05;
	Mon,  6 Feb 2012 15:05:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IG+d4ls92KQX
	AtaVKhPmvpCsq3I=; b=cF0ozFkfEIL1eIUMikZCRkkj4i6/n/RdYvx3ERmI2/9r
	8oSBC1J2W5Vx0BTJ0BCi3wZw3FtCWxAZhSveimmVdetsZRtGKMZLbRQ9MjKk1SPR
	hZXjEZf9xB+V2AshkQQFx/eE1XM/OEe+l9HQYsMe3HlWZNjuAGkLeiODtSd4218=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aXOPUV
	gmNqKoHCQGW/+eOBJIf2H5To7L8fUHbvPBhXSgt/TygIG687RWTt/uKsx2oX2MhG
	ThF9RjBJBV1yzm80W7FsJ800K/3a/rk6WRn0zVTfkCmjGwz5LZjO2t7aPJsgeANb
	pLsgKNe3luIpzJhjMGUdIOeVdObBgjKhGBGkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C95C86B04;
	Mon,  6 Feb 2012 15:05:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 608ED6B03; Mon,  6 Feb 2012
 15:05:46 -0500 (EST)
In-Reply-To: <1328525855-2547-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Feb
 2012 17:57:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4EEF018-50FD-11E1-A076-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190093>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 09b8bbf..7c7ab54 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -50,7 +50,7 @@ test_expect_success 'can commit tree with i-t-a ent=
ry' '
>  	echo frotz >nitfol &&
>  	git add rezrov &&
>  	git add -N nitfol &&
> -	git config commit.ignoreIntentToAdd true &&
> +	git config commit.ignoreIntentToAdd false &&

This deserves a comment to the effect that the variable is now *ignored=
*.

>  	git commit -m initial &&
>  	git ls-tree -r HEAD >actual &&
>  	cat >expected <<EOF &&
