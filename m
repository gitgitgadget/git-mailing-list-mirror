From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 03 Feb 2012 21:22:44 -0800
Message-ID: <7vsjirjhp7.fsf@alter.siamese.dyndns.org>
References: <7v8vkjl24d.fsf@alter.siamese.dyndns.org>
 <D140688E-B86C-4A67-9AD6-56160C26884D@ericsson.com>
 <20120204050818.GA2477@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com, tomg.grennan@ericsson.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:23:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtY5g-0000y1-7I
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 06:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab2BDFWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 00:22:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab2BDFWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 00:22:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4AC8252F;
	Sat,  4 Feb 2012 00:22:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbQXXRfj8x4ZUzWBBanVmJkaZHA=; b=AGrigv
	YZeEdlMv8xdvAcFtscHhUsYov0+Nfnvwn1gVr0DothvkZvCVdLiv8KXIo10ou7wq
	p5eW5aCO+3MrqSAREhewf7YOqDoOAxbMigjD+2fDe0zte+DIsRCNfstr+gnC40+u
	oQVKTuRDn6aAQxiKSyCyww9uqGo+oR1oLYwdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s1O8qs318a1TJEXnIa9C2PZ3S1/WsXlg
	PzMNe3OJnhxJWLd0O1Px/3QuTdcJyMj8a6nCtY9dBAS4y64fbxLov/QylwM1+waO
	AMmab2TYfA10kCSvGq1Oa9xJ2Hln83Tf+6bUFpKrRrqo2iXQ4SrIlL8xZbnnUvYH
	O98iEedFDIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB754252E;
	Sat,  4 Feb 2012 00:22:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43F48252D; Sat,  4 Feb 2012
 00:22:46 -0500 (EST)
In-Reply-To: <20120204050818.GA2477@tgrennan-laptop> (Tom Grennan's message
 of "Fri, 3 Feb 2012 21:08:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 457F15EA-4EF0-11E1-8161-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189844>

Tom Grennan <tmgrennan@gmail.com> writes:

> Wouldn't you want Shawn and Jeff to tag the object (commit, tree, or
> blob) that you had tagged?

No.

We _designed_ our tag objects so that they are capable of pointing at
another tag, not the object that is pointed at that other tag.  And that
is the example usage I gave you.

The statement by Shawn and Jeff, "This tag is Gitster's" is exactly that.
It was not about asserting the authenticity of the commit. It was about
the tag object I created.

>    gitster$ git verify-tag --pointed v1.7.10
>    tag v1.7.10: OK

Just saying "$name: OK" will *never* be acceptable. "A signature made by
any key in my keychain is fine" is not the usual use case. At least the
output needs to be "Good signature from X".
