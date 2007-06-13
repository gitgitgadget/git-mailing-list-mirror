From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: [PATCH] Add a guilt-export(1) command to export a guilt series to quilt.
Date: Wed, 13 Jun 2007 08:10:36 -0700
Message-ID: <1621f9fa0706130810n17bc3f67h1c539d75b3aed4ed@mail.gmail.com>
References: <1181743313509-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>, git@vger.kernel.org
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUUd-0000SY-Hi
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653AbXFMPKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758617AbXFMPKi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:10:38 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:53190 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758312AbXFMPKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:10:37 -0400
Received: by nz-out-0506.google.com with SMTP id n1so248522nzf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 08:10:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MLIaxR6GNlOaQlR2b8Bz+9Z3XImUVkxKlc6AeaRUNjYCgsyjmpMtLsQ64/6Q8ZNWZtcV4HeAf8A3Z9L+wwjbhzWqVFkr2egLheZuzIjFgD/ItFPLgfexnuloUIpj/PdV7twVEWUCypcYgAwwyLSO+ERwavURbKKB7xW1AvbDkLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RsCfRsJ84VsKjssRYxgtPnui08+9cAQZOOSK+RjG8tepE4Y6JgVcCCxWBXEGwGo5FZLYJG5G3ahsB+QwZuCitmJmAwUKKYQMQ59AEIj5j6ZlQTlJ07H8SagvvkmJ1LmaIreFpM9HN2qMVVZuGIzQTwXmobnlI2qU3pIej3l2C3U=
Received: by 10.142.79.15 with SMTP id c15mr35570wfb.1181747436123;
        Wed, 13 Jun 2007 08:10:36 -0700 (PDT)
Received: by 10.142.108.1 with HTTP; Wed, 13 Jun 2007 08:10:36 -0700 (PDT)
In-Reply-To: <1181743313509-git-send-email-madcoder@debian.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50074>

For the shebang:
#!/usr/bin/env bash
should works well and should work on non-linux boxes that did not
added a link in /bin/bash.

My 2 cents.

On 6/13/07, Pierre Habouzit <madcoder@debian.org> wrote:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  Documentation/guilt-export.txt |   30 ++++++++++++++++++++++++++++++
>  guilt-export                   |   26 ++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/guilt-export.txt
>  create mode 100755 guilt-export
>
> diff --git a/Documentation/guilt-export.txt b/Documentation/guilt-export.txt
> new file mode 100644
> index 0000000..b7b0a4b
> --- /dev/null
> +++ b/Documentation/guilt-export.txt
> @@ -0,0 +1,30 @@
> +guilt-export(1)
> +===============
> +
> +NAME
> +----
> +guilt-export - Export a patch series (to be used by quilt)
> +
> +SYNOPSIS
> +--------
> +include::usage-guilt-export.txt[]
> +
> +DESCRIPTION
> +-----------
> +Export a guilt series to be used by quilt.
> +
> +OPTIONS
> +-------
> +<target_dir>::
> +        Name of the directory to export the patch series to.
> +        (defaults to patches).
> +
> +Author
> +------
> +Written by Pierre Habouzit <madcoder@debian.org>
> +
> +Documentation
> +-------------
> +Documentation by Pierre Habouzit <madcoder@debian.org>
> +
> +include::footer.txt[]
> diff --git a/guilt-export b/guilt-export
> new file mode 100755
> index 0000000..9ff9924
> --- /dev/null
> +++ b/guilt-export
> @@ -0,0 +1,26 @@
> +#!/bin/bash
> +#
> +# Copyright (c) Pierre Habouzit, 2007
> +#
> +
> +USAGE="[<target_dir>]"
> +. guilt
> +
> +if [ $# -gt 1 ]; then
> +       usage
> +fi
> +target_dir=${1:-"patches"}
> +
> +if [ -e "$target_dir" ]; then
> +       die "Specified directory already exists"
> +fi
> +
> +trap "rm -rf \"$target_dir\"" 0
> +mkdir -p "$target_dir"
> +
> +get_series | tee "$target_dir/series" | while read p; do
> +       cp "$GUILT_DIR/$branch/$p" "$target_dir/$p"
> +done
> +
> +trap - 0
> +echo "Series exported to \"$target_dir\" sucessfully."
> --
> 1.5.2.1
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
