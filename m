From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] fast-import: stricter parsing of integer options
Date: Mon, 29 Nov 2010 17:01:42 -0800
Message-ID: <7vzksrwrnt.fsf@alter.siamese.dyndns.org>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino> <20101128194246.GB19998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 02:02:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNEbi-0002F5-UG
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 02:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992Ab0K3BCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 20:02:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab0K3BCB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 20:02:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD3193C3A;
	Mon, 29 Nov 2010 20:02:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8JNXhHqu/hmWppdeSwPzFtn1LA=; b=YTHQam
	Ghsib+yyil47IiZczOm+B7S/0C4A8FBR0g3Cb6+SMuMQZJRpbBasGU3829qY6xYo
	Aa7dGpIO2qqP9zTK25iK2aTlzc/nHQhoye9sXmoqjFyUrYSe9U/9jib9ZGS6IMSb
	EI8BHmfiXYEpmrHIH+/RZCuOj24Z6kBSkVe8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iW1149RQsgPxRr+da5hdVPWjbCdZLWYR
	EqPoS1gk64BjL9Lg4grLdl3ZvZXD0K/fN+ZbLy/3QHqDuFX3tsdLqDrCq26SkmlZ
	Fe/zG9qGW7NYY7DT7X257hf1wk3cmX3G9lEf8IL13GF8RsxILStKYcj1umqHPPJg
	iu94CTePnhA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4BBCA3C39;
	Mon, 29 Nov 2010 20:02:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DF9A53C35; Mon, 29 Nov 2010
 20:02:01 -0500 (EST)
In-Reply-To: <20101128194246.GB19998@burratino> (Jonathan Nieder's message of
 "Sun\, 28 Nov 2010 13\:42\:46 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76415D4A-FC1D-11DF-8B97-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162457>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +static unsigned long ulong_arg(const char *option, const char *arg)
> +{
> +	char *endptr;
> +	unsigned long rv = strtoul(arg, &endptr, 0);
> +	if (strchr(arg, '-') || endptr == arg || *endptr)
> +		die("%s: argument must be an unsigned integer", option);

Micronit.

It probably is Ok for the target audience, but it might be more proper to
call it "non-negative integer" ("unsigned integer" is a container to hold
such quantity).
