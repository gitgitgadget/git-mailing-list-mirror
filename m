From: Johan Herland <johan@herland.net>
Subject: Re: git merge --abort? [was: Re: [PATCHv4 00/21] git notes merge]
Date: Fri, 22 Oct 2010 17:12:05 +0200
Message-ID: <201010221712.06059.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net> <201010221611.15425.johan@herland.net> <20101022145553.GA9224@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, bebarino@gmail.com,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JIb-0004Cu-1k
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab0JVPMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:12:48 -0400
Received: from smtp.opera.com ([213.236.208.81]:35855 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376Ab0JVPMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:12:47 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9MFC6mX010013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 15:12:06 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20101022145553.GA9224@burratino>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159696>

On Friday 22 October 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> > Does this mean that there are situations where you simply _cannot_
> > get back to the pre-merge state (using 'git reset --merge' or
> > otherwise)?
>
> Technically yes, there is such an edge case, but I don't think that
> was what he was talking about.

Ah, sorry for the misunderstanding.

> > Is this something we should detect and warn about when starting the
> > merge? Something like:
> >
> >   $ git merge bar
> >   I'm sorry, Dave. I'm afraid I can't merge with and unclean index.
> >   Use -f to force the merge anyway, but then 'git merge --abort'
> > will lose your staged changes.
>
> "Use -f to force the merge anyway" does not make sense to me.
> git merge does not work with an index that does not match HEAD
> (except in the aforementioned edge case where the content in the edge
> already matches the merged content).  So 'git merge' bails out in
> this case, leaving the index as-is; if a person doesn't notice that
> and tries 'git reset --merge', her staged changes may be clobbered.
>
> > Or could we solve it simply by making a backup of the pre-merge
> > index that can later be restored by 'git merge --abort'?
>
> Yes, that's one way.  I think it might be better for 'git reset
> --merge' to check for MERGE_HEAD and do nothing if it is absent if we
> want it to be closer to an inverse to failed 'git merge'.

Yes, that makes sense to me, especially if we make a 'git merge --abort' 
synonym. Alternatively, we can make 'git merge --abort' check for 
MERGE_HEAD, and then defer to 'git reset --merge', while leaving 'git 
reset --merge' as-is.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
