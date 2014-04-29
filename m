From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 8/8] remote-hg: trivial cleanups
Date: Tue, 29 Apr 2014 23:06:58 +0100
Organization: OPDS
Message-ID: <9374D3886766421BAA17E07C62F256DB@PhilipOakley>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com> <1398762275-346-9-git-send-email-felipe.contreras@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGB4-0005G2-Oh
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbaD2WG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:06:58 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:62605 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933881AbaD2WG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 18:06:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnYZAGshYFNZ8YTM/2dsb2JhbABZgwZPiHm1JxuHLwQBAQIBAYEjF3SCIAUBAQQBCAEBLhYIAQEhBQYCAwUCAQMVAgolFAEECBACBgcPCAYBBwsIAgECAwEMBIgMAwkMCat4lxMNhnKMOIE1EQFQDYMegRUEiTqGMYc1gyyLUYVVgzI8gTU
X-IPAS-Result: AnYZAGshYFNZ8YTM/2dsb2JhbABZgwZPiHm1JxuHLwQBAQIBAYEjF3SCIAUBAQQBCAEBLhYIAQEhBQYCAwUCAQMVAgolFAEECBACBgcPCAYBBwsIAgECAwEMBIgMAwkMCat4lxMNhnKMOIE1EQFQDYMegRUEiTqGMYc1gyyLUYVVgzI8gTU
X-IronPort-AV: E=Sophos;i="4.97,953,1389744000"; 
   d="scan'208";a="610605992"
Received: from host-89-241-132-204.as13285.net (HELO PhilipOakley) ([89.241.132.204])
  by out1.ip06ir2.opaltelecom.net with SMTP; 29 Apr 2014 23:06:55 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247623>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: [PATCH 8/8] remote-hg: trivial cleanups

It's useful, as a reader of the shortlog and email message subject 
lines, to know what sort of triviality is being tidied.
Usually they are 'spelling' or 'variable naming' or some such that can 
easily be squeezed on the end without breaking the ~50 char guide. In 
this case there were two types, so I ended up with this suggestion for 
the message heading

    remote-hg: cleanup 40*{0} string, and de-dup tests

which adds just enough (for me) to get a feel for the style of what's 
inside

regards

Philip

> Cleanup 51be46e (remote-hg: do not fail on invalid bookmarks).
>
> Having a 40-characters string is not ideal, and having three tests for
> basically the same relatively rare situation is overkill.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> git-remote-hg.py     |  2 +-
> t/t5810-remote-hg.sh | 56 
> ++++------------------------------------------------
> 2 files changed, 5 insertions(+), 53 deletions(-)
>
> diff --git a/git-remote-hg.py b/git-remote-hg.py
> index 402b92f..74f2a2e 100755
> --- a/git-remote-hg.py
> +++ b/git-remote-hg.py
> @@ -677,7 +677,7 @@ def do_list(parser):
>             print "? refs/heads/branches/%s" % gitref(branch)
>
>     for bmark in bmarks:
> -        if  bmarks[bmark].hex() == 
> '0000000000000000000000000000000000000000':
> +        if  bmarks[bmark].hex() == '0' * 40:
>             warn("Ignoring invalid bookmark '%s'", bmark)
>         else:
>             print "? refs/heads/%s" % gitref(bmark)
> diff --git a/t/t5810-remote-hg.sh b/t/t5810-remote-hg.sh
> index ba8b2d8..9946f57 100755
> --- a/t/t5810-remote-hg.sh
> +++ b/t/t5810-remote-hg.sh
> @@ -772,7 +772,7 @@ test_expect_success 'remote double failed push' '
>  )
> '
>
> -test_expect_success 'clone remote with master null bookmark, then 
> push to the bookmark' '
> +test_expect_success 'clone remote with null bookmark, then push' '
>  test_when_finished "rm -rf gitrepo* hgrepo*" &&
>
>  hg init hgrepo &&
> @@ -781,67 +781,19 @@ test_expect_success 'clone remote with master 
> null bookmark, then push to the bo
>  echo a >a &&
>  hg add a &&
>  hg commit -m a &&
> - hg bookmark -r null master
> + hg bookmark -r null bookmark
>  ) &&
>
>  git clone "hg::hgrepo" gitrepo &&
>  check gitrepo HEAD a &&
>  (
>  cd gitrepo &&
> - git checkout --quiet -b master &&
> - echo b >b &&
> - git add b &&
> - git commit -m b &&
> - git push origin master
> - )
> -'
> -
> -test_expect_success 'clone remote with default null bookmark, then 
> push to the bookmark' '
> - test_when_finished "rm -rf gitrepo* hgrepo*" &&
> -
> - hg init hgrepo &&
> - (
> - cd hgrepo &&
> - echo a >a &&
> - hg add a &&
> - hg commit -m a &&
> - hg bookmark -r null -f default
> - ) &&
> -
> - git clone "hg::hgrepo" gitrepo &&
> - check gitrepo HEAD a &&
> - (
> - cd gitrepo &&
> - git checkout --quiet -b default &&
> - echo b >b &&
> - git add b &&
> - git commit -m b &&
> - git push origin default
> - )
> -'
> -
> -test_expect_success 'clone remote with generic null bookmark, then 
> push to the bookmark' '
> - test_when_finished "rm -rf gitrepo* hgrepo*" &&
> -
> - hg init hgrepo &&
> - (
> - cd hgrepo &&
> - echo a >a &&
> - hg add a &&
> - hg commit -m a &&
> - hg bookmark -r null bmark
> - ) &&
> -
> - git clone "hg::hgrepo" gitrepo &&
> - check gitrepo HEAD a &&
> - (
> - cd gitrepo &&
> - git checkout --quiet -b bmark &&
> + git checkout --quiet -b bookmark &&
>  git remote -v &&
>  echo b >b &&
>  git add b &&
>  git commit -m b &&
> - git push origin bmark
> + git push origin bookmark
>  )
> '
>
> -- 
> 1.9.2+fc1.3.gade8541
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
