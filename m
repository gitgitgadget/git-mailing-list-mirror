From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] "commit --template" fixes
Date: Tue, 03 Apr 2012 14:55:04 -0700
Message-ID: <7v1uo4cwg7.fsf@alter.siamese.dyndns.org>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
 <1333136719-12657-1-git-send-email-gitster@pobox.com>
 <4F775ACF.50007@gmail.com> <7vaa2vhyso.fsf@alter.siamese.dyndns.org>
 <4F7B2F35.40807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ivan Heffner <iheffner@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBh6-00058F-FP
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab2DCVzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:55:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab2DCVzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:55:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 743DB735F;
	Tue,  3 Apr 2012 17:55:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7C9iWLtjhPxvWsaSSakS/KkbWVE=; b=UUBfvm
	jXBf5PS5aduB1ZhSxSz7wuvNqwUnCdvlKK1mvKPuzYwP3dtMdoj42XjRZEjih5ku
	TXoFWf+SZoW1ed7TexdHx+mJZmuMvS7/SkL5pNfba6fWNn7+RUmw8vc4IVsP/sCa
	OXxsUnCfxmRhg96dc1BamJJCRQZoMsg7mXky8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQOgLOzhziGQ7UtEbpAnNspusqchl4pG
	OlpujruDxpaiwivH4wgFBNzbVI0rs9AaQmFRBeb9m+EY809nvq809NTZb8h2rEYk
	iLJs83lHilv7U8iSVR8Ag9bAgy59s4XZ4cx5xQ/fVMeRPih/MUNWS1aEfuZYiCSM
	NppW/laRYw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C804735E;
	Tue,  3 Apr 2012 17:55:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25E15735D; Tue,  3 Apr 2012
 17:55:06 -0400 (EDT)
In-Reply-To: <4F7B2F35.40807@gmail.com> (Adam Monsen's message of "Tue, 03
 Apr 2012 10:11:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC6671C0-7DD7-11E1-8CD4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194653>

Adam Monsen <haircut@gmail.com> writes:

> How about this? I'm a little bummed it doesn't include why commit
> --template exists at all, but it reads well: terse and to the point like
> (IMHO) a manpage should.

Perhaps we should explain why somebody might want to use --template
instead of -F; personally, I do not think --template command line option
would not make much sense unless it is used as a part of a script that
enforces external constraints in a larger workflow, even though such a
project could instead require the participants to set commit.template to
one supplied by the project.  As an enforcement mechanism, use of such
stricter "commit wrapper" and commit.template configuration cannot be
mechanical and absolute either way, as Git is distributed and whatever
happens in the participant's repository is purely up to the participant.

>  -t <file>::
>  --template=<file>::
> +	Use the contents of the given file as the commit message. The
> +	editor is invoked so you can make subsequent changes. If you make no
> +	changes, the commit is aborted. If a message is specified using
>  	the `-m` or `-F` options, this option has no effect. This
>  	overrides the `commit.template` configuration variable.

When editing the commit message, start the editor with the contents in the
given file.  The `commit.template` configuration variable is often used to
give this option implicitly to the command.  This mechanism can be used by
projects that want to guide participants with some hints on what to write
in the message in what order.  If the user exits the editor without editing
the message, the commit is aborted.  This has no effect when a message is
given by other means, e.g. with the `-m` or `-F` options.

Hmm?
