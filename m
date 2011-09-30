From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] use new Git::config_path() for aliasesfile
Date: Fri, 30 Sep 2011 15:18:01 -0700
Message-ID: <7voby1oesm.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <1317379945-9355-3-git-send-email-cowose@gmail.com>
 <7vsjndoldq.fsf@alter.siamese.dyndns.org>
 <201110010000.13328.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 00:18:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9lPI-0004lF-2D
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212Ab1I3WSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 18:18:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757992Ab1I3WSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 18:18:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D2A62EE;
	Fri, 30 Sep 2011 18:18:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4F8QjQnotp9RTFm7a4u9/Xylyp8=; b=KFaCh6
	OO7MwPH2sgyAzM2JOmvziVqDbKRL6zLI8jv83380WR/Ez3m5rdgk9/XLJtpoA9wr
	sAJfTNGCp1VYJlnTnBUlG+EE03na/CXjE6r5IUsJ5cf6QDxf9tCqXwcX76iBNf6t
	N/GJ1/nQeWVYsZHzmMzdDnaK/z4Fd7GINzhaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XgUJRTM4Plxr+Ka2JsRe4Nf/kBlXapbx
	ES338dLHsTMqNein39SCa4A4RjcxLwqwsFJPZOE9BUpUEwbYHrXRg8mJIMBv4jIz
	IaU3d0zirAWmpDVNBkBlK+VJ+r+yJXjoYdcVR8vpALcOEh1y4774SWg/cdyt8eEj
	+BJ9Uu4VyCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA97362ED;
	Fri, 30 Sep 2011 18:18:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CEDD62EC; Fri, 30 Sep 2011
 18:18:03 -0400 (EDT)
In-Reply-To: <201110010000.13328.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat, 1 Oct 2011 00:00:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10752656-EBB2-11E0-B53A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182518>

Jakub Narebski <jnareb@gmail.com> writes:

> On Fri, 30 Sep 2011, Junio C Hamano wrote:
>
>> I think the addition of "config --path" support is a good idea, but the
>> resulting code suffers from too many cut&paste cruft across the config*
>> family of methods.
>> 
>> How about doing a bit of refactoring, perhaps something like this, on top
>> as a separate patch?
>
> This is a good idea, in my opinion.

Thanks.

>> I tried to be careful to still forcing the "one value only" for config_bool
>> and config_int, but extra sets of eyeballs would be needed.
>
> We do have tests for that, have we?

Perhaps, but I consider Perl "other peoples' problem" ;-) so...

> BTW. why do you use hashref?  Do you plan for the future to pass more
> options that 'kind'?

I don't, but other people might, and I didn't want to place undue burden
on them.
