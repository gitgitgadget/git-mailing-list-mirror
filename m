From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 09:30:36 -0700
Message-ID: <7vk402272r.fsf@alter.siamese.dyndns.org>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <4FBC0019.6030702@in.waw.pl> <7v4nr72bim.fsf@alter.siamese.dyndns.org>
 <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 18:30:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEST-0007Ky-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab2EWQak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 12:30:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab2EWQaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 12:30:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 958CE84AD;
	Wed, 23 May 2012 12:30:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MWx1va70B9VbQC9Df5n04mgH+WQ=; b=cidO83
	H94KxVP+4MfjTW9e7OxHglcmTuv2ePEOQvEyHh/Cnoh5kvHbCQ+dUTmnQZvwiJxv
	iovzFpzBxo43+e8MlMDsWXxjE13G3jnWnUAH9cSX4EVzopmkbuTyDuNFF/0iWopy
	3SGD3IgKxHeSfyGvUjSeU7dNgld7tTCqKbEZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S8+dNiceXj/EqSpcRniio/OjaAix0nTi
	PZ6tHLmA0HEYJR4A3ULVoxfyLAnW1E/8TrOxe2GcbVDBw4IJCv/K4i43NyTI39AC
	bJTKGmxzW+H4lpkpImNu49tAOZiRdrkC3tEYFOZZr3eK3s/yOPPFvwlkykeFEZ97
	JG1gDM2Ba0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A79D84AC;
	Wed, 23 May 2012 12:30:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10244849E; Wed, 23 May 2012
 12:30:38 -0400 (EDT)
In-Reply-To: <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 23 May 2012 17:40:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1330A4A-A4F4-11E1-B16C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198305>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And how do you propose to update the install documentation?
>
> #    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
> #    2) Add the following line to your .bashrc/.zshrc:
> #        source ~/.git-completion.sh
> #
> #    3) Consider changing your PS1 to also show the current branch:
>
> 1) Copy the file (e.g. ~/.git-completion.sh)
> 2) Copy the other file (.e.g ~/.git-prompt.sh)
> 3) Edit the original file (~/.git-completion.sh), modify the 'source'
> command to use the other file (~/.git-prompt.sh)
>
> And if the user doesn't care about prompt this certainly looks like overkill.

Agreed--the above would not fly.

> What do we gain by this incredible user annoyance? Less maintenance
> burden of __gitdir() which barely changes anyway?

If it lived in two separate projects, the pros-and-cons might be differnt
because there will be cost for coordinating changes between the projects,
but I do not think "barely changes" is a good rationale to keep duplicates
in this case, as we know both files come from the same project, and there
is no release engineering cost to coordiate changes.  The only price we
pay by not removing the duplicates at the source level is the risk of two
drifting apart without anybody noticing, and that particular risk becomes
the more likely the less often the function changes.  In other words,
"barely changes" is an argument _for_ removing duplicates.

Splitting the definition of whatever is duplicated out to a separate file,
having contrib/completion/Makefile insert it at an appropriate place in
both scripts at the build time, and driving that machinery from the
Makefile at the top-level would be one possible way forward.  For people
who download and install from the source, the "install insn" could also be
added to the generated file to avoid confusion (and for people who just
get the script(s) from their distro, the packagers would do that for
them).

You may think of a better solution to remove duplicates, of course, so I
am not married to the "have Makefile do it" approach and am open to
suggestions.
