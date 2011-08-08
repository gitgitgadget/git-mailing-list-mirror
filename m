From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Mon, 08 Aug 2011 10:16:36 -0700
Message-ID: <7vk4anzuvf.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075232.GJ12341@sigill.intra.peff.net>
 <7vr55k4mxn.fsf@alter.siamese.dyndns.org>
 <20110722204749.GC11922@sigill.intra.peff.net>
 <7vbowmx9da.fsf@alter.siamese.dyndns.org>
 <20110722221337.GA15753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 08 19:16:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqTRU-0007zu-Pr
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 19:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab1HHRQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 13:16:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab1HHRQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 13:16:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0959241A1;
	Mon,  8 Aug 2011 13:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aN75xLY7QvW0ldWmqPUuLYcF7uU=; b=NOAuxb
	ZIzpr2g7MR2sLlJssGDheUeXSbGGqz5dqtmt21DAC8TY/HOsgoNmDrMd+wdXInIo
	bq5j30PLfrn8Q5BC09fCLnI4b1jCG0Okb+rVq1qZkZjb9IBzJh9QAE3jxReCj2oG
	584rtI+F14qLX9wxzhY7lafZdFI4eGJmQaol8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CvCyjXncKE/uUwRRN+XlBUKOQnYMx1vs
	XWgzSDvCY59C1MUDu+jd3wGSBNFRpzjLTYkWztuU/ZCXJOa9XykEkeuxGCdpThbw
	JBQZaCRTj8H7ko5sys7sbjj7rf4CACK56+NzaeGDNKdjiGSlORi0T/u2cNUwERv9
	7zQDgiyuJrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E7D41A0;
	Mon,  8 Aug 2011 13:16:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75B8A419E; Mon,  8 Aug 2011
 13:16:38 -0400 (EDT)
In-Reply-To: <20110722221337.GA15753@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Jul 2011 16:13:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D1F8FF2-C1E2-11E0-B2B4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178964>

Jeff King <peff@peff.net> writes:

> I expect those cases to be even less common, of course, but it's nice
> that it's straightforward to support them.
>
>> > I tried to optimize for the common case (many repos under one identity)
>> > than the uncommon (many identities under one host).
>> 
>> As I am not convinced if this statement is true.
>
> I admit I don't have any data beyond my own experiences. GitHub tends
> towards the concept of a single identity, and it has some group
> management. I don't know about other sites, though. Do you have any
> specific examples in mind?

I think I heard Shawn talk about Gerrit installations where multiple
instances that serve separate userbases are behind a shared Apache
front-end that would be problematic with this limitation.
