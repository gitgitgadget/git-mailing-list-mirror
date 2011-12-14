From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Wed, 14 Dec 2011 10:19:16 -0800
Message-ID: <7vzkevow2j.fsf@alter.siamese.dyndns.org>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Miles Bader <miles@gnu.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 19:19:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RatQM-0008Bh-2I
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 19:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592Ab1LNSTV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 13:19:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373Ab1LNSTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 13:19:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F032D4C59;
	Wed, 14 Dec 2011 13:19:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ObbL4S95Zyyx
	c9tOHb+fnlMdKC0=; b=qa00Cm3mZEH+y2WlXb01wnN3YoUA16L1GXBD6N3fTLV1
	e9JO3rCtfXCmlESJgpVYcYCMSdnvs6DVun3aipUPpbJT1+W4Dp23TpDKT8amtOGn
	VyLjwf0KMJfhW8T8tzjF9o9hSFLRdNoRTrDD0Yk4Kcia+3u0ygy6PoXRbuUSIeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tRVtqC
	2RQ0tp5BZYPNGE0T+ORZDPaod40Q2fxKqiqkW2fk8LFsFtpOV3mEV9NodEAFWDSj
	nnW3a04VKWA1YGk3PWFWOJxcnc0HySg4tlxN3feE1vyFkMKb2iW+XFRr6vtmEzsR
	aZVTQWHjYgyqOZmwgALgW5NDCNd86ZHI4DlYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E81F24C58;
	Wed, 14 Dec 2011 13:19:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 782834C57; Wed, 14 Dec 2011
 13:19:18 -0500 (EST)
In-Reply-To: <1323871699-8839-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 14 Dec
 2011 21:08:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2323A7B0-2680-11E1-8A97-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187162>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We assume that the commit log messages are uninterpreted sequences of
> non-NUL bytes (see Documentation/i18n.txt). However the assumption
> does not really stand out and it's quite easy to set an editor to sav=
e
> in a NUL-included encoding. Currently we silently cut at the first NU=
L
> we see.
>
> Make it more obvious that NUL is not welcome by refusing to create
> such commits. Those who deliberately want to create them can still do
> with hash-object.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Limiting the Porcelain layer to deal only with reasonable text encoding=
s
(yes, I am declaring that utf16 is not among them) is perfectly fine, b=
ut
I was somehow hoping that you would allow the option for the low-level
function commit_tree() to create a commit object with binary blob in th=
e
body part, especially after seeing the patch 1/3 to do so.

Certainly that kind of usage would not give the binary blob literally i=
n
"git log" output, but it is with or without the issue around NUL byte. =
A
custom program linked with commit.c to call commit_tree() may not be us=
ing
the data structure to store anything that is meant to be read by "git l=
og"
to begin with.

Not a strong veto at all, just throwing out something to think about.
