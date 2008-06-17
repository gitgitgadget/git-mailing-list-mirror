From: Don Zickus <dzickus@redhat.com>
Subject: Re: using git-blame with patches as input
Date: Tue, 17 Jun 2008 10:15:19 -0400
Message-ID: <20080617141519.GK16941@redhat.com>
References: <20080616213517.GE20727@redhat.com> <7vej6x9hpk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:17:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8bz5-00057y-Bv
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944AbYFQOPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757941AbYFQOPg
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:15:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35893 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940AbYFQOPf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:15:35 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5HEFMe0006060;
	Tue, 17 Jun 2008 10:15:22 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5HEFJkc019327;
	Tue, 17 Jun 2008 10:15:19 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5HEFJBt023420;
	Tue, 17 Jun 2008 10:15:19 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m5HEFJo1019795;
	Tue, 17 Jun 2008 10:15:19 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m5HEFJwQ019794;
	Tue, 17 Jun 2008 10:15:19 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vej6x9hpk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85301>

On Mon, Jun 16, 2008 at 02:45:59PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > I deal with a lot of backported patches that are a combination of multiple
> > commits.  I was looking to develop a tool that would help me determine
> > which chunks of the patch are upstream (not necessarily currently in HEAD
> > but at some point in the file's history).
> >
> > For example, if I took the top three commits from HEAD and appended them
> > into one patch file and then ran this tool with the patch as input, I
> > would hope that it gave as output the three original commits.
> 
> A quick and dirty hack would be to:
> 
> 	rm .git/index
> 	sed -ne 's/^[+ ]//p' -e '/^@@/p' patches... >file
>         git add file
>         git commit -m 'only "a file" remains'
>         git blame -C -C -w file
> 
> which would try blaming all the postimage concatenated together ;-)

Heh.  Interesting.  I'll try that today.  Thanks.

Cheers,
Don
