From: John Keeping <john@keeping.me.uk>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 15:01:20 +0100
Message-ID: <20130618140120.GD4676@serenity.lan>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowTd-0000HL-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932841Ab3FROBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:01:37 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52633 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701Ab3FROBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:01:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1FAE8CDA594;
	Tue, 18 Jun 2013 15:01:36 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJraQl+XyCTy; Tue, 18 Jun 2013 15:01:31 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 03EBFCDA613;
	Tue, 18 Jun 2013 15:01:30 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id EEEE6161E49E;
	Tue, 18 Jun 2013 15:01:30 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rgJfOECwdlT; Tue, 18 Jun 2013 15:01:26 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 72DA7161E4AD;
	Tue, 18 Jun 2013 15:01:22 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228233>

On Tue, Jun 18, 2013 at 03:25:22PM +0200, Alexander Nestorov wrote:
> Recently I had to write some automation scripts and I found
> that git reset --hard actually restores each file's permissions.
> 
> That is causing both the created and the last-modified dates
> of the file to get changed to the time of the git reset.
> 
> This behavior is easy to demonstrate:
> 
> echo "test" > myfile
> chmod 777 myfile
> git add myfile && git commit -m "Test" && git push
> chmod 775 myfile
> git reset --hard origin/master
> 
> After the git reset --hard command, the entire file was
> checkout-ed. Instead, git should be able to check if the
> content of the file changed and only if it did, check it out.

Does "git reset --keep" behave in the same way?  I would expect it to
leave permissions as they were.
