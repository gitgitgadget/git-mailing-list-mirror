From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Sun, 06 Feb 2011 21:50:37 -0800
Message-ID: <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 07 06:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmK06-0001Mx-Pk
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 06:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab1BGFuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 00:50:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab1BGFuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 00:50:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AE5121D3;
	Mon,  7 Feb 2011 00:51:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z6+ABUHitSf209X6ytmBtMkpwCg=; b=w1CbZq
	kimuBNz1ESpseHcTTop99KuEdmpqsRTkGytycWxGekHWi0UjlBZHC1UrFKpwn8fB
	LYGzp6wIFO5W3EHrHEODn6HngmbI3prMTjt8sUXW8lXty1TAgnGIdjgMhqWxRFFk
	zqFjt4c+LJWT2bQ2EVwqbXLEu9UMGOy6YKr/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u8bUyo1WXO+jMFbw3rKqJDbPbhyqZi4j
	FxpheXLfyG+NriRBI1crvKyKGq1EfNGEzTSl7JtaOJzAJT2p0m+NHoSM5wk+aw/f
	4T69kDT7IVBL7xwSvJ5cqGHLMCFFhs+yZ4hlFhAURVdtwqv80fW4KNyplBPsgpTc
	Wr1m3AgoSqM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29D1421D1;
	Mon,  7 Feb 2011 00:51:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D2FF521D0; Mon,  7 Feb 2011
 00:51:36 -0500 (EST)
In-Reply-To: <vpq1v3kopn3.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 06 Feb 2011 21\:48\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 569A29DA-327E-11E0-9F78-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166231>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Sebastian Pipping <webmaster@hartwork.org> writes:
>
>> I was and I can confirm the different behaviour with 1.7.4 over here: it
>> does work on the root directory of the repo as you supposed.
>
> What do you mean by "it does not work"?
>
> "git add -u" adds files under the current directory, and it always
> did.

As it takes pathspecs (think "git add -u this-file"), it fundamentally
shouldn't be tree-wide.  I think the original implementation didn't take
pathspecs and was mistakenly done as tree-wide operation, but I think it
was fixed rather quickly.
