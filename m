From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default=upstream doesn't play nicely with remote.pushdefault/branch.*.pushremote
Date: Tue, 10 Sep 2013 09:06:29 -0700
Message-ID: <xmqqsixczmnu.fsf@gitster.dls.corp.google.com>
References: <522F1A61.3010805@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ximin Luo <infinity0@gmx.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 18:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJQSb-00081H-TF
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 18:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab3IJQGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 12:06:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab3IJQGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 12:06:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 278E4409BA;
	Tue, 10 Sep 2013 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qv1uKt5ZRDKu8NhxeVaSDCQ/eCY=; b=pEHSms
	NyyfoH1fmKJnhJauBod00tN7g/u3K/CjQG38wMdpImRfyhN3pGO3Y139eawy4nzW
	VakHf1yiuGVNF1jPDLXuTqAnTF7d1wwZ5PVKrwkOFoxdS4a8YiM4t+XtH9noseW0
	z60DlHcUqiO+9OWdduIOspiigWOXQ9ctpWYp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UA6WosrxaPFagztCQI5Gl0BJ5xmJcRdv
	n9gR5zFpPSDm2x5eE7IqxjBPMdY+iR27oDXaRIcffOq4SkUACq/iXdsxSKYegXIy
	4pPZ5bUnMLVmuTUZeVYj86LrYIiUyv/1P51st3vDdbkZqjx14Ge40R/dwlgEHj7I
	bRbrJeV3kow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1929C409B9;
	Tue, 10 Sep 2013 16:06:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4345B409B3;
	Tue, 10 Sep 2013 16:06:32 +0000 (UTC)
In-Reply-To: <522F1A61.3010805@gmx.com> (Ximin Luo's message of "Tue, 10 Sep
	2013 14:10:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F5A03FA8-1A32-11E3-A325-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234438>

Ximin Luo <infinity0@gmx.com> writes:

> (Please CC me as I am not subscribed.)
>
> $ git config -l | grep '^branch.master\|^push.'
> push.default=upstream
> branch.master.remote=upstream
> branch.master.merge=refs/heads/master
> branch.master.pushremote=origin
>
> $ git branch
> * master
>
> $ git push
> fatal: You are pushing to remote 'origin', which is not the upstream of
> your current branch 'master', without telling me what to push
> to update which remote branch.
>
> push.default=upstream means "push back where it came from (*)". However, if I specifically define remote.pushdefault or branch.*.pushremote, this clearly means I don't want to do (*) in this case.

I think this was discussed on the list during the last development
cycle.  Please check the list archive.

"git config --help" has this to say about it:

    * `upstream` - push the current branch back to the branch whose
      changes are usually integrated into the current branch (which is
      called `@{upstream}`).  This mode only makes sense if you are
      pushing to the same repository you would normally pull from
      (i.e. central workflow).

    * `simple` - in centralized workflow, work like `upstream` with an
      added safety to refuse to push if the upstream branch's name is
      different from the local one.

      When pushing to a remote that is different from the remote you normally
      pull from, work as `current`.
