From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/4] commit: Add commit.verbose configuration
Date: Tue, 17 Jun 2014 14:37:45 -0700
Message-ID: <xmqqy4wvjjyu.fsf@gitster.dls.corp.google.com>
References: <cover.1403033723.git.caleb@calebthompson.io>
	<2a0ed28d8ef50ce432c7680c1f01eb0f52891134.1403033723.git.caleb@calebthompson.io>
	<20140617212132.GC13848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Thompson <caleb@calebthompson.io>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx14m-0000cn-08
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbaFQVhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:37:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58906 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964863AbaFQVhv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:37:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E96191F955;
	Tue, 17 Jun 2014 17:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v0u5wMNPsurEzbHf9pqFVKVf94Y=; b=ZWaRQn
	abmDka76FiHmn5H/B85F7OO2++YF0/9CsHbiGZKMKyUKRccU+FOQFNvew3X8AUYX
	q029P2Q8gZ2mT6wbCw8QGTe6nMDIeZzvwniOnKL8U+IzDoZqhm4RICr07EjdXSNJ
	/H1JSVAHX/lRCUBlluc83Pe8gkLjIiCkjmsTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNDyHw210jy336RhjidX8qaXR475UWua
	rILcG82yqjROUmyQmABCIkqDwJsHykbhbUysHI+WORMbnm74bwZz+BNHRFP5q/+p
	IULOaE9/swv4BhHZ3W57DFxtZbQBAvutdxTwSl4rpsaQBdKOGIVNnAh/76GVm22Z
	1h6WCeRUVqw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE71C1F954;
	Tue, 17 Jun 2014 17:37:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A02B61F942;
	Tue, 17 Jun 2014 17:37:44 -0400 (EDT)
In-Reply-To: <20140617212132.GC13848@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Jun 2014 17:21:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E26D806-F667-11E3-9E48-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251956>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 17, 2014 at 02:39:00PM -0500, Caleb Thompson wrote:
>
>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> index 35a4d06..471bd8f 100755
>> --- a/t/t7507-commit-verbose.sh
>> +++ b/t/t7507-commit-verbose.sh
>> @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
>>  	exec grep '^diff --git' "$1"
>>  EOF
>>  
>> +write_script check-for-no-diff <<-'EOF'
>> +	! check-for-diff
>> +EOF
>
> Don't you need "$PWD/" or similar here, since check-for-diff is not in our path?

I actually would prefer a simpler

	! grep '^diff --git' "$1"

that does not depend on what other parts of the tests have done.
