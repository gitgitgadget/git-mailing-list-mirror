From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Tue, 12 Aug 2014 13:38:28 -0700
Message-ID: <xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 22:38:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHIqB-0000Dl-S9
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 22:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbaHLUij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 16:38:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52412 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbaHLUii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 16:38:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C8F431F94;
	Tue, 12 Aug 2014 16:38:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lKCYVRSd72YjenKztH4XJFV6ATA=; b=DFuOeT
	K2GtTzp3soFXZpZEMTLjTUBQ42ar/VBD0sdWcMIz33Lta9HYCSyF+s79DxAD7/Fs
	FjWy4L9rNoQpxMgZ7uIJgqf1lSEo68QW8cdbhieztPmif7yKLLIRML+sOLsHFXyO
	0VG3fDW8vaLqt4B1ZtK6uwEUIZkdRVnmAbEhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wNit9tI0tMl24QC0mA+Kaj0985gDrOCe
	8ranmj5Qc2Yacxh1TUV+I3eme3DmIvbi4t6sO+Ngo9/HLhKbfP4YskqR0k2M0NIF
	HMmDGNvLyBkuIWUPXm9aOMcHgRGX2TxZGyumLFuXX6X++Ww9Y8j+EzejdM/6pkIq
	E4QXSBf6mmA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6146631F93;
	Tue, 12 Aug 2014 16:38:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 673E231F7F;
	Tue, 12 Aug 2014 16:38:30 -0400 (EDT)
In-Reply-To: <xmqq4mxh5w34.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Aug 2014 12:47:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9ECBF88E-2260-11E4-9F5A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255163>

Junio C Hamano <gitster@pobox.com> writes:

> So I think the reasoning (i.e. "is a descendant" is not quite right)
> is correct, but the updated text is not quite right.  Changing it
> further to "only the committer timestamps and identities would
> change" is probably not an improvement, either.  "Force the rebase
> that would otherwise be a no-op" may be a better phrasing that does
> not risk going stale even if we update what are preserved and what
> are modified in the future.
>
> Also I notice the sentence "Normally non-interactive...in such a
> situation" is not helping the reader in this description very much.
> I wonder if we should keep it if we are rewriting this paragraph.

How about doing it this way, perhaps?

-- >8 --
From: Sergey Organov <sorganov@gmail.com>
Date: Tue, 12 Aug 2014 00:22:48 +0400
Subject: [PATCH] Documentation/git-rebase.txt: -f forces a rebase that would otherwise be a no-op

"Current branch is a descendant of the commit you are rebasing onto"
does not necessarily mean "rebase" requires "--force".  For a plain
vanilla "history flattening" rebase, the rebase can be done without
forcing if there is a merge between the tip of the branch being
rebased and the commit you are rebasing onto, even if the tip is
descendant of the other.

[jc: reworded both the text and the log description]

Signed-off-by: Sergey Organov <sorganov@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2a93c64..f14100a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -316,11 +316,8 @@ which makes little sense.
 
 -f::
 --force-rebase::
-	Force the rebase even if the current branch is a descendant
-	of the commit you are rebasing onto.  Normally non-interactive rebase will
-	exit with the message "Current branch is up to date" in such a
-	situation.
-	Incompatible with the --interactive option.
+	Force a rebase even if the current branch is up-to-date and
+	the command without `--force` would return without doing anything.
 +
 You may find this (or --no-ff with an interactive rebase) helpful after
 reverting a topic branch merge, as this option recreates the topic branch with
-- 
2.1.0-rc2-238-g2566d2d
