From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] notes remove: allow removing more than one
Date: Wed, 18 May 2011 23:50:52 -0700
Message-ID: <7v1uzv9oab.fsf@alter.siamese.dyndns.org>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
 <1305764061-21303-2-git-send-email-gitster@pobox.com>
 <4DD4BC0D.2000805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 19 08:51:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMx4b-0004Av-Er
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab1ESGvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:51:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab1ESGu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:50:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 635C2319D;
	Thu, 19 May 2011 02:53:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OUyK8Qd9yPP2fnvBmKGeTu53kRI=; b=p6T4Xd
	MIYzywNo3B/esfpYiXXrj+sy30FbbJ4pRbh7r+6RM9tGcgdT4V3KpI9EsmdP2OEX
	efAFN//bGpC0thP1lDiFZ3n7brhThKF34oq4+Je+zn/W0HI8ekbDfzWNPUKWijoi
	nO06n1EC8h5Pd5QgYeibkae0qauqJHrqalPy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q1ciCfsxTwpG4a0v+n+BHcNeg0oN3MRy
	MlG1v3F+E/UwvBD1cUAfL+JPF/Ti8OHlo44cpqGAqzXfbjnwyOxRuVuHINFnG6dZ
	sI6kTACggWn7tF7PRG71M1u/Ls4GoUgeQb3sqAsShPMvc/RSaUl3m9jAQSJi5p+d
	yGZOP7BJm1s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EFFA319C;
	Thu, 19 May 2011 02:53:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 639203199; Thu, 19 May 2011
 02:53:01 -0400 (EDT)
In-Reply-To: <4DD4BC0D.2000805@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 19 May 2011 08:43:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4FCD7E8-81E4-11E0-9189-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173939>

Michael J Gruber <git@drmicha.warpmail.net> writes:

[jc: cull the part you did not comment on, thanks]

>> +test_expect_success 'removing more than one' '
>> +	before=$(git rev-parse --verify refs/notes/commits) &&
>> +	test_when_finished "git update-ref refs/notes/commits $before" &&
>> +	git notes remove HEAD^^ HEAD^^^ &&
>> +	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
>> +	test 2 = $(wc -l <actual) &&
>> +	git ls-tree -r --name-only refs/notes/commits >actual &&
>> +	>empty &&
>> +	test_cmp empty actual
>> +'
>
> You're not really testing that this removes the correct notes. Actually,
> you're not even testing that this removes only 2 notes when there are
> more than 2, are you?

In the test vector, there are only two notes, and I am testing removal of
multiple.  What do you want me to do?  Test removing one and make sure the
other one survives ;-)? 

Patches on top of it is very welcome, but I wouldn't bother.
