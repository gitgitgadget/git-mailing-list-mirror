From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a
 shallow clone
Date: Sat, 13 Jul 2013 14:25:41 -0700
Message-ID: <20130713212541.GA10951@google.com>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 23:26:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy7KU-0008DO-0S
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 23:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab3GMVZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jul 2013 17:25:50 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:34878 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab3GMVZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 17:25:49 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so10133320pbc.10
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5AyU1kyhqURKzCX8/ujWLgSGDh2W5+aJTieUWlx7lWE=;
        b=0K1gXd/Z7FGeJowpvDAUz1XnXYFcaOcoWL3ukVdSqVpXsH8R/0cc+RwqM/bSqZvdrV
         fJhV9suViBu3SOKOFmnUiuuszS12Si2utsf2FhOszgcOnzx4FEOIgqLkz8+P44ew0QW+
         Sj0hZPthdu3r4KfpVA8iCzaFMPfRlGmhsz5mDD1tNRb+D6RSvZtRwE89y29sYqPb6Rfv
         vu9n2/8BfbSJNeyiEUbT19VMaccVMLqyVVnqsrhTi0U8lLtYUYo2Y5ld5mwj8ihy4u+y
         D+QepZggv6D2KyoHv1PiYl5cbKAUBai+gzR4cOW8Ua6sZNMuNJYCTJKNHP08kKyNwKgz
         yHpQ==
X-Received: by 10.68.6.97 with SMTP id z1mr39909984pbz.3.1373750749286;
        Sat, 13 Jul 2013 14:25:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qv4sm52352484pbc.16.2013.07.13.14.25.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 14:25:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230294>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Since 52fed6e (receive-pack: check connectivity before concluding "gi=
t
> push" - 2011-09-02), receive-pack is prepared to deal with broken
> push, a shallow push can't cause any corruption. Update the document
> to reflect that.

Hmm, what happens when pushing to servers without that commit?  Do you
think it should be applied to Debian squeeze for server operators that
haven't upgraded yet to the current stable release?

[...]
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -182,11 +182,13 @@ objects from the source repository into a pack =
in the cloned repository.
>  --depth <depth>::
>  	Create a 'shallow' clone with a history truncated to the
>  	specified number of revisions.  A shallow repository has a
> -	number of limitations (you cannot clone or fetch from
> -	it, nor push from nor into it), but is adequate if you
> -	are only interested in the recent history of a large project
> -	with a long history, and would want to send in fixes
> -	as patches.
> +	number of limitations (you cannot clone or fetch from it, nor
> +	push into it), but is adequate if you are only interested in
> +	the recent history of a large project with a long history.
> ++
> +Pushing from a shallow clone should be avoided if the git version on
> +the receiver end is older than v1.7.10, or any other git
> +implementation that does not perform connectivity check.

"git name-rev --tags" tells me 52fed6e was applied during 1.7.8-rc0,
so it might make sense to s/1.7.10/1.7.8/ here.

Aside from that nit,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan
