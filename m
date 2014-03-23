From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify pre-push hook documentation
Date: Sun, 23 Mar 2014 13:12:07 -0700
Message-ID: <xmqqy500r7xk.fsf@gitster.dls.corp.google.com>
References: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
	<1395601709-78479-1-git-send-email-dcow90@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Cowden <dcow90@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 21:12:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRoki-0004HN-UH
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 21:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbaCWUMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 16:12:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbaCWUML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 16:12:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C065476AF8;
	Sun, 23 Mar 2014 16:12:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m0Pb5LHerDmwlwGZrg7Ut1EYqag=; b=P87yTi
	9koQ98JuGw6IP1EVNQsbNrS2v0svwkGMGVTAahXhvo7jNKMgPTXdQbL0fyaIAScW
	fylR68+fWs8wP8g04y/QtfxfDtfUDIHRW+o9N1Oa0jir1cgMUpDmzLoyVYNEgLiC
	8DnDHTJdacoM+lEcoa6fJy9vG2ObTPz9S1ILA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ncKcrFMGOucIDHnpYZp9kD4dgkt4gpXM
	Dv58OsdW7w/eBowfK31zwAk7c/cMAGbihzNgrpeAKaYd3jiYpgwhIG+zePOed0aX
	b+EMQpkeF9LPJM22MicBeU7UOXQ2CNTEBOX2nQv+WCqRaxZtKJlmvRzNer+1q+gT
	DdHKuJJ3IPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A790876AF7;
	Sun, 23 Mar 2014 16:12:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C4D576AF6;
	Sun, 23 Mar 2014 16:12:10 -0400 (EDT)
In-Reply-To: <1395601709-78479-1-git-send-email-dcow90@gmail.com> (David
	Cowden's message of "Sun, 23 Mar 2014 12:08:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A336304-B2C7-11E3-84DA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244805>

David Cowden <dcow90@gmail.com> writes:

> The documentation as-is does not mention that the pre-push hook is
> executed even when there is nothing to push.  This can lead a new
> reader to beilieve there will always be lines fed to the script's
> standerd input and cause minor confusion as to what is happening
> when there are no lines provided to the pre-push script.
>
> Signed-off-by: David Cowden <dcow90@gmail.com>
> ---

The "everything is up to date; no need to have any data sent back to
the other end" is one case two readers of the documentation may
guess what should happen, one thinking "we know nothing is
pushed---there is no need to even call pre-push", the other thinking
"we should always call pre-push, and tell it what will be pushed, in
this particular case, nothing".  It is a good change to clarify that
ambiguous expectation with the new paragraph.

Aren't there other cases that can invite ambuguous expectations in a
similar way?  For example, when there are differences between what
they have and what we are updating it with but the update does not
fast-forward?

> +The hook is executed regardless of whether there are changes to push or not.
> +In the event that there are no changes, no data will be provided on the
> +script's standard input.

What I am tryihng to get at is if "whether there are changes to push
or not" is covering only too narrow a subset of cases where the
readers may suffer from their expectations.

Thanks.
