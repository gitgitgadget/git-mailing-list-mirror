From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] imap-send: cleanup execl() call to use NULL sentinel instead of 0
Date: Sat, 11 Mar 2006 21:30:22 +0100
Message-ID: <20060311203022.GA1578@fiberbit.xs4all.nl>
References: <20060311085550.GA32089@fiberbit.xs4all.nl> <118833cc0603110601x6ac9b2b6kaa0277981c6dd44b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 11 21:30:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIAjS-0002Bq-7Y
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 21:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWCKUaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 15:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCKUaZ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 15:30:25 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:23177 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751187AbWCKUaZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 15:30:25 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1FIAjH-0000Qp-1f; Sat, 11 Mar 2006 21:30:23 +0100
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc0603110601x6ac9b2b6kaa0277981c6dd44b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17505>

On Saturday March 11th 2006 Morten Welinder wrote:

> If you're going to fix that, you should use (char *)NULL or
> (char *)0, just in case you end up on a machine where
> NULL doesn't a pointer type.
> 
> (Yup, NULL can be a null pointer without having pointer type.)

For gcc NULL is specifically always guaranteed to be a valid sentinel.
And it was basically just about fixing the gcc warning, no pedantics
intended! All other uses within git for the exec() family also use plain
uncast NULL, which looks better anyway.

Strictly speaking you're probably right, but there's a chance that this
will generate warnings on other compilers.

And if you should use a compiler with a weird notion of NULL, you're
probably better off switching compilers immediately. ;-)
-- 
Marco Roeland
