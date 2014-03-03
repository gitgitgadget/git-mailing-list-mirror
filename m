From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit.c:record_author_date() use skip_prefix() instead of starts_with()
Date: Mon, 03 Mar 2014 10:40:08 -0800
Message-ID: <xmqqmwh7qg6v.fsf@gitster.dls.corp.google.com>
References: <1393703299-7977-1-git-send-email-tanayabh@gmail.com>
	<53144450.3080006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:40:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXmn-00014v-CT
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbaCCSkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:40:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761AbaCCSkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:40:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17FCE6F5BB;
	Mon,  3 Mar 2014 13:40:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZFru3s0hpSGZU5F0jax50a6KuY=; b=eezS+z
	+2GqTAwYTP+rB9bMShG0DFl5gi1Hqi0X6O1RuebjtZbAVjLDFD1DmnSB57XqflEu
	1PAKXKh8TmWQrW6Tk6AkVSvpC/IT2z6f7YNzCHtS1GehbzURx3SM1X1ZjjEGhzrE
	U/KYMV6r5Qui9AVkyfBY5wBxC6LfTOidayeI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmCsN2tSLoZQovT0m2aD5AAf3eOWy94t
	BARmiuZw1S3sJKT1UHqy4uIrTmAXNE0XWFHwjRmyb7+gjXaLE0OzwnglseyEc3wy
	UzhODNpQCQYT+MQMjgN899Z+Y+ldl1lGaUMkDU6xlhgBndVFO8iWtwuecI8kVALp
	Vl9Pqg6ZZss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED1DD6F5BA;
	Mon,  3 Mar 2014 13:40:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FB116F5B8;
	Mon,  3 Mar 2014 13:40:11 -0500 (EST)
In-Reply-To: <53144450.3080006@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 03 Mar 2014 09:58:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40681160-A303-11E3-8566-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243250>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> -		if (!starts_with(buf, "author ")) {
>> +		if (!skip_prefix(buf, "author ")) {
>
> If this is the only change, there is not much point, is there?  How does
> this help?  Perhaps there is some way to take advantage of the
> difference between starts_with() and skip_prefix() to simplify the rest
> of the function?

I admit I lost track, but wasn't there a discussion to use
starts_with/ends_with when appropriate (namely, the caller is
absolutely not interested in what the remainder of the string is
after skipping the prefix), moving away from skip_prefix()?  Isn't
this change going in the wrong direction?
