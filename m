From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] git-send-email.perl: Deduplicate "to:" and "cc:"
 entries with names
Date: Fri, 26 Nov 2010 16:25:18 -0800
Message-ID: <7vk4jzpq8h.fsf@alter.siamese.dyndns.org>
References: <1290272809.27951.30.camel@Joe-Laptop> <m2mxp3zr88.fsf@igel.home>
 <1290286877.31117.15.camel@Joe-Laptop> <4CE84FF3.2070906@pcharlan.com>
 <1290294365.31117.40.camel@Joe-Laptop>
 <7vmxowq6gz.fsf@alter.siamese.dyndns.org>
 <1290807268.11971.310.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Harlan <pgit@pcharlan.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 01:26:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM8c9-0008UL-8B
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 01:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031Ab0K0AZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 19:25:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab0K0AZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 19:25:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95ADA276E;
	Fri, 26 Nov 2010 19:25:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YPVrlqUSoE/LBEzJHEYd9jf9jK4=; b=BxA0u8
	kkOhLTlyr3tDK02+bOvXYrIiiaGy22RyjYxb7iLqTxKQW7nAce3qKfVanjccry1I
	2QlRgBviz4QrBo2/KBES6JmzuXZ9mZABY4Yfh8eT0kwAXmxKxta7C9jtMlNCYCDy
	yHn+hIRoj2JiiDSrxhCKHISy8mik1K/lE7KWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OZoATj2NdnbiKldKdMUz5OjTcwBu61re
	wMl4Wdx+1LLA1E6EmgwDX1UmrmQQCNZTi7ONlgtZ03l2m6froCDRvWa13PazPNIL
	0PUtteNks8kWGHqFioYR2M61atGAimrLbJTsam0R3j/V8ZLwZ/gi8p8EiULELhW7
	wGmqXLLb5Gc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4FF312768;
	Fri, 26 Nov 2010 19:25:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B65C72766; Fri, 26 Nov 2010
 19:25:36 -0500 (EST)
In-Reply-To: <1290807268.11971.310.camel@Joe-Laptop> (Joe Perches's message
 of "Fri\, 26 Nov 2010 13\:34\:28 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE47CC0C-F9BC-11DF-A559-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162286>

Joe Perches <joe@perches.com> writes:

> On Fri, 2010-11-26 at 10:34 -0800, Junio C Hamano wrote:
>> I wonder if we should remove addresses from To: and Cc: if the same
>> address appears in @bcclist, by the way, but that is a separate topic.
>
> Most likely it should be culled from the bcclist.

That means that the current behaviour is Ok, no?  We do make the "RCPT TO"
list of addresses we feed to smtp unique after concatenating To/Cc/Bcc, if
I am not mistaken.
