From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: don't trigger detailed diagnosis for file
 arguments
Date: Mon, 18 Jun 2012 10:50:36 -0700
Message-ID: <7v62ao4ihf.fsf@alter.siamese.dyndns.org>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
 <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehpc4jpw.fsf@alter.siamese.dyndns.org> <vpqpq8wpled.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 18 19:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgg67-000672-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab2FRRuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 13:50:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab2FRRui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 13:50:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 314E58A8F;
	Mon, 18 Jun 2012 13:50:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DC/2vqi9XyqBITaEOFuvnhVXWM8=; b=sFIV49
	4IhPZELAFdsHzb7CBghZtg23B+idSJk0MiCT/DT6kiLuBTc/RB1qSGOEZlmBXgz6
	NaMcIrEBmr31o9RMweZJ10nn00Y7Da6Y/P7BbiG1CswMKJ1xBTjsNnk5ncWVn2cS
	DQ3sCOj29TG6w8HuaATqaXxkuYV71GsCNuTG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pMSA44hNMhPQXaBicdmfKaOYU8rhIJyN
	XHfid6PirKM51foEdpZ20qSqpF/oSwRd3oZYAeInPuTtjp36HDRkAPGmtkOHtaX5
	7SOi4ZJAZLvJ5yTrlbfslIwB7WC3uexukJb3aaHXGTrcNZwnO6JPYwc0F0Yuc9b0
	p7EbuEwjMQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A738A8E;
	Mon, 18 Jun 2012 13:50:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95DFD8A8C; Mon, 18 Jun 2012
 13:50:37 -0400 (EDT)
In-Reply-To: <vpqpq8wpled.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 18 Jun 2012 19:42:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CA98E28-B96E-11E1-B6AC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200150>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> My version reads as
>
>   try something;
>   if (it failed && I'm only here to report an error)
>           report_error();
>
> which I find easier to understand.

I agree that _this_ part is easy to understand when written that
way.  But then shouldn't there be a blanket "The caller is here only
to report an error, but all the previous code didn't find any error,
so there is something wrong" check much later in the code before it
returns a success?  Or am I being too paranoid?
