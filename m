From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Why is git-subtree docs XML and not HTML?
Date: Tue, 29 Oct 2013 17:03:53 +0100
Message-ID: <CAHGBnuNDBH-V+Ebi27BOE8ebNQdhn+MCvabh97_zL3nTctz4yA@mail.gmail.com>
References: <CAHGBnuO1xPrAFG1tvS5zaVD9yefa2VUNYM93YLt1pQ1yJwHkrw@mail.gmail.com>
	<20131029155037.GA3628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: greened@obbligato.org, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 17:04:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbBlv-0006M6-FR
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 17:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab3J2QDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 12:03:55 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:50857 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab3J2QDz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 12:03:55 -0400
Received: by mail-la0-f44.google.com with SMTP id ep20so51584lab.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aYKrPrx7Ov/0dYXfZfIVSVCgm4LgUbXbOxUiH5WW4lA=;
        b=SYnauUQeMwo5LuY0XgxICmReejZ6IQyX2s3BdguK7fU+Kk2X19NrUfF9lG9fODA7Ch
         0qHD84OnCV2R5Pt5NHLlxSilZdd7emrC1Z7kMu3WuGjnPJWXbm99eovLyqCe9Oa1J0p3
         vaJGW3iu2UTLPDgVTHjt+haQXGu+i4hwWxMLxHw0h+KWWd+8rbsi1Ya5qRpfQ4qztUhH
         sj/ISfBO0ZsmwQxdFN4smVUGFmVgGPJ1+T5tIxGANJmNv4DJFjiJk044ORsIoCjKbawu
         uEypkkZXAKoBUyNu/Z5UMlfn+plxlx6vkbiVc+eI4b/fhQXZJXoJ2PINnc9UwBfY9257
         Jdpg==
X-Received: by 10.112.143.166 with SMTP id sf6mr539732lbb.29.1383062633536;
 Tue, 29 Oct 2013 09:03:53 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 29 Oct 2013 09:03:53 -0700 (PDT)
In-Reply-To: <20131029155037.GA3628@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236933>

On Tue, Oct 29, 2013 at 4:50 PM, Jeff King <peff@peff.net> wrote:

> I think this would do what you want:
>
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 435b2de..e9026da 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -21,6 +21,7 @@ GIT_SUBTREE    := git-subtree
>  GIT_SUBTREE_DOC := git-subtree.1
>  GIT_SUBTREE_XML := git-subtree.xml
>  GIT_SUBTREE_TXT := git-subtree.txt
> +GIT_SUBTREE_HTML := git-subtree.html
>
>  all: $(GIT_SUBTREE)
>
> @@ -46,6 +47,10 @@ $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
>         asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) \
>                 -agit_version=$(gitver) $^
>
> +$(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
> +       asciidoc -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
> +               -agit_version=$(gitver) $^
> +
>  test:
>         $(MAKE) -C t/ test
>

I just gave it a try and it works nicely:

Tested-by: Sebastian Schuberth <sschuberth@gmail.com>

Also, the clean target already contains "*.html", so nothing else to
do there. Any chance to get this queued in pu?

Thanks a lot!

-- 
Sebastian Schuberth
