From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 10:02:46 -0700
Message-ID: <xmqqbnrl1ya1.fsf@gitster.dls.corp.google.com>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de>
	<53ED0257.3070505@jump-ing.de>
	<xmqqppg21wyk.fsf@gitster.dls.corp.google.com>
	<273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:03:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIKu5-0000uR-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 19:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbaHORC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 13:02:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54251 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaHORC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 13:02:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41C332EEA2;
	Fri, 15 Aug 2014 13:02:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kEGcus/eLKO1PZIIN1VI0p5D96I=; b=fAUa4O
	wackdPQ+BbqfcFqaWsblmiPWnt/y4Qi6Jto9f1LtDb9fS9VljpYjYSc5v7PsgMkU
	i5+yTkhQFXc2GpU03JI94Z3IdUyMN1utjNdZdjOK2sutKJP0Hr5pvTtvyb0qFXtV
	DOL5C1Zlolh2RWpl9RkYMmhM6ITeCas4hKXOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tYkIvj6VRmXOYepp5fmKil8LrOci0Hx9
	cWcnpHevwBwXxC81ENH4nauu6yTKXTiufqQFuHhr450spcgAJLVPScIBVeQSyPVX
	PtLxeGVYRDinwvRAsFXMxz9xfC67O2FZPBAeezyfaqyeRgIS9sAvK43GLwx5nNh0
	8ukbpZbHJzI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 358DB2EEA1;
	Fri, 15 Aug 2014 13:02:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D8CEB2EE93;
	Fri, 15 Aug 2014 13:02:48 -0400 (EDT)
In-Reply-To: <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Fri, 15 Aug 2014 00:46:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FC48F536-249D-11E4-8222-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255294>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> The below patch does the right thing.  Conveniently there's already
> a test for 10.4 and earlier so only a single line need be added.
>
> --Kyle
>
> ---- 8< ----
> Subject: [PATCH] config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older systems
>
> Older MacOS systems prior to 10.5 do not have the CommonCrypto
> support Git uses so set NO_APPLE_COMMON_CRYPTO on those systems.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 7846bd76..f8e12c96 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -88,6 +88,7 @@ ifeq ($(uname_S),Darwin)
>  	NEEDS_LIBICONV = YesPlease
>  	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
>  		OLD_ICONV = UnfortunatelyYes
> +		NO_APPLE_COMMON_CRYPTO = YesPlease
>  	endif
>  	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>  		NO_STRLCPY = YesPlease

By the way, can we document this "uname_R on MacOS X" business
nearby, perhaps like this?

-- >8 --
Subject: config.mak.uname: add hint on uname_R for MacOS X

I always have to scratch my head every time I see this cryptic
pattern "[15678]\."; leave a short note to remind the maintainer
and the reviewers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index f8e12c9..7e49aca 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -86,6 +86,10 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	# Note: $(uname_R) gives us the underlying Darwin version.
+	# - MacOS 10.0 = Darwin 1.*
+	# - MacOS 10.x.? = Darwin (x+4).* for (1 <= x)
+	# i.e. "begins with [15678] and the a dot" means "10.4.* or older".
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV = UnfortunatelyYes
 		NO_APPLE_COMMON_CRYPTO = YesPlease
