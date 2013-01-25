From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Finishing touches to "push" advises
Date: Thu, 24 Jan 2013 21:04:33 -0800
Message-ID: <7va9rx7t0e.fsf@alter.siamese.dyndns.org>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358978130-12216-1-git-send-email-gitster@pobox.com>
 <CAEUsAPYAikZUTf9OE=PoGBYot6Udnw9XTYDs6Ug7h=PWbCYM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 06:04:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TybTG-00068U-J6
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 06:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab3AYFEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 00:04:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab3AYFEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 00:04:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3501ACDF7;
	Fri, 25 Jan 2013 00:04:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WlOd6fhC8PiLOSRDvvkzAKYf3Bg=; b=PcN36Z
	qNYByCj7IBbJ1FkhwwQ6kNnVmKYZoeXdRRgeVyfqS/y+tKq2BRNIsA7UnOrIMVYT
	zWQVtC4/GYdRXzNiyZbHdSSdrDy0lX2UrYHBIsHdC9gRh6vWooCyk96ECYKAnwWO
	f1eHFIvz355PgnDA9tRjP+igtxTtLcAwwIOKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzYQkifnj59fal+saPXZDTyc+C9aMk5Y
	8NbetnSZYSQWWjCPf+c7yVDfVzSQgULDtMfbx7WrU1RBvjXI4w2HBv4D1IKKbBA9
	7LxWSxJVdBeuV1ZsmsksbhTLEBMn/R3ey8ciqAPak5RpT/rtfUjObeSsb4w9K9GC
	odRxF9jUsZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29B40CDF6;
	Fri, 25 Jan 2013 00:04:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 721F4CDF3; Fri, 25 Jan 2013
 00:04:35 -0500 (EST)
In-Reply-To: <CAEUsAPYAikZUTf9OE=PoGBYot6Udnw9XTYDs6Ug7h=PWbCYM1Q@mail.gmail.com> (Chris
 Rorvick's message of "Thu, 24 Jan 2013 22:31:43 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B661123E-66AC-11E2-A4FA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214497>

Chris Rorvick <chris@rorvick.com> writes:

> Had I written the the "already exists" advice in the context of these
> additional statuses I would have said "the destination *tag* reference
> already exists", or maybe even just "the destination *tag* already
> exists".

Yeah, now we do not use "already exists" for anything other than
refs/tags/, right?  Your rewording sounds like the right thing to
make it even clearer.

Thanks for bringing it up.  

Would it be sufficient to do this?  I think "the tag already exists
in the remote" is already clear that we are talking about the
destination.

diff --git a/builtin/push.c b/builtin/push.c
index a2b3fbe..78789be 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -228,7 +228,7 @@ static const char message_advice_ref_fetch_first[] =
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_already_exists[] =
-	N_("Updates were rejected because the destination reference already exists\n"
+	N_("Updates were rejected because the tag already exists\n"
 	   "in the remote.");
 
 static const char message_advice_ref_needs_force[] =
