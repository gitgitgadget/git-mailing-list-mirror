From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify interaction of --reset-author
 with --author
Date: Tue, 15 Feb 2011 17:04:39 -0800
Message-ID: <7vhbc4lrh4.fsf@alter.siamese.dyndns.org>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
 <20110215230015.GA17812@elie>
 <AANLkTinZ0ewJy01rV66xMMCKLon=7qz=hoJ3DbtXmtXL@mail.gmail.com>
 <20110215234735.GA18151@elie> <20110216000553.GB18151@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 02:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpVpX-0006im-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 02:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199Ab1BPBE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 20:04:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929Ab1BPBEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 20:04:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DCE754C5B;
	Tue, 15 Feb 2011 20:05:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EFY0eYfTfbLEZpU0s3jljoaLac0=; b=DPCqc4
	jJ4y/xpFOkHvUpIVhW4iQASfqy7zuOD3C+momSCKO93db8swGt3W5z7oHMY/PjwS
	7PeweilrcI1p2cPpDBKmE7BqF7otOo34fD/U3/+Vu9wa02hSVKNc62OmOI2OH6kw
	FOkVk8Nn/ed4pYGSbrxXJBN4awVtfwV1v8pro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KzkVS0GrfL7DzcLPYxo9UfBP8solBXoT
	2213rYFyPGwrtC2H1aiG3aoNUoYAeP6JwQwcznMsVbIvNpAMemATg0CkjLEJOgRI
	2NLiK+8N+gJFuiVK0H+u4dfX6Ke/9oayx9/ldvwDVx+9hxZt8S9IDB2WVt2s5Pl6
	Q9VuDsk7SjI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DC4E4C58;
	Tue, 15 Feb 2011 20:05:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F5294C54; Tue, 15 Feb 2011
 20:05:46 -0500 (EST)
In-Reply-To: <20110216000553.GB18151@elie> (Jonathan Nieder's message of
 "Tue\, 15 Feb 2011 18\:05\:53 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E666F610-3968-11E0-AFF6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166910>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The --author and --date options override the author and date from
> --reset-author.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jonathan Nieder wrote:
>
>> Patch below.
>
> Sane?

The option is about reusing only the message and determine authorship
information from usual means, so in that sense it is sane.  A command line
"commit -C $that_one --reset-author --date=yesterday --author=$him" would
make sense in practice, but if you give both explicitly, you don't need
an explicit --reset-author anymore, so overall it makes sense in a funny
way.

>  Documentation/git-commit.txt |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index b586c0f..f766d53 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -84,9 +84,12 @@ OPTIONS
>  	linkgit:git-rebase[1] for details.
>  
>  --reset-author::
> -	When used with -C/-c/--amend options, declare that the
> -	authorship of the resulting commit now belongs of the committer.
> +	Despite use of the -c, -C, or --amend option, declare that the
> +	authorship of the new commit belongs to the committer.
>  	This also renews the author timestamp.
> ++
> +Can be combined with `--author` or `--date` to claim authorship using
> +some specific name and email address or date.
>  
>  --short::
>  	When doing a dry-run, give the output in the short-format. See
> -- 
> 1.7.4.1
