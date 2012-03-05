From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Path character encodings
Date: Mon, 05 Mar 2012 13:40:32 -0800
Message-ID: <7vipiizpyn.fsf@alter.siamese.dyndns.org>
References: <20120305212657.GA17903@jupiter.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Betts <paul@paulbetts.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4fe5-000134-1c
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 22:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab2CEVkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 16:40:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860Ab2CEVkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 16:40:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D436508;
	Mon,  5 Mar 2012 16:40:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SV9Xz5FNUCMES+sTh+vh9osWV/Y=; b=LVQNl/
	UE1M1YQEHc+rWKgDWAmrhqebAjQZ7EFihs7i/kJ1Tq6EQ/sdRN5pCCsCKr58IORF
	pwFQZPHj0v62fsmW4XLxd5zu2ObugcuWoP/t5KkEOJRTMvSu86cblX6x0kyAL3fK
	yMF1qluwtoufbbahLUWSe+2RQM53EnHyxHy5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F9+wZgA70v6fQ+aNBoyuIIsFsLOOMXvw
	MbOJesXJZqF9GmSTbnQNNzw+KhX39vaWMdtPa+X20K3FlfTKgdXkZnH7E5yaPpEN
	bbnOui9dMRlYN2/dKMqdsP9SvHcovdUk+MbE+UcHokUVBnFcYl8OQObFO04Xbx6g
	cqT/x9hfvD4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5DF86507;
	Mon,  5 Mar 2012 16:40:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41CBF6505; Mon,  5 Mar 2012
 16:40:34 -0500 (EST)
In-Reply-To: <20120305212657.GA17903@jupiter.local> (Paul Betts's message of
 "Mon, 5 Mar 2012 13:26:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6BC8334-670B-11E1-8AE9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192275>

Paul Betts <paul@paulbetts.org> writes:

> ## Proposed Mitigation
>
> For an initial mitigation plan, I'd like to propose adding a warning to either
> git clone or git checkout, that if invalid UTF-8 strings are detected, a
> warning is printed to the user.
>
> However, without an actionable solution, it's not much of a help other than to
> suggest that they downgrade to a lower version of Git.

Hmph, I do not see a reason to make a huge molehill in this. The
pathnames are of unspecified encoding, and if a project declares
that they always use UTF-8, that would be great. Older history may
need to be rewritten but that is a given.

Wouldn't a flag day event per project that runs filter-branch and
have participants restart their repositories be sufficient?  Why
does git itself have to do anything about it, and how would it help
users without hurting other git users who are not involved in such a
project?
