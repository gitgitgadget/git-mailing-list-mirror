From: Delcypher <delcypher@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Mon, 24 Mar 2014 15:07:41 +0000
Message-ID: <CANNJ_zg10oMjwL-0j0XVAEmqgQU1fLsr6GYbKSRVApqgKrYvMQ@mail.gmail.com>
References: <53076DFC.1000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 16:07:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS6Tb-0006G4-IY
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 16:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbaCXPHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 11:07:42 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:33529 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbaCXPHl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 11:07:41 -0400
Received: by mail-vc0-f171.google.com with SMTP id lg15so5877142vcb.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8O+Yd8z95h9/KsnNguK4DRgQzPC696buNJQbXSNC2t4=;
        b=mbU1oDEKLDBxFvf9Hd+oRo+PTIur0Dr3Yd9qcguj6LkKC/2Wa6qesTgSc0+ENiGQNG
         jUBY8OSBux5hdf4gapBoRq5bL9c3c89zl730D8FrqGDHyKeVIWmQAqQsuoaavlIGu+Yj
         S6pELea6izMOABv7RJ6PROv0CmMSaJHKpYITk0cmo7THOjoHdRygfciHL3HYP2H21yGp
         aEB761IbDTwgZ8Zca2v4FpHPfZ4n52Oe22BoLbBnzNLd6/XPWc9OEONuL2eq+FzXwr9d
         p7yZ5zFa87GAf64J7Vu+2z7xOAzyx88x7qSM3tsomfr6sK657pG1v8aDMasDxEiscnOD
         2+lg==
X-Received: by 10.221.29.137 with SMTP id ry9mr51091256vcb.6.1395673661119;
 Mon, 24 Mar 2014 08:07:41 -0700 (PDT)
Received: by 10.220.88.66 with HTTP; Mon, 24 Mar 2014 08:07:41 -0700 (PDT)
In-Reply-To: <53076DFC.1000602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244823>

ping.

On 21 February 2014 15:17, Daniel Liew <delcypher@gmail.com> wrote:
> git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
>
> Use the hgrc configuration file in the internal mercurial repository in
> addition to the other system wide hgrc files. This is done by using the
> 'ui' object from the 'repository' object which will have loaded the
> repository hgrc file if it exists.
>
> Prior to this patch the mercurial repository's hgrc file was ignored
> which I consider to be a bug.
>
> Signed-off-by: Dan Liew <delcypher@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg
> b/contrib/remote-helpers/git-remote-hg
> index eb89ef6..451842a 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -421,7 +421,7 @@ def get_repo(url, alias):
>
>          repo = hg.repository(myui, local_path)
>          try:
> -            peer = hg.peer(myui, {}, url)
> +            peer = hg.peer(repo._unfilteredrepo.ui, {}, url)
>          except:
>              die('Repository error')
>          repo.pull(peer, heads=None, force=True)
> --
> 1.9.0
>
>
