From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] diff --ignore-case
Date: Mon, 20 Feb 2012 11:47:58 -0800
Message-ID: <7vvcn1l21d.fsf@alter.siamese.dyndns.org>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
 <4F420749.9010206@kdbg.org> <7v8vjxnayn.fsf@alter.siamese.dyndns.org>
 <871upp4n15.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, <git@vger.kernel.org>,
	Chris Leong <walkraft@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:48:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZDe-0004ec-RG
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab2BTTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:48:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab2BTTsC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:48:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC797977;
	Mon, 20 Feb 2012 14:48:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R4YuyapTv6fvxY76fN5beGMnvvA=; b=TM46tl
	Naf4oiv7HXBUpLUKjSULNU/7ZdjQ6r5zeLcYKXLBvaSBgC24lduQcHXvvlpMl6TP
	1OqPYpJEeb6Lia1/vsJq3sQA7WwJIhe3CBymKfm8Hj7CANqSkSsrGw7ut6jFhioK
	bpHTcWz6MzYRhKg66CYh6Cu+Qouejh9kHLeGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GLVj6fufD4/eOF8FKmrzAT/1sFotmDcq
	SyQ/eutFJWd9T/xmZM/xAKHlAVvbr0Vt97NVSTCoJ+mOD3vCXk2vMqxvrfDgCzmH
	EvG7llPA1cDjk2APeQTxE7qQpHB6y92zl+K0vZN0xSZxezlRjvo1dSinKW3Q1V2Q
	ezRncfbBY10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE877976;
	Mon, 20 Feb 2012 14:48:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 831BE7975; Mon, 20 Feb 2012
 14:48:00 -0500 (EST)
In-Reply-To: <871upp4n15.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 20 Feb 2012 15:06:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB6A54E0-5BFB-11E1-A0B8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191091>

Thomas Rast <trast@inf.ethz.ch> writes:

> I wonder which one of us misunderstood the original request ;-)

Heh, I did ;-)

> It was
>
> } Is there any way to run diff -G with a case insensitivity flag?
>
> and I took that to mean "I want to find addition/removal of a string
> like -G does, but I don't know how it was capitalized".

I think it is just the matter of checking REG_ICASE that may be set in
revs->grep_filter.regflags, and propagating it down to the regcomp at the
beginning of diffcore_pickaxe_grep().

Want to try and see how well it works?
