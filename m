From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's
	name.
Date: Thu, 31 Jan 2008 00:36:29 -0200
Message-ID: <20080131023629.GB7778@c3sl.ufpr.br>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <7vwsprj0sv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 03:37:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKPJ7-0007GL-Bj
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 03:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513AbYAaCgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 21:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756298AbYAaCgw
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 21:36:52 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:56589 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYAaCgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 21:36:51 -0500
Received: from localhost (unknown [189.25.95.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 11524700003C1;
	Thu, 31 Jan 2008 00:36:46 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <7vwsprj0sv.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72092>

On Tue, Jan 29, 2008 at 10:16:16PM -0800, Junio C Hamano wrote:
> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> 
> <snip> 
> I am not sure about the effect of this change on a large scale
> site.  If you do not have the project list file, originally we
> just needed a stat per project, but now you open an extra file
> (either "owner" or "config") and read it, once per every
> project.

Opening the extra file has same problem as the description file. And, as
gitweb allow us to create  "description" and "cloneurl" file there is no 
problem having another file to open instead finding out who is the owner of
the directory asking to the filesystem.

> 
> The project list page does that for every project, and it
> actually is worse because it also needs to open yet another file
> "description" from the directory.  It almost makes me wonder if
> are much better of to have a single file per project to read all
> the necessary information off of, instead of having to open many
> little files (currently it is only two---owner and description.
> But who knows what other little pieces of information you would
> want to add next week).
wow, just me adds more little information?! 8-P (I have my own git.acl which
is the "simple" way to my SSH scripts control acl via public_key, but that's
another story).

Having a single file is already done, having the config file but parser may
be bad too (or not for common case), we can have a "gitweb.config" which
contains all those necessary information like owner, description, cloneurl
...

Another "option" is to make cache of then project list page =) From time to
time (each push ?!) gitweb creates project list page again and generates a
new project_list file to have easy access when entering summary page, or
make summary page cached too  

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
