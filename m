From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: --inline-single
Date: Fri, 22 Feb 2013 08:47:39 -0800
Message-ID: <7vmwuws3bo.fsf@alter.siamese.dyndns.org>
References: <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
 <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
 <20130221231328.GA19808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 17:48:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8vn6-0001CV-0u
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 17:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049Ab3BVQrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 11:47:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757921Ab3BVQrm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 11:47:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD0F9A0C5;
	Fri, 22 Feb 2013 11:47:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SMe7M2rk15wtk4VnGBvty8zuUvM=; b=W1upkW
	hqxbCHt57fM6kllv+TaEsjz/d2ZwcTn/d6l+ER6cHV0DN3k+slupKCM3Slw6Tnwd
	PmaFkNEGbXEtGpRYyvQYQHUPQh1rBTqBBJpk5UC7i2mOBrJTMebk4we2gJXsFQxT
	WdMiJkXQ/UwMj/bvlupS8VysUIePoeKTFMjC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=clTiCa/tvCPUryMPZmw20pUluItzBHWt
	kw8Isw7MC2tY/iRJt/T9Rb2XmbvNQF9UUEeXvvd2lhAY8BZ1z5BU5CoNSPnqH5Y6
	8mEeE4bAqOpqa83lVPRA5VoQ3KfpWC2NnMvbKu3ApWeBFwypZ9b8NcRShfHD2cCQ
	HcqOR5zLfHU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1533A0C3;
	Fri, 22 Feb 2013 11:47:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33F4AA0C2; Fri, 22 Feb 2013
 11:47:41 -0500 (EST)
In-Reply-To: <20130221231328.GA19808@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 21 Feb 2013 18:13:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 929BED50-7D0F-11E2-898D-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216838>

Jeff King <peff@peff.net> writes:

>> ... <helper function to see if the user is the author> ...
>> +}
>
> Nice, I'm glad you handled this case properly. I've wondered if we
> should have an option to do a similar test when writing out the "real"
> message format. I.e., to put the extra "From" line in the body of the
> message when !is_current_user(). Traditionally we have just said "that
> is the responsibility of the MUA you use", and let send-email handle it.
> But it means people who do not use send-email have to reimplement the
> feature themselves.

I am not sure if I follow.  Do you mean that you have to remove
fewer lines if you omit Date/From when it is from you in the first
place?  People who do not use send-email (like me) slurp the output
0001-have-gostak-distim-doshes.patch into their MUA editor, tell the
MUA to use the contents on the Subject: line as the subject, and
remove what is redundant, including the Subject.  Because the output
cannot be used as-is anyway, I do not think it is such a big deal.

And those who have a custom mechanism to stuff our output in their
MUA's outbox, similar to what imap-send does, would already have to
have a trivial parser to read the first part of our output up to the
first blank line (i.e. parsing out the header part) and formatting
the information it finds into a form that is understood by their
MUA.  Omitting From: or Date: lines would not help those people who
already have established the procedure to handle the "Oh, this one
is from me" case, or to send the output always with the Sender: and
keeping the From: intact.  So,...

 
