From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/Makefile: Use $(sort ...) explicitly where needed
Date: Thu, 19 Jan 2012 14:01:51 -0800
Message-ID: <7v8vl3ic6o.fsf@alter.siamese.dyndns.org>
References: <1327004244-18892-1-git-send-email-kirr@navytux.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Thu Jan 19 23:02:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro03U-0002pq-2U
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 23:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab2ASWBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 17:01:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab2ASWBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 17:01:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D609A692E;
	Thu, 19 Jan 2012 17:01:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BIYO/GC/gXydwH7x55+BEyKR8Iw=; b=Aeiv7b
	17oCHWE2mkstva6frja66KCl7kQONp+Re/ATHRTn9GROPzkNYzta9QLzCMIk3zNN
	okuI0oosZzE7O4rES3ipjmaaAiYU7AMT3IA+sECR/pPNkwiS9Iz6+MrxJrWR/Y3Z
	2PBwv76HfjI1afijJZJltUfbkyzJfThWOiWPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vx9RkxvyGeUeV9UwDzuv1pRXesvn+ZVJ
	nGGYJX3zqD0J8RFWXno7TNOcBabnlsvL25CwM56RIkdJz4CdStlsxrPGyMXL+Z8N
	T/mT+/14IfnWn4YAMuZ/CQRSUi0qD1tulhoIORZJMERwUeRqozMqUuD7EEFVoex6
	+prRjCrAGOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE511692D;
	Thu, 19 Jan 2012 17:01:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62D45692B; Thu, 19 Jan 2012
 17:01:53 -0500 (EST)
In-Reply-To: <1327004244-18892-1-git-send-email-kirr@navytux.spb.ru> (Kirill
 Smelkov's message of "Fri, 20 Jan 2012 00:17:23 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32287260-42E9-11E1-B75E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188841>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> Starting from GNU Make 3.82 $(wildcard ...) no longer sorts the result
> (from NEWS):
>
>     * WARNING: Backward-incompatibility!
>       Wildcards were not documented as returning sorted values, but the results
>       have been sorted up until this release..  If your makefiles require sorted
>       results from wildcard expansions, use the $(sort ...)  function to request
>       it explicitly.
>
>     http://repo.or.cz/w/make.git/commitdiff/2a59dc32aaf0681dec569f32a9d7ab88a379d34f
>
> so we have to sort tests list or else they are executed in seemingly
> random order even for -j1.

I do not necessarily buy your "so we HAVE TO, OR ELSE".

Even though I can understand "We can sort the list of tests _if_ we do not
want them executed in seemingly random order when running 'make -j1'", I
tend to think that *if* is a big one.  Aren't these tests designed not to
depend on each other anyway?
