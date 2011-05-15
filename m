From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] add, merge, diff: do not use strcasecmp to compare
 config variable names
Date: Sat, 14 May 2011 18:53:29 -0700
Message-ID: <7vhb8wrap2.fsf@alter.siamese.dyndns.org>
References: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
 <20110514190122.GA16851@elie>
 <BANLkTi=MSfRhUhY1jkRC0agQNp7WHDG9FQ@mail.gmail.com>
 <20110514201921.GA10758@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 04:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLQmx-00063v-3L
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 04:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759516Ab1EOBxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 21:53:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759327Ab1EOBxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 21:53:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 547F255C1;
	Sat, 14 May 2011 21:55:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=StR1KnWaxPnLK16d/IG4EO8YDiU=; b=ehCPq8
	HkrhSAUqB4dVshFpe+PkmVnK6X2bGjbl62/ddrLuN/0LZR17VIkSKP5mBmHSDsqq
	wNzVWZL7Hno8hpj/O4W8/j8edqoUwry34vmfknx68S0bMT9LGxYt18+Llcae4/Xi
	HElGuSjcPJ63JiRDDan+OSdNuGQoZaytGOlUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PsqtU/yQtGsoragB4xU/H0OPRPI8X9cd
	tOdhPW4YBioQZajbJ/OrOAcX1RA0I5kysM6xGDHbYiDcwuYXe7dmg0iPxE60vqd5
	utB0xetE3C2X2xr9LI02uAXk2MFynOm8IsINdbJb/+ij5PsEhEuQDshxXN8VJDb0
	rQnTl7d9tTA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2468655BF;
	Sat, 14 May 2011 21:55:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E56B55BE; Sat, 14 May 2011
 21:55:36 -0400 (EDT)
In-Reply-To: <20110514201921.GA10758@elie> (Jonathan Nieder's message of
 "Sat, 14 May 2011 15:19:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7004D87A-7E96-11E0-AE63-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173613>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The config machinery already makes section and variable names
> lowercase when parsing them, so using strcasecmp for comparison just
> feels wasteful.  No noticeable change intended.

A quick "grep 'strcasecmp(va*r*, "[^"]*\.' yields exactly the ones covered
by this patch.

Thanks, I've been meaning to change these while reading merge-recursive.
