From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Thu, 18 Aug 2011 13:42:00 -0700
Message-ID: <7vvctu8naf.fsf@alter.siamese.dyndns.org>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
 <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org>
 <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
 <20110818191812.GG30436@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 22:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu9Pn-0001Cj-84
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 22:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab1HRUmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 16:42:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab1HRUmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 16:42:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DFD7442E;
	Thu, 18 Aug 2011 16:42:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GZEEdOZzAeNHNFVfRdz68YoCZBU=; b=kOJvkp
	uYG9WJayJRFi384svbvY0egI84tUrukOCoSQxMQWWQs0k4X28qt6WFN/MarMTEIg
	vJw5NlfAs2SMDphI4LfRXCBZwo/ZUZujfs66RwI/vdEgFklQhRr+YUj1R8arevIw
	n+az4JQxaz+86l5fEH+p8rm48O6LOITP60AEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HAuH1pfBOpZUlvU8TQYWGLj5BHNLOQ2P
	bG5jZkR8uSkBuWYTyqSZDMgzl+HLGYOFydTK39FW26oaITFLrhSrvmrTZeh7q6pt
	heSH056RvAQgCc0WiY3c+gbmsB21tncT/z23Q65DWPyXk42CuRDuW719FttHHhKq
	OLHDc0VqTIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94F3A442D;
	Thu, 18 Aug 2011 16:42:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECEF7442C; Thu, 18 Aug 2011
 16:42:01 -0400 (EDT)
In-Reply-To: <20110818191812.GG30436@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Thu, 18 Aug 2011 14:18:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86A8591E-C9DA-11E0-BCC5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179627>

Jonathan Nieder <jrnieder@gmail.com> writes:

> One part I'm handwaving is what to do about commands like "git
> cherry-pick foo^..foo" which use a commit range that only happens to
> contain one commit.

Historically cherry-pick took a single commit from the command line. That
can easily be distinguished from a "set that ended up with one positive
commit after walking the history". I think you can even check before
triggering the revision walking machinery in the first place.
