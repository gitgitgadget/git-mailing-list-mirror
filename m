From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] git submodule add: make the <path> parameter
 optional
Date: Tue, 22 Sep 2009 12:25:58 -0700
Message-ID: <7vbpl2srw9.fsf@alter.siamese.dyndns.org>
References: <4AB8E8D4.40105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqB0V-00008n-EA
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 21:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZIVT0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 15:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbZIVT0G
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 15:26:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbZIVT0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 15:26:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF3B93C90E;
	Tue, 22 Sep 2009 15:26:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=POmjMsVCo1RPlZcSH+B3MxdVQr0=; b=lhBg+l
	hShdak7GhrcCf4osW9djTi6eepbi44/BWd91MRnq/j1oUoXPp+NxQoMBrnRN9OCK
	PqvobZSSioFYElNIvc3Mzhybc9lq8qiC1vEKltrswMOamlpDLKIpWXxO2BUDk/ew
	Fwd7p2bFX+Azyw0d7neaxBBpUDAmRFPmkzgrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFaxUkIEKkFL52MO8GeU8hQtVBWz4p4R
	6t+DuA1AQ4yHiyd2us/O1CWlgzr3sECN0OBk8cVfYlMDKKnfvi/KZf+58Ep57vca
	Y8lrfdfbUnYX3b2QYvYumIXOBG8v2clAFIh0X1gO9MguUsVVuVYaBaysZGDMpzfe
	Csg8WBUE/lg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A44323C90D;
	Tue, 22 Sep 2009 15:26:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9E763C908; Tue, 22 Sep
 2009 15:25:59 -0400 (EDT)
In-Reply-To: <4AB8E8D4.40105@web.de> (Jens Lehmann's message of "Tue\, 22 Sep
 2009 17\:10\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C525C06A-A7AD-11DE-B1E6-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128953>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> When <path> is not given, use the "humanish" part of the source repository
> instead.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> With this patch, git submodule add behaves like git clone in this respect.
>
> Didn't get a response the last weeks, so here is a resend.
>
>
>  Documentation/git-submodule.txt |    8 ++++++--
>  git-submodule.sh                |    7 ++++++-
>  t/t7400-submodule-basic.sh      |   16 ++++++++++++++++
>  3 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 5ccdd18..4ef70c4 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git submodule' [--quiet] add [-b branch]
> -	      [--reference <repository>] [--] <repository> <path>
> +	      [--reference <repository>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
> @@ -69,7 +69,11 @@ add::
>  	to the changeset to be committed next to the current
>  	project: the current project is termed the "superproject".
>  +
> -This requires two arguments: <repository> and <path>.
> +This requires at least one argument: <repository>. The optional
> +argument <path> is the relative location for the cloned submodule
> +to exist in the superproject. If <path> is not given, the
> +"humanish" part of the source repository is used ("repo" for
> +"/path/to/repo.git" and "foo" for "host.xz:foo/.git").

I do not know if this is useful in practice nor even desired.  Comments?
