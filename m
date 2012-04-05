From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not
 make sense
Date: Thu, 05 Apr 2012 12:48:58 -0700
Message-ID: <7vlima5591.fsf@alter.siamese.dyndns.org>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
 <20120405124706.GA3921@sigill.intra.peff.net>
 <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
 <20120405184345.GA6448@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 21:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFsg9-0005Jm-72
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 21:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab2DETtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 15:49:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab2DETtB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 15:49:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3D0C675F;
	Thu,  5 Apr 2012 15:49:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BBQ6ggCQmkDFGlL+D+LEhR7PeGY=; b=VLN3vg
	im6VKzr+nBZF3S8S5NKJok2OQXHvzOwZ+oECCsM5K0zlKhi/iKba25WsP1qEENOY
	RlLZa1d0lth9jyedjLAeMJxNAhJlQZJTrFBRuOoGNX1tE3EzgsXIjIRCS8BRPHxW
	uLSIRbCTCvhYXJG3x0PXfm9JIx16UsAFP95pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sBOkbM07yKnoh4niQG2bKVWMVWL2S11D
	4sctF6C0mRVPhYujo+rd27kZvh5bgzOnhEPtfA9WAsqyfrQOkQmHsmS2dnK+u42e
	9snFGBOOdvFIKJRxBCwvpIO79pTZY69SUwSuTiew+cX/Qvcmux5+of0ZtAYzco1I
	OkNMCJNIBFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAFC0675E;
	Thu,  5 Apr 2012 15:49:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F12CB675D; Thu,  5 Apr 2012
 15:48:59 -0400 (EDT)
In-Reply-To: <20120405184345.GA6448@burratino> (Jonathan Nieder's message of
 "Thu, 5 Apr 2012 13:43:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63707DB2-7F58-11E1-B409-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194801>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I worry that a beginner seeing this message would think it means that
> when "master" is set up to track origin/master that there is no way to
> push that branch to any other repository.
>
> Maybe something like
>
> 		die(_(
> "You are pushing to remote '%s', which is not the upstream of your\n"
> "current branch '%s', without specifying a refspec.\n"),
> 		    remote->name, branch->name);
>
> would be harder to misunderstand.

Perhaps.  Do we need to rephrase it without using the word 'refspec'
(e.g. "without telling me what to push"), or there is no point avoiding
jargon because other jargons (i.e. 'remote' and 'upstream') already appear
in the sentence?
