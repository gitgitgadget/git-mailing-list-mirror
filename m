From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Fri, 06 Sep 2013 11:12:38 -0700
Message-ID: <xmqqk3ityg2x.fsf@gitster.dls.corp.google.com>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
	<vpqioyfukkw.fsf@anie.imag.fr>
	<20130905232322.GB29351@sigill.intra.peff.net>
	<20130906165330.GA6462@google.com> <vpq38phsvuc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI0WY-0008TW-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab3IFSMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:12:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab3IFSMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:12:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C3283F0AE;
	Fri,  6 Sep 2013 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eTAy59EPGEIOIuLzyVEjafafbDM=; b=hez4aN
	vGC5sRABZTjeOk9uWi/UU8kYhGg1KkSSQQiYydkAvNmiaLh4t7bVKPu08FgCzOCj
	RBtXPlWIBDsfURCbACs3srIC6VWux4BjPEwFemcPuaAsx4Fa5+CK8ctTwr0ol3hv
	P8wgrNE46ZkBrNbyZ43EFguZYAiOG3DE+M6pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMSoDFPO73pnBXNK+jz73Fkx797q0Dy4
	EpLxistKu3PQTkfC7ZutegQ4q6NzIOKfsyVYbAEdKjfzYmLOXX2RMdZy9E8hgN3B
	QsPDeYX6/gneVnsQFA0444wJnY4f/ZZRsazUOfxIDa/JmQqDZHGtuFtO6WYrzaDc
	xjwOKqv8VB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA673F0AD;
	Fri,  6 Sep 2013 18:12:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F1643F0A7;
	Fri,  6 Sep 2013 18:12:42 +0000 (UTC)
In-Reply-To: <vpq38phsvuc.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	06 Sep 2013 19:28:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EC18D6FE-171F-11E3-A462-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234080>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>>   Untracked files:
>>>           t/foo
>>>           test-obj-pool
>>>           test-string-pool
>>>           test-treap
>>>           test-url-normalize
>>>
>>>   nothing added to commit but untracked files present
>>
>> The added blank line before "nothing added" sounds like a good idea.
>
> I won't change the header part in this topic (no time, sorry), but the
> missing newline before "nothing added" actually sounds like a bug, as
> there is normally a newline after each list of file in `git status`,
> except untracked and ignored.

Actually, "nothing added ..." is not a part of status proper; it
will be clear if you run the command with comment prefix, whose
output may end like so:

    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       gomi
    #       kuzu
    nothing added to commit but untracked files present (use "git add" to track)

But I agree that the output without comment prefix needs an extra
blank before that line (if that line will be emitted, that is).
