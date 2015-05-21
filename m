From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix inconsistent spelling of "packfile"
Date: Thu, 21 May 2015 09:37:14 -0700
Message-ID: <xmqqegm9lwed.fsf@gitster.dls.corp.google.com>
References: <xmqqr3qaledb.fsf@gitster.dls.corp.google.com>
	<1432193225-3502-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu May 21 18:37:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTTG-0002Xq-UH
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbbEUQhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:37:17 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34289 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbbEUQhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:37:16 -0400
Received: by ieczm2 with SMTP id zm2so12502185iec.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9nFWu1qa7DxHpNX1iMUQ9DcgRF4Qx3GLweiqcqUraLA=;
        b=kxICv4Nho+sZtqyil1D1JZjnLWSomREKODHO7y4TxQPk6RQZOf6T+Q+I2gRdUfRxec
         spbN2PxEL7cuwz95Ztk9ox17PYD+qHzvZYp4vnOw3V0WNVSkUX3blqKklNGuDFN2HGux
         /ZHjwHgFJRXRx0h1AQsPpAF+S2V9xbEceM5yYZcHiMkuUFZGEAqG7jyhQ0XMnGs22L4y
         xkIaZT8PvDNAthqUmYVQb1m5wQppvNMpnOPvzOn+mh7JILmQlZPFii0++rPqBZlL6Jj7
         ILF6hqGLhEyIAlCE0ZH5a0AgqaTnuQBXqcfaYsotu4JafRl+bZ+TIRrmjjmb/C1Lq/fA
         Ip1A==
X-Received: by 10.107.128.30 with SMTP id b30mr4472041iod.84.1432226236152;
        Thu, 21 May 2015 09:37:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id k16sm1672711igf.19.2015.05.21.09.37.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 09:37:15 -0700 (PDT)
In-Reply-To: <1432193225-3502-1-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Thu, 21 May 2015 09:27:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269605>

Patrick Steinhardt <ps@pks.im> writes:

> Fix remaining instances where "pack-file" is used instead of
> "packfile".
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> This patch now also fixes instances where we refer to EBNF-style
> command line parameters, as discussed by Junio and Peff.

Thanks.

> diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
> index 7a4e055..49621da 100644
> --- a/Documentation/git-index-pack.txt
> +++ b/Documentation/git-index-pack.txt
> @@ -9,9 +9,9 @@ git-index-pack - Build pack index file for an existing packed archive
>  SYNOPSIS
>  --------
>  [verse]
> -'git index-pack' [-v] [-o <index-file>] <pack-file>
> +'git index-pack' [-v] [-o <index-file>] <packfile>
>  'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
> -                 [<pack-file>]
> +		  [<packfile>]

Hmm.  The former is taking a concrete *.pack file on disk, and the
latter is optionally writing the pack stream out to a *.pack file on
disk.  If we follow "'packfile' for the concept, 'pack-file' to
refer to a file with .pack ending" guideline, I'd think both should
be 'pack-file'.

	Side note: because these invocations, especially the latter
	form, can take any filename, you could do:

        	git index-pack foo.tmp && mv foo.tmp $realfilename.pack

	in which case the arguments may not be files whose names end
	with ".pack"; it is just a file that holds pack data stream,
	so it could be argued that "packfile" is not incorrect.  But
	the reason why you are doing the above is to ultimately
	create a *.pack file, and I'd say "pack-file" would be more
	correct.

> @@ -37,11 +37,11 @@ OPTIONS
>  
>  --stdin::
>  	When this flag is provided, the pack is read from stdin
> -	instead and a copy is then written to <pack-file>. If

Likewise; we are writing to a *.pack file, "written to" is not
talking about what (i.e. "packfile", the pack data stream) is
written but what accepts and holds that data stream in the end.

> -	<pack-file> is not specified, the pack is written to
> +	instead and a copy is then written to <packfile>. If
> +	<packfile> is not specified, the pack is written to
>  	objects/pack/ directory of the current Git repository with
>  	a default name determined from the pack content.  If
> -	<pack-file> is not specified consider using --keep to
> +	<packfile> is not specified consider using --keep to
>  	prevent a race condition between this process and
>  	'git repack'.

All of the above talk about that same entity on the filesystem that
receives the pack data stream.

> diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
> index 894d20b..07d4329 100644
> --- a/Documentation/git-unpack-objects.txt
> +++ b/Documentation/git-unpack-objects.txt
> @@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
>  SYNOPSIS
>  --------
>  [verse]
> -'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
> +'git unpack-objects' [-n] [-q] [-r] [--strict] < <packfile>

This feeds the pack data stream to the command from its standard
input, so would be a good change.

	Side note: if you have an on-disk file to feed this command
	from its standard input, it is more than likely that the
	file is a *.pack file, i.e. a "pack-file".  But in practice,
	the command is more often than not fed an output of another
	command via pipe, and it only cares about it being a pack
	data stream.  So in that sense, both are correct but the
	updated one is more correct.

> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 812d857..fc09c63 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -465,7 +465,7 @@ contain all the objects that the server will need to complete the new
>  references.

All changes to this file are good.

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 68978f5..7147519 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3164,7 +3164,7 @@ objects.  (Note that linkgit:git-tag[1] can also be used to create
>  "lightweight tags", which are not tag objects at all, but just simple
>  references whose names begin with `refs/tags/`).
>  
> -[[pack-files]]
> +[[packfiles]]

Isn't this a xref target?  Can you change it without changing all
the referrers?


In any case, after doing the above two side notes, I am not sure if
readers would appreciate our careful choice of words between
"packfile" and "pack-file" when they read the documentation.
