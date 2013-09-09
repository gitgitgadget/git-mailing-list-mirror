From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Mon, 09 Sep 2013 15:26:53 -0700
Message-ID: <xmqqk3ip3a36.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley>
	<xmqqfvthyfui.fsf@gitster.dls.corp.google.com>
	<94A71512041A4F9BB402474DB385E310@PhilipOakley>
	<xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com>
	<531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley>
	<xmqqk3ir6wu3.fsf@gitster.dls.corp.google.com>
	<5425F66B510F423EA685BCEF40EF8FA7@PhilipOakley>
	<xmqqr4cy5a2z.fsf@gitster.dls.corp.google.com>
	<CBB3BFF2B74D4A768238512FBF1CD6E7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ9vK-00021d-8h
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab3IIW1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:27:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755667Ab3IIW1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:27:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75BAF40A5C;
	Mon,  9 Sep 2013 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJ40DoooOwwebPThKXLjytu6W9g=; b=XdtAtX
	228nNYf6bz8mYlPbQGOs6tfAddAGog6KD8pBGhIekKW3u3wCQpICVnNNko/nwm1V
	i23zJDBv/5ns7TKZkd5it/QHy4d7egl/2Z8OYCl6tXwykkEOsEMzhUizBtI9srfZ
	9vM3cYuDUvbujOU9cCsLr1trKlLFkRYEmpjhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FLWy9O+Y+Bw3UOazO02f3lczPUT8acPA
	m8D3Rm415d+JHo7S6VC13gUEFbXXwzAys3sNMga12nknB6ACuaobdiH3ZnJzxV7N
	f0KcSl7UH6ZEPqkXFMy7DRY+kxBKSt3Xfg39RWzZuUCWFPOM3hjeikAlZb5/pVYs
	mygiQ2BSq4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B778540A55;
	Mon,  9 Sep 2013 22:27:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2818840A48;
	Mon,  9 Sep 2013 22:26:58 +0000 (UTC)
In-Reply-To: <CBB3BFF2B74D4A768238512FBF1CD6E7@PhilipOakley> (Philip Oakley's
	message of "Mon, 9 Sep 2013 23:20:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F0D4AD7C-199E-11E3-BD39-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234385>

"Philip Oakley" <philipoakley@iee.org> writes:

> These look to work OK. Not sure If I've properly covered all the
> options.
>
> A nice feature is that ls-remote will find the fake ref !
>
> $ git ls-remote /c/gitBundleTest1/RepoHEADnomaster.bundle Test:HEAD
> 41ccb18028d1cb6516251e94cef1cd5cb3f0bcb5        refs/heads/Test:HEAD
>
> It's only the clone that barfs (so far) (which could be 'fixed').

You cannot 'fix' the ones deployed in the wild, but I think saying
"funny ref" and not aborting is a good compromise.  The updated
documentation for bundle can mention that error message and explain
that the older version of "clone" will say that in what situation.

I didn't notice it the first time, but I think the above would read
better and match what has been discussed on the on-the-wire format
to swap the order, i.e. use "HEAD:refs/heads/Test" to mean "HEAD is
a symref that points at the Test branch".

> Obviously, if it can be made to work, one check would be that the two
> refs (HEAD and refs/heads/wherever) point to the came commit before
> generating the HEAD symref.

Yes, that is a sensible check.
