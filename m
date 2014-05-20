From: Junio C Hamano <gitster@pobox.com>
Subject: Re: EXT :Re: GIT and large files
Date: Tue, 20 May 2014 11:14:39 -0700
Message-ID: <xmqqoaysz59s.fsf@gitster.dls.corp.google.com>
References: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
	<xmqqmwec1i9f.fsf@gitster.dls.corp.google.com>
	<C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD631@XMBVAG73.northgrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Stewart\, Louis \(IS\)" <louis.stewart@ngc.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmoYt-00053y-6n
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbaETSOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:14:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62055 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676AbaETSOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:14:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E577189F4;
	Tue, 20 May 2014 14:14:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XNxnr1uhz4S12+TLG6EHJhFuhpE=; b=B04Mwe
	NbgSlaWMabtPVJEzOVCe8xcFZOz5qM5IFCjU9BRAURBCysW4+rEWOE3yoB+YKs9f
	7xhttKNcrmxEKxb2fH1r90IP7y+KyosSovHgmCINRsvdg6RIaYIZyPxxnSq4ep5A
	Km1PJnQvrz6tMjIr9CcWakSDvKAq0GQdrQm2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=phP/99RsbbJPDFKgoj59uEZVPNGu62dd
	IFAq3SFM9uQXpUqn3afNnfd5Tr3HN6bLxlW1XJt+nFWGb+rrs4/csEdSPGCjMdPM
	Cy0wrUVey1V7asxqjdEeS3jCAF9Ci/qEvtrJ2tkkgcFh7bnF0+r0fL0/88DolYEY
	muyEA6FIIjo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5495F189F3;
	Tue, 20 May 2014 14:14:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C218189F1;
	Tue, 20 May 2014 14:14:40 -0400 (EDT)
In-Reply-To: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD631@XMBVAG73.northgrum.com>
	(Louis Stewart's message of "Tue, 20 May 2014 17:24:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C96D442-E04A-11E3-A63E-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249714>

"Stewart, Louis (IS)" <louis.stewart@ngc.com> writes:

> Thanks for the reply.  I just read the intro to GIT and I am
> concerned about the part that it will copy the whole repository to
> the developers work area.  They really just need the one directory
> and files under that one directory. The history has TBs of data.

Then you will spend time reading, processing and writing TBs of data
when you clone, unless your developers do something to limit the
history they fetch, e.g. by shallowly cloning.

>
> Lou
>
> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Sent: Tuesday, May 20, 2014 1:18 PM
> To: Stewart, Louis (IS)
> Cc: git@vger.kernel.org
> Subject: EXT :Re: GIT and large files
>
> "Stewart, Louis (IS)" <louis.stewart@ngc.com> writes:
>
>> Can GIT handle versioning of large 20+ GB files in a directory?
>
> I think you can "git add" such files, push/fetch histories that contains such files over the wire, and "git checkout" such files, but naturally reading, processing and writing 20+GB would take some time.  In order to run operations that need to see the changes, e.g. "git log -p", a real content-level merge, etc., you would also need sufficient memory because we do things in-core.
