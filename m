From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Tue, 16 Jul 2013 11:37:09 +0200
Message-ID: <878v16kfqy.fsf@linux-k42r.v.cablecom.net>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	"Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:37:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1h6-0003IJ-O0
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab3GPJhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:37:11 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6868 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166Ab3GPJhK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:37:10 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:37:06 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 16 Jul 2013 11:37:07 +0200
In-Reply-To: <9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Fri, 12 Jul 2013 10:58:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230557>

Thomas Rast <trast@inf.ethz.ch> writes:

> From: "Dale R. Worley" <worley@alum.mit.edu>
>
> open() returns -1 on failure, and indeed 0 is a possible success value
> if the user closed stdin in our process.  Fix the test.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>

I see you have this in 'pu' without Dale's signoff.  I'm guessing
(IANAL) that it's too small to be copyrighted and anyway there is only
way to fix it, but maybe Dale can "sign off" just to be safe, anyway?

>  wrapper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index dd7ecbb..6a015de 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  		template[5] = letters[v % num_letters]; v /= num_letters;
>  
>  		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> -		if (fd > 0)
> +		if (fd >= 0)
>  			return fd;
>  		/*
>  		 * Fatal error (EPERM, ENOSPC etc).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
