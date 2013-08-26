From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: do not remove .git/shallow file when --depth is not specified
Date: Sun, 25 Aug 2013 23:09:30 -0700
Message-ID: <xmqqk3j9j84l.fsf@gitster.dls.corp.google.com>
References: <20130826002202.GA26940@camk.edu.pl>
	<1377483446-24834-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kacper Kornet <kornet@camk.edu.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 08:09:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDpze-0001HU-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 08:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab3HZGJf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Aug 2013 02:09:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827Ab3HZGJe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Aug 2013 02:09:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36E79375E9;
	Mon, 26 Aug 2013 06:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Bmn2JZgF9An8
	9/UVStiwhuj2K2A=; b=UtNiHQrUZVEgAIuABFTBEQhbI2ePSIY8JQ/jIKG6gM9x
	xi1e2SxV6st0fvfl/9z4xUSmcdsv+j/jDqhBKVDMFwGrmvWZHazFa5094Rf871im
	9xHNv2t1s3arvxeFjNv7L0oVWUFu+rqvREYRk0VS4R0hLsRWLA6hQX6hYrCbDdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RqvLWm
	VnbA/bIi93fH8PD1W1FM7fdwCtmLmVCr0RxpdMUs/3zbKKfXo275EIQ2PoB8231T
	1+8rzzK4l3R20yOqJKdAhA4z9pHCMHUp19WNLb5EcaR1TVo/4cbcLDxw27cAAdxn
	T7jgLDKFJ6V6kJsNGfuMP2LWYwohzguSoQhnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CF34375E8;
	Mon, 26 Aug 2013 06:09:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 854AF375E7;
	Mon, 26 Aug 2013 06:09:33 +0000 (UTC)
In-Reply-To: <1377483446-24834-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 26
 Aug 2013 09:17:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 13CD639E-0E16-11E3-90DA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232976>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  > The two possible fixes which I see are:
>  >
>  > 1) Replace back if (alternate_shallow_file) condition in fetch pac=
k with
>  >    if (args->depth > 0)
>  >
>  > 2) alternate_shallow_file should be copy of shallow_lock.filename =
not a
>  >    reference to it
>
>  3) Move alternate_shallow_file to struct fetch_pack_args, which will
>     always be zero'd by memset
>
>  I think #1 is better. It's the original condition before 6035d6a
>  replaces it with "if (alternate_shallow_file)". Apparently I did not
>  see that fetch_pack() could be called twice. #3 is also an option,
>  but we still need static "shallow_lock" anyway, so I disregarded it.

Thanks.
