From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Thu, 14 Feb 2013 15:36:46 -0800
Message-ID: <7vr4kiwjqp.fsf@alter.siamese.dyndns.org>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
 <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
 <51067353.2090006@drmicha.warpmail.net>
 <7v4ni1xjuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 15 00:37:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U68Mb-0002Pv-4h
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 00:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935100Ab3BNXgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 18:36:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759670Ab3BNXgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 18:36:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF89FC8B7;
	Thu, 14 Feb 2013 18:36:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crxzuQ4p8ziYGw+S0TXzs/8pTuE=; b=ciM8Cp
	M8nAbRcmmNwW9PiD88TgoZ9WZQdUQyHTQA7XjEKSoUO5AAjtLHP7j2/5ktf+ugn2
	yXJDIbGO7LNCcByEsjcBRtE6l7ypPcnK8mBxXlZNjMwbU67p2biNywWvcow3lkQK
	3pvj4q2XdzXF2ji25RwGzrmURZAWIogR/B3zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uxv+0RYZDvb2cQBvYb1rjTIRgxZYNIoZ
	VI3dX5sxruUhtqVtrrz3EKv4LRZndlOVXar3f3MxGrq4/lrhm+VbimAR5WuP+IVs
	/yD/NU3Tdi4iZmekPayLUmdm+F3Uf35uNs2CNk4zEe2E0lEuEy82nXf9WcuXbBl0
	3gPBC9l1Kxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2879C8B4;
	Thu, 14 Feb 2013 18:36:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 037D3C8B2; Thu, 14 Feb 2013
 18:36:48 -0500 (EST)
In-Reply-To: <7v4ni1xjuc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Jan 2013 10:07:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6662EFC4-76FF-11E2-8C94-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216338>

Junio C Hamano <gitster@pobox.com> writes:

> We should probably update the documentation/help for "git add", but
> that is entirely a separate topic.

The documentation update in 0fa2eb530fb7 (add: warn when -u or -A is
used without pathspec, 2013-01-28) says:

    If no <pathspec> is given, the current version of Git defaults to
    "."; in other words, update all tracked files in the current directory
    and its subdirectories. This default will change in a future version
    of Git, hence the form without <filepattern> should not be used.

(oops, I just spotted a stray <filepattern> here, which came from a
semantic mismerge---I'll fix it locally).

The above text says that we currently add what you have in your
current directory and below, before it says this default will
change.  That makes it easier to connect "the default will change"
and "form without pathspec should not be used" in readers' mind.  It
does not take that much imagination and intelligence to infer "it
will change and will not limit to my current directory, so in the
future I will have to be explicit when I want to do what I just told
git to do".

But the warning text does not sound quite right.  This is what I get:

    warning: The behavior of 'git add --update (or -u)' with no path argument from a
    subdirectory of the tree will change in Git 2.0 and should not be used anymore.

There is a logic gap between "will change" and "should not be used"
that is not filled like the text in the manual page does.
