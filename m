From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Sat, 5 Jun 2010 14:32:47 -0500
Message-ID: <20100605193247.GA5573@progeny.tock>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100604211811.GA7471@progeny.tock>
 <7v39x1z72z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 21:33:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKz73-0001Zx-JG
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 21:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab0FETcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 15:32:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39360 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab0FETcq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 15:32:46 -0400
Received: by iwn37 with SMTP id 37so2139355iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lKwMSnT7s8YtoC54o2YRBNn3aUVi4DJnkv+2aifZ6fM=;
        b=sv++B/u8bAagvFd29BAoP3uQ2KSdwKL6WCV0wOsR0CLML78Ya9wqD9ZpPtaXWP40xm
         YskJr+I52U2/MmV9+/aONeVq4WRZoBcJu2hIUtzOS9JZlyBPMdiH/mfJ62+5jncWs1BW
         GwNRnFV7luvEppIPjHfkTn0tI+4lixYO158Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=giwkoQLBYvRXhM4QJP4lBNkJQIffgM2hz8ipkS3J3XkZv33YXE/7Pzo/A9G+PF4OH+
         fnYmV8+mBGjNT/TyLlLX9923PH0k8hRZ7fJ5DLndCoH0lHkQFDmAtoILECg2MpKnt2Bv
         ATiOs26Pf7aXKRCN+Yh2I4ILkyxmjCPEN8qkQ=
Received: by 10.231.120.100 with SMTP id c36mr15305265ibr.77.1275766366347;
        Sat, 05 Jun 2010 12:32:46 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm11773913ibf.7.2010.06.05.12.32.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 12:32:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39x1z72z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148488>

Jun 05, 2010 at 11:07:32AM -0700, Junio C Hamano wrote:

> @@ -1582,6 +1583,7 @@ define cmd_munge_script
>  $(RM) $@ $@+ && \
>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>      -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
> +    -e 's|@@DIFF@@|$(DIFF_SQ)|' \
>      -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>      -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
>      -e $(BROKEN_PATH_FIX) \
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 3145009..b86402a 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -107,7 +107,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		# remove lines that are unique to ours.
>  		orig=`git-unpack-file $2`
>  		sz0=`wc -c <"$orig"`
> -		$DIFF -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
> +		@@DIFF@@ -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
>  		sz1=`wc -c <"$orig"`
>  
>  		# If we do not have enough common material, it is not

Looks good to me.  Thanks.
