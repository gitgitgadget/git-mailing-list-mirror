From: Zach Brown <zab@zabbo.net>
Subject: Re: git (commit|tag) atomicity
Date: Tue, 28 Feb 2012 13:57:21 -0500
Message-ID: <4F4D2391.9020701@zabbo.net>
References: <CADWOt=j8gJvr88eNAfoYq_qGQvG6M_k-9MCuof_DRrH0sHRVCA@mail.gmail.com> <4F4D04F4.80905@ira.uka.de> <CADWOt=ig5=Bhhkjs9-wbm2djtwWPOfPGtYt9pH-U3YuQ+iyXzg@mail.gmail.com> <m3aa42vosb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Jagger <jon@jaggersoft.com>, git@vger.kernel.org,
	Holger Hellmuth <hellmuth@ira.uka.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:04:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SLk-0003Hk-T1
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965995Ab2B1TEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:04:32 -0500
Received: from lulu.zabbo.net ([69.168.54.52]:51459 "EHLO lulu.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964824Ab2B1TEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:04:32 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Feb 2012 14:04:32 EST
Received: from [192.168.1.133] (unknown [66.207.222.38])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by lulu.zabbo.net (Postfix) with ESMTPSA id 7FD2222161A;
	Tue, 28 Feb 2012 10:57:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20120131 Thunderbird/10.0
In-Reply-To: <m3aa42vosb.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191762>


It's a bit of a tangent, but just to be sure people don't get the wrong
impression..

> But I am not sure... that probably depends on how opendir(3) and
> readdir(3) works on given filesystem wrt. updates to opened directory.
> I think VFS on Linux ensures that you see view of filesystem as it was
> on opendir().

No, readdir() does not give you a static view of the entries in a
directory as it was on opendir().  readdir() will reflect modifications
that are done after opendir().  The specifics for a given situation
depend on how the file system maps the readdir position (f_pos) to
directory entries.  You can see very different results when comparing,
say, stock ext2, indexed ext[34], and btrfs.

- z
(your message probably caught my eye because telldir()/seekdir() is
*loathed* by file system designers)
