From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 08 May 2012 08:09:38 -0700
Message-ID: <7vaa1izp3h.fsf@alter.siamese.dyndns.org>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
 <4FA904C3.7070208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 08 17:09:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRm2s-0004Wv-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 17:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab2EHPJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 11:09:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755667Ab2EHPJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 11:09:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF7796FA1;
	Tue,  8 May 2012 11:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NkBeKHQmwQBdHsu0gNsHZlxXf6I=; b=FPq1/y
	hc4QQvlaDpc+uSpETBpPJ/Cod4G0jQvPBJTkpnb06+qdCWS8jcjkB5gYsLpgYH9V
	Zbg5sSRt+my9UAzqHGBPG4BzvhZ45918msWHH8yc4criVUB6UlpUdvJJOCZUOOK6
	39ICNPx4oq+YGAath5USuv3SzLIFHELOH/nkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQbc0i1GKFKei25O9b1OxN0ob8bJy4kg
	7v8V0C8JJgTIwwb3oCgZrISKPZoJ9R1sJJtjrbJkudtHowxIwXvhaeiZSQF6QG+9
	pSFaBp1NZsTLPoj5Xk/o0ZkBmP2IptPU5hN8X7AHyQdYSKxycyta2kAtitqc0dB1
	TZOzSfsMIX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6BFB6FA0;
	Tue,  8 May 2012 11:09:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F88F6F9E; Tue,  8 May 2012
 11:09:40 -0400 (EDT)
In-Reply-To: <4FA904C3.7070208@viscovery.net> (Johannes Sixt's message of
 "Tue, 08 May 2012 13:34:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5888E04-991F-11E1-A7BB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197373>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/8/2012 13:24, schrieb Erik Faye-Lund:
>> +		git show-ref | !grep "(null)"
> ...
>> Now, doing this doesn't make my test above pass,
>
> It is unlikely to pass if you used this test script literally, because
>
>    $ !grep
>    !grep: command not found
>
> "!" is not an operator in a shell script. Insert a space.

Good eyes.  Also wouldn't it be a bit pointless to grep for (null) in the
first place?  It comes only because a particular implementation of
vsnprintf() happens to emit it when asked to turn a NULL pointer into a
string, and on other platforms it is allowed to segfault.
