Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0ED1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbcFUSj5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:39:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752010AbcFUSj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 14:39:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 560CF25753;
	Tue, 21 Jun 2016 14:16:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pLSlHGs0mKDsdUa6IqWK4T2Dw9k=; b=Bjb1Ke
	ewAIvYMc34CJ7T0lIWpsEedMlNCAE+EPbLf06VHdlw8WGTMjGPkeUydTWlMQscz0
	Y3bwVv+IbPxtFTs8edP58uCZ2v/rOJULtN84j+5JOZcDTH7gnYYbFNOx4LOWzoy8
	iJc1otZ8ksy9kz3WIGPCX059YaVgR7NSw9iQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=quoH+gW2lHAz6eeFBd6ccGZ9sOB+c9ri
	9frW08nxXcXPfozlNSx7BdEEEMKuttyMThulWJmyYo553Oy+09h3NNpUnvAveZdW
	nkOzPEbLiybgARSOm7NaiZo068fZUAqb1H8jpi3BThMru+HsHE8raIYNfYX/Ze1G
	NwkFDFWlbYQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46E0F25751;
	Tue, 21 Jun 2016 14:16:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6D7525750;
	Tue, 21 Jun 2016 14:16:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Andrew Oakley <aoakley@roku.com>, git@vger.kernel.org,
	luke@diamand.org
Subject: Re: [PATCH 1/1] git-p4: correct hasBranchPrefix verbose output
References: <1466517222-12600-1-git-send-email-aoakley@roku.com>
	<C471957C-3FEE-4CEB-8940-624F73784355@gmail.com>
Date:	Tue, 21 Jun 2016 11:16:16 -0700
In-Reply-To: <C471957C-3FEE-4CEB-8940-624F73784355@gmail.com> (Lars
	Schneider's message of "Tue, 21 Jun 2016 20:05:39 +0200")
Message-ID: <xmqqbn2uqufj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 400BDFA6-37DC-11E6-B1FF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 21 Jun 2016, at 15:53, Andrew Oakley <aoakley@roku.com> wrote:
>> 
>> The logic here was inverted, you got a message saying the file is
>> ignored for each file that is not ignored.
>> ---
>> git-p4.py | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/git-p4.py b/git-p4.py
>> index b6593cf..b123aa2 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2674,7 +2674,7 @@ class P4Sync(Command, P4UserMap):
>>             return True
>>         hasPrefix = [p for p in self.branchPrefixes
>>                         if p4PathStartsWith(path, p)]
>> -        if hasPrefix and self.verbose:
>> +        if not hasPrefix and self.verbose:
>
> Thanks Andrew! Your fix is correct.

Thanks.  This needs sign-off, though.

>
> - Lars
>
>>             print('Ignoring file outside of prefix: {0}'.format(path))
>>         return hasPrefix
>> 
>> -- 
>> 2.7.3
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
