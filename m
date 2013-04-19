From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 20:41:17 -0700
Message-ID: <7v4nf34276.fsf@alter.siamese.dyndns.org>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cRp7J+HYBA=2OL-CdA3NiQFjuUMZEjE+i+SnNrrPBAZ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 05:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT2Ce-0006K0-JR
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 05:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967891Ab3DSDlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 23:41:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967859Ab3DSDlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 23:41:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 279D711C5E;
	Fri, 19 Apr 2013 03:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AOiVNwK5MkbvuVX0/8vnZVZVZuQ=; b=F9XfpH
	Tpn0ssTzg056X9znOpps+nyFZLYtUv2NqxdEfY/cOF+7Yabq47J+sOyFtjdbiuPX
	4Lz5Ai29fnFwBWIxF73uT7sfPzQuS9uzKwxTdBFOwt5uyQgcZzi+3V1WBp9uFbEC
	X/SI0zeNV7jvc8C8VExsO/Gf0YDQcD6vfbkYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TU9IsGhs/C4IwQwjITEwXwIPk7Jjr164
	ptNDNN6i93mOPdRcvXN7O0yMz+IrwsyySGER5RzyP1p9ZF7FJVN8ZPNJs7CZ2dPf
	7RMVRuxcH8CZBBB2YGdJYgJ2FenX7sZ8N0j7t79x6dgEwcGPkht5oVbCHy7Khs+3
	JITOBhNQsNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C92C11C5C;
	Fri, 19 Apr 2013 03:41:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AAF111C5A;
	Fri, 19 Apr 2013 03:41:19 +0000 (UTC)
In-Reply-To: <CAPig+cRp7J+HYBA=2OL-CdA3NiQFjuUMZEjE+i+SnNrrPBAZ6Q@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 18 Apr 2013 20:27:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF4629B6-A8A2-11E2-ADE2-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221725>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       grep "remote-helper doesn.t support push; refspec needed" error
>
> Is "doesn.t" intentional? It certainly works by accident in grep, but
> did you mean s/doesn.t/doesn't/ ?

The pattern matching the expected string is not by accident, but by
design.

It of course can be made more strict to reject "doesnot" and require
"doesn't" by doing something like this:

       grep "remote-helper doesn'\''t support push; refspec needed" error

but at some point, it simply stops being worth it to tighten the
pattern.

For that matter, it could be as loose as

	grep "support push; refspec needed" error

if you know the string is unique enough.
