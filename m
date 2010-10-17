From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2010, #01; Wed, 13)
Date: Sat, 16 Oct 2010 21:43:40 -0700
Message-ID: <7vk4lh5szn.fsf@alter.siamese.dyndns.org>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 06:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7L6C-0003NB-IP
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 06:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab0JQEnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 00:43:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0JQEnu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 00:43:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42854DFC1F;
	Sun, 17 Oct 2010 00:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=OKUAfq4N0DcyneycxkeBFuO6B
	fw=; b=I+G+wV3wR6LvnSpfYpPgS/qK/ggUT5kTvzjrTDex7A+74CTC0Kw8+Qzf6
	sXhQ/uEA4O0r1JHuG3E3vGibg+zfzNlWGYq6U+yj+UkFEdS9vkepfiz+vBjfqi1y
	V9dkNAalZYayVl+fANtQTPNwjvLc/RfZ4XA73IuRTnrEP6v0PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=JezwpvXHgUzfFzqRM37
	HyE9XvDqwQr6JOG+FAJIwdpToLB7kXk1A35RCJR238V3jSpI557LAdy9+idqGEiR
	Bu2UYnrUIX4UaGQUMdqatHuOLUcVTQ3t9ccrM33DxrAcwwJEZW2c+LJKMNyVfUTD
	GK3NGh5mLOS6Do/lTjjBGjf8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C0B3DFC1D;
	Sun, 17 Oct 2010 00:43:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24441DFC18; Sun, 17 Oct
 2010 00:43:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20F744D0-D9A9-11DF-8FDF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159194>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Oct 14, 2010 at 04:46, Junio C Hamano <gitster@pobox.com> wro=
te:
>
>> =C2=A0- test-lib: make test_expect_code a test command
>>
>> Somewhat rerolled, but the largest one among the series was Nacked b=
y a
>> few people and needs to be rerolled again.
>
> Why did you amend this to use this sed trick:
>
>     +sed -e 's/Z$//' >expect <<\EOF &&
>     +not ok - 1 tests clean up even after a failure
>     +#      Z
>     +#          touch clean-after-failure &&
>     +#          test_when_finished rm clean-after-failure &&
>     +#          (exit 1)
>     +#      Z
>     +not ok - 2 failure to clean up causes the test to fail
>     +#      Z
>     +#          test_when_finished \"(exit 2)\"
>     +#      Z
>
> Is it just to keep it diff --check clean?

Yes and files with trailing whitespaces are hard to understand in gener=
al
when reading, even outside the "should I apply that patch?" contenxt.

> Anyway if we munge the output like this the output of test_cmp will b=
e
> more confusing when it fails, because it'll be diff(1)-ing something
> that the test-lib would never emit.

Hmm, why?  "expect" has trailing whitespaces on lines that end with Z,
i.e. what the original patch wanted to place in.
