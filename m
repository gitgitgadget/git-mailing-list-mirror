From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] wildmatch: remove static variable force_lower_case
Date: Tue, 09 Oct 2012 13:47:42 -0700
Message-ID: <7vtxu3e5jl.fsf@alter.siamese.dyndns.org>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
 <1349752147-13314-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 22:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLgia-0008N6-UV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 22:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab2JIUrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 16:47:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab2JIUrp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2012 16:47:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F549387;
	Tue,  9 Oct 2012 16:47:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PCB3w7/jsUdK
	fl/mT9tfUsYv2Dw=; b=E7QmOjiUqBZrBjaHWK4/T2+zttTipcSB8TyDdpag/BGh
	Q8rTB2spXvaDS89E/yWCc8BBZUSB+YMnepVwU5stHJiqh+ysTV0JTAv8FYgLeFgz
	XM+hGLp3xbVsujobMdAnQfmn6a9IElsoLth59syAW+OZNHtj+9MZhjaYA/vhqV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qepx3o
	wkRTr2kZoPWPrMVJoGXB0d2MiCTlGSALfL7lLRJQpVhgouDUQS3rIhlbGfjAb/+F
	TuzBkajutrCenT8gw7MNIMw67+LoYhTZVX2N9z/Vi59Tn+9h+OXCH2ck3w/J30s0
	7l7f8UkYQidlVGbqp4VfCQ4BWnU5GDPEEcA8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E101A9386;
	Tue,  9 Oct 2012 16:47:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58A669385; Tue,  9 Oct 2012
 16:47:44 -0400 (EDT)
In-Reply-To: <1349752147-13314-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 9 Oct
 2012 10:09:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 936030C0-1252-11E2-A431-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207345>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/wildmatch.c b/wildmatch.c
> index 7b64a6b..2382873 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -11,8 +11,8 @@
> =20
>  #include <stddef.h>
>  #include <ctype.h>
> -#include <string.h>
> =20
> +#include "cache.h"
>  #include "wildmatch.h"

This is wrong; the includes from the system headers should have
been removed in the previous step where the series "integrated"
wildmatch to git, after which point the first include any C source
that is not at the platform-compatibility layer should be cache.h
or git-compat-util.h.
