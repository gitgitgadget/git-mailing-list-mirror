From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-add doesn't apply filepatterns to tracked files
Date: Wed, 08 Dec 2010 15:07:59 -0800
Message-ID: <7vipz3j228.fsf@alter.siamese.dyndns.org>
References: <47FCD78C-5D8C-4FA5-88DC-26FDCC7361AD@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Dec 09 00:08:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQT7Q-0002Uh-U5
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 00:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718Ab0LHXIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 18:08:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756661Ab0LHXIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 18:08:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF4832613;
	Wed,  8 Dec 2010 18:08:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b4FrOWX1aqVYjt7kkQ7z9YLje+Q=; b=LEehgq
	tQOIPpTg0DZmZG6PkWkDZMTYnXnF9Y9ZU4LroRrtfQH+6o2DIhpWaXpiZqYr9c65
	mZtObVtL4tW+dcUo9+soIC56M4Nv39H/7tZYALHA0DLqB4RjNlUrcfVpSx8psJgm
	tkJwZmTdn+oYqCaYvxSRNMTrVOPjanR3fPnkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udTdt3xsouVGTbUb91ORwek6Ms9L8CaC
	OQdANEgSFQOK5m9WtqR3jzDwL4DJecvwAlSxtcb/Wm9O/vKUHzGt0qKpWmnW8Y+S
	F1NNIq8HGfJAOEbx2eDd1LhSMNby/UME9MYBHMWKF5Vs48xLKDPhqS18kFkYtynZ
	MCC1CN9qYlU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9FE9260F;
	Wed,  8 Dec 2010 18:08:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7B112608; Wed,  8 Dec 2010
 18:08:24 -0500 (EST)
In-Reply-To: <47FCD78C-5D8C-4FA5-88DC-26FDCC7361AD@sb.org> (Kevin Ballard's
 message of "Wed\, 8 Dec 2010 15\:01\:57 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10D366D8-0320-11E0-B9E7-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163241>

Kevin Ballard <kevin@sb.org> writes:

> It seems that git-add doesn't match filepatterns against tracked files,

This is an issue known for a long time (and the one I had been bitching
about every time I had a chance).  Tracked ones obey diff-index pathspec
rules (leading path match only) while untracked ones use gitignore
pathspec rules.
