From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-clean: Document --force --force
Date: Thu, 20 Dec 2012 19:01:41 -0800
Message-ID: <7vr4mk2jmy.fsf@alter.siamese.dyndns.org>
References: <b48ad5f0-25f7-45c3-b2dc-c0c01645a247@CO9EHSMHS031.ehs.local>
 <335802a0-38b5-4cbc-9e52-92c92083119e@VA3EHSMHS005.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 04:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlss7-0007sC-9M
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab2LUDBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:01:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2LUDBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:01:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E162DA591;
	Thu, 20 Dec 2012 22:01:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dOjBwFuyTtJqQBb8FWtM2/ZHI+Q=; b=rucWw7
	p2V/tm0UVH2RnEPtAnw+gVod4wXN9ogb4p16RBSE7Cry6Lzco4GzNuhMXYrr0Tl3
	IMw5EptogCaOxc+0XtANUEzpBZnHBLZgee6rIYADyy8nm1en4kccLu35kt4Byjki
	ZHcySI9YcdHhEl4Vccomojzu80riJJp1GLKAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dP5k7OiIbB1k0uTCvRb5x4WDSVLyno0j
	ySY1umMxgCha5olJiHPVCJHUoXaQl18nMt3PPrjCo7JxEdmIRct8I3sRfuA4dDVr
	qt+obSQCXA7AjnZ2tmvCqpCRgy4wvRIWFbPMe5nlhgdTzGXHFElHeGRsuJku2zS4
	TSuZGWurNqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF7B5A590;
	Thu, 20 Dec 2012 22:01:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FFF6A58E; Thu, 20 Dec 2012
 22:01:43 -0500 (EST)
In-Reply-To: <335802a0-38b5-4cbc-9e52-92c92083119e@VA3EHSMHS005.ehs.local>
 (Soren Brinkmann's message of "Thu, 20 Dec 2012 15:37:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFB47B12-4B1A-11E2-8E9B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211942>

Soren Brinkmann <soren.brinkmann@xilinx.com> writes:

> Ping?

I *think* it is a mistake for the command to remove a separate
project repository within, with any number of "-f", so I'd rather
see a patch to fix it, instead of casting such a misbehaviour as a
feature in stone by documenting it.

I dunno.

> On Thu, Dec 13, 2012 at 05:46:55PM -0800, Soren Brinkmann wrote:
>> This patch documents the behavior of 'git clean' when
>> encountering nested git repositories.
>> Such repositories are only deleted if '-f' is passed twice
>> to 'git clean'.
>> 
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>  Documentation/git-clean.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
>> index 9f42c0d..0b31454 100644
>> --- a/Documentation/git-clean.txt
>> +++ b/Documentation/git-clean.txt
>> @@ -23,6 +23,9 @@ example, be useful to remove all build products.
>>  If any optional `<path>...` arguments are given, only those paths
>>  are affected.
>>  
>> +Nested git repositories are not removed unless the '-f' option is
>> +passed to 'git clean' twice.
>> +
>>  OPTIONS
>>  -------
>>  -d::
>> @@ -35,6 +38,8 @@ OPTIONS
>>  --force::
>>  	If the git configuration variable clean.requireForce is not set
>>  	to false, 'git clean' will refuse to run unless given -f or -n.
>> +	Pass this option twice to 'git clean' in order to also remove
>> +	nested git repositories.
>>  
>>  -n::
>>  --dry-run::
>> -- 
>> 1.8.0.2
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
