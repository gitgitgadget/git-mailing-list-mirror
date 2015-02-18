From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 23:11:00 -0800
Message-ID: <xmqqvbiz4ruj.fsf@gitster.dls.corp.google.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>
	<54E31405.5040502@gnu.org>
	<xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
	<54E3A5E2.6060806@gnu.org>
	<CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
	<54E3AA41.5070209@gnu.org>
	<CA+55aFxdxzeHmckgn5ZSvXKr9VOztNApif+=5xmZ+4v=RhUryQ@mail.gmail.com>
	<1957798859.18730760.1424207408147.JavaMail.zimbra@redhat.com>
	<CA+55aFy_63YEaYa4KYEiMP+pR0-MKrf2nd1PgnJ2Ez2XJuVGhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 08:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNyms-0000kR-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 08:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbbBRHLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 02:11:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbbBRHLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 02:11:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 302BA31D87;
	Wed, 18 Feb 2015 02:11:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zGEUqEJ1ANS9KdnpwfOMsUgLgrQ=; b=KGycvw
	bzQm5zYPxNdB+nHguLDK6B5n8xsYgDKh47YDkjFXz9T3SMhOQHL6BdLzDN7E0qVR
	6vguli62DmbYvvhsSHHUTaORjeKl34xhjXwCUiYNJHOGqFW7YWzfDs2fdjbnhwOG
	WP0g0vBxfU0EDjux9pbuOR1iRmAVFIKa10NUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N5A2KXB0bLTQii+CAZy2T4TVisqbBHrQ
	F0OwQ3Clmq87QSpkSsRQP+E/97e9YYK7V9ftprKreNEDX8ySfI9AJMgIWpSDPmAV
	0JZOG/d6cJF2pSQCMvqRoShC4oevD9hGzKDWk0STcpJlcYzgRzhIpG2s1557HCnk
	0Ftfv9bv9IU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2411231D85;
	Wed, 18 Feb 2015 02:11:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A14731D84;
	Wed, 18 Feb 2015 02:11:01 -0500 (EST)
In-Reply-To: <CA+55aFy_63YEaYa4KYEiMP+pR0-MKrf2nd1PgnJ2Ez2XJuVGhQ@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 17 Feb 2015 13:18:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B8D8904-B73D-11E4-9949-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264004>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So basically I agree that git request-pull has changed behavior, but
> the new behavior is *more* in line with other git commands, and the
> old behavior was actually really really odd with that whole extensive
> "guess what the user means". No other git command ever did that
> guessing thing (ok, famous last words, maybe somebody can come up with
> one), and not mentioning a branch/tag/commit explicitly pretty much
> always means "HEAD".

OK.

There may be some stuff that DWIMs "HEAD" to something other than
the commit that is at the tip of HEAD, but I agree that the fewer we
have such oddballs, the better.

Thanks.
