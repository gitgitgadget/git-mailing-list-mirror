From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 11:43:37 -0700
Message-ID: <7v8v24vd0m.fsf@alter.siamese.dyndns.org>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	<git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 20 20:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upjpk-0007Jl-Sq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 20:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191Ab3FTSnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 14:43:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161036Ab3FTSnk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 14:43:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB92629347;
	Thu, 20 Jun 2013 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u7+ipOeKuHErfmIapnF3/wvam+w=; b=PzgIak
	dTeNHj3jWnYskA/MjUqxA7VDeGQex7J0egcJDeFGx9d574ky+tt0RiA761QCB1kO
	FDVOaLB6q4M/U5fDYQc4P1sO1yrom14WKLL8bKBuscmiw4smKbPjXvzQf58/gr6R
	vAKJtcXxTFcwsQ1nt7j56C3eWmNKC5/ATzi2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=goLNB6P1OnlhtpFJkgM7q5Ck33OkfG+d
	BdMNTCIFHzXcyo60skvSzbnmJI2fos6FSLS9ACOurcbhFcqg+Pl/h8Ri4d0qWjEY
	se5f1/CncLff+mf0YVjpnaYvU0CuKUuz22JbUDCnbtFsacb8x79uFuShnqVSegMu
	x3mIbvsW75w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDF8629345;
	Thu, 20 Jun 2013 18:43:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E65329343;
	Thu, 20 Jun 2013 18:43:39 +0000 (UTC)
In-Reply-To: <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Thu, 20 Jun 2013 15:06:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52BFCC7A-D9D9-11E2-8014-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228521>

Thomas Rast <trast@inf.ethz.ch> writes:

> The logic for pulling into an unborn branch was originally designed to
> be used on a newly-initialized repository (d09e79c, git-pull: allow
> pulling into an empty repository, 2006-11-16).  It thus did not
> initially deal with uncommitted changes in the unborn branch.  The
> case of an _unstaged_ untracked file was fixed by 4b3ffe5 (pull: do
> not clobber untracked files on initial pull, 2011-03-25).  However, it
> still clobbered existing staged files, both when the file exists in
> the merged commit (it will be overwritten), and when it does not (it
> will be deleted).

Perhaps making sure the index is empty is sufficient, then?
