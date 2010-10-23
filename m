From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in
 git-status
Date: Sat, 23 Oct 2010 13:13:50 -0500
Message-ID: <20101023181350.GA21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9ifA-00009E-4w
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124Ab0JWSRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:17:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45997 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531Ab0JWSRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:17:43 -0400
Received: by gyg4 with SMTP id 4so1337339gyg.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8hzI0WmjDs3RMRdUK7yYLYYG+H0iigCb2hJuZQUpFCo=;
        b=dpnIsw1zopPma/TSEyqjDf9nGJs/qVHPHSnW/RVYwfK3LOjmV8IwQI3kUBceMk1ZQh
         CipKsttIbsxij8g7C1KG+zRmOwl3DJ41Kdc4LDqFjI1KVSXQKh6RVsh1GrTWR2FVZP51
         KodbojDdQNma/fknnzmvGSpgybjT1iKshCRUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OJPuJ89gEgNj6S096d9aTl2yzRwACjTeEhIJdKLzKFP1IQcejO5c3aiahUjL2DQEAq
         AwPiX3POVu1V70vHaEraJZQyqLxLFeKFKC2rtSHMCkQsSpcBk3OJDnhyNG6M5pf/fYb9
         fckKi3qna6/PuvLr5hk7ojJS6zTFW7HjD5rnA=
Received: by 10.150.57.5 with SMTP id f5mr4439716yba.411.1287857862341;
        Sat, 23 Oct 2010 11:17:42 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v12sm4720263ybk.23.2010.10.23.11.17.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:17:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-2-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159805>

Matthieu Moy wrote:

> --- a/Documentation/gittutorial-2.txt
> +++ b/Documentation/gittutorial-2.txt
> @@ -373,7 +373,7 @@ $ git status
>  #
>  #       new file: closing.txt
>  #
> -# Changed but not updated:
> +# Changed but not staged for commit:
>  #   (use "git add <file>..." to update what will be committed)

I find this even more confusing, though I admit that may be due to
habit more than anything else.

My reading, before:

	These files were changed, but the version to be committed has
	not been updated to include the latest changes (use "git add
	<file>..." to add these changes to the index).

Afterwards:

	These files were changed, but they are not staged for the
	next commit.

If I do

	echo hello >hi.c
	git add hi.c
	echo world >>hi.c
	git status

then what does it mean to say "hi.c" is not staged for commit?
It actually does have changes ready for committing.

I would prefer to say something to the effect of

	# Has unstaged changes:

Anyone wordsmiths out there with ideas to make this clearer?
