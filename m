From: Stephen Bash <bash@genarts.com>
Subject: Re: Effectively navigating branch history
Date: Tue, 31 May 2011 14:51:15 -0400 (EDT)
Message-ID: <21849336.45230.1306867875224.JavaMail.root@mail.hq.genarts.com>
References: <7vtycaiuh9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRU2K-0002Pp-CQ
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 20:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab1EaSvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 14:51:23 -0400
Received: from hq.genarts.com ([173.9.65.1]:20112 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756654Ab1EaSvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 14:51:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id CAB3FEA2308;
	Tue, 31 May 2011 14:51:21 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9U3+EkFh8I9p; Tue, 31 May 2011 14:51:15 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 59269EA2306;
	Tue, 31 May 2011 14:51:15 -0400 (EDT)
In-Reply-To: <7vtycaiuh9.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Win)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174820>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Tuesday, May 31, 2011 2:40:50 PM
> Subject: Re: Effectively navigating branch history
> 
> >> Yeah, I think it was 1f9a980636 which was a merge between fb674d7
> >> and 73546c0. I just compared the output between these two:
> >>
> >> $ git diff fb674d7...73546c0 -- config.c ;# what the topic did
> >> $ git diff fb674d7 1f9a980 -- config.c ;# what was merged
> >
> > I often find myself wanting to do the "what the topic did" operation
> > but once the branch is merged and deleted, I have difficulty finding
> > useful SHAs to diff.
> >
> > So in an attempt to educate myself, I tried to track down fb674d7
> > and 1f9a980 (and failed miserably).
> 
> I just did
> 
> $ git log --first-parent master -- config.c
> 
> which was sufficient for my workflow as most of the commits on master
> are merges from topics and I can see what each topic did from the merge
> commit summary message.

Ah, if only our workflow made it that easy... unfortunately it does not ;)

> If I were doing this on a codebase I am not very familiar with, I
> probably I would have first narrowed things down a bit by
> 
> $ git grep -n -e NOGLOBAL -- config.c ;# to learn the line number 830
> $ git blame -L825,835 -- config.c
> 
> to learn where the offending NOGLOBAL came from (it is from ab88c363)
> so that I can say
> 
> $ git log -m -p -GNOGLOBAL ab88c363.. -- config.c
> 
> to find that 1f9a980 reintroduced it by mistake.

Ah, I was missing the -m!  At one point I realized pickaxe was only showing me non-merge commits and skimmed the log manpage to see if there was an option that would enable it but apparently missed -m.

Thanks!

Stephen
