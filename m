From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone over HTTP returns 500 on invalid host name
Date: Wed, 13 Jun 2012 16:40:56 -0700
Message-ID: <7vbokmg4qf.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJuax3-x53HJT-s32euyf2=d57MsRCQWo6NZO3OL35+o7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 01:41:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SexBP-00051p-8A
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 01:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab2FMXk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 19:40:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab2FMXk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 19:40:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6268147;
	Wed, 13 Jun 2012 19:40:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4A0njCDVWdZDiNGYjiLw8jBG5A4=; b=jGkBC/
	PktWb0SH1y+AiLE9DmGlkkVw5B0xC7yqtpWNlSYk3GTLWPDmbOyW5AL38CxSWfjK
	YwDK9si8s+056FUvbm8t+dW7yZbW+H1/8JozmN6Av246EifeQrvC76+t7CZgoBXx
	PdTtpsSSATFDoVRJt08QDfnF8FqqVM3L6X86Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SwnjyTaDgbKu9hc31koHAqxeLO+G6TaY
	Ou7dMds6NQQmEPTThuqtXnGS1JMZwXpEMhxB52owb3x82t/jzqik/8vZUDClnSQM
	Sm1ld7fjBO+O/qzC6nADER+FNkgdAh3rYDFngTxCW6XBdYqVSdt54CjcElQkxllF
	tStuXmSlHeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 650BE8146;
	Wed, 13 Jun 2012 19:40:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0CFC8144; Wed, 13 Jun 2012
 19:40:57 -0400 (EDT)
In-Reply-To: <CAJo=hJuax3-x53HJT-s32euyf2=d57MsRCQWo6NZO3OL35+o7g@mail.gmail.com> (Shawn
 Pearce's message of "Wed, 13 Jun 2012 16:36:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39992180-B5B1-11E1-A010-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199960>

Shawn Pearce <spearce@spearce.org> writes:

> $ git clone https://this.host.does.not.exist/foo
> Cloning into 'foo'...
> error: The requested URL returned error: 500 while accessing
> http://this.host.does.not.exist/foo/info/refs
> fatal: HTTP request failed
>
>
> Hmm. Telling me the host doesn't exist is more useful than 500:
>
> $ git clone git://this.host.does.not.exist/foo
> Cloning into 'foo'...
> fatal: Unable to look up this.host.does.not.exist (port 9418) (Name or
> service not known)
>
>
> Does anyone care about this other than me?  :-)


$ git clone https://this.host.does.not.exist/foo
Cloning into 'foo'...
error: Couldn't resolve host 'this.host.does.not.exist' while accessing https://this.host.does.not.exist/foo/info/refs
fatal: HTTP request failed

What are we doing differently?  Perhaps you have a custom proxy that
throws 500 back at you or something?
