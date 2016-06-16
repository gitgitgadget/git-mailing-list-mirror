Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC5F1FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 21:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933339AbcFPVdo (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 17:33:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754747AbcFPVdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 17:33:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C12A25308;
	Thu, 16 Jun 2016 17:33:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DIlOU6cU8+jaPmhVy1TXRY8Jgt4=; b=yapSsu
	KjYreHdbUjHYPIUXNuajTgY6rRVrOftGR8Jz3WMseNEh4VQ4hJxCZh9zLmBno14d
	8c1NAffmxokQD94NFn0/yHmd7z3j95990TJlfWXTWQm9LTqBNqzIIxSkSza3X+uN
	gFLXlUQj4pEAE3NKdj7iSXWYTKt7bZuY75Q94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MT0CAp9rS1CcKI68QRxX9HSuBr4ehSY6
	vQVOpD0Y1b9yeFIovlPPo+mxW1Nccb+KR++zZ9vplCYMawo8wkbTYp1i08/TYn5A
	GRYCGSTEmfWAhmriN6tYoQ6KPc/vPWIfesRnM2MC8xAlModEnKNF8tnQ9AlIrXJt
	h34nYTe1W/o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 537A025307;
	Thu, 16 Jun 2016 17:33:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C93C225306;
	Thu, 16 Jun 2016 17:33:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <joeyh@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/4] clarify %f documentation
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-2-joeyh@joeyh.name>
Date:	Thu, 16 Jun 2016 14:33:38 -0700
In-Reply-To: <20160616203259.5886-2-joeyh@joeyh.name> (Joey Hess's message of
	"Thu, 16 Jun 2016 16:32:56 -0400")
Message-ID: <xmqq8ty44y4t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDC5EE28-3409-11E6-A915-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <joeyh@joeyh.name> writes:

> It's natural to expect %f to be an actual file on disk; help avoid that
> mistake.

I agree that "the name of the file" can be interpreted in many ways,
and I agree that it would be a good idea to find a better phrase to
name the path that is being worked on, but I do not think "the file
in the git repository" is that phrase.  When I first read the
updated text without the above two lines in the log message, I
thought "hmph, so we may use a temporary file somewhere in $GIT_DIR/
and that would be pointed at by %f, not the actual path we are
working on???", i.e. the rephrasing had exactly the opposite effect
on me.

Given that this being part of gitattributes(5) that begins with

    A `gitattributes` file is a simple text file that gives
    `attributes` to pathnames.

    Each line in `gitattributes` file is of form:

            pattern	attr1 attr2 ...

    That is, a pattern followed by an attributes list,
    separated by whitespaces.  When the pattern matches the
    path in question, the attributes listed on the line are given to
    the path.

and that the readers already read something like this in the
paragraphs before the mention of '%f':

    For example, in .gitattributes, you would assign the `filter`
    attribute for paths.

    ------------------------
    *.c	filter=indent
    ------------------------

    Then you would define ...

I think using the word "path" somewhere in the updated description
is more likely to have the effect you desire.


> Signed-off-by: Joey Hess <joeyh@joeyh.name>
> ---
>  Documentation/gitattributes.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index e3b1de8..e077cc9 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -365,8 +365,8 @@ you can declare that the filter is `required`, in the configuration:
>  ------------------------
>  
>  Sequence "%f" on the filter command line is replaced with the name of
> -the file the filter is working on.  A filter might use this in keyword
> -substitution.  For example:
> +the file in the git repository the filter is working on.
> +A filter might use this in keyword substitution.  For example:
>  
>  ------------------------
>  [filter "p4"]
> @@ -374,6 +374,9 @@ substitution.  For example:
>  	smudge = git-p4-filter --smudge %f
>  ------------------------
>  
> +Note that the "%f" is the name of a file in the git repository; the
> +corresponding file on disk may not exist, or may have unrelated contents to
> +what git is filtering.
>  
>  Interaction between checkin/checkout attributes
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

