From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git mv` has ambiguous error message for non-existing target
Date: Thu, 15 Nov 2012 17:34:32 -0800
Message-ID: <7vehju8h5j.fsf@alter.siamese.dyndns.org>
References: <50A53A80.4080203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Lehner <lehner.patrick@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 02:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZApV-0000ra-U1
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 02:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab2KPBeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 20:34:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab2KPBef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 20:34:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DE899759;
	Thu, 15 Nov 2012 20:34:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FeQFo3FfGXc1Ty2hmtVVrN8PjxE=; b=BEXXyk
	/wB8BN9VE0WbDnDBCEhqClttUcolUe8Y6vVaFE6cSogEWMXHIGGPtoyG6sEI3yeF
	nuyH9ORbVkUVYn7nP7QfYYJt8gwIcNPJ8KyPJodELqQ46DEdjTJnfeJTYnTFdwsQ
	+35WABQ+vA8B9RhK0QWpme6ZCafqZSArw7s5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FRdtMmWufvuXL95PowQvkV8BxX113+Kp
	VFBvuySHFMLB8EaJfmvEGghfzGvV7zEJOtSNihqSNZl4JdxR4l38irCyDzxqiY+U
	gVLE4nc+9PqfQ+6cb9up1CQ9SmfAjBKeM5GrrIMVayAy5ukpBIx4YvvN4VpyZYr9
	qNS8Atv2qZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B3969757;
	Thu, 15 Nov 2012 20:34:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5B249756; Thu, 15 Nov 2012
 20:34:33 -0500 (EST)
In-Reply-To: <50A53A80.4080203@gmx.de> (Patrick Lehner's message of "Thu, 15
 Nov 2012 19:54:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6541E08-2F8D-11E2-942A-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209855>

Patrick Lehner <lehner.patrick@gmx.de> writes:

> To reproduce:
> - cd into a git repo
> - assuming "filea.txt" is an existing file in the CWD, and "dirb" is
> neither a file nor a directory in the CWD, use the command "git mv
> filea.txt dirb/filea.txt"
> - this will produce an error message like `fatal: renaming 'filea.sh'
> failed: No such file or directory`
>
> It does not mention that the problem is, in fact, the target directory
> not existing. This seems to be mostly a problem for users unfamiliar
> with bash/*nix console commands. Although it is documented that git mv
> will not create intermediate folders (which is fine, because neither
> does mv), the error message might lead to believe a problem exists
> with the source file.

    $ rm -fr xxx
    $ >yyy
    $ mv yyy xxx/yyy
    mv: cannot move `yyy' to `xxx/yyy': No such file or directory

It doesn't mention that the problem is with 'xxx' and not 'yyy'
either.
