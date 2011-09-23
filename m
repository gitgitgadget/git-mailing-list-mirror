From: Junio C Hamano <gitster@pobox.com>
Subject: Re: deleting non-existent ref via push
Date: Fri, 23 Sep 2011 11:16:03 -0700
Message-ID: <7vmxdvunto.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_gksrR800yJHSnQWDNeDvD75+3Rp+qRWCuUrQyWmNDMsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:16:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7AIM-0008EK-7F
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab1IWSQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:16:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab1IWSQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:16:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47CCE65DF;
	Fri, 23 Sep 2011 14:16:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BR00qHRp/TR3S2fu4lmVOAcxHVQ=; b=a2Aeqj
	OYdtCB3fKa1065Meuhf285IpZuKRE3+vffGbYMXWafV8gj4MgpTwBR4fpvEQQwsT
	RR0hTYlUpE0pLT6wgyBmbFdKfcnAINXt4GB1LG9XvqmTACd8krszLqQFusWWkci8
	tPICOkekQtYtzxZeLirfGfkXPcvau56cvS8CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CVKKA6n6tPROi55k4FJXkMoJIFE5JErV
	GHl+PFkvSmw2j6LWzydTk7z8XWs3aWl9qPuIaVneOwM5TeKFeqzLhNSeBUe65+1F
	qjXpU2axjRq+VRgEC8XSIjmPprhy39jWAI+lSo86JyPmePBdh1asHxERDWHSROu4
	cMD+twjmbFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FBDA65DE;
	Fri, 23 Sep 2011 14:16:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3B2265DD; Fri, 23 Sep 2011
 14:16:04 -0400 (EDT)
In-Reply-To: <CAMK1S_gksrR800yJHSnQWDNeDvD75+3Rp+qRWCuUrQyWmNDMsA@mail.gmail.com> (Sitaram
 Chamarty's message of "Fri, 23 Sep 2011 10:34:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19C73BCE-E610-11E0-B7DF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181985>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Pushing to delete a non-existent ref (git push origin :refs/heads/foo)
> works without error, except for a warning that the remote is "Allowing
> deletion of corrupt ref".  By "works" I mean all hooks are also
> executed.
>
> Is this expected/supported behaviour?  Can I rely on it continuing to
> work, especially in terms of executing hooks.

This most definitely is just "we didn't bother checking the error too
carefully, especially because the result of deleting something that did
not exist in the first place is a no-op; anybody who tries to delete a
non-existing thing is a moron and deserves whatever random result he
gets".

It would be a good idea to tighten it.
