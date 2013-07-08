From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0000: do not use export X=Y
Date: Mon, 08 Jul 2013 08:20:55 -0700
Message-ID: <7vy59h13jc.fsf@alter.siamese.dyndns.org>
References: <201307081121.22769.tboegi@web.de>
	<8761wli0fe.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:21:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDFU-0004oo-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab3GHPVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 11:21:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab3GHPVC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 11:21:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FB402DFC3;
	Mon,  8 Jul 2013 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ivRf/1z7Bhkw
	RXqtRGdv7DpA77k=; b=caoaeoTVs8opMKHr9osrER579nhwK2aAZta/zpHdbVbd
	W0TtCUXgSTHZ0LzxAqX0H5I6njuGuOnO1WdZz6RtwdxTNyk/oxlWOqYFfudfKO7h
	WWG5SpxTads3WplxgVXczlLcdesV9uLvnjWpVjcqGjJdX7Ee85mgL+E8jLvqx4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xbY3TD
	6B9z57nBq2LRQI/CI9xgkFZmKjA1BwNreIBJ4Dzd4hfYjw4ACeP9vmpRrOxKdAZ/
	ycjRc1qvAPAkGr72IKvPepoYzU3mrNrOeYU23BT0tiw2TZOfQgOMO9aHklW2Zmr6
	8rUy7RjsM5s+M2H2u+LheHwr9aVYlkycApjY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A288F2DFBB;
	Mon,  8 Jul 2013 15:20:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A457D2DFAE;
	Mon,  8 Jul 2013 15:20:57 +0000 (UTC)
In-Reply-To: <8761wli0fe.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 8 Jul 2013 16:36:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDC5B650-E7E1-11E2-B10D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229866>

Thomas Rast <trast@inf.ethz.ch> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> The shell syntax "export X=3DY A=3DB" is not understood by all shell=
s.
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>>  t/t0000-basic.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index 5c32288..10be52b 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -53,7 +53,8 @@ run_sub_test_lib_test () {
>>  		# Pretend we're a test harness.  This prevents
>>  		# test-lib from writing the counts to a file that will
>>  		# later be summarized, showing spurious "failed" tests
>> -		export HARNESS_ACTIVE=3Dt &&
>> +		HARNESS_ACTIVE=3Dt &&
>> +		export HARNESS_ACTIVE &&
>>  		cd "$name" &&
>>  		cat >"$name.sh" <<-EOF &&
>>  		#!$SHELL_PATH
>
> Ack.  Sorry for breaking this -- I suppose test-lint would have caugh=
t
> me out?

Or I should have.  Thanks for catching.
