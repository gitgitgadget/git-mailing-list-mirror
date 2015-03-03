From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] t7508: test git status -v
Date: Tue, 03 Mar 2015 14:26:09 -0800
Message-ID: <xmqqioehafb2.fsf@gitster.dls.corp.google.com>
References: <54B8C82E.8000707@drmicha.warpmail.net>
	<4979bf9de04197c1cd0d4a6af1348b45d4b0894c.1425390756.git.git@drmicha.warpmail.net>
	<xmqqr3t5aicu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 23:26:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSvGb-0000xv-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 23:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816AbbCCW0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 17:26:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756742AbbCCW0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 17:26:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3E803EE61;
	Tue,  3 Mar 2015 17:26:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zTnz+14i1c6BqeYiyTSHl07Jza8=; b=hdsAyT
	LOesdDcGD/mjQPBSkfV8m1YuHLbuheSPwD6r1nBH4UZZboirUTpgDKlZYNLJPjIL
	cReG2PlB8BbUP2ACkejVhuuh6fluNWDVeKzWwwvEiY8yKQinp1z/Ltv5UL/9uqI4
	PP4A/m+ndXYvnuZ+F2B8K37ixH2GvK2CcfoM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CVAQnYqwyF599zazi4TgEP/efBCGa4Py
	zMbMOIT/6cCXTTSGNKpxu80eqGjJJuMKKNiSxiZqaZuWqsalSjbs6pw9viPSANmN
	mPvyCQKbwFwzvophhvH3xGGK9A2MU2ysqdM8Rdf3lNA1ojresSUKRG7nNVNFptYd
	vDrfmpiI/Hs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E35223EE60;
	Tue,  3 Mar 2015 17:26:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A6A03EE5B;
	Tue,  3 Mar 2015 17:26:11 -0500 (EST)
In-Reply-To: <xmqqr3t5aicu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 03 Mar 2015 13:20:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BAEA6FE-C1F4-11E4-A4E9-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264700>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  t/t7508-status.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
>> index 8ed5788..4989e98 100755
>> --- a/t/t7508-status.sh
>> +++ b/t/t7508-status.sh
>> @@ -133,6 +133,12 @@ test_expect_success 'status with status.displayCommentPrefix=false' '
>>  	test_i18ncmp expect output
>>  '
>>  
>> +test_expect_success 'status -v' '
>> +	git diff --cached >>expect &&
>
> This makes the test rely on the previous one succeeding.  Do we
> care, or is reproducing what ought to be in 'expect' at this step
> too expensive?

Ahh, OK.  The way the existing tests prepare 'expect' is "by hand".

So I think what is wrong with this new test is not that relies on
the current contents of 'expect', but that it modifies it (imagine
being a merge/patch monkey who has to accept this change while a
change from somebody else that wants to add another test that relies
on the original 'expect' intact and then have to scratch his or her
head when the two topics are merged, wondering why the latter test
starts failing).

Perhaps

	( cat expect && git diff --cached ) >expect-with-v &&
        git status -v >actual &&
        test_cmp expect-with-v actual

or something?
