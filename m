From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Tue, 16 Apr 2013 11:23:09 -0700
Message-ID: <7vvc7ml4he.fsf@alter.siamese.dyndns.org>
References: <20121127163004.GC7499@science-computing.de>
 <20130305115837.GD21473@science-computing.de>
 <7vd2vdvn7l.fsf@alter.siamese.dyndns.org>
 <20130306081942.GA11151@science-computing.de>
 <20130416145653.GG12782@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 20:23:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAXE-0008Jg-N3
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934008Ab3DPSXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:23:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469Ab3DPSXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:23:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EC8717576;
	Tue, 16 Apr 2013 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u1AprXUQ+aRzapsQlknOj3ARRg0=; b=S2HkiB
	VywrNwHCgOwlG7Yf8ljupFQLorU62BqqGGOpPsKTYMy5VvlwYK4AVUJO03Gmmole
	WUFSIXrbgiDopuYMzvpWA0NYD8mT5IkEL1zRMZY4VzjlVMUfMmh94HpilJF8KPkM
	g9WhEMgErFn947oUvtFXeSQ8kO9Y2E7t/ELj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQWVs6NtA856Lxnc/5VXUCG0X1uBH7I3
	br+A8iB47qPyfhbNPaDWkjQFtQIg9sJYJAGzWtkx2LhGrCL0LAwBx9gGtLS56VhV
	GH6K+pJkmD4O6VuDLV50BYNaCu9rPF5l3QVVOIo5XQwhOuC6KqxsbuCPlAZ+sNK5
	Varmp9Kr1VQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 525A317575;
	Tue, 16 Apr 2013 18:23:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3C9E17574; Tue, 16 Apr
 2013 18:23:10 +0000 (UTC)
In-Reply-To: <20130416145653.GG12782@science-computing.de> (nobody's message
 of "Tue, 16 Apr 2013 16:56:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B19ACBD6-A6C2-11E2-8C90-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221446>

nobody writes:

> Hello Junio,
> Hello list,
>
> On Wed, Mar 06, 2013 at 09:19:42AM +0100, Michael Weiser wrote:
>
>> > >> Support determining the binaries' installation path at runtime even if
>> > >> called without any path components (i.e. via search path).
>> > The default for any change is not to include it.  Is there any
>> > reason why we want this change?
>> It makes a binary git installation fully relocatable. Seeing how git
>> already has basic support for it I thought other people might be
>> interested in this.
>
> I am still interested in getting this accepted into git. Where do I push
> to get it committed?

I do not have a strong objection to what it tries to achieve, but
I'd prefer to see no "#ifdef platform" code in a very generic part
of the system like exec_cmd.
