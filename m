From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/18] revert: Save data for continuing after conflict
 resolution
Date: Thu, 28 Jul 2011 19:45:19 +0200
Message-ID: <20110728174519.GB29866@elie.dc0b.debconf.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 19:45:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmUeJ-0007jt-FH
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 19:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab1G1Rp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 13:45:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53460 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab1G1Rp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 13:45:26 -0400
Received: by fxh19 with SMTP id 19so1473132fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1Ut3i8h43gfCJocCQj+0vj7BxSo9ModzOJFmgxhwlAU=;
        b=eEcSXdi3p353p7jrVVIsLLkM4Cf0JarWJhVA/HsydofIJe4Yp/RUI3QdvWLeMav3j7
         Gfz0ViCWi7aZu+1CyXQthtX2GRpX2J7oV4czGRjZMRI0Hg+TcXjH818eOHlz55HRAAb7
         GvYOCS/67S03A5I+l3v6t/QWc2jB/cV5t7qxE=
Received: by 10.223.98.77 with SMTP id p13mr360127fan.72.1311875124851;
        Thu, 28 Jul 2011 10:45:24 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id n18sm608356fam.7.2011.07.28.10.45.22
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 10:45:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311871951-3497-11-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178106>

Ramkumar Ramachandra wrote:

> That these two files alone are not enough to implement a "--continue"
> that remembers the command-line options specified; later patches in
> the series save them too.

Micronit: I think this sentence has an extra "That".

[...]
> +	if (!(file_exists(seq_dir) && is_directory(seq_dir))
> +		&& mkdir(seq_dir, 0777) < 0)
> +		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);

Nice, thanks.

[...]
> +pristine_detach () {
> +	git checkout -f "$1^0" &&
> +	git read-tree -u --reset HEAD &&
> +	git clean -d -f -f -q -x
> +}

Nit: probably best to include the "rm -rf .git/sequencer" in this
function.  But I don't think that should hold up the patch.

Aside from typos in commit messages as mentioned before, the patches up
to here look ready.
