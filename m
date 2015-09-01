From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport: add commandline option --series <file>
Date: Tue, 01 Sep 2015 11:16:30 -0700
Message-ID: <xmqqa8t6ron5.fsf@gitster.mtv.corp.google.com>
References: <1441022798-6033-1-git-send-email-juerg.haefliger@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Juerg Haefliger <juerg.haefliger@hp.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 20:16:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWq6o-0000JZ-Av
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbbIASQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:16:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32849 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbbIASQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:16:33 -0400
Received: by padan5 with SMTP id an5so3579624pad.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=siFrzpKKhNC0XWQJU3tdqfm+5WwcSDZjMbZEFN3IkAc=;
        b=AoamoLhxJ+iNvZIR0pcFiNNixLu0qpfWwZ+rhhKBwHZRD5Xb7e6ET8AnNrAdZPgWI9
         Qtrn96861wYAggXJbSIWbj8xcLcF5/7/78eTgnt7kebgtozRdT7bconhr+yL50t3JDFC
         CUSq9p5WnOsKKofa07Jd2kO/gUuaE6HAFgf46l1vvz25GmALYkdi29MN7YBpxqPBOYL4
         lrL7Uh6HV/NYfL/dFHXt4xraXRbg9QeWn/VP9SHIMu/nCw0l8VneOBBpHKQCixYHVKCB
         TMoseMmGoOW2jIEZp6fe2bkSkdcBGWQ3TG4GTdrTTcP3A3Da9b0k9XhruShwSuBxkFOr
         tzOA==
X-Received: by 10.66.65.234 with SMTP id a10mr55889405pat.2.1441131392623;
        Tue, 01 Sep 2015 11:16:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id v6sm18945495pdp.18.2015.09.01.11.16.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 11:16:31 -0700 (PDT)
In-Reply-To: <1441022798-6033-1-git-send-email-juerg.haefliger@hp.com> (Juerg
	Haefliger's message of "Mon, 31 Aug 2015 14:06:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277006>

Juerg Haefliger <juerg.haefliger@hp.com> writes:

> The quilt series file doesn't have to be located in the same directory
> with the patches and can be named differently than 'series' as well. This
> patch adds a commandline option to allow for a non-standard series
> filename and location.
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@hp.com>
> ---
>  Documentation/git-quiltimport.txt | 11 +++++++++--
>  git-quiltimport.sh                | 16 ++++++++++++++--
>  2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
> index d64388c..ff633b0 100644
> --- a/Documentation/git-quiltimport.txt
> +++ b/Documentation/git-quiltimport.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
> +		[--series <file>]
>  
>  
>  DESCRIPTION
> @@ -42,13 +43,19 @@ OPTIONS
>  	information can be found in the patch description.
>  
>  --patches <dir>::
> -	The directory to find the quilt patches and the
> -	quilt series file.
> +	The directory to find the quilt patches.
>  +
>  The default for the patch directory is patches
>  or the value of the $QUILT_PATCHES environment
>  variable.
>  
> +--series <file>::
> +	The quilt series file.
> ++
> +The default for the series file is <patches>/series
> +or the value of the $QUILT_SERIES environment
> +variable.
> +

Makes sense.

I am not a quilt user, but the Internet finds pages like
http://lists.gnu.org/archive/html/quilt-dev/2009-12/msg00021.html
and http://www.man-online.org/page/1-quilt/, both of which tell me
that QUILT_SERIES is an environment variable that has established
meaning, and the new use in this patch is consistent with the
established practice.

Thanks, will apply.

>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index 167d79f..6d3a88d 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -6,7 +6,8 @@ git quiltimport [options]
>  --
>  n,dry-run     dry run
>  author=       author name and email address for patches without any
> -patches=      path to the quilt series and patches
> +patches=      path to the quilt patches
> +series=       path to the quilt series file
>  "
>  SUBDIRECTORY_ON=Yes
>  . git-sh-setup
> @@ -27,6 +28,10 @@ do
>  		shift
>  		QUILT_PATCHES="$1"
>  		;;
> +	--series)
> +		shift
> +		QUILT_SERIES="$1"
> +		;;
>  	--)
>  		shift
>  		break;;
> @@ -53,6 +58,13 @@ if ! [ -d "$QUILT_PATCHES" ] ; then
>  	exit 1
>  fi
>  
> +# Quilt series file
> +: ${QUILT_SERIES:=$QUILT_PATCHES/series}
> +if ! [ -e "$QUILT_SERIES" ] ; then
> +	echo "The \"$QUILT_SERIES\" file does not exist."
> +	exit 1
> +fi
> +
>  # Temporary directories
>  tmp_dir="$GIT_DIR"/rebase-apply
>  tmp_msg="$tmp_dir/msg"
> @@ -135,5 +147,5 @@ do
>  		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
>  		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
>  	fi
> -done 3<"$QUILT_PATCHES/series"
> +done 3<"$QUILT_SERIES"
>  rm -rf $tmp_dir || exit 5
