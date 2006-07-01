From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Speed up history generation
Date: Fri, 30 Jun 2006 18:52:04 -0700 (PDT)
Message-ID: <20060701015204.17216.qmail@web31813.mail.mud.yahoo.com>
References: <7v3bdmglxo.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 03:53:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwUff-0001qu-B7
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 03:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWGABwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 21:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWGABwH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 21:52:07 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:1361 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751308AbWGABwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 21:52:05 -0400
Received: (qmail 17218 invoked by uid 60001); 1 Jul 2006 01:52:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OvCQYjMIqVPnn9rYOKAaAWzGunGHjVCK8v2Hnq4Zm4dsdLRmc/wKU/mJugB8IOwTx7UwQkJAPDCK3zCzjdNdrH2cdzgcJq69M5BqncTcVoZcLlhWg+SEXxOCXkOcCjTZPSbCfgW5k3RBuhWf6VGYjy27KDZJ2sAaiA7wna/0P+M=  ;
Received: from [68.186.62.135] by web31813.mail.mud.yahoo.com via HTTP; Fri, 30 Jun 2006 18:52:04 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bdmglxo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23029>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- Junio C Hamano <junkio@cox.net> wrote:
> >...
> >> > @@ -2295,16 +2295,12 @@ sub git_history {
> >> >  	      "</div>\n";
> >> >  	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
> >> >  
> >> > -	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin --
> >> > \'$file_name\'";
> >> > -	my $commit;
> >> > +	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";
> >> 
> >> This would speed things up but at the same time it changes the
> >> semantics because it involves merge simplification, no?
> >> 
> >> At least that should be noted in the commit log.
> >
> > Ok, I guess this should be in the log.  Can you add it please when
> > commiting to the master git branch?
> 
> Well, by "at least", what I meant was that it might make sense
> to pass "--full-history" option to be more compatible with the
> original output.  For graphical output like gitk, --full-history
> makes a mess on the screen, but a list-oriented output like
> gitweb it might be less confusing to show all the alternate
> paths that touched the path than leaving some histories out.

Ok, I can add the --full-history option, test it out and resubmit.

    Luben
