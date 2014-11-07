From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --only -- $path when $path already has staged content
Date: Fri, 07 Nov 2014 08:57:56 -0800
Message-ID: <xmqqioirgd7v.fsf@gitster.dls.corp.google.com>
References: <545CA118.6040500@atlas-elektronik.com>
	<xmqqmw83gd94.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 17:58:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmmrN-0006sW-A5
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 17:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbaKGQ6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2014 11:58:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751678AbaKGQ57 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2014 11:57:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F5D71A2F1;
	Fri,  7 Nov 2014 11:57:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d/E9Pp5CTi+1
	qR1o015b+gQQBeo=; b=x0SE01YujyO4A9d32u2CnQiyNV7H/SNrgD2PgcohV6K2
	m/sacBZNzz+pRScqtpnMTcuWTjXAQ8lPwIJkD00OrGvCkiOyMjLsTy63BzLAWzQi
	YI6B/AN1YwL9/oAYylETpAlpWgsDZmRc/MdQBut0cWF8zHrF0P4VMCqS4YCFCTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wA5JE9
	W1Na0UzZ52Hqj26W3qTXaNJH8EaLfBM/FbntZOQYhNBOcceiG+1w2t9G3dE+f41C
	cDrxdGSt1yLJfFQiU5y2Z1/ZqL9Rnili/XiiEQB1G/71QWeXnNHDOOrg6mWKYwTN
	DyMwux1TMjYD72NvNVTg3fkyDYh2sMdptwZL4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 950D01A2F0;
	Fri,  7 Nov 2014 11:57:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15D901A2EE;
	Fri,  7 Nov 2014 11:57:58 -0500 (EST)
In-Reply-To: <xmqqmw83gd94.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 07 Nov 2014 08:57:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39A61448-669F-11E4-B074-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:
>
>> The manpage of git commit reads:
>>
>>   --only
>>
>>       Make a commit only from the paths specified on the command lin=
e,
>>       disregarding any contents that have been staged so far. This i=
s
>>       the default mode of operation of git commit if any paths are g=
iven
>>       on the command line, in which case this option can be omitted.=
 [...]
>
> "--only" is as opposed to "--also".  Two modes of partial commits
> are:
>
>  - "--also" which updates the index with the whole contents of the
>    given paths and record the resulting index as the tree of the new
>    commit;
>
>  - "--only" which starts from a new temporary index initialized from
>    HEAD with the whole contents of the given paths and record the
>    resulting index as the tree of the new commit, and then updates
>    the original index with the whole contents of the give paths.
>
> In other words, you give paths from the command line to tell the
> command that you want to record the contents of them in the working
> tree as a whole to be recorded in the resulting commit.

s/also/include/; "--also" was its original name of the option while
it was in development.
