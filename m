From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] diff: shortcut for diff'ing two binary SHA-1 objects
Date: Thu, 14 Aug 2014 10:00:16 -0700
Message-ID: <xmqq38cz2ehr.fsf@gitster.dls.corp.google.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHyOB-0002ZF-D7
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 19:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbaHNRAb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 13:00:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63693 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbaHNRAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2014 13:00:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA7052F1D4;
	Thu, 14 Aug 2014 13:00:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fn99xr2JlCa0
	XeV9lQXy/QlHDbE=; b=oYb9lNPtqe383av6I1kC3Fjz4sHSq7UBUVffsWxQFmUD
	39I1enpCrsRhxkKrMG1zwv6YOXm4oEfrpneYL3apeJdhDiFqcTxgBNSZ9Xsw+pjC
	ajPbTB+tyZeAf6Eq/CyNjPx2BMOF/nrvHGyu5w0QzKTeYT7+CegOEKILAIZIPhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tY43Xg
	9LFnozT+me9R4rOQS8DFKwREFe5VIs0R3e8J8uf3sJ47rNwmBWDarY+NanQDApor
	4xMJ1hGtZN96wkb/jrMKRJ+n4UGUwXekTpFdzb2gZOZ86Y+pyowIJzE8rNcoSQUH
	tATjNI67vHnUd1lVLyXzsQLJZyRbHuZcES5fY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 803F62F1D2;
	Thu, 14 Aug 2014 13:00:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C31A2F1B3;
	Thu, 14 Aug 2014 13:00:18 -0400 (EDT)
In-Reply-To: <1407927454-9268-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13
 Aug 2014 17:57:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 77FFEF92-23D4-11E4-AFA2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255267>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 711f22c..b294963 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -116,6 +116,14 @@ test_expect_success 'diff --stat' '
>  	git diff --stat HEAD^ HEAD
>  '
> =20
> +test_expect_success 'diff' '
> +	git diff HEAD^ HEAD
> +'
> +
> +test_expect_success 'diff --cached' '
> +	git diff --cached HEAD^
> +'

What are these checking?  No check for their outcome?

>  test_expect_success 'hash-object' '
>  	git hash-object large1
>  '
