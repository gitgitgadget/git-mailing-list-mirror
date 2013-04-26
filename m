From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Fri, 26 Apr 2013 11:33:58 -0700
Message-ID: <7vzjwlw38p.fsf@alter.siamese.dyndns.org>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
	<7vppxi60pj.fsf@alter.siamese.dyndns.org>
	<7vfvye4jrc.fsf@alter.siamese.dyndns.org>
	<517A4F05.5030609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 26 20:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnTJ-0000nV-Px
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236Ab3DZSeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:34:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932229Ab3DZSeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:34:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A342195B2;
	Fri, 26 Apr 2013 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZjtPTVFQjoYSe45ZmHc8dAL7zio=; b=a3pMQN
	n8mVsgL7TqQggrBqF3bnwLIEYg+YN20QlvVeKMtos1wwUheal0FPIKfK1yx4bz4D
	7soiJ20HOzelZcvba9kTYrtc2OG5m2hoo8mok2z6qxP806XGDWbfCz0YLLFcH/CI
	d33FOADJGX0DaSCTqS6TQgol+hygeGOg85l+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghLfvJTO+rhtalU+RgRY6KB7oRbEUjqk
	n4v1fEKjBNY4tQAVW3KOqO90PQQ6JHDaijc68xBzWbGSIUxc4Wr6UzFFa2O+25Ty
	0EuKWeNgKPNYab0cVPADjtGbmb0xOVuuUn2Rx7hkF7ft+94lRB4sGd5OlO40kc+7
	V5gqqUq54M4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ED89195B0;
	Fri, 26 Apr 2013 18:34:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1866195AC;
	Fri, 26 Apr 2013 18:33:59 +0000 (UTC)
In-Reply-To: <517A4F05.5030609@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 26 Apr 2013 11:55:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCAE2388-AE9F-11E2-8FB5-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222548>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> It is a separate issue to port git-remote-testgit to POSIX (J6t
>> already has a two part draft), move it to git-remote-testgit.sh, and
>> get its shebang line preprocessed like all other shell scripts.  I
>> think it is worth doing.
>> 
>> Takers?

By the way, this hint still stands ;-)

>> 
>>  t/t5801-remote-helpers.sh | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
>> index 4dcf744..c956abd 100755
>> --- a/t/t5801-remote-helpers.sh
>> +++ b/t/t5801-remote-helpers.sh
>> @@ -118,7 +118,9 @@ test_expect_success 'pushing without refspecs' '
>>  	(cd local2 &&
>>  	echo content >>file &&
>>  	git commit -a -m ten &&
>> -	GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2>../error) &&
>> +	GIT_REMOTE_TESTGIT_REFSPEC="" &&
>> +	export GIT_REMOTE_TESTGIT_REFSPEC &&
>> +	test_must_fail git push 2>../error) &&
>>  	grep "remote-helper doesn.t support push; refspec needed" error
>>  '
>>  
>> 
>
> Perfect, I just failed to notice that the subshell would make the export
> local to that test.

Good.

I think I queued the fix near the tip of that topic yesterday.
