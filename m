From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Fri, 09 May 2014 14:08:27 -0700
Message-ID: <xmqqy4yavewk.fsf@gitster.dls.corp.google.com>
References: <536A8FF8.7080909@fabiodalfonso.com>
	<xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
	<20140508041423.GC26630@sigill.intra.peff.net>
	<536B1DF4.5080109@fabiodalfonso.com>
	<20140509155945.GG18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 23:08:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wis20-0001kx-B9
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 23:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbaEIVId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 17:08:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60321 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757368AbaEIVIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 17:08:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2B611723D;
	Fri,  9 May 2014 17:08:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VGkI0VVb+ghvKAIYvrBLPDAR5mM=; b=RkqTAXx6VJTl4bDLm08P
	aQbTsnVcLguxCmFjbfJFsFt17MLBqJNgDlbVwpsXxBcHzK1ZOQ2DEV0V2PLu5cG9
	cl2xvTgbkCC79iYDr5AL2SQO3Ke8tAVHb3Oq3gwjsbeOqwhr9ndj3b1zEMV56e3U
	QpX72BuXdt1d96ggJqT7wx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=n5bgaa20qMHDxljsmQQE7rae1YYcIjTE9WA540hfBqY4De
	J1ipHjQXAh6xfDF3XThGuAsv9itAs/X+xz+7X/IgCFeG9Z/MOj+s5NupRjp4ya2u
	ntFj9NYh8b4sWolm6OBQvBUxegYAOqLniC9F6OQgAYrAdqyEsyW4MYwDvfWqE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B84CC1723C;
	Fri,  9 May 2014 17:08:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3CFB71723B;
	Fri,  9 May 2014 17:08:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 11BCEAC6-D7BE-11E3-B399-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248642>

Jeff King <peff@peff.net> writes:

> Does running the tests as a non-root user fix it? If so, I think we have
> a few options in git:
>
>   1. Add a User directive to our httpd.conf. I doubt this is a good
>      idea to do unconditionally, as a non-root apache would probably be
>      unhappy with it.
>
>   2. Add a User directive when we detect that the tests are running as
>      root.  This might work, but I'm a bit iffy, as we do not know the
>      appropriate username for the system (e.g., "nobody" versus
>      "www-data" versus something else).
>
>   3. Just disable the http tests when run as root.
>
> I think I'd favor 3. But I'd like to be sure that being root is the
> problem.

I agree with both the conclusion and the precondition.
