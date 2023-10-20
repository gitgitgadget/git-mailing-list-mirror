Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D511DA59
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BrxvJ4vx"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C5D69
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 13:08:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D14032D2E;
	Fri, 20 Oct 2023 16:08:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZHWYZgflLIkSvxOUABFCyhTAevJmGq15tK7a1w
	H8CfA=; b=BrxvJ4vx1iT8+z6mH4jlSMyfyMByPZu8Gh3EkOy9M4ODJADAyoNDQb
	iaeUqjpgfEYskYvT8O23qYf/CNB1hxMfOKokK0VWfyqMOynvKoxNxxppNIQX0kHI
	RSpQtNFW9XtvSMhd+qMQSZ2H3IUjYbVXTGV+rn9VauBPub30mk5u0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 35E4F32D2D;
	Fri, 20 Oct 2023 16:08:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B642332D2C;
	Fri, 20 Oct 2023 16:08:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-push: more visibility for -q option
In-Reply-To: <20231020184627.14336-1-msuchanek@suse.de> (Michal Suchanek's
	message of "Fri, 20 Oct 2023 20:45:21 +0200")
References: <20231020184627.14336-1-msuchanek@suse.de>
Date: Fri, 20 Oct 2023 13:08:04 -0700
Message-ID: <xmqqwmvhoy57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 618600FC-6F84-11EE-BB19-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Michal Suchanek <msuchanek@suse.de> writes:

> The -v option listed at the top as option al parameter while -q is not.

"as option al parameter" - ECANNOTPARSE.  Probably

    The `-v` option is shown in the SYNOPSIS section near the top,
    but `-q` is not shown anywhere there.

or something, I think.  I agree showing it next to "-v" would make
the most sense.

>
> List -q alongside -v.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Documentation/git-push.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 5b4edaf4a8..003bc7d9ce 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git push' [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
> -	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
> +	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-q | --quiet] [-v | --verbose]

Yup, the change makes sense.  We may want to wrap the first line to
a more reasonable length in a separate commit, and when that
happens, we probably would want to start [-v] [-q] on a separate
line as well, but for now this would do.

