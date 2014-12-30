From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] git-config support for diff.relative setting
Date: Tue, 30 Dec 2014 10:16:08 -0800
Message-ID: <xmqqegrhrok7.fsf@gitster.dls.corp.google.com>
References: <548B7967.3060201@shysecurity.com>
	<54972C29.7060801@shysecurity.com> <54A2E744.8010508@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: kelson@shysecurity.com
X-From: git-owner@vger.kernel.org Tue Dec 30 19:16:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y61L6-0008AP-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 19:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbaL3SQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 13:16:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751303AbaL3SQL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 13:16:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CB3B28588;
	Tue, 30 Dec 2014 13:16:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VH+sSA8w0acuGaXI4M7ztI1ejMs=; b=lcM9/g
	HCCej1sYmnGs4WwJk6f7ucth8gdl4VCnoJjjsbudfZILnB9JkdK6vXv+NieLj7EV
	J6458FR9+NtDrc/guvSzwk6mqavyB0JLm9+EYUIr816njrm3fCn+N4CgIfyjGyhS
	ZSJ5OphOrtX8IYzhW5/bSYDzVOsy1elZnuNFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bdB3TKDBYn7JV8PyMyHfKMaQ8qHtVGOp
	vkswDC7BiyJBwCFO99uPzfRJI4UBIm2wmgUiIPKT4pgxUsWqTVfsAP2XMyFiOLJw
	QeJAYXXqzJjo/6jPvWPJBgVS8uzkI5reHyThAOQGR3hyj6HrW/IZAILro0UlJnVa
	/8EZjkmTakc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4445228587;
	Tue, 30 Dec 2014 13:16:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE74328586;
	Tue, 30 Dec 2014 13:16:09 -0500 (EST)
In-Reply-To: <54A2E744.8010508@shysecurity.com> (kelson@shysecurity.com's
	message of "Tue, 30 Dec 2014 12:56:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE074ACC-904F-11E4-8C68-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261931>

kelson@shysecurity.com writes:

> By default, git-diff shows changes and pathnames relative to the
> repository root.
> Setting diff.relative to "true" shows pathnames relative to the
> current directory
> and excludes changes outside this directory.

The above does not tell any lie, but it is mostly a description of
what "--relative" does.  I think the main point of this change is
that by configuring a variable "diff.relative" (and forget about it)
you do not have to keep saying "--relative" from the command line,
so that is how you should "sell" this change to others, I think.

> ---

No signoff?

>  Documentation/diff-config.txt |  5 +++++
>  diff.c                        |  8 ++++++++
>  t/t4045-diff-relative.sh      | 21 +++++++++++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index b001779..496e9b0 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -103,6 +103,11 @@ diff.orderfile::
>      one shell glob pattern per line.
>      Can be overridden by the '-O' option to linkgit:git-diff[1].

Whitespace damaged patch?  HTs are all gone.  Please practice first
by sending your patches to yourself, and then try to "git am" them
by saving the e-mail messages you received from yourself.

"git grep -i thunder Documentation" seem to tell me that there are
hints on using Thunderbird in SubmittingPatches and format-patch
documentation.

I might have said this already, but I think this change, without
support for "--no-relative", would be an incomplete one that can
break the end-user experience, and it would be better to swap the
order of the patches.

Thanks.
