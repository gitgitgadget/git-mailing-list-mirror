From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6131 - skip tests if on case-insensitive file system
Date: Wed, 17 Jul 2013 12:47:44 -0700
Message-ID: <7vppuh55pb.fsf@alter.siamese.dyndns.org>
References: <1374067336-6545-1-git-send-email-mlevedahl@gmail.com>
	<CACsJy8Ayyb7kTydXFxoeqNQgGemdUXXzAc3ZwEbT5dCuk_tkQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 21:47:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzXhY-0003rC-28
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 21:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab3GQTrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 15:47:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757146Ab3GQTrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 15:47:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C93131E09;
	Wed, 17 Jul 2013 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ngym2fwIMrvl7kFYQrTY91D+WQ=; b=fh0uNn
	dr/HqZUXkErxX82gqUbOteJp1OTZhJUGDm5Nj+zT1BBvsYhIo1qFTw75rUV9D3DN
	UjtLFNZy00Hkgr49oMr8AEEZiDjDlpODmXogjO0dGv6UWmyJ3Y6FU0bezkeN2FaY
	6vgo32A2EH83tAWSWR1lABlhq2C2q+6OSikn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XX5vpLywmjw94PxUbx/TiLqH0GjuV+HU
	6/LvgKqD1OVYBSz3fovxTawm5FQ3ZfclBPNerJsDaCsdM1rNPPHr17uHE7KXSlyi
	oPjFjxyXrRVQY46dnzX6+4VlLMGbwwq/mygC99+2tfQKQkmBqQ9Ce3FEdy8MLNt1
	lxrWvfCFtro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22DFF31E08;
	Wed, 17 Jul 2013 19:47:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8204E31E02;
	Wed, 17 Jul 2013 19:47:45 +0000 (UTC)
In-Reply-To: <CACsJy8Ayyb7kTydXFxoeqNQgGemdUXXzAc3ZwEbT5dCuk_tkQA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 17 Jul 2013 20:42:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C062401E-EF19-11E2-8768-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230644>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jul 17, 2013 at 8:22 PM, Mark Levedahl <mlevedahl@gmail.com> wrote:
>> This test fails on Cygwin where the default system configuration does not
>> support case sensitivity (only case retention), so don't run the test on
>> such systems.
>
> Yeah. I knew this when I wrote this test but forgot to put the check
> in. Thanks. We can re-enable the test later, as it does not really
> need case-insensitive filesystems.

Yeah, I tend to agree.  You do not need to create case-colliding paths
for the purpose of :(icase) tests.

>
>>
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
>> ---
>>  t/t6131-pathspec-icase.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
>> index 3215eef..8d4a7fc 100755
>> --- a/t/t6131-pathspec-icase.sh
>> +++ b/t/t6131-pathspec-icase.sh
>> @@ -3,6 +3,12 @@
>>  test_description='test case insensitive pathspec limiting'
>>  . ./test-lib.sh
>>
>> +if test_have_prereq CASE_INSENSITIVE_FS
>> +then
>> +       skip_all='skipping case sensitive tests - case insensitive file system'
>> +       test_done
>> +fi
>> +
>>  test_expect_success 'create commits with glob characters' '
>>         test_commit bar bar &&
>>         test_commit bAr bAr &&
>> --
>> 1.8.3.2.0.63
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> Duy
