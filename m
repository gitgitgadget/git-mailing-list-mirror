From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin: t3200-branch.sh fails with "List form of pipe open not implemented at -e line 22."
Date: Mon, 17 Oct 2005 10:40:30 +0200
Message-ID: <81b0412b0510170140r6d5c5f23g87d01ff6cbd0d02e@mail.gmail.com>
References: <81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com>
	 <434FF189.3080806@zytor.com> <20051015211808.GA3497@steel.home>
	 <7vbr1peweu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 10:42:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERQYK-0003cf-P1
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 10:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVJQIkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 04:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVJQIkc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 04:40:32 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:55875 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932213AbVJQIkc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 04:40:32 -0400
Received: by nproxy.gmail.com with SMTP id n15so391747nfc
        for <git@vger.kernel.org>; Mon, 17 Oct 2005 01:40:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Snnkc3EnsWPgUS+P/+/xe7CsKSmr/VuhBf94tnM9c49d2vIprcnBaJ42ejnO+NmIB5fOjz4LY05WbS7e1PLqbNBpFYAsE0v7jOPlYr7iVNrXMklbdKp8WPJ7/Y1Emi5szw8AWFrjf1kOtS6V5k/jfLQVBHejBTHdcHjXM2wPnks=
Received: by 10.49.2.8 with SMTP id e8mr76569nfi;
        Mon, 17 Oct 2005 01:40:30 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Mon, 17 Oct 2005 01:40:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr1peweu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10182>

On 10/16/05, Junio C Hamano <junkio@cox.net> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
> >> >The message comes from one of the hooks, which are executed even
> >> >though they never meant to, because cygwin apparently uses file
> >> >content or name to detect executability (on FAT).
>
> Is this one of the hooks we ship as examples?  If so, that
> means worse brokenness than just test failing.  It means that
> the hook is not usable in your environment.
>
> I presume it is this line in pre-commit sample hook:
>
>     open $fh, "-|", qw(git-diff-index -p -M --cached HEAD);
>
> Is Perl on Cygwin incapable of handle this in general, or is it
> just what is on your machine being behind?

ActiveState's Windows port of Perl 5.8.6.

$ perl -e 'open $fh, "-|", qw(git-diff-index -p -M --cached HEAD)'
List form of pipe open not implemented at -e line 1.

I think it is not implemented because of Win32 lacking fork(2).
