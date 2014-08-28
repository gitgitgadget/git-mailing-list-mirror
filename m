From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t0027: Tests for core.eol=native, eol=lf, eol=crlf
Date: Thu, 28 Aug 2014 12:20:56 -0700
Message-ID: <xmqqha0wa09z.fsf@gitster.dls.corp.google.com>
References: <53EFBC3A.5020805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:21:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN5GB-00082o-QJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 21:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbaH1TVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2014 15:21:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61170 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbaH1TVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 15:21:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD87F35A55;
	Thu, 28 Aug 2014 15:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yi1C9zdhclqF
	DZsdKecFAfJmyhw=; b=bnAKrLR1unqd47VxAt+Yrmc9rHsKV0GUPUDd8eV0lNae
	3XJsZrBcrorVPwbA0oYwojAseHkLXW7CUYD6u010O1bLQtuCASId6BchdoqZaw3p
	nvZ9kDw4Ct6CagZWXK9jE0eVQwaVkKY/ePiIBhHRRadcWd9VB39ZioQg2V6TU8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QQHaAc
	kukUrYpdAuF5uL3XkPOyG0kCdfXcPtM7FaHgR7dE222VuVpQQb5PQMUChTeQQ7ak
	ApR7MACxqSsIXhNCnEZ65Vj9r/oTZNIpaG2Iyb6eMh24UY3SjS6tvVYiq2FQ8pHg
	8yWN1gKq3uWfLrWwJu4dO6jsVbmi0R4Mpw0VY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C27E335A54;
	Thu, 28 Aug 2014 15:21:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8BA4C35A4C;
	Thu, 28 Aug 2014 15:20:58 -0400 (EDT)
In-Reply-To: <53EFBC3A.5020805@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 16 Aug 2014 22:16:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70AFAEFC-2EE8-11E4-988F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256116>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Add test cases for core.eol "native" and "" (unset).
> (MINGW uses CRLF, all other systems LF as native line endings)
>
> Add test cases for the attributes "eol=3Dlf" and "eol=3Dcrlf"
>
> Other minor changes:
> - Use the more portable 'tr' instead of 'od -c' to convert '\n' into =
'Q'
>   and '\0' into 'N'
> - Style fixes for shell functions according to the coding guide lines
> - Replace "txtbin" with "attr"
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

It appears that I missed this patch?  You seem to have rerolled the
corresponding 2/2, to which I responded ($gmane/255507).  Is this
one still viable/necessary?

If you are doing the whole-sale style fixes for this script, can you
also fix the case/esac statement in create_gitattributes?  The case
arm labels are indented one level too deep, making it harder to spot
them than necessary.

Test files "setup master" step creates appear to end in an
incomplete line.  Is this intended or by mistake?  Making sure
things work even on files that end in an incomplete line is a good
thing, but it looks somewhat strange not to test normal cases (in
other words, it makes it appear as if normal cases work OK but
incomplete lines cause corner case bugs and these tests are meant to
check them, or something).

Thanks.
