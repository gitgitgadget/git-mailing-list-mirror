From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Smart-http documentation: add example of how to
 execute from userdir
Date: Tue, 05 Jan 2010 00:23:25 -0800
Message-ID: <7veim52c5e.fsf@alter.siamese.dyndns.org>
References: <905315641001042359h7850c6cdrf9160030aff67839@mail.gmail.com>
 <1262678381-86653-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 09:23:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS4hc-0005Ty-A7
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 09:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab0AEIXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 03:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935Ab0AEIXj
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 03:23:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0AEIXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 03:23:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B06E8E77A;
	Tue,  5 Jan 2010 03:23:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qCqTsx+bSykuplKCQ7CSE6XnG68=; b=L+5lxa
	nQvIklU7UmxUXa0J5ezSwLUpwkDt7zBO5DecKqxj9/7XPc+xLbu5pNuQfXoTsOJQ
	OJE2Wp21iyBBWzCV41a0QZGkLpSxyTOKACWpBW51E99cyfgcHzb5teHYZkp3nbVy
	R9x7dtgLHp+bA876L3Q/URP2pApoIhmAvK9h4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZxxXXVNm2JEj7EaR7gOqdvv4PgUVSqV
	mA2x3F4oa5PRudKLMJvDHC/0xeDBST7yg22lMGokGOUuARhpZXi8WZ8ArtqS4dhY
	kVPJXQW9ceULXdRbCeeK+MuDTgd8EebCziSvRj541Js3x9/e1o6ZFv1eGNysgUGy
	SfkE02J9Qfs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB0DE8E779;
	Tue,  5 Jan 2010 03:23:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF7EE8E778; Tue,  5 Jan
 2010 03:23:26 -0500 (EST)
In-Reply-To: <1262678381-86653-1-git-send-email-tarmigan+git@gmail.com>
 (Tarmigan Casebolt's message of "Mon\,  4 Jan 2010 23\:59\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9BF94EC8-F9D3-11DE-ACA3-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136177>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> +Depending on the global configuration of the web server, the
> +"FollowSymLinks" or "SymLinksIfOwnerMatch" options might be needed.
> +If the web server does not follow any symbolic links, the
> +'git-http-backend' executable may be copied into the cgi-bin directory
> +and renamed to 'git' to acheive the same effect, but it will also need
> +to be manually updated whenever a new version of 'git-http-backend' is
> +installed.

Hmph, has Apache heard of hardlinks?  If not, wouldn't this be much
simpler?

    cat >git <<\EOF
    #!/bin/sh
    exec /path/to/libexec/git-core/git-http-backend "$@"
    EOF
    chmod +x git
