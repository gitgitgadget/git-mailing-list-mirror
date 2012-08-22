From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] Comparing differences introduced by two commits?
Date: Wed, 22 Aug 2012 09:58:19 -0700
Message-ID: <7vharuamok.fsf@alter.siamese.dyndns.org>
References: <2794881.R5SsgFdXjR@laclwks004>
 <CAF5DW8L=6wn6wumzwJuC=QMkb3ggZoPxOJrZf=FQEdArwNzzdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@maxim-ic.com>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4EGC-0005vv-Ua
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800Ab2HVQ6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:58:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37540 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992Ab2HVQ6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:58:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08B6D8AD0;
	Wed, 22 Aug 2012 12:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYjS7bYus3tcT1JVaBEh2Gh60cc=; b=nPehhr
	GuXyUdsM/QBHkEwZfz26ZrKEEMb8ToqoGTn5N8Dsy/9z6eUwJelFwYPbcH0tN8YZ
	iA2CI62swoNmjmXNICCf8LjQEte/uvpR+8jHyXBe4jv3ubmCV5VzM1qOLLEn67gg
	EyZMA/IDU423KV92+cUPIHW+tKstwK+MYe7Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uKPpVIxQKk8KZ9rDHGcJlJNSLo21nCmu
	ClW3R4DCDoK6LTWj7jg22OaaS3h2UnTsRGNOKMoEGcvA99YlwP7DLhWGPUzcSpZw
	p/rpscxDj71QQ8+hndEUbtwBw0FlmDjptRELeovbf1iuNgMjme553GsVErBMR5Ll
	Y3PwOQgxmTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6368ACF;
	Wed, 22 Aug 2012 12:58:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C9818ACE; Wed, 22 Aug 2012
 12:58:21 -0400 (EDT)
In-Reply-To: <CAF5DW8L=6wn6wumzwJuC=QMkb3ggZoPxOJrZf=FQEdArwNzzdw@mail.gmail.com>
 (Jonathan del Strother's message of "Wed, 22 Aug 2012 16:15:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94176F04-EC7A-11E1-827D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204031>

Jonathan del Strother <maillist@steelskies.com> writes:

> On 22 August 2012 13:10, Brian Foster <brian.foster@maxim-ic.com> wrote:
> ...
>>  In the past I've done:
>>
>>     diff <(git show A) <(git show B)
>>
>>  which produces rather messy output but is Ok when dealing
>>  with just one or two sets of A/B commits.  I now have a
>>  large-ist set of A/B commits, and the above is impractical.

Isn't this what interdiff is for?

>>  Some searching hasn't found any suggestions I'm too happy
>>  with, albeit I've very possibly overlooked something.
>
> What about cherry picking B onto A, then showing the cherry-picked commit?
>
> Off the top of my head :
>
> git checkout A
> git cherry-pick B
> git show HEAD

Wouldn't you see a lot of needless conflicts while doing such a cherry-pick?

I often do

	git checkout A^
        git cherry-pick B
        git diff A

when queuing an updated patch.
