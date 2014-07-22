From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] completion: add missing terminator in case statement
Date: Tue, 22 Jul 2014 13:18:17 -0700
Message-ID: <xmqqvbqpf8qd.fsf@gitster.dls.corp.google.com>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
	<xmqqmwc2k4h4.fsf@gitster.dls.corp.google.com>
	<xmqqk376iidy.fsf@gitster.dls.corp.google.com>
	<20140722182207.GC26927@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:18:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9gW7-0004lz-LA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 22:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbaGVUS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 16:18:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50126 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbaGVUS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 16:18:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CF112CC1E;
	Tue, 22 Jul 2014 16:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hphynGTTOI7u7JQwQmA9/D94NEU=; b=sAP0Es
	JM4w6N5aOfe289uz+hWuUiGXfVrXVv4lZLeN+XmXzS/LN/49n7L4WMWtnXGoALuA
	vlyRphksRFaljXakW0OVcR+oPtdEuKtNt74B1OA5GYhsll/SiZgqo2/nIKD4LeIV
	cfx7H/qai5zkwRnFF84S+WGjm6h6ZWXoW7kmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DhYJ66BMkbbg+VO1w2SejH1y72a+v65F
	Lnytz0tWWte5+beSZbFOjS35VCuz+xPqBB1+7lzqgFds9GdY8VpcQeRwQ47wF/M+
	XX2AHW5uSrZL4pHIs7qr6O+Loq0KvPPeifprDBq3menSic4+dqNFjVSUJabs7fgK
	pF7mz72IdGc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E36D62CC1D;
	Tue, 22 Jul 2014 16:18:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF6732CC18;
	Tue, 22 Jul 2014 16:18:19 -0400 (EDT)
In-Reply-To: <20140722182207.GC26927@serenity.lan> (John Keeping's message of
	"Tue, 22 Jul 2014 19:22:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 52904EEA-11DD-11E4-8149-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254034>

John Keeping <john@keeping.me.uk> writes:

> On Mon, Jul 21, 2014 at 01:09:13PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > John Keeping <john@keeping.me.uk> writes:
>> >
>> >> Signed-off-by: John Keeping <john@keeping.me.uk>
>> >> ---
>> >
>> > As these ;; are separators not terminators, this is not strictly
>> > necessary.  Squashing it into a change that adds more case arms to
>> > this case statement is of course not just good but necessary,
>> > though.
>> 
>> s/necessary/may be &/; if you add new arms before this one, you
>> won't need it.  But if you add one after this, you would ;-).
>
> Hmm... POSIX describes them as terminators :-)
>
> 	The compound-list for each list of patterns, with the possible
> 	exception of the last, shall be terminated with ";;".

A terminator that is optional at the end is a separator ;-).

Having ';;' immediately before 'esac' is not wrong, but omitting it
is exactly equally correct as having one, so it is not something we
would want a patch to churn.

> I'll drop this patch in the re-roll since it isn't necessary.

This round looked good from a cursory read, except that the first
one still makes me wonder why you chose to put it there _before_
where we handle --repo, where the corresponding case on "$cur"
handles --repo= first and then --recurse-submodules= next.

Wouldn't the end result easier to follow if you stuck to the same
order?
