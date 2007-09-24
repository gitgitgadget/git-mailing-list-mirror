From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-submodule - allow a relative path as the subproject
 url
Date: Sun, 23 Sep 2007 22:27:40 -0400
Message-ID: <46F7209C.2030205@gmail.com>
References: <11904936042891-git-send-email-mdl123@verizon.net> <loom.20070924T002011-331@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Smith <msmith@cbnco.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 04:27:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZdfw-0007Z6-C0
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 04:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbXIXC1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 22:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbXIXC1u
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 22:27:50 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:55556 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXIXC1t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 22:27:49 -0400
Received: by an-out-0708.google.com with SMTP id d31so208555and
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 19:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=5IEveOKw7974MEaiCnoi5DDJRF/WcjQKrcA3jwQgnLo=;
        b=m2PfbL4VwdvwhAacsHW1WDiEZijPpRbX1eeGMgaZrrT0O4pdI2KBBUcplOgCcnTKXMcJZwGKsx+atXmqgUTAmVL+QlhmMl5yTkJKbFCxn2meXMRfqXwSo0v63zYB6uZTS6Yh9wkrmqolPrfKrx36o+dWsn5veBGR0lAMHyiDOzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hENqVEMFOiOXxB61g6x5GlG3dbDU3C0ttnO1Y0cG6Ulc5lCMJI4Heuz2oiQmyTe3upR1yekoSZtWoZF9dX502ZIAnfLphqDLtYnUQhLT5LjTOcFlNYteFKT5yU5ut7gMlt1gbv/YBKN9be4Nn67ZTXtA2AxrFiazq6ZTkYbLJ6M=
Received: by 10.100.134.2 with SMTP id h2mr7594008and.1190600864560;
        Sun, 23 Sep 2007 19:27:44 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.126.132.29])
        by mx.google.com with ESMTPS id h8sm4440442wxd.2007.09.23.19.27.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Sep 2007 19:27:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <loom.20070924T002011-331@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59013>

Michael Smith wrote:
> Hi Mark,
>
> I have a use case where this would be very handy -- two teams geographically
> separated. But in the end I think I disagree with it: it's not up to me, as the
> person creating a superproject, to decide that anyone who forks or clones it
> also has to clone all the submodules.
>
>   
With or without the patch, the cloner has to execute "submodule init" 
and "submodule update" to actually check things out. Absolutely nothing 
has changed there: it still requires the same explicit actions to get 
the submodules.

This patch does not alter any existing behavior: it provides an 
additional option, and one that is very useful in a world of mirrors. My 
particular use case is for a geographically distributed work flow 
involving several mirrors, all of which are behind firewalls and/or 
connected only to a LAN. There is no single server that is available to 
everyone, hence no single url for a submodule is usable across the 
group. By offering the *option* (and it is only an option) to make the 
urls relative to the super-project, the super-project can be usefully 
shared.
> Instead they can decide themselves by editing .git/config between "git submodule
> init" and "git submodule update", or by branching .gitmodules.
>   
Yes, a person can edit .gitmodules, or can edit .git/config, in order to 
tell git where things are. But why should they *have* to when relative 
urls will suffice and git can take care of this transparently.
> If you source git-parse-remote, you can use
>
>                 realrepo="$(get_remote_url "$(get_default_remote)")$repo"
>
> Mike
>   
Yes, the patch itself can be improved, am sending a revised one.

Mark
