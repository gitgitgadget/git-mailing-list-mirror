From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2] fetch: allow command line --tags to override
 config
Date: Thu, 12 Aug 2010 18:22:19 -0700
Message-ID: <7v8w4bmhmc.fsf@alter.siamese.dyndns.org>
References: <AANLkTike2mAoGGk2ryZGjOmfT=yjHBLD4W5GPaXkxiso@mail.gmail.com>
 <1281567440-6329-1-git-send-email-ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 03:22:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojiyg-0005Mr-Bf
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 03:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760770Ab0HMBWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 21:22:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab0HMBW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 21:22:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA76FCD9B4;
	Thu, 12 Aug 2010 21:22:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P2FrPjCFbvfhfUKK8zQm+9bJTAo=; b=S1vSOZ
	1F3tDBkNPlGEvmUcnjKx4JpH6RZhQzsJy3NvfDVV6WUZX4yqJgJ48FT5m/f04H3M
	EgwvR/KdfjOEOlAMNtGdYb4Tcb0erGbjeZl11fVTuiCVwIkJ3+Po+f8BnZ0683ty
	03lZ3i/SNtMy71zb9g+OwjxEqihP/WdFH3+b0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Md7qbwcxcgs3+GvFV1RWtwv87T+Kk2tg
	tsboT7eggZpeqOby3V2XM9QEqJHlsmDA6KOz7seg5/4io340nwm53MFWxlA16Y5v
	I74DkdPl2WRyUXwwndDGYHB5ifTN9Te62PVVFgXe7at565FpBLFhvmJgMLAfkEso
	bnuj+rLvinM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B6CCD9B2;
	Thu, 12 Aug 2010 21:22:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58E88CD9B1; Thu, 12 Aug
 2010 21:22:21 -0400 (EDT)
In-Reply-To: <1281567440-6329-1-git-send-email-ComputerDruid@gmail.com>
 (Daniel Johnson's message of "Wed\, 11 Aug 2010 18\:57\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AC9F9C4-A679-11DF-ADE2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153451>

Daniel Johnson <computerdruid@gmail.com> writes:

> Originally, if remote.<name>.tagopt was set, the --tags and option would
> have no effect when given to git fetch. So if
> tagopt="--no-tags"
>
> 	git fetch --tags
>
> would not actually fetch tags.
>
> This patch changes this behavior to only follow what is written in the
> config if there is no option passed by the command line.
>
> Signed-off-by: Daniel Johnson <ComputerDruid@gmail.com>
> ---
> On Sat, Aug 7, 2010 at 10:17 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
>> On Fri, Aug 6, 2010 at 9:54 PM, Daniel Johnson <computerdruid@gmail.com> wrote:
>>> ---
>>> How does this look?
>>
>> Looks ok - now you'll have to squash this with your code patch.
> And here it is. Sorry about the lateness. I also fixed a mistake I made in the
> documentation (linked to the wrong secton).
>
> I'd still like comments on both the code and the change in behavior behind it.

The current behaviour seems to me a bug introduced while git-fetch was
rewritten in C (the original found in contrib/examples reads from the
config only when no --tags/--no-tags option is given from the command
line).

Is this something we can protect with a test script from future breakages?

Thanks.
