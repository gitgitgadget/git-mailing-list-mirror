From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitweb showing slash r at the end of line
Date: Fri, 27 Jan 2012 15:15:36 -0800
Message-ID: <7vvcnwybxj.fsf@alter.siamese.dyndns.org>
References: <1327673954458-7229895.post@n2.nabble.com>
 <m3aa58eskw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ondra Medek <xmedeko@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 00:16:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqv1T-0001gh-WD
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 00:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab2A0XPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 18:15:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab2A0XPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 18:15:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 707507DD0;
	Fri, 27 Jan 2012 18:15:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4qkIOAIgvLZ190b5XlgcuZYv05c=; b=s3n9Mv
	U5KfVD9L0V3S+inpsYS9FzM+uCzjoKoJ26f1zn9awSId2ppydqz7S1LSpERzF8xF
	thdJmOfsCn4CEiWBVacUz8vb2jbpxhVKf9cLcVs0Hx8gyr2nSQaaHdlrlwfM4yDT
	hY5dU0c0pqhji/BkC/l217NNXpzI/+TwkQmzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRTbh2xfndM1k5xqsMqCxR7lkzyLfkn+
	VOPm4OWDVRRX3r6hs1phfmEbLEU2TLJAgfhk8Zsa6rtME7iv3QP9i65TWf8rGaRZ
	s0U8M2Y/1VM7d9TZzpCc4+KJCl4JEHwdtl+I7XNCttEE8cLunkePHKiNrNojIIe7
	Z+gtKILExiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663F97DCF;
	Fri, 27 Jan 2012 18:15:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E85F07DCE; Fri, 27 Jan 2012
 18:15:37 -0500 (EST)
In-Reply-To: <m3aa58eskw.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 27 Jan 2012 13:35:45 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2B2D474-493C-11E1-A407-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189243>

Jakub Narebski <jnareb@gmail.com> writes:

> Ondra Medek <xmedeko@gmail.com> writes:
>
>> we have gitweb running on Linux box. Some files have Windows line ending
>> (CRLF) end we do not use core.autcrlf translation. gitweb show the last \r
>> in the end of each line, which is annoying.
>
> Well, this "\r" allows to recognize when file with Windows line ending
> (CRLF) made it into repository... which usually is discouraged.  But
> if you allow this, I can understand that those "\r" at the end of
> every line can be annoying.

I think the right thing to do is:

 * If the repository data is _supposed_ to have CRLF endings (e.g. check
   with core.crlf or something), strip \r and do not show them.

 * Otherwise, i.e. if the repository data is supposed _not_ to have CRLF
   endings, do show these '\r'.  Annoyance here is a *feature* to remind
   the viewer that the contents needs _fixing_.

 * No other switches.
