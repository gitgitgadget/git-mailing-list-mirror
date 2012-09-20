From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --oneline: put decoration at the end of the line
Date: Wed, 19 Sep 2012 17:18:14 -0700
Message-ID: <7v392deed5.fsf@alter.siamese.dyndns.org>
References: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
 <20120919182039.GE11699@sigill.intra.peff.net>
 <7vr4pxg507.fsf@alter.siamese.dyndns.org>
 <7vr4pxegec.fsf@alter.siamese.dyndns.org>
 <20120919234226.GA27626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:18:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUTK-0002IQ-Di
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab2ITASS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:18:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab2ITASR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:18:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C437A8AE3;
	Wed, 19 Sep 2012 20:18:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E0c8gx94NCOIfuDo3ffhopuTucg=; b=vjv2iQ
	3ZSwFlv26YMjpEWXAzQo9ix62KBoa8KXvxXFMAjdFGAxz7RZE3f2/CeXpbt7YYEd
	/5p0bFcPPIk4BfjHTNohLuUmx5AgBTJ6n081y7x9FL6lwwbqdauaeLCMNviPVN6t
	2g8rjTyyL7dllSkIzx7PAUXoJFhn7OXC+2uX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wgfokJKi+7sAXWyQvKuRqmRVwin2202p
	fVy31lh1h/6tBOrO3pjBK6yCiPGWkidAKebLwQj+eWg1ORDoy1nVRGUpGWKLfiMV
	guvjWinkEPnsdCh7hEtDBIQoy6+QFltUjAIlijsLD57V8zCPIIGyVDQG5ACaf2o4
	x2LKc2B15A8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B21CC8AE2;
	Wed, 19 Sep 2012 20:18:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B0768AD5; Wed, 19 Sep 2012
 20:18:16 -0400 (EDT)
In-Reply-To: <20120919234226.GA27626@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Sep 2012 19:42:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC38EBCC-02B8-11E2-B650-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206020>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 19, 2012 at 04:34:19PM -0700, Junio C Hamano wrote:
>
>> > Yeah, I do not think it is likely.  Among the in-tree scripts,
>> > git-stash does use rev-list --oneline but the purpose of the call
>> > exactly is to grab a human readable one line summary, and it will be
>> > happy with any change to make --oneline more human readble.
>> 
>> Having said that, one of my often used alias is
>> 
>>     [alias] recent = log --branches --oneline --no-merges --decorate --since=3.weeks
>> 
>> to help me see what topics in flight may potentially interact with
>> an incoming patch, when deciding on which commit to base the patch
>> on.  Pushing the decoration at the end to let it fall off the right
>> edge of the screen severely reduces the usefulness of it and defeats
>> the point of using --decorate, at least for this use.
>> 
>> I could use --source instead, though, if it is not moved by the
>> patch.
>
> If you are particular about the exact format, how about using
> --format="%h%d %s" instead?
>
> Obviously Duy could do the same to achieve his format,...

It indeed was the first reaction when I saw the patch under
discussion that came without RFC/ in the subject.

> but I think there
> is still value in considering what the default for --oneline should be.

Yes.  And I was reasonably sure that having the decoration at the
tail is a better default, but no longer.
