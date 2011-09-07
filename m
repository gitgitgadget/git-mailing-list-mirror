From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git without morning coffee
Date: Wed, 07 Sep 2011 10:35:15 -0700
Message-ID: <7v62l445nw.fsf@alter.siamese.dyndns.org>
References: <4E6721E3.7000207@drmicha.warpmail.net>
 <7vehzs47we.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:35:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1M2G-0005Uk-5T
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab1IGRfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:35:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634Ab1IGRfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:35:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28033D07;
	Wed,  7 Sep 2011 13:35:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CykZLou+ZP7m1cpXY1xiAaWAyuE=; b=qhMyGI
	LY6aNY5ATVLcykLOrjOyxtdO2+DfxW+fPfRjOXd/acc4rRzXv6+OxUd0/sE8qJy6
	78sOQQScoB8Ly448r591csbeN1pg45rs1WIrVj0c8wyjgU+UilUnFNm9vC63b84W
	mc1d4j2Ye1kloZAHKWDuwSnoxSgPeU5e8FQCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CDFRR2U2HQAvWiC3eBHaVAwzfb6WWGYW
	0fB9hTg5bEtxIs9hn4dmf156Ddgj+0weCWVdrm+W6q7u8dlOiyB4IzRlVAsn5UW4
	BBOm/seyYwXBlIM7PT8tRBhwqy79tDmvZkJQXhdTdkARJGEWT+im7L43k6oof0/1
	AkPVfQyHN/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA1A43D06;
	Wed,  7 Sep 2011 13:35:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 575B63D05; Wed,  7 Sep 2011
 13:35:17 -0400 (EDT)
In-Reply-To: <7vehzs47we.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 07 Sep 2011 09:46:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C06AF2A4-D977-11E0-BE1C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180882>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> git merge ":/Merge branch 'jk/generation-numbers' into pu"
>> fatal: ':/Merge branch 'jk/generation-numbers' into pu' does not point
>> to a commit
>> # Huh?
>
> Interesting.

This is because 1c7b76b (Build in merge, 2008-07-07) grabs the name of the
commit to be merged using peel_to_type(), which was defined in 8177631
(expose a helper function peel_to_type()., 2007-12-24) in terms of
get_sha1_1(). It understands $commit~$n, $commit^$n and $ref@{$nth}, but
does not understand :/$str, $treeish:$path, and :$stage:$path.
