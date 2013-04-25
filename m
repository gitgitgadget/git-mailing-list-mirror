From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Thu, 25 Apr 2013 16:41:47 -0700
Message-ID: <7vvc7ayy84.fsf@alter.siamese.dyndns.org>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
	<7vhaiu1a89.fsf@alter.siamese.dyndns.org>
	<7v4neu19mj.fsf@alter.siamese.dyndns.org>
	<20130425232410.GN29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 01:41:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVnW-000784-In
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab3DYXlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:41:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758783Ab3DYXlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:41:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5362919D30;
	Thu, 25 Apr 2013 23:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ji+qfBgad/ORfmWIBt2qziNj2nU=; b=V0GNW0
	7MO+oeOWLeiXVQJwcGLzygRlAqVlpTq9ghy0gt6YSlyvCCYp3KxMrzGlLx8Y/11d
	7W6PajveqyFhLYeQaOdl4rDuvGyUX65QdAcXoOGFGVU/57zC23xNjHw1k3i9q5GA
	ac/GbhCIR1lDrwNWKUN3EGRO/2nQ92vH2kp+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RgOWHLBJiq83LM2Fi3S52iznfzQvT9hr
	NUB71944LtTreU4PF0NCfLUvL86ombBng1A1gEVBhgED6X8tCuAoZF0cBjuaRAnh
	9DAMNpHZVuv1Fw+aWwT3nXA24ke5WiruJ11nzQUFqWTUPOnY6wCAnJjDFG90kkwC
	w4LSrTmPRjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B14319D2F;
	Thu, 25 Apr 2013 23:41:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2CBD19D2B;
	Thu, 25 Apr 2013 23:41:48 +0000 (UTC)
In-Reply-To: <20130425232410.GN29963@google.com> (Jonathan Nieder's message of
	"Thu, 25 Apr 2013 16:24:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B288E924-AE01-11E2-B617-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222466>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> At the point of calling warn_pathless_add(), it seems that we are
>> triggering this for paths that are not necessarily modified when run
>> with "add -n -u".
>
> Do you mean files that were touched but have no content change, or
> something more subtle?

I had the change (which by the way needs a fix for the "found a
directory" codepath) on top of master, uncommitted, and no other
change (I also have some cruft that is not ignored).

    cd Documentation && ../git add -n -u

reported GIT-VERSION-GEN which was not touched.  It does not
reproduce, though...
