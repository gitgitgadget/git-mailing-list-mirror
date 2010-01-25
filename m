From: Junio C Hamano <gitster@pobox.com>
Subject: Issues that need to be resolved before 1.7.0-rc1
Date: Mon, 25 Jan 2010 10:29:19 -0800
Message-ID: <7vsk9u2g3k.fsf@alter.siamese.dyndns.org>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 19:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZTgs-0000pf-Ak
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 19:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0AYS33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679Ab0AYS32
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 13:29:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab0AYS3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 13:29:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08ECC9328F;
	Mon, 25 Jan 2010 13:29:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mg9n8Urh2x5zlQGz9gIiPFuFFek=; b=XhlC84
	w0LVOSQeYVD8WW2n0gCJ3SE937EoKCXLx8c0mbch1KXOR+8g6okZ1H1QNrWIcTuu
	fLb90a5FzJoQavo/r5W4QilpzvetUzDDIT2YYtT0OPdHpGX7g2/qoiHKtJKj6X7e
	9GFJxc+TdctoRX4XjzVYgpKLaehzYwZLDr1Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q2OQh9wCxowqhpLQp+wqSL10gR0mZeF/
	91wD4Jw/q8X/9IXO5/epP5pp+wIBQ1ZrKsy2xpyPalg65lE52i8urdiPKQ86gO5g
	zR+1NEZ6k4r4s6WwSW3tKeZ3iFYyZZ7sfoyiXttVg8QsUzrl2Av1EmKAAXUqm6lT
	ThNPBOD06PE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB22E9328D;
	Mon, 25 Jan 2010 13:29:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57B0C93286; Mon, 25 Jan
 2010 13:29:21 -0500 (EST)
In-Reply-To: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 24 Jan 2010 20\:39\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F34A9AA-09DF-11DF-BA8A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137976>

Right now 'next' is empty and there are a handful topics in 'pu':

 - Jens Lehmann's updates to omit expensive is_submodule_modified() call
   when running "diff --ignore-submodules" and to make "diff --submodule"
   to show the "dirty worktree" status.  I think they should be in 1.7.0
   as part of the series to show work tree/index dirtiness in "git diff"
   output from the superproject.

 - Christian Couder's "reset --keep".  I am inclined to exclude it from
   1.7.0 as I cannot make a convincing argument to sell this to users
   without confusing them (even I am not convinced even though I do fairly
   straight line development at day-job), but hopefully we can keep
   cooking it in 'pu/next'.

 - Johan Herland's notes updates.  Won't be ready for 1.7.0 but hopefully
   we can keep cooking in 'pu/next'.

 - John Hawley's gitweb caching layer.  Jakub is splitting them into
   smaller pieces and they are still generating discussions.

 - My "how about this" patch to make 'grep --author=foo --grep=bar' to
   implicitly run --all-match; this is not yet readyand needs reworking.

There also is a discussion on //server/share path on msysgit, that was
started since 288123f (ignore duplicated slashes in make_relative_path(),
2010-01-21).  If that commit _breaks_ use case on msysgit that used to
work, I think the sanest course of action is to revert it and ship 1.7.0
with the same breakage we've had forever when the user gives extra slashes
in the paths to --git-dir or --work-tree options.  We could instead apply
Thomas's patch

Message-ID: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch>

that changed behaviour in much narrower case, which should be safer.  In
any case, a more intrusive change for UNC is outside the scope of 1.7.0
(discussion and preparation can continue on 'pu/next').

I saw a few patches and discussion to git-p4 in contrib from Pal-Kristian
Engstad and I understand that we are waiting for revised version before I
should take any action on them.

The above are the current set of unresolved topics and their status but I
am sure I've missed some others.  Please remind me and the list if there
are other important ones that need to be discussed.
