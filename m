From: Johan Herland <johan@herland.net>
Subject: git merge --abort? [was: Re: [PATCHv4 00/21] git notes merge]
Date: Fri, 22 Oct 2010 16:11:15 +0200
Message-ID: <201010221611.15425.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net> <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com> <7vaam7rv49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, jrnieder@gmail.com,
	bebarino@gmail.com, avarab@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 16:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9IRg-0004NK-Q6
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 16:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab0JVOSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 10:18:06 -0400
Received: from smtp.opera.com ([213.236.208.81]:51516 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755577Ab0JVOSG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 10:18:06 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9MEBFTg003097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 14:11:15 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vaam7rv49.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159689>

On Friday 22 October 2010, Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
> > Can someone comment on whether "git reset --merge" is a good
> > implementation of "git merge --abort"? If we can get an Ack from
> > someone I'd love to see this implemented.
>
> I think it depends on in what state you started from and how the
> merge operation stopped.  If your index was clean, probably yes, but
> "git reset --merge" may not be something you may want to do if the
> merge stopped because you had previously added something.

Does this mean that there are situations where you simply _cannot_ get 
back to the pre-merge state (using 'git reset --merge' or otherwise)?

Is this something we should detect and warn about when starting the 
merge? Something like:

  $ git merge bar
  I'm sorry, Dave. I'm afraid I can't merge with and unclean index.
  Use -f to force the merge anyway, but then 'git merge --abort' will
  lose your staged changes.

Or could we solve it simply by making a backup of the pre-merge index 
that can later be restored by 'git merge --abort'?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
