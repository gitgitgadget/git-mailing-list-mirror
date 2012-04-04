From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] contrib: add win32 credential-helper
Date: Wed, 04 Apr 2012 10:44:22 -0700
Message-ID: <7vaa2r9ytl.fsf@alter.siamese.dyndns.org>
References: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
 <20120323211001.GA18198@sigill.intra.peff.net>
 <CABPQNSac0opcTDVBwr4VeuA7pxqbtsqU7mdmYWms9tu3MjcpeQ@mail.gmail.com>
 <20120404101014.GB13870@sigill.intra.peff.net>
 <CABPQNSYRxZHSW_urpH7yh=Bct2-X2TAsd3=jaJF_9Rb-foegLA@mail.gmail.com>
 <20120404112341.GA28354@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:44:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFUFz-0008JY-P5
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 19:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488Ab2DDRo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 13:44:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431Ab2DDRoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 13:44:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2982B6926;
	Wed,  4 Apr 2012 13:44:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s4HbZkjDkNF6p93w/74ttkp4gE0=; b=AcjyKE
	DUlIvgqzCVtkRLOiocxJPLlj+bxgudl+448EFtywMEdwHsCtfU7yPjEGC53hLVJO
	zvyWrqtZUKVOwGt4FbMkpXL6sKWlILD7B8LlgX3BLh6Gdeq6r5Huhnfh0C5yJ2MR
	giF5cyLQ2FrpsXHi8XQc5kyt3FD1d1N5rNJps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BrvmVrWWLZbqvYXYM2zDHnmLFYuRcivK
	GwAIw+2vrHSsY/ktLGERorLzb2Y+qJKhxJ2gAL5wlW+eeUtRm4oH4OdIv+l9/hOe
	deTNbAmNrxEovFLZBB31q1rjmu7nl7zY7gwX7sYMV9frfaI03GYQEPeqnS3YeNE8
	SmjhDCPcKOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 211CF6925;
	Wed,  4 Apr 2012 13:44:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A40396924; Wed,  4 Apr 2012
 13:44:23 -0400 (EDT)
In-Reply-To: <20120404112341.GA28354@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 Apr 2012 07:23:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0CB705A-7E7D-11E1-B789-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194712>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 04, 2012 at 12:37:25PM +0200, Erik Faye-Lund wrote:
> ...
>> The problem is that for some helpers you need to know the encoding in
>> order to have a user-interface show the data. This goes both for OSX
>> and Windows. If you mess up the encoding, in the helper, then you'll
>> mess up the entries in the OS'es key-managers. While this might not be
>> a problem in practice for US-English users, we've seen for Git for
>> Windows that e.g. some Asians are really unhappy with their username
>> becoming some completely incomprehensible string.
>
> How are they inputting their username? If they are seeing garbage, then
> surely it is coming to git in some encoding that is different than what
> the password manager expects. Then we give it to a helper, which hands
> it to system storage, which assumes that what we give it is utf-8. So
> the error there seems to me to be the layer between the helper and the
> system storage, where the string is converted from "a stream of bytes"
> to "a utf-8 encoded string".
>
> So why is this a credential helper protocol problem, and not an
> implementation issue for the specific helper? How does git find out the
> encoding? Presumably by checking $LANG, or whatever system-specific
> locale information there is. Can't the helper do the same thing?

FWIW, this matches exactly my reaction.

If a helper on a specific system somehow *knows* the user means to give
UTF-8, uses system UI that interacts with the user and gives UTF-16 back,
and uses system store that takes UCS-2, it is entirely sensible for the
helper to convert between these encodings internally and use UTF-8 when
interacting with credential-helper API which only expects "stream of
bytes".  But that is just a specific implementation detail of the helper.
