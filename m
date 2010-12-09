From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Wed, 08 Dec 2010 22:22:40 -0800
Message-ID: <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com>
 <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 07:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQZuv-0007Ej-BB
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 07:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab0LIGXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 01:23:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0LIGXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 01:23:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 084312701;
	Thu,  9 Dec 2010 01:24:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ju2l38Wn5rdbHctjrWBvm0NhzXc=; b=hj9kZA
	MzVzUN02QWidShD74IEeECiIvcfsWo3BlrF2e+AnL6gZ//tIAmPRzTIBDh4jb+KF
	PvbXdfdinox4Tqydd1SOafp+k4dCwpL6T95fp+V6A6g0Da3QAxc/X33dE4BXN5Jr
	Ei1XoJbhNjEQY54n9G76Ph39+ZFDsYkXc077s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ch4EqCueOVRaApnD1i6jf+9qMzNED+Db
	TnWGoSX/yFJAC19MSPBI9CBlqjyE9U8cjolUdYP+hBA1Gq0XfWSH8bUBKGnhH0Ku
	fcVbnybG3BB5s9UGZwipgwAUN6CLJlw4L72GuemVtg5RNft+Fy5Prj2kUPljkTNt
	9zu4rlWEOoM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A5182700;
	Thu,  9 Dec 2010 01:23:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 315CC26F5; Thu,  9 Dec 2010
 01:23:09 -0500 (EST)
In-Reply-To: <20101209015926.GA31119@burratino> (Jonathan Nieder's message of
 "Wed\, 8 Dec 2010 19\:59\:26 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4F6FB50-035C-11E0-8596-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163266>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jakub Narebski wrote:
>
>> You would need HEAD{^{/foo}^@}x3, or use special rule that HEAD^{/foo}x2
>> means really HEAD^{/foo}^@^{/foo}, with ^@ used to join them.
>
> That said, does ^2x500 really do something meaningful that a person
> would ever need?  I like the
>
> 	^{:nth(3)/foo}
>
> syntax because perl6 supports m:nth(3)/foo/, suggesting a menu of
> already-defined modifiers to implement when they prove useful,...

Can you explain what the colon in "$commit^{:nth(3)/foo}" is doing?  

Are we declaring anything that begins with ':' is a magic inside ^{...}
construct?

I do not think nth($n) without specifying where to start (iow, what the
current ":/foo" implementation does but with "three levels deep") makes
any sense, but because the main point of your argument is that we can have
modifies other than nth($n) that may make sense in such a context, I would
want to make sure anything we come up with is extensible to that syntax.

On the "starting from any ref" front, I think "!" (as in ":/!some magic")
was the introducer we reserved for such a magic some time ago, so perhaps
on the "starting from this commit" side, "^{!magic/foo}" may be more
appropriate?
