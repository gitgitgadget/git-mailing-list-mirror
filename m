From: Junio C Hamano <gitster@pobox.com>
Subject: Re: XDL_FAST_HASH breaks git on OS X 10.7.3
Date: Mon, 30 Apr 2012 21:41:02 -0700
Message-ID: <7v4ns0cy3l.fsf@alter.siamese.dyndns.org>
References: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com>
 <87mx5tyy2a.fsf@thomas.inf.ethz.ch>
 <3BE9DFB5-81F9-40D6-A637-6C3C232394A6@gernhardtsoftware.com>
 <7v8vhccy6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 01 06:41:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP4tj-0003De-Db
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 06:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab2EAElG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 00:41:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160Ab2EAElE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 00:41:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B7227E70;
	Tue,  1 May 2012 00:41:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wi90mzgX3mzZxoG7kwr2py5yr7I=; b=oCvFLg
	hsk6a6ES920NiO3coGm8tlOfNrsqrwyqTlRf4FisRAzL5oy0+VyopiyXL/vm8tw+
	O0Ra7NXVFDpwTHH6KbRnRiqcApPqe2yqtna/oVzlOBuynLDC13bCf/VSXKiqP6Kp
	EMbgmmlNjPobLMBwU1870Cwnuutr62kWSPFmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nBEB+pxALlFnpgZ1nZ70OdweH09UXiv6
	9DOP/MQo9iYkrHCcnMvWFVc0q+vW0YlBZwv9m1bGw2cO6O81ydcH013A/oNo0M5e
	IPTqdZOEdzy4wOci3eptd1iEqttTWtwcBCSflagjBYP+RMf9MXJioIIj/B0vKxvg
	CHUZyoKHh68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 136AF7E6F;
	Tue,  1 May 2012 00:41:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9637D7E6E; Tue,  1 May 2012
 00:41:03 -0400 (EDT)
In-Reply-To: <7v8vhccy6m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 30 Apr 2012 21:39:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBBAED9A-9347-11E1-9770-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196657>

Junio C Hamano <gitster@pobox.com> writes:

> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
>
>> On Apr 30, 2012, at 12:38 PM, Thomas Rast wrote:
>>
>>> I can reproduce this.  The problem is that __WORDSIZE is not defined,
>>> either because it's Darwin or because the GCC is too old.  It winds up
>>> compiling the 32-bit case, which of course doesn't work for 64-bit
>>> builds.
>>
>> Great.  I was worried about having to help you debug it via e-mail round-trips.  :-D
>>
>>> Perhaps we can rewrite it in terms of sizeof(long) like this?
>>
>> It does work for me, and seems pretty valid to me since long is actually
>> the type you're storing it in.
>
> Thomas, care to roll an incremental update with proper log message, so
> that we can unbreak the tip of 'next' for Darwin users?
>
> Thanks, both.

Oh, one thing I forgot to say.  The low-level code structure seems to
become different, so the perf numbers may need to be measured again.
