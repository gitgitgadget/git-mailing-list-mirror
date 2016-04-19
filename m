From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 10:52:48 -0700
Message-ID: <xmqq37qh32q7.fsf@gitster.mtv.corp.google.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 19:52:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZpY-0005g1-7N
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159AbcDSRww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:52:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754490AbcDSRww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:52:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5DA313062;
	Tue, 19 Apr 2016 13:52:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WNzjX8Rsz9K46sECGf9kg1iUXDE=; b=p2B2n7
	A7iOQSj4TqMMrM5vrNNR5d3jwgU9AuY8OTTMKyRd7aCF+SH+Y9zWTHiBTSLSI+77
	ijD+x5sjX57u33AkkBtdRvAujIaanW38BTX4CXd2+2IeRSmerYrxV/D0qiyHDaDY
	RfH2yQUwVSUdIHDiI9uhMYq3URoSfx1ZlS2Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oHLIFQemHGsIpP7gz415smGKWzEV1WX2
	y4vgg+Euh7N3t6pTk0aA9CB6qKqeoM+6So1B/daOB4qpm4eGNAI1YNS2lxoVLLjx
	gKPWwLFpfVslJbFzGcoxP0K1viXMkn6nEnXmzWo/GYetfygmFeJJKvpE9fOkzgcd
	vxTAnmMLKA0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E09413061;
	Tue, 19 Apr 2016 13:52:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DDC713060;
	Tue, 19 Apr 2016 13:52:49 -0400 (EDT)
In-Reply-To: <xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 Apr 2016 18:15:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8857B606-0657-11E6-95F9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291892>

Junio C Hamano <gitster@pobox.com> writes:

> Not a new problem in this script, but we'd prefer to spell this as
>
>     p4_add_job () {
>
> i.e. a space on both sides of ().
>
>> +	name=$1 &&
>> +	p4 job -f -i <<-EOF
>> +	Job: $name
>> +	Status: open
>> +	User: dummy
>> +	Description:
>> +	EOF
>> +}
>
> It may be better without $name?

Just so that I won't get misunderstood, with this I do not mean
"Job: $name" line does not have to be there.  I meant that there is
no need to use name variable in this function; just writing $1
instead of $name there is better, as $name is not a function local
variable in POSIX shells.
