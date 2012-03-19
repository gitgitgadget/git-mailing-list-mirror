From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9 v2] difftool: teach command to perform directory
 diffs
Date: Mon, 19 Mar 2012 14:00:01 -0700
Message-ID: <7vhaxk9ui6.fsf@alter.siamese.dyndns.org>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 22:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9jgh-0006H8-MF
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 22:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab2CSVAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 17:00:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab2CSVAI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 17:00:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F4E97C60;
	Mon, 19 Mar 2012 17:00:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZUlRl+Y6QaNiEVHOK63Yvrnp94A=; b=g4D1cu
	fFxDcB+RhEtvgxhZAzeL7+1i1fOw/QrnXRTgn5KAxcdzdSSOqAjoumKFdbvxq7vY
	SWV0+ImcFomlqX6zve951XfODbov/2zc+AE7zzsQ1Aafc6CAFHV3j31A11jCQRqQ
	fgpz7DufAe+8LRYk/hZbbicF/dIEh93oTgIUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ME5dkH0DyNujrCyugdXTC0gDMiqIlBKY
	+JAI71nChTLcOISrDtp2WDL+9gga/EmtIIqApby8A3t2hPdtI9Ora19qtNQ1PmIK
	tNXpXtFNvSwHVHSNucqcC7x9VPr8+Fr13qRgPnBuilsGIOVOc50pWEgHZoFwqTIS
	nOtuWNJ07EM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F6CD7C5B;
	Mon, 19 Mar 2012 17:00:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 457F57C51; Mon, 19 Mar 2012
 17:00:03 -0400 (EDT)
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Sat, 17 Mar 2012 21:55:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F8A3DEE-7206-11E1-A453-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193459>

Thanks.

I do not know a difftool user, and I wasn't paying close attention to the
discussion but I recall these points raised and I do not recall the
resolutions:

 * In [1/9], use of pass_through would mean 'git difftool' must be fed the
   options for difftool and then options meant for underlying diff
   machinery.  Is this limitation still there?  If so, isn't this a
   regression?  Shouldn't it at least be advertised to the users a lot
   stronger in documentation?

 * In [4/9], you remove the .exe extension when running git, which was
   there since the beginning of difftool 5c38ea3 (contrib: add 'git
   difftool' for launching common merge tools, 2009-01-16).  I think it is
   safe but are Windows folks OK with this?

 * In [6/9], the exit code in the failure case seem to be modified from
   that of the underlying "git diff" to whatever croak gives us.  Is this
   a regression, or nobody cares error status from difftool?  I personally
   suspect it is the latter, but just double-checking if you have
   considered it.

 * In [7/9], difftool--helper declares SUBDIRECTORY_OK, but there doesn't
   seem to be any inclusion of git-sh-setup in this script, and the patch
   does not have any effort to prepend $prefix to paths relative to $cwd.
   What good does the variable do here?
