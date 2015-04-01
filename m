From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 01 Apr 2015 10:20:40 -0700
Message-ID: <xmqqh9szn4t3.fsf@gitster.dls.corp.google.com>
References: <551B0D37.5070407@ubuntu.com>
	<xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
	<551B5E64.9070906@ubuntu.com>
	<xmqqtwx0mka8.fsf@gitster.dls.corp.google.com>
	<CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phillip Susi <psusi@ubuntu.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 19:20:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdMJt-0002gZ-Gm
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 19:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbDARUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 13:20:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752619AbbDARUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 13:20:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6407D42114;
	Wed,  1 Apr 2015 13:20:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PPzop+0xt9kiwgsOwvbZe+CmgIc=; b=h1cNI8
	K0V2kgbRhHqwPef4dQ9gvN2rBO1hG+UwqutNM4JNQmzU9wqOoYGWaNSORAm8RXVu
	FLGArR2irUBmTKOOYtT+V9lPubDB+M/3yv5ah5TLH4c72hUd1rR1mdSIWyV1EbMA
	4ufT1g2032OEhmSADSVAdm/A6mwieer2MZSSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErX3NEzoXeH8YCfSdJfXrY1Nnfp2K6aL
	RLtOZivIKQ3Y3m4+EDs4n0+Wd9vWkulq1iGfNxV/JoamK5dXgLo1pi9As9lQll8K
	d6D/B1lKXB/0gGf1oP4F+McGJbmwncn0wLVb81kxJ0JyGDQLCogtlOFloNfILvmY
	/z2v9cmpAfM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A43842113;
	Wed,  1 Apr 2015 13:20:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D93EC42112;
	Wed,  1 Apr 2015 13:20:41 -0400 (EDT)
In-Reply-To: <CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 1 Apr 2015 17:01:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C7052C4-D893-11E4-A486-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266613>

Duy Nguyen <pclouds@gmail.com> writes:

> Alternatively, we can record SHA-1 in the shallow file as refs whose
> name is always ".shallow". This way "unbundle" can recreate the
> shallow file if it wants.

Wouldn't the extracting end care about such a name ".shallow" being
duplicates (if you have multiple boundaries) or not check-ref-format
kosher?

I was hoping we will have a solution for a new bundle command to
create a bundle out of a shallow repository that is somehow usable
by existing 'git bundle' implementations.  You may take a bundle out
of a shallow repository to preserve your work on top since you made
the shallow clone originally, and then send it to your friend with
existing 'git bundle' implementation to extract it into his full
clone to sneaker-net.

And that is why I did not suggest such an alternative.
