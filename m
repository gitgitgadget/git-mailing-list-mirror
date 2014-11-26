From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t7503: use write_script to generate hook scripts
Date: Wed, 26 Nov 2014 10:12:08 -0800
Message-ID: <xmqqk32hrfuv.fsf@gitster.dls.corp.google.com>
References: <cover.1416955873.git.oystwa@gmail.com>
	<78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
	<20141126045127.GC15252@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:12:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xth4a-0004xT-RL
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbaKZSMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2014 13:12:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070AbaKZSMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2014 13:12:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87F3720B14;
	Wed, 26 Nov 2014 13:12:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4Lz2w4FmL1//
	6bCaC2y+dCmCHPg=; b=K8GIG7MUKpbx6Aug4wIHm0dMLyS553SJ+6q5qOizKGfK
	drv9N0OKPT1DizDlhXmiCVgOwH9ZJa8BcdHhXtjwJK2A1QJESlvjyg1T7iQIveiv
	vqypZnRpwfV21X3O6Opn2rrSV6zBiccZXtI+7KqeixxlQ1DwLUsEkSpuvvFfzLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AstKT4
	nRubB8Sr4zCTlH/Oi6kYvhr+dNbJTa4vhN9uwUEj7BWu8ZswqA6oT18ZvTplvrXF
	z2Wy/x49PquRcArtYMp1qZECNL7/ytdr45h4RBi5XT/Gys0l+3lPXYv7iH4pepRw
	WzOSnQkisKqp1vI0rRtFNDwbFeWls+t6DoEks=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EB5C20B13;
	Wed, 26 Nov 2014 13:12:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07B5A20B12;
	Wed, 26 Nov 2014 13:12:09 -0500 (EST)
In-Reply-To: <20141126045127.GC15252@peff.net> (Jeff King's message of "Tue,
	25 Nov 2014 23:51:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD107AA6-7597-11E4-BEC6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260288>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 25, 2014 at 11:51:28PM +0100, =C3=98ystein Walle wrote:
>
>> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
>> ---
>>  t/t7503-pre-commit-hook.sh | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
>> index 984889b..99ed967 100755
>> --- a/t/t7503-pre-commit-hook.sh
>> +++ b/t/t7503-pre-commit-hook.sh
>> @@ -24,8 +24,7 @@ test_expect_success '--no-verify with no hook' '
>>  HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
>>  HOOK=3D"$HOOKDIR/pre-commit"
>>  mkdir -p "$HOOKDIR"
>> -cat > "$HOOK" <<EOF
>> -#!/bin/sh
>> +write_script "$HOOK" <<EOF
>
> While you are touching this line, please make it "<<\EOF". It does no=
t
> matter for these simple cases, but as a style, we try to avoid
> interpolation unless it is necessary.

Thanks.  It is more about reducing cognitive burden from the
readers.  An unquoted <<EOF signals you that your eyes need to scan
carefully for $subsitutions to understand what is going on, instead
of coasting it over.
