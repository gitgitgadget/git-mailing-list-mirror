From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 09 Jun 2014 22:44:53 -0700
Message-ID: <xmqqsindb9nu.fsf@gitster.dls.corp.google.com>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
	<CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
	<87vbsayy9w.fsf@fencepost.gnu.org>
	<CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
	<loom.20140610T025754-449@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dale Worley <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 10 07:45:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuErp-00049e-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbaFJFo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 01:44:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51533 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbaFJFo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 01:44:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67BE310023;
	Tue, 10 Jun 2014 01:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Ky1oOZcDNyMcUS704hiPRn1AV0=; b=izTjjQ
	dkP8TbmxDqxxERF8ueXDl23cPkaYOR30cfALArp7tTViGhJiAyueCmsrM/w+Ji5c
	bV+VbYU5gQQcSt4zJXMcbC22tDE7Js3XOSH+MldjO6e7F2L21jEL+yxYAIQrBkjp
	cdIXSnywBq9o0I81C/9zoBiXjJW69r8PXWYSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hkXtfwCXgJbCDfq1fDr1cmVUBykhoqb+
	bYVxqdHaqm6Qot8yumjaIsL+61VfLvvd+3dKXuN7APRfRAyN2wHHJlIkXTbmvE3f
	lALTLnWP4bBX/vIZUd5RtyN2qzUBw8bzb3GQiW1v/YS/DeG5xcWCLMMnqWJ04ztE
	esHQgqcgmJw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F1F210022;
	Tue, 10 Jun 2014 01:44:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8893A1001E;
	Tue, 10 Jun 2014 01:44:54 -0400 (EDT)
In-Reply-To: <loom.20140610T025754-449@post.gmane.org> (Dale Worley's message
	of "Tue, 10 Jun 2014 01:03:09 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 593A1CAE-F062-11E3-9AB0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251161>

Dale Worley <worley@alum.mit.edu> writes:

> (As far as I can tell from Git's behavior, the definition of tracked file is
> "any file that is in the base commit or in the index".  Based on that
> definition, "git reset --hard" is working as documented.)

The book (whichever book you guys are talking about) is wrong, if it
considers only the paths in the HEAD commit tracked.  After the user
deliberately does "git add" a path not in HEAD, the user runs any
command (e.g. "git apply --index", "git cherry-pick --no-commit")
that may bring a path not in HEAD to the result without recording a
new commit that updates the HEAD, a new path is recorded in the
index and that path is considered "tracked" before the resulting
contents in the index is made into a commit.
