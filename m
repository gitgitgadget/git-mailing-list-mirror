From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log history simplification problem
Date: Tue, 04 Feb 2014 12:11:08 -0800
Message-ID: <xmqqiosu8wpv.fsf@gitster.dls.corp.google.com>
References: <20140204173713.GC17861@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@collabora.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 04 21:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmRO-0002Q2-VW
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbaBDURu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:17:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164AbaBDURt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:17:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8B666712C;
	Tue,  4 Feb 2014 15:17:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/65q3CqcADQwJgUZOQAw7jeXq4k=; b=dVxi+S
	GLfObONJ1p6FKKgKQJdXp8nb+d60BzY5tsra9UFx5oGvUXBKpYQIYsNEnz1DF4zO
	JI5W7zFDf+mt0McjLU4+RrgTBxI3ONf2/Kv34CyaMKRymU8Dbp0xg2Lp7Gf+aJHQ
	0TvNd4dR7ecGqRQp+0mZdR5V6gckC3qPWsVRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wn87MVyjjxOGb1dx7r1rXz6Stw9n6rEf
	VM541wkYZAtPvqZ90wB+uQ5pFkbeOuLeU6MZGCla4/wThq6zFYQA8EYfxmmhiNgJ
	MeTySf1jBcxhBbtORCElKd76jHjjjqwWZ2sNLH1w5H9leStt3oD2VYpI7MOoCucu
	poqEYT/Bee0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F32067128;
	Tue,  4 Feb 2014 15:17:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A027369DB8;
	Tue,  4 Feb 2014 15:11:11 -0500 (EST)
In-Reply-To: <20140204173713.GC17861@collabora.co.uk> (Miklos Vajna's message
	of "Tue, 4 Feb 2014 18:37:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7DF23172-8DD8-11E3-9B68-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241548>

Miklos Vajna <vmiklos@collabora.co.uk> writes:

> Hi,
>
> I was trying to understand the history of a piece of code in LibreOffice
> and I'm facing a behaviour of git-log which is not something I can
> explain. I'm not sure if this is a git bug or a user error. ;)
>
> Here is the situation:
>
> git clone git://anongit.freedesktop.org/libreoffice/core
> cd core
> git log --full-history -p -S'mnTitleBarHeight =' sd/source/ui/dlg/PaneDockingWindow.cxx

Lack of -m is what I would first suspect when somebody
misunderstands "merge simplification".  I am not saying that will be
the issue, but merely pointing out that that is the first thing that
jumps at me when I view the above command line.


>
> Here the first output I get from git-log is
> b390fae1706b9c511158a03e4fd61f263be4e511, where you can see that the
> commit *added* that string. So it should be there on master, I would
> assume.
>
> But then I run:
>
> git grep 'mnTitleBarHeight =' sd
>
> and it's not there. Am I missing something, as in e.g. even with
> --full-history git-log does some simplification?
>
> Thanks,
>
> Miklos
