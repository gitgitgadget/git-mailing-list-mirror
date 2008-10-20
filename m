From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 4/5] gitweb: parse parent..current syntax from PATH_INFO
Date: Mon, 20 Oct 2008 11:18:43 +0200
Message-ID: <200810201118.44654.jnareb@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 17:18:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrsLU-0004CU-Gd
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 12:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYJTKtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 06:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbYJTKta
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 06:49:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:62064 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYJTKt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 06:49:29 -0400
Received: by ey-out-2122.google.com with SMTP id 6so539983eyi.37
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zbQ8vEBE/w6+dXEwLrUq4jT6c0BpLA2e/wY3cc7vVvU=;
        b=Y2xa/r03IejXlSKM9j8kksRdVoTp6mCn4tflnxqbGn6tnfgjq3WQCszVICrhMiWqHo
         IBSZefqvGpbyM92KZF9ziiE6et6JhAavDWtZb2VqqgrFEANIkyA6ix59vXbdBVnnwFWJ
         x1U5JIgKVFYvgSVWmVIZEV1xQmKLDRVeNBZpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bw4f6RDXshGO91eJ5z4IaktpsIpZm5PhGZ7hvezxl5AP40HyLJXuMgX1Z5uxOGOFkF
         J3PifqE0EI5/EFFvpuvKhw0rvc3gIs3CMjf8I8JrHh/axd9MT5rVamDalSqo5yBVadAp
         mzzHUDkfmB7T1Q5f+/+CdotgXY11FW3AaXDx8=
Received: by 10.210.65.17 with SMTP id n17mr1962574eba.148.1224499768070;
        Mon, 20 Oct 2008 03:49:28 -0700 (PDT)
Received: from ?192.168.1.11? (abwi157.neoplus.adsl.tpnet.pl [83.8.232.157])
        by mx.google.com with ESMTPS id h1sm5843060nfh.19.2008.10.20.03.49.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 03:49:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1224188831-17767-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98673>

On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:

> This patch makes it possible to use an URL such as
> $project/somebranch..otherbranch:/filename to get a diff between
> different version of a file. Paths like
> $project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
> as well.

Just a nitpick: why '$project' and '$action', but 'somebranch',
'otherbranch' and 'filename'?

> 
> All '*diff' actions and in general actions that use $hash_parent[_base]
> and $file_parent can now get all of their parameters from PATH_INFO

Which currently mean 'shortlog', and I guess in the future would mean
also all other log-like views: 'log', 'history', 'search' (the commit
message kind, not the pickaxe kind), and perhaps also 'rss'/'atom'.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

For what is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   36 ++++++++++++++++++++++++++++++++++--
>  1 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 49730f3..1a7b0b9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -548,7 +548,12 @@ sub evaluate_path_info {
>  		'history',
>  	);
>  
> -	my ($refname, $pathname) = split(/:/, $path_info, 2);
> +	# horrible regexp to catch
> +	# [$hash_parent_base[:$file_parent]..]$hash_parent[:$file_name]

This comment is really nice here, to explain what we try to catch.
Is it really "horrible"... let others decide.

Note: this (as also previous code) makes use of the fact that refname
cannot contain ':' as per git-check-ref-format(1), and the fact that
gitweb limits $hash* parameters to simple revision syntax, allowing
only SHA1 and refnames, and not allowing (see validate_refname() used
in $hash* validation) extended SHA1 syntax like <commit-ish>:<path>
for $hash ('h') param for 'blob' view: gitweb uses $hash_base and
$file_name for that.

(But I guess it is too long explanation to put it in comment)


Side note: the regexp below allow for $parentpathname to contain
'..', but we don't want to rely on such minute detail of implementation
detail (because it depends on whether we use greedy or non-greedy
matching there).

> +	my ($parentrefname, $parentpathname, $refname, $pathname) =
> +		($path_info =~ /^(?:(.+?)(?::(.+))?\.\.)?(.+?)(?::(.+))?$/);
> +
> +	# first, analyze the 'current' part
>  	if (defined $pathname) {
>  		# we got "branch:filename" or "branch:dir/"
>  		# we could use git_get_type(branch:pathname), but it needs $git_dir
> @@ -557,7 +562,13 @@ sub evaluate_path_info {
>  			$input_params{'action'} ||= "tree";
>  			$pathname =~ s,/$,,;
>  		} else {
> -			$input_params{'action'} ||= "blob_plain";
> +			# the default action depends on whether we had parent info
> +			# or not
> +			if ($parentrefname) {
> +				$input_params{'action'} ||= "blobdiff_plain";
> +			} else {
> +				$input_params{'action'} ||= "blob_plain";
> +			}

Nice.

I was wondering about 'project/hash_parent..hash' syntax, but then I have
realized that it doesn't change action (as in 'blob_plain' -> 'blobdiff_plain'),
but is always 'shortlog'.

By the way, I wonder if it should be 'blobdiff_plain' or just 'blobdiff'.
the 'blob_plain' was here to use gitweb as a kind of versioned web
server; there is no such equivalent for 'p/hbp..hb:f' syntax. On the
other hand it is consistent behavior, always using *_plain...

>  		}
>  		$input_params{'hash_base'} ||= $refname;
>  		$input_params{'file_name'} ||= $pathname;
> @@ -577,6 +588,27 @@ sub evaluate_path_info {
>  			$input_params{'hash'} ||= $refname;
>  		}
>  	}
> +
> +	# next, handle the 'parent' part, if present
> +	if (defined $parentrefname) {
> +		# a missing pathspec defaults to the 'current' filename, allowing e.g.
> +		# someproject/blobdiff/oldrev..newrev:/filename
> +		if ($parentpathname) {
> +			$parentpathname =~ s,^/+,,;
> +			$parentpathname =~ s,/$,,;

Hmmm... should we strip trailing '/' here?

> +			$input_params{'file_parent'} ||= $parentpathname;
> +		} else {
> +			$input_params{'file_parent'} ||= $input_params{'file_name'};
> +		}
> +		# we assume that hash_parent_base is wanted if a path was specified,
> +		# or if the action wants hash_base instead of hash

Nice comment.

> +		if (defined $input_params{'file_parent'} ||
> +			grep {$input_params{'action'} eq $_} @wants_base) {

My preference of style would be to use here:

+		    grep { $input_params{'action'} eq $_ } @wants_base) {

> +			$input_params{'hash_parent_base'} ||= $parentrefname;
> +		} else {
> +			$input_params{'hash_parent'} ||= $parentrefname;
> +		}
> +	}
>  }
>  evaluate_path_info();
>  
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
