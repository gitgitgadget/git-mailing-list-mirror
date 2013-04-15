From: Junio C Hamano <junio@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 11:50:15 -0700
Message-ID: <7va9ozsk60.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
 <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
 <516C4A52.1080908@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 20:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URoUR-0002HD-14
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 20:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934953Ab3DOSua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 14:50:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934871Ab3DOSuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 14:50:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2901C16091;
	Mon, 15 Apr 2013 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jk9V0u96uURo4yUFNGQb7NFsZPQ=; b=dl0GOb
	MHUTSH829vQbhvJZ1Ddn0Ne8E+NTa6cUxQrXJc3wOE6pOkJOnco1P/IuqsIyHFCR
	T6TouQHwVk96nIT2Y00+VOXfF3q5kTbqVUk6rgNu4yIsFp6en9Gp4eBcD0ccHF4E
	IDG0i7ywaMoDnMGaat5o8ERnOYD0EH6i8oaAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z9DyyM+o0ntuLv9sdpcSiYOD1iwY6bPT
	yCGNpYLh+EPDhQ7WO0sQiTtUxndGZiHcn5jllAAoXsNc1jeCnSwxBFFln7vIRlZB
	2+ZQuduE2/J3hmN3RNt/wcdO0sKWhFLUOwzzYf+61sqTB3X4u9rf4RcekrcGfOQL
	CYuF03kLMkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2018316090;
	Mon, 15 Apr 2013 18:50:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 995E01608E; Mon, 15 Apr
 2013 18:50:16 +0000 (UTC)
In-Reply-To: <516C4A52.1080908@xiplink.com> (Marc Branchaud's message of
 "Mon, 15 Apr 2013 14:43:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50422444-A5FD-11E2-976A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221287>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> After that "clone" or "init" creates a repository, you still have to
>> "add" if you want to make it a submodule to the toplevel.
>
> To me it makes more sense to move the .git directory when the user invokes
> "git submodule add" instead of creating it in an unusual place when the
> sub-repo is cloned.  After all, git can't *know* that it'll be a submodule
> until it's submodule-added to the super-repo.

It does not relieve "git add" (or "git submodulea add") from the
responsibility of moving .git directory.  It only reduces the need
to do so.

When the user says "add" and the repository has .git directory in
it, "add" (or "submodule add") is still responsible for relocating
it.
