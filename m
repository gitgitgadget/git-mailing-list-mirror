From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch --merged and git branch --verbose do not combine
Date: Mon, 15 Sep 2014 13:20:51 -0700
Message-ID: <xmqqwq944ov0.fsf@gitster.dls.corp.google.com>
References: <87fvfutza3.fsf@fencepost.gnu.org>
	<xmqq38bs92sg.fsf@gitster.dls.corp.google.com>
	<87a960r9d2.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:21:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTclm-0006xd-KT
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 22:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbaIOUUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 16:20:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58852 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756086AbaIOUUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 16:20:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B70593B3D2;
	Mon, 15 Sep 2014 16:20:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hDSqOA/q0kbSoEHOP9fLJXQIcz4=; b=XZfBDc
	b4ZtcMtXBmL6+Plmlu0OMhrdqwD00ASXe3Eme5/PwqSa6zoNMAj1IqqJELAcsE9W
	lIHAcu92Q1FA8OsMTuA4E6c5d+0nSpU/dA3kucviJJbgllSvkKLGz/DCnoBAfe0N
	SMTzRb95Hdd2ILCtzpAcL9X+rYzIPdr3gcM5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ahEuFUUD/xILT/YZM72Qog3l2xeVNyoJ
	8OjL6a/nc2eqoAr6qPjmyv0gDvb7zJC+zKTe/vDiMPGMMtXRIhVSZWR/AtRowSRW
	weU4Ny0Nl8hLf+F7XUfvVLg9c4BnKcAncLxQItbwGZCqgnifA9yhkDgn9284wKbZ
	+CXkGiIlEVI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE4D93B3D1;
	Mon, 15 Sep 2014 16:20:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24C613B3D0;
	Mon, 15 Sep 2014 16:20:53 -0400 (EDT)
In-Reply-To: <87a960r9d2.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 15 Sep 2014 21:07:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CAA84B54-3D15-11E4-B3A4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257079>

David Kastrup <dak@gnu.org> writes:

> This gives the same result as
>
> git branch --verbose --merged
>
> namely _only_ listing the current branch verbosely.

Hmph.  Then that is a different issue.  As I never use --merged
myself, even though I use "git branch [--verbose] --no-merged pu"
quite often to check the list of topics that I received but not yet
merged anywhere in my tree, I wouldn't be entirely surprised that
the combination does not work, but with a quick glance of the code,
especially how matches_merge_filter() uses "--[no-]merged", I cannot
offhand imagine how --no-merged would work and --merged break.
