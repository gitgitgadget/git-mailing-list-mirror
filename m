From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] some sequencer loose ends (Re: Fix revert
 --abort on Windows)
Date: Mon, 12 Dec 2011 13:31:04 -0800
Message-ID: <7v39cp32av.fsf@alter.siamese.dyndns.org>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDSr-0003jp-RE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab1LLVbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:31:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080Ab1LLVbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:31:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F3557BE0;
	Mon, 12 Dec 2011 16:31:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BK/s2pTP1+kFvPETnpfhNiKWkq4=; b=ydhk3u
	WUcm3LIfPHqEYFHQ2Knr6+2ArsijZW9ZReoATXlf/AhTaxbH6+MzD60+U45jmsOZ
	wu9x3Jc6N82b+FxcGbXmpV6R6DntQz1YM6MnXYK/q2yCSeNy0eDc3mQNDqHrXtWW
	F22CfbIh8KMVtjY+XN7F/qHD/o2e7uLqag+zA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XqndqhNNsi7ZnTwLFdqrLcTA307GdRnm
	Pr24gEnn3T4vf9oO3XM2FfTXETAFHqv5VTmzBBjaM6iF/sHhtuWPEqK+IEn+Tpq9
	pzpKGYCwjjdjlM3uPevjOxq3wwnDxJHbUNTi8oQZvAXlce3fEyVUF+DNjCunPHIm
	b8jjpnFrqrc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85ADE7BDF;
	Mon, 12 Dec 2011 16:31:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D7847BDE; Mon, 12 Dec 2011
 16:31:06 -0500 (EST)
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Sat, 10 Dec 2011 06:46:44 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99651D56-2508-11E1-A722-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186955>

Overall, I think this series is a more correct and faithful implementation
of the design we discussed earlier in the thread

 http://thread.gmane.org/gmane.comp.version-control.git/179304/focus=179625

I saw a few minor nits in the log messages but otherwise nothing
objectionable jumped at me from my initial reading of the series.

Thanks.
