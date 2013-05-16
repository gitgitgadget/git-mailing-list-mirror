From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "remote-hg: update bookmarks when pulling"
Date: Thu, 16 May 2013 09:39:22 -0700
Message-ID: <7v4ne27ubp.fsf@alter.siamese.dyndns.org>
References: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud1DF-0001yj-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab3EPQjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:39:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab3EPQjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:39:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB95C1EB01;
	Thu, 16 May 2013 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5s4FAfnoD+t2ygYsy2/Wv/Z9uno=; b=DH76wM
	d6RvrP2FvT8Sp9BjRCMnVQAQa93YmNb4SmP1WP/qDM3R2+ZxakkbS+rQSRjFsD8o
	1Ej6weZQXzKT3qgCgAiGVwSuqw6o9IyQtMSUA1Lcegp0wminGagMg3hDdYlaN/8K
	1vtPfJ2J++2lmd7gTRxXFE5HlaGUoCr/TQmE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GGI6/nq1KGAMgIaTPOUeHTKOW0RIgwHd
	jSCcMzjBkr05kho+ckM2508e3T3G3rMhM1xPqM44tAhdzoP/9zTUGujMCnqFdyrQ
	w15MIuEQEVS6aZr7ZGuK85NawYnX7SetDSlhQxd5tBarEmKUdB8CsZgVejdOTZI3
	2tC9VjnoJoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F5E61EB00;
	Thu, 16 May 2013 16:39:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22AE61EAFE;
	Thu, 16 May 2013 16:39:24 +0000 (UTC)
In-Reply-To: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 07:43:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A9E6F7E-BE47-11E2-B7D4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224599>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This reverts commit 24317ef32ac3111ed00792f9b2921dc19dd28fe2.
>
> Different versions of Mercurial have different arguments for
> bookmarks.updatefromremote(), while it should be possible to call the
> right function with the right arguments depending on the version, it's
> safer to restore the old behavior for now.
>
> Reported by Rodney Lorrimar.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> Intended for master (v1.8.3).

Hmm, is this the one we merged yesterday?

>
>  contrib/remote-helpers/git-remote-hg | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index dc276af..beb864b 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -363,9 +363,6 @@ def get_repo(url, alias):
>                  die('Repository error')
>              repo.pull(peer, heads=None, force=True)
>  
> -        rb = peer.listkeys('bookmarks')
> -        bookmarks.updatefromremote(myui, repo, rb, url)
> -
>      return repo
>  
>  def rev_to_mark(rev):
