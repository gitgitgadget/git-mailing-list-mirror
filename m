From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lookup_object: remove hashtable_index() and optimize hash_obj()
Date: Thu, 12 Sep 2013 13:30:57 -0700
Message-ID: <xmqqmwnhok8u.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.03.1309101811510.20709@syhkavp.arg>
	<20130911184845.GA25386@sigill.intra.peff.net>
	<alpine.LFD.2.03.1309121606130.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 22:31:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDXg-0004Ph-OV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890Ab3ILUbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:31:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755956Ab3ILUbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:31:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC1741D77;
	Thu, 12 Sep 2013 20:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KDgrVJiA0YZ0qHHOGBlWhAWRIAs=; b=EnCPqC
	AcpBjs3Xp93+JeymHtXFuICpLBgTBLoeO0U/K/x704n4/VucAnB5UPW6Ael1c+og
	LtcZpIKdv6yWRGcaOxCe3PkH9jE7lYOviqEZaIMeyD4nPQo9H20sMqK1W5e+IRO6
	u/Iw10WB6ail9T9u/yk9K8X7JrfMUlTqeSAyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKAOFR9xOPzQPdFu3lAsma38AJuPkgM2
	VjoPYzb9/jNx2EyTp+hYXRm898Hmagt38GIrAxHbMmH9cjl+Punp0oZ8DfTHwiZL
	BS5LAcQmqaQOj2z/wyd/m3Xztwu7j23Hg0WM+anec1I3M182+XtQnmtmZa2PQ7hx
	AU0Zlx+s1ZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1D1341D76;
	Thu, 12 Sep 2013 20:30:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22FBB41D6E;
	Thu, 12 Sep 2013 20:30:59 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309121606130.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Thu, 12 Sep 2013 16:08:04 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3BD8499E-1BEA-11E3-AA2F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234693>

Nicolas Pitre <nico@fluxnic.net> writes:

>> Maybe it's worth squashing in one or both of the comments below as a
>> warning to anybody who tries to tweak it.
>
> Agreed.
>
> @Junio: are you willing to squash those in, or do you prefer a resent?

I think I've queued it ready to be squashed.  No need for resend.

Thanks.
