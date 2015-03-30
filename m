From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-branch: show all local heads when only giving one rev along --topics
Date: Mon, 30 Mar 2015 15:24:26 -0700
Message-ID: <xmqqd23qw2cl.fsf@gitster.dls.corp.google.com>
References: <1427753543-19680-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yci6j-0000JF-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 00:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbbC3WY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 18:24:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753253AbbC3WY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 18:24:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E9664535E;
	Mon, 30 Mar 2015 18:24:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rdPeWu0ScoERu3aD6DQPfjoDVco=; b=vpjf1x
	fK+ez3ZjsoYK4oeoKYj/O/rAewsNAq6nxdDRpAPS4yCZ8RhCztqy2Tc+Dd43zevJ
	orXXNozaMIp5IogzDLXZJNj6dY7SByrxUFRKLNoZ8D2U5tZw2W9VznhCe6ePtffH
	LlJ0WN//ee1dLWXcfeKDpvhx1R1i3S9t382Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qhIxxLI4eLkMTiNdjhiJj6jD5Ak5WY9h
	Mg0unuvV+SBJfZqJlHEKWSHL48tZMuoaDp2VqV7IYr6Xa2jXgvQL4ixPktlk8Isq
	4wN5Poq59fOdQc6TD/udjHlktlL0fKy55im5qDgQZHU1Fx6DaDsi/MvyCslTTGW6
	pSEad4SCwFs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04FFD4535D;
	Mon, 30 Mar 2015 18:24:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FA934535C;
	Mon, 30 Mar 2015 18:24:27 -0400 (EDT)
In-Reply-To: <1427753543-19680-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Tue, 31 Mar 2015 07:12:23 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86EFB770-D72B-11E4-B68D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266482>

Mike Hommey <mh@glandium.org> writes:

> (Maybe --topics should always require one rev on the command
> line?)

That sounds line a good thing to do.

> -	else if (all_heads + all_remotes)
> -		snarf_refs(all_heads, all_remotes);
>  	else {
>  		while (0 < ac) {
>  			append_one_rev(*av);
>  			ac--; av++;
>  		}
> +		if (all_heads + all_remotes)
> +			snarf_refs(all_heads, all_remotes);

Hmmmmmm.  Is this safe and will not cause problems by possibly
duplicated refnames that came from the command line and the ones
that came from for-each-ref iteration?  I am not saying the change
is problematic; it is just I haven't looked at this code for a long
time that the existing machinery is already designed to tolerate
duplicated input.

Thanks.
