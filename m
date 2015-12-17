From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RefTree: Alternate ref backend
Date: Thu, 17 Dec 2015 13:57:42 -0800
Message-ID: <xmqqk2ocbuw9.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 22:57:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9gYd-0007DO-DU
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 22:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933531AbbLQV5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 16:57:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932330AbbLQV5s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 16:57:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D68A136241;
	Thu, 17 Dec 2015 16:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FgIwhrHwmmd4r9ot/3pVAOo0wks=; b=NF+xVv
	H8mgK+ofBo6DN2dj9+LCxM6aIBv+k8FGmX9if6BOb+SUBA9B6a92llGq58iWomzJ
	oEqjqBQLC+xPMRaLkSALVCWbWMKFFcxjaGUE1GEhvWTGKKhZnuYktWQF04U3yzi4
	YERvx2Bd0YxYyyhI1S96jSu4c/hNOQ7x/HBn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BQe2DctYdHRObs2YKbAWJO5be8ESIsLC
	GCin7T+Z1l9ZcvSQQxzfofQq8OWxSEGwE5fdWimObjcPHtDMbFYCKpKgzBXN4BhP
	P45N03VVLLVE2Lg9jyWxpD64MRvx+ub1ZfxbD9Drft3wLicgGzzADI3E2f9tEs+E
	Wka67hTdeOE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE03836240;
	Thu, 17 Dec 2015 16:57:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 424823623F;
	Thu, 17 Dec 2015 16:57:44 -0500 (EST)
In-Reply-To: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
	(Shawn Pearce's message of "Thu, 17 Dec 2015 13:02:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 338D2ACA-A509-11E5-ABA6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282679>

Shawn Pearce <spearce@spearce.org> writes:

> For example, recent git.git has a structure like this:
>
>   $ git ls-tree -r refs/txn/committed
>   120000 blob 22e42fc826b437033ca444e09368f53a0b169322 ..HEAD
>   160000 commit 1ff88560c8d22bcdb528a6629239d638f927cb96 heads/maint
>   160000 commit f3adf457e046f92f039353762a78dcb3afb2cb13 heads/master
>   160000 commit 5ee9e94ccfede68f0c386c497dd85c017efa22d6 heads/next
>   160000 commit d3835d54cffb16c4362979a5be3ba9958eab4116 heads/pu
>   160000 commit 68a0f56b615b61afdbd86be01a3ca63dca70edc0 heads/todo
>   ...
>   160000 commit 17f9f635c101aef03874e1de1d8d0322187494b3 tags/v2.6.0
>   160000 commit 5bebb9057df8287684c763c59c67f25f16884ef6 tags/v2.6.0-rc0
>   160000 commit 16ffa6443e279a9b3b63d7a2bebeb07833506010 tags/v2.6.0-rc0^{}
>   ...
>   160000 commit be08dee9738eaaa0423885ed189c2b6ad8368cf0 tags/v2.6.0^{}
>
> Tags are stored twice, to cache the peel information for network advertisements.

The object 17f9f635 is not a "commit" but is a "tag".  It is
somewhat unfortunate that "ls-tree -r" reports it as a commit; as
the command (or anything that deals with a gitlink) is not allowed
to look at the actual object, it is the best it could do, though.

The "..HEAD" hack looks somewhat ugly.  I can guess that the
reasoning went like "if we stored these in the most natural way, we
always need a top-level tree that hold two and only two entries,
HEAD and heads/, which would require us one level of tree unwrapping
to get to most of the refs" and "HEAD is the only oddball that is
outside refs/ hierarchy, others like MERGE_HEAD are ephemeral and
for the purpose of Gerrit that does not even do working tree
management, those things that are not necessary in order to manage
only the committed state can be omitted.", but still...
