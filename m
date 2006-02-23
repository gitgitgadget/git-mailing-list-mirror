From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Prevent git-upload-pack segfault if object cannot be found
Date: Thu, 23 Feb 2006 01:34:00 +0100
Message-ID: <20060223003400.GA27800@diku.dk>
References: <20060222181758.GH3355@andrew-vasquezs-powerbook-g4-15.local> <87bqwzs07h.wl%cworth@cworth.org> <7vr75vmcod.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 01:34:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC4Qs-0000WU-No
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 01:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWBWAeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 19:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWBWAeE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 19:34:04 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:39123 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932354AbWBWAeD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2006 19:34:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 58369770023;
	Thu, 23 Feb 2006 01:34:02 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14447-08; Thu, 23 Feb 2006 01:34:00 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C70F477001F;
	Thu, 23 Feb 2006 01:34:00 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7F27B6DF88D; Thu, 23 Feb 2006 01:32:56 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id AA9BB61C4A; Thu, 23 Feb 2006 01:34:00 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr75vmcod.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16626>

Junio C Hamano <junkio@cox.net> wrote Wed, Feb 22, 2006:
> @@ -552,7 +563,9 @@ static void prepare_packed_git_one(char 
>  	len = strlen(path);
>  	dir = opendir(path);
>  	if (!dir) {
> -		fprintf(stderr, "unable to open object pack directory: %s: %s\n", path, strerror(errno));
> +		if (errno != ENOENT)
> +			error("unable to open object pack directory: %s: %s\n",
> +			      path, strerror(errno));

No need for the ending \n.

-- 
Jonas Fonseca
