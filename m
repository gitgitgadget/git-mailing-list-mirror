From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: "git rebase" loses the additional changes in "evil" merges
Date: Mon, 4 Mar 2013 22:24:07 +0100
Message-ID: <87sj4aoo3s.fsf@pctrast.inf.ethz.ch>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
	<7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Dale R. Worley" <worley@alum.mit.edu>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 22:25:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCcsY-0005Fz-V8
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 22:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586Ab3CDVYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 16:24:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:9833 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932607Ab3CDVYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 16:24:11 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 4 Mar
 2013 22:24:05 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 4 Mar
 2013 22:24:07 +0100
In-Reply-To: <7vtxoqx3s1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Mar 2013 13:18:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217412>

Junio C Hamano <gitster@pobox.com> writes:

> worley@alum.mit.edu (Dale R. Worley) writes:
>
>> (git version 1.7.7.6)
>>
>> I've been learning how to use Git.  While exploring "git rebase", I've
>> discovered that if the branch being rebased contains an "evil" merge,
>> that is, a merge which contains changes that are in addition to the
>> changes in any of the parent commits, the rebase operation will
>> silenty lose those additional changes.
>
> I think this is to be expected for "git rebase", as it does not even
> look at merges.  It is a way to find non-merge commits that haven't
> been applied yet, and apply them to the upstream to create a new
> linear history.

I can see the problem with --preserve-merges though.  It will actually
just *redo* the merge; the name is wrong in the sense that it undertakes
nothing to preserve whatever evilness was in it.

I suppose in theory it could first redo the merge on the original
parents, and diff against the existing merge; that would be the evilness
component.  Then it could attempt to apply the same evilness on the new
merge.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
