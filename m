From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Replace filepattern with pathspec for consistency
Date: Tue, 12 Feb 2013 08:31:00 -0800
Message-ID: <7vliatijej.fsf@alter.siamese.dyndns.org>
References: <1360661084-8678-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 12 17:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Ilf-0005Uw-9v
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 17:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933398Ab3BLQbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 11:31:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758698Ab3BLQbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 11:31:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B89A7B900;
	Tue, 12 Feb 2013 11:31:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4geizfwSWbdGZ8HiyYkxH2H3Slc=; b=n79E1L
	huEl8UQ1QmpBQ4GTL9wXwoqNxmzxo0bkoKbAJ3aYldrnHS1Z/E9CT2WS9IO/pbKJ
	AnEXc35J/U5gYQIYoayO57R/5jSWw9da5AqUAH3Ch06vL42xVYXZCy+DuyGK6rNW
	13TPZeiit2wMHpAKAPUF3lrlrLPIGi7eZrMxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bOCn4oPQrVE3IwbrJNme3t0hlqCxMC5j
	CZ3VD/OWp5CDKRv9eqznS1j6cX9xF+PvepTbt53SZZ2H57t25BCxriUwKzQxbr46
	46L+9u/BNs254oYAJhfCB2yZtOAKoRx/s+dZ1Zb4epGq922qByyv2R840p4/Dnlo
	9LqS6Z/HIds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5C13B8FF;
	Tue, 12 Feb 2013 11:31:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10F10B8FE; Tue, 12 Feb 2013
 11:31:01 -0500 (EST)
In-Reply-To: <1360661084-8678-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Tue, 12 Feb 2013 10:24:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96F14160-7531-11E2-8CD9-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216160>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> pathspec is the most widely used term, and is the one defined in
> gitglossary.txt. <filepattern> was used only in the synopsys for git-add
> and git-commit, and in git-add.txt. Get rid of it.
>
> This patch is obtained with by running:
>
>   perl -pi -e 's/filepattern/pathspec/' `git grep -l filepattern`
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I'm a bit unsure about the changes to the .po files, but I guess doing
> the substitution there too does the right thing.

I am not sure if that is the right thing from the workflow point of
view, though.

The strings that are fed to _() would be updated with your patch,
but the replacement will stay to be "filepattern" translated to the
target language.  Translators have to actively hunt for the messages
to update them.  If you left the .po files untouched, they would
notice when git.pot is updated the next time and that will ensure
that the affected messages get translated, no?

>  Documentation/git-add.txt | 12 ++++++------
>  builtin/add.c             |  2 +-
>  builtin/commit.c          |  4 ++--
>  po/de.po                  |  6 +++---
>  po/git.pot                |  6 +++---
>  po/sv.po                  |  6 +++---
>  po/vi.po                  |  6 +++---
>  po/zh_CN.po               |  6 +++---
>  8 files changed, 24 insertions(+), 24 deletions(-)

For the above reason, I am inclined to take the first three and drop
the rest.

Thanks.
