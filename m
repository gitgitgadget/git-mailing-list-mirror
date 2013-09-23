From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 8/9] transport-helper: add support to delete branches
Date: Sun, 22 Sep 2013 21:50:49 -0400
Message-ID: <523F9E79.8070602@bbn.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com> <1377789808-2213-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 03:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNvIg-0004ur-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 03:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab3IWBuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 21:50:55 -0400
Received: from smtp.bbn.com ([128.33.1.81]:17510 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061Ab3IWBuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 21:50:54 -0400
Received: from socket.bbn.com ([192.1.120.102]:42995)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VNvIZ-00095W-Pk; Sun, 22 Sep 2013 21:50:51 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0516F3FF4D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1377789808-2213-9-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235177>

On 2013-08-29 11:23, Felipe Contreras wrote:
> For remote-helpers that use 'export' to push.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t5801-remote-helpers.sh |  8 ++++++++
>  transport-helper.c        | 11 ++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
[...]
> diff --git a/transport-helper.c b/transport-helper.c
> index c7135ef..5490796 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -844,18 +844,19 @@ static int push_refs_with_export(struct transport *transport,
>  		}
>  		free(private);
>  
> -		if (ref->deletion)
> -			die("remote-helpers do not support ref deletion");
> -

The above deleted lines actually appear twice in transport-helper.c due
to an incorrect merge conflict resolution in
99d9ec090677c925c534001f01cbaf303a31cb82.  The other copy of those lines should
also be deleted:

diff --git a/transport-helper.c b/transport-helper.c
index 859131f..bbf4e7c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -874,9 +874,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];

-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
