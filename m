From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 16:09:03 -0700
Message-ID: <7vhaxi50q8.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org>
 <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org>
 <7v62e09sig.fsf@alter.siamese.dyndns.org> <4F67B78B.6080208@pileofstuff.org>
 <7vsjh48af1.fsf@alter.siamese.dyndns.org> <4F68F4A3.60506@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 00:09:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA8Az-0002PO-9v
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759328Ab2CTXJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 19:09:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab2CTXJG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 19:09:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08EED77B4;
	Tue, 20 Mar 2012 19:09:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QVIEZWwLW/pmWYPOQyZPbEVk8yo=; b=ky5Xxp2rnGbVOahmQ5Qn
	bi27dc/mzUBRnHWNzPMlyCsZuWtIUWk0b2llmhr4OAUHK54zChuWBgmLpcvMMRQM
	jCG4Yj/C4H6XBT7abjb+3HccDH0NygV9H6FcQEkcggtw72QqThDp+e1djGep+NDq
	ZEG6/KJHdhXMb4xV3VU47X8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=a76ixAW21DuTqI25Kvt0jG3mg8oJ16F9gqbDZSeN1egmTF
	2rGChYGNj12VdvRfTmk5/zCq8XLP1gGZKzMb06fEvYsN+5BmnnuZvlJaYNP5UjD2
	uNjpZfO+OpAjVNGNvogsOSRfCDhGagq9JIpu37D6kxOlWepcKPnwDenmJ698c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1EB377B3;
	Tue, 20 Mar 2012 19:09:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B2D477B2; Tue, 20 Mar 2012
 19:09:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B084C154-72E1-11E1-9EE9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193549>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> I assume the reason for removing the warning altogether is that some day
> the signal:noise ratio will just get too bad.

The reasoning is a lot simpler than that.

If the end game is not remove the warning, then we would be switching to a
new default that is "give loud warning until the user configures her own
default, but push upstream/current anyway" mode.  We do not want such a
stupid mode as the default---we want the default to be either upstream or
current at the end, when nobody remembers what the ancient default was.

The "warn loud but do it anyway" is a very good interim step during the
migration, but is never a good default.  If we are going to stop there,
"give loud warning until the user chooses and configures the default, and
push nothing" mode would be a LOT safer and saner default, as it would
really force people to configure the default.  Obviously we do not want to
go there, so...
