From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deletion of remote branches
Date: Mon, 01 Oct 2012 10:22:09 -0700
Message-ID: <7v1uhids5a.fsf@alter.siamese.dyndns.org>
References: <CC8F65C7.E79%jens.hausherr@xing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jens Hausherr <Jens.Hausherr@xing.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:32:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjhH-00085z-VZ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab2JARWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 13:22:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab2JARWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 13:22:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D46B69011;
	Mon,  1 Oct 2012 13:22:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k56LUoIyt5X+
	cPDD0FUDqkL/ksk=; b=sS15bCJvMjRPXfN0VIo+XM3T40vVdAqZu8A+A8PnbO1M
	WVn2kYyYy5hX/FpG9sDHBX7FN+Yii7pRuHIvdC6FEJAlj2V/B6Q9JX+vPUuqIDYa
	Ckz9UnFq05NwwwrES1s0g1sP7SFCP3ra5MKG4RjZU3dbn890phH21M9FzAjIr0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NLfqgr
	aue6wEds7xBFH2nsqlPeqXdw+W/2ww+YbpaysHvXSNyJeOQ3lctcItRt67haagNk
	HoCZql3aeJ/+SCR8KdwaOvOQeArabi99zwnXnA3R/p/7SciOH+D8bv8eoXhtQoeL
	PpwsZwkYmfcLOuX0G+VFWQFxwq4PrR42A4xjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0F11900E;
	Mon,  1 Oct 2012 13:22:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27E67900A; Mon,  1 Oct 2012
 13:22:11 -0400 (EDT)
In-Reply-To: <CC8F65C7.E79%jens.hausherr@xing.com> (Jens Hausherr's message
 of "Mon, 1 Oct 2012 13:22:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88E93C8E-0BEC-11E2-957F-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206746>

Jens Hausherr <Jens.Hausherr@xing.com> writes:

> I came across an issue with deleting remote branches: When deleting a
> branch using "git branch =C2=ADr =C2=ADd <branch>" the branch is dele=
ted and no
> longer shown by "git branch =C2=ADr".
>
> "git ls-remote --heads" on the other hand still lists the ref for the=
 last
> branch commit.
>
> If I delete the branch using "git push origin :<branch>" the branch i=
s
> removed completely (i.e. git ls-remote  no longer returns a ref).

All of the above are expected and working as designed.  Remote
tracking branches are local _copies_ of what you have over there at
the remote repository. The latter is the authoritative version, and
you asked "ls-remote" to go over the network to view them.

If you are trying to remove the branches you show to others and
yourself who are observing that remote repository from your local
workstation, you can first "git push origin :<branch>" to remove it
in the remote repository. You can run your next fetch with "--prune"
to get rid of remotes/origin/<branch>, I think.
