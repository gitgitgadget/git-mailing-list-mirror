From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: preserve permissions?
Date: Tue, 4 May 2010 14:44:15 -0400
Message-ID: <1D033321-2F57-44BF-B27F-D7450AFC85E6@kellerfarm.com>
References: <C1288762-C750-4919-A853-5E3229870A59@btinternet.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 04 21:38:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Nwf-000627-Ej
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 21:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882Ab0EDTiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 15:38:09 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:50794 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753600Ab0EDTiI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 15:38:08 -0400
X-Greylist: delayed 3223 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2010 15:38:08 EDT
Received: from c-208-53-115-13.customer.broadstripe.net ([208.53.115.13] helo=[192.168.0.101])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1O9N6I-0003ov-Vv
	for git@vger.kernel.org; Tue, 04 May 2010 14:44:11 -0400
In-Reply-To: <C1288762-C750-4919-A853-5E3229870A59@btinternet.com>
X-Mailer: Apple Mail (2.1078)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146338>

On May 4, 2010, at 8:29 AM, Jonathan Chetwynd wrote:

> ...
> 
> what is the reason permissions are not preserved?
> 
> ...


Git implements a network of trust permission model.  In this model, system permissions are used (among other things) to control who has access to a repository.  Once someone has access, they can perform a clone or a fetch.  This process downloads refs into a local repository that inherits your local permissions.  This model is simple, but it is often capable of most things that system permissions can do, and it avoids the problem of a given user in the repository not existing on a machine.

One of the implications of this model is that although system permissions can be used to control who has access to a repository, they are not stored in the repository itself.  This means that if you clone a repository, the system permissions of the repository are never preserved.  This is a very intentional detail of the network of trust permission model.  Once a user has access to a repository, that user has access to the whole repository.  It is exactly like telling another person something.  Once the other person hears the data, that person can do whatever he or she wants with it.  He or she "owns" a copy of the data.

In other words, if you want a user X to own a repository upon cloning, then user X must be the one to perform the clone.  If you want Sue to know that the new kitchen table is made of oak, then Sue must be the one to ask the question (aka clone or fetch).  You cannot ask the question for Sue and expect her to instantly know what you know.

HTH
~ Andrew Keller
