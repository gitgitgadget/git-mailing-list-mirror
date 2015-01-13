From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Tue, 13 Jan 2015 11:17:51 -0800
Message-ID: <xmqqppaicwww.fsf@gitster.dls.corp.google.com>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq387eed30.fsf@gitster.dls.corp.google.com>
	<CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 20:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB6yV-0007ja-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 20:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbAMTRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 14:17:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751085AbbAMTRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 14:17:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A751D2E4E2;
	Tue, 13 Jan 2015 14:17:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HPd9xlgiPoRey3QkA5M6/GmuIbE=; b=muudQD
	J7qLhXCPmwr9cIuNDb9Gt049JwVeRc/U719367MhgCD7VktIhFVoGyeePxJSkMdu
	gxzQKpH33RQgP+fkDQEtPgV+OfAwvVXx4n/8OoEW25n3lp9pzxIVsDOyMZ3nM/cJ
	dW63jxoOsp6iTh0ep6aQ/lD7SSk/rB7sFV9uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=baoyZIBAjjObDbPM7tHYw0QlSJtihUuT
	FYJa+YFDb+Y05laGZsXjVv+e/BBauop3L5Odsu3NZXsJ/KQiS6a6r/o1G6xBQ8/X
	NY1k7n3i3smflQ2u5lNuBNp/dREBJwumUvt3ixDqvu3ALUqjCYdhFVM1keJO/ocx
	KpqHPRufoSs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DE212E4E1;
	Tue, 13 Jan 2015 14:17:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21C292E4DF;
	Tue, 13 Jan 2015 14:17:53 -0500 (EST)
In-Reply-To: <CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
	(Alexander Kuleshov's message of "Wed, 14 Jan 2015 00:52:27 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF2A5F1C-9B58-11E4-9A5D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262350>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> 2015-01-14 0:43 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
>> Why?
>
> As some commands does it when they are executed without arguments,
> like git config, git blame and etc...

For format-patch, I think the current behaviour is more of the lack
of implementation of the obvious default.  "git blame" does not have
any obvious default (would there be a single file you would want to
dig the history when the user does not tell you which one?  No), so
it proabaly is the right thing to do to error out.

But I would not surprised if those who build on top of others' work
to wish that "git format-patch" that was invoked without argument on
a branch created by "git checkout -t -b" to default to format commits
since the branch forked from @{upstream}, for example.
