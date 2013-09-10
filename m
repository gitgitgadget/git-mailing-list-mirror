From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote-bzr: reuse bzrlib transports when possible
Date: Tue, 10 Sep 2013 15:01:26 -0700
Message-ID: <xmqqbo40wd3d.fsf@gitster.dls.corp.google.com>
References: <522C0B66.1080707@bbn.com>
	<1378619269-21991-1-git-send-email-rhansen@bbn.com>
	<xmqqa9jl1u7j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJW05-0007Zq-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab3IJWB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:01:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab3IJWB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:01:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77ACF411EB;
	Tue, 10 Sep 2013 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0oR9XZQ3EHcqBQ9geuw1hbkThm8=; b=d4nvjI
	7cBXeIlrq84ec5OH0/j1f6t4pCC7OGAbvErmbsrsZWxeM8IErdVWcWp112GmUxr9
	TQKmHeJAyjCs0huO67QFA/6ByffSTgcOoADr2kjMughzfsfOUi2DZnsxSLvBFBJ+
	oKOvnkq+p7Fb6jCJ242l2k2/aAc1jfCGaoBz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFbU30LHPhUghHuns+Wu/5TMsA+f7wqw
	j/FZ4gPQw4bqk1Owce5gWGB2XLPziuqaH7aUpWMAe/oKtZQg/rJPMHmhHevkDLun
	shlNmPIOfJEbKupljwpJnnl3B3pir2r78V2BVIdYZxc9sMIJlxUH0s9X57NeO45R
	pESTngPK0Uo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DC9C411EA;
	Tue, 10 Sep 2013 22:01:28 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7CDD411E7;
	Tue, 10 Sep 2013 22:01:27 +0000 (UTC)
In-Reply-To: <xmqqa9jl1u7j.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 Sep 2013 10:55:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8AAE6094-1A64-11E3-A8EE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234489>

Junio C Hamano <gitster@pobox.com> writes:

> Richard Hansen <rhansen@bbn.com> writes:
>
>>  def do_export(parser):
>> -    global parsed_refs, dirname
>> +    global parsed_refs, dirname, transports
>
> As this has been acked by Felipe who knows the script the best, I'll
> apply this directly to 'master'.
>
> These additions of "global transports" however have trivial
> interactions with fc/contrib-bzr-hg-fixes topic Felipe posted
> earlier, which I was planning to start merging down to 'next' and
> then to 'master'.  Most funcions merely use the variable without
> assigning, so "global transports" can be removed, in line with the
> spirit of 641a2b5b (remote-helpers: cleanup more global variables,
> 2013-08-28), except for the obvious initialisation in main(), I
> think.  Please double check the conflict resolution result in a
> commit on 'pu' with
>
>     git show 'origin/pu^{/Merge fc/contrib-bzr}'
>
> when I push the result out.
>
> Thanks.

Ping?  I'd like to merge fc/contrib-bzr.hg-fixes topic to 'next'
(and fast track it to 'master' after that), and it would be helpful
to get an Ack on the conflict resolution I have.
