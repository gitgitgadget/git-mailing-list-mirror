From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitignore vs. exclude vs assume-unchanged?
Date: Tue, 22 Apr 2014 10:54:28 -0700
Message-ID: <xmqqtx9l5jxn.fsf@gitster.dls.corp.google.com>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
	<xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
	<dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
	<20140416234555.GA4309@google.com>
	<4dd8389939fbf3dc77b58adcca7b17c1@bellandwhistle.net>
	<CAH5451k+GGGdHXkwne2O-h2m2AyWg7K+5reNRG64+eF891pVUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alex@bellandwhistle.net, Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:54:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcetz-0004pN-2A
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 19:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933604AbaDVRye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 13:54:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933600AbaDVRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 13:54:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3D57FAAC;
	Tue, 22 Apr 2014 13:54:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cTQIJUrOC7DPok7x4yyNFI/PVgY=; b=pKsoXA
	0P1PpRgvHfIMYybLyYlcWganoLlL8c1sTSBZB3na0AhWr90xk3A33c6UBMhs7shV
	vLF7l1RcAZm94MpjJ/R1CHFnzgUYtncOCvtEztAhZSAv3D3bnH/XsCt/awxU8WUf
	WDbXQOsaq2CGWjF4x/eVpPJCIYx1tA2W+B6Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qz0WqGha/+BFdAR/w7EbebmP/IMDF90/
	jXhLfncAEPAVdjNdYhYmzHRcR6Ogs02wow75hobSgoMmPEf66YxhZPCg1gPlVVcl
	3xDCMbCNWMSGsGf7+F4XxxBH96IWH5HQPVi7p3SnYDDTS9RGXj0WTRyuQKfZ8GwE
	qVC6k1IYHlM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4249B7FAAB;
	Tue, 22 Apr 2014 13:54:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 293227FAA6;
	Tue, 22 Apr 2014 13:54:30 -0400 (EDT)
In-Reply-To: <CAH5451k+GGGdHXkwne2O-h2m2AyWg7K+5reNRG64+eF891pVUA@mail.gmail.com>
	(Andrew Ardill's message of "Tue, 22 Apr 2014 10:40:43 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 274A9DCC-CA47-11E3-9781-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246759>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> As a data point, I have seen people add ".gitignore" to their
> .gitignore file, as they don't want to share the file.

Interesting.  It will break immediately when the project starts
wanting to distribute its "canonical" ignore list, but until that
time, it would "work" (for some definition of "working").

> It would be possible to check for this antipattern during normal use
> and provide a hint to the user, but that is probably too heavy handed
> and might annoy people with a legitimate use case. For that matter, if
> the gitignore file is easier to use for the 'private ignore' use case
> we have a bigger problem and shouldn't dictate to users what to use.

Very true.

> ... The introduction does specifically mention 'gitignore'
> files, but that seems to be due to all the ignore files
> ($HOME/.config/git/ignore, $GIT_DIR/info/exclude, .gitignore) being
> classified as 'gitignore' files.

Yes.  Notice that that the blanket term used is not "dot-gitignore",
but "gitignore".  The difference may be too subtle, and your
suggestion to introduce a new phrase "git ignore files" as the
blanket term might be one way to make it less subtle.  I would
actually think "ignore files" (without Git, as all readers know we
are talking about _our_ ignore mechanism in our documentation) may
even be a better idea. 

> We could reference the multiple ignore locations earlier, for people
> who don't read past the first paragraph of to documentation.
>
> "Git ignore files specify intentionally untracked files that Git
> should ignore. A git ignore file can be specified for all local
> repositories, a specific local repository, or shared with other users
> of a repository. Files already tracked by Git are not affected; see
> the NOTES below for details."

Sounds good, with or without s/git ignore/ignore/.

> Finally, it's a little confusing that one of the files is called 'exclude'.
>
> It would be great to rename it to 'ignore'; $GIT_DIR/info/exclude ->
> $GIT_DIR/info/ignore. Is there any reason this shouldn't be done?

If we were starting Git from scratch, we may have called it
info/ignore, but we do not live in an ideal world, so we need to
worry about people's existing repositories, scripts and templates.

That does not mean we cannot transition over time, aiming to flip
the default in a future big version bump (no, not in 2.0), along the
lines of (note: I haven't thought this thru, and do not take this as
an authoritative and correct plan):

  Step 1.

   - Check if info/ignore exists, and read it without reading or
     even checking the existence of info/exclude;

   - Check if info/exclude exists, and read it.  Warn about future
     default change and tell the user to rename (or if we are
     absolutely sure that we are interactive, we can offer to do the
     rename for the user by prompting).

  Step 2.

   - Wait for several major releases, until major distros catch up
     with step 1.

  Step 3.

   - Drop the support for info/exclude altogether, without even
     warning about our stopping to read it.
