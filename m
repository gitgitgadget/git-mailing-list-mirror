From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] show_ref(): remove unused "flag" and "cb_data"
 arguments
Date: Fri, 06 Jan 2012 21:08:23 -0800
Message-ID: <7vobuggkvs.fsf@alter.siamese.dyndns.org>
References: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
 <1325859153-31016-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Jan 07 06:08:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjOWC-0002CW-Ag
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 06:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734Ab2AGFIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 00:08:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab2AGFI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 00:08:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C2FF6F4F;
	Sat,  7 Jan 2012 00:08:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Mpj4nq+74Tk7/mPgHJnGsK3oJCI=; b=hhxq0Qseec+n/TwK8I93
	3RnRRSVLTVVPig9MCcwkrF8TkkbZU4+q5ma0G8POf19yrZnBU4NVya+KLJEqFI0Y
	IuUMtQ6vYsukkTYoGEKZ8hqDRgd11Pt9h92ijLRAU0p0pwv25xOpT1ETvYwaObOb
	GY3Y2ufb4OHfIWFCqIYwDFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RMNW6YGQ691fvBTFA4ggCFdubl67FgP/abVF7iXECLmRVj
	3MuWK3uzAVlKxi55jIjZLBF2jBcMP/pTMUTwFETX3RxlEnT5qR1IlZQzpjU8NBqy
	1E0mTRGqc8ujFnMg1oUVy5rJbGfTW6XzI2xZrimnCVL2KpIgfYe2hIxuftq8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 407776F4E;
	Sat,  7 Jan 2012 00:08:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD1D36F4D; Sat,  7 Jan 2012
 00:08:25 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1119E0A-38ED-11E1-BE6C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188063>

mhagger@alum.mit.edu writes:

> I suppose, though I didn't verify, that the old function signature was
> a vestige of its earlier having been used as a callback function.  But
> it doesn't really matter; the point is that the extra arguments are
> currently not needed.

Yeah, since 8a65ff7 (Generalize the "show each ref" code in receice-pack,
2005-07-02) the function has always been fed to for_each_ref(), but when
6b01ecf (ref namespaces: Support remote repositories via upload-pack and
receive-pack, 2011-07-08) introduced show_ref_cb() as the callback that
uses show_ref() as a helper, it forgot to do the clean-up in this patch.
