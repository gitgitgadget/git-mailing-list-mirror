From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Commit 7c5977297f07c2a52c8c0f486309076b2a795d33 appears to have
 broken cg-init
Date: Mon, 11 Jul 2005 00:01:55 -0400
Message-ID: <42D1EF33.2070000@gmail.com>
References: <20050711015820.GA16618@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 06:03:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrpW3-0000Vs-Kc
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 06:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVGKEDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 00:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVGKEDI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 00:03:08 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:35895 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262222AbVGKEB4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 00:01:56 -0400
Received: by zproxy.gmail.com with SMTP id x3so366111nze
        for <git@vger.kernel.org>; Sun, 10 Jul 2005 21:01:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mBL/zlHGsoX/K1Szh3MYd6e4rgs9KKO6VPOlhcRxuVCriJMpiDyoUnf1OaTq8CAr7ZoS77LolnD/UKqW7OG+BsLfA3fYlqUj4KTHam6ipVak9UimtIYb+KH/dGTuHEAaDQZclBvc2lSJc0hdub5UorYKt9KxWjyzwncTa3wAgow=
Received: by 10.36.46.6 with SMTP id t6mr949070nzt;
        Sun, 10 Jul 2005 21:01:56 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 18sm1854836nzo.2005.07.10.21.01.56;
        Sun, 10 Jul 2005 21:01:56 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20050711015820.GA16618@ca-server1.us.oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Yes, I meant to use $ARGS.  I included the fix in the patchset I just sent.

Sorry,
Bryan


Joel Becker wrote:
> Petr,
> 	Commit 7c5977297f07c2a52c8c0f486309076b2a795d33 contains the
> chunk:
> 
> -uri=$1
> +
> +infoonly=
> +while optparse; do
> +	if optparse -N; then
> +		infoonly=-N
> +	else
> +		optfail
> +	fi
> +done
> +
> +uri=$ARGV
> 
> 	However, $ARGV is not a variable I've ever seen supported in a
> Bourne-like shell.  Certainly Bash supports BASH_ARGV, but not ARGV.
> 	The recent option parsing code adds ARGS in cg-Xlib, but not
> ARGV.
> 	The upshot is that a cg-clone/cg-init attempt thinks $uri is
> empty, and always creates an initial commit.  No clone.  I don't know
> how folks have gotten cg-clone rsync://linus to work since this change
> went in.
> 	I don't know what the proper solution is with the modern option
> code, but changing it back to 'url=$1' allows me to grab Linus' tree.
> 
> Joel
