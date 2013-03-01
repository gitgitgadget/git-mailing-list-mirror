From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 01 Mar 2013 15:24:42 -0800
Message-ID: <7vlia6em9x.fsf@alter.siamese.dyndns.org>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:25:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZKD-0003Vf-NI
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab3CAXYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:24:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab3CAXYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:24:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B2FDBF60;
	Fri,  1 Mar 2013 18:24:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X8fVlDGCHMf4Q4rSbf52IItw4b4=; b=wXRglp
	TQH2J3ylQo47vrPwjJHZMElCzXGIkdKwyCmF7XmmZlNMU46n507IJBvaE8WXplZR
	cUi9r8Et1trvGKIW3mxlZ7TymRwhL0Hdvz2G04TgtshvSz1E9i63x8Ki2u56WTiy
	2hIVnbHpdXY2SFp5KBJp0tc7bkG6pFyMNBwFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hhzCub6Zf7enrBA+x1rRlwRfrOsEnvkZ
	mzCIVXmhBHk05V+9xYLP1VJo8EtDPQPinyrJoCb5YpsgUXU3xFRMarSnncxwQOxU
	eQJhW8tR0DW0ZhaUjLnsM7gvJ9nNfM5xJwD+CRH+pY0xEUvddFgLHnh1RUmAljOd
	vYHHKyx+eZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3FEEBF5E;
	Fri,  1 Mar 2013 18:24:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 834D1BF5A; Fri,  1 Mar 2013
 18:24:43 -0500 (EST)
In-Reply-To: <20130301230508.GC862@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Mar 2013 18:05:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32B679F6-82C7-11E2-8923-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217305>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 01, 2013 at 05:52:31PM -0500, Jeff King wrote:
> ...
>> The maildir spec explicitly says that readers should not make
>> assumptions about the content of the filenames. Mutt happens to write
>> them as:
>> 
>>   ${epoch_seconds}.${pid}_${seq}.${host}
>> 
>> so in practice, sorting them kind of works. Except that ...
>> << it does not work >> ...
> That ordering is not necessarily useful.
> ...
> So it is somewhat against the maildir spec, but I think in practice it
> would help.

I do not think it would help, unless these epoch_seconds are the
sender timestamps.  And the number of digits in epoch-seconds for
recent messages would be the same, so ordering textually would be
sufficient if ordering by timestamp were.
