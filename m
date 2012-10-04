From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] log --grep: honor grep.patterntype etc.
 configuration variables
Date: Thu, 04 Oct 2012 09:46:42 -0700
Message-ID: <7vehle18y5.fsf@alter.siamese.dyndns.org>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-7-git-send-email-gitster@pobox.com>
 <20121004081732.GD31305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:23:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtdk-00033L-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460Ab2JDQqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:46:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932263Ab2JDQqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:46:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 673718ABE;
	Thu,  4 Oct 2012 12:46:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i327Bx3FapL3TATmKkvGBFPgxig=; b=Y8yafL
	GOb/BRMVxT3VChMd0BEKR/pe/Fo5Tbtt4lI8bYhZe1zGkiZhFZVN6DQW2kz8xUdn
	gHufq/qVobkMIllfaUc6v8EanOF5nEqRj6a0+xvyyvE3s7Np+mFCuvFQuPGKjrtk
	Wyz/9Koyd0jpMkDn3PFSCFIF7T+FcTHGVAOxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CkTkCS3NFw+RrQLejGb37+vEatiRgA2B
	3pL4eSMTJv0HmOJNC3yFz9TVXc6134hyk6Pl3uEPqqQRbEkuKiqx1O13ePGfYYzn
	RcpUoU/IRJ9PQXlW/X4bQ8Q5tZtTSeKL3Pvph/XuWOOB68inAFzUALvFoXGjR9Od
	OnKVW9DDLV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53FA98ABC;
	Thu,  4 Oct 2012 12:46:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C35A38ABB; Thu,  4 Oct 2012
 12:46:43 -0400 (EDT)
In-Reply-To: <20121004081732.GD31305@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 04:17:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14247FEA-0E43-11E2-93C3-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206993>

Jeff King <peff@peff.net> writes:

> Hmm. So I think this is a nice feature for some people, but I wonder if
> we would run into any plumbing compatibility issues. People do tend to
> use "log" as plumbing (since rev-list is not as capable). On the other
> hand, I'd think most internal uses of "log --grep" would be passing
> something along from the user, and the user would be happy to have it
> interpreted by their chosen set of rules.

This does make "rev-list --grep" aware of the configuration but at
the same time --basic-regexp and friends are also available to it.
