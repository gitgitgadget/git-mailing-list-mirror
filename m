From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH] Git.pm: Don't return 'undef' in vector context.
Date: Fri, 16 Nov 2007 21:20:40 -0600
Message-ID: <473E5E08.2090609@zwell.net>
References: <473D3593.9080806@zwell.net> <fhjl70$db4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 04:22:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItEG4-0003IT-QY
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 04:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbXKQDVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 22:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbXKQDVx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 22:21:53 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:41396 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbXKQDVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 22:21:52 -0500
Received: by py-out-1112.google.com with SMTP id u77so4578493pyb
        for <git@vger.kernel.org>; Fri, 16 Nov 2007 19:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=SRC+m4tl9VE5oieu76hPAYxLldXChvasIJiHlHbjCZg=;
        b=PrP8zRiIJ9uL0g3nu2zZ1+WOhf+yNeE3P2ANDB2bYQJuqBLSTACv7lOVBV1lQlz2nBXhgTCdl9cOCFnkJI9RCWPfH6t2sSR0rZQr7dqJLQPqxXoUedPHYIEoYFZX0lMgtO6yWHeP7wi/wcZxmP1n5uwCkbTqdiEqPW1Lx0tSghU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=PCk3y+5KzBatx9jwNPLXYeLoZSJiTfaFpxvKNz3LhuK8DF/Kfdc3j/P14nDoZj+ex4T9JxTNd2iDOml6nyIsFcGBG4E18HduydOo2RRWnNLU5RRVxUqTsHniAzSsdSRu1+ya8e1FB2NI4/O5pv14oJAbAE+g1Mdvvf0vjK2j9fM=
Received: by 10.35.96.6 with SMTP id y6mr2945109pyl.1195269711224;
        Fri, 16 Nov 2007 19:21:51 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id a79sm8521676pye.2007.11.16.19.21.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Nov 2007 19:21:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
In-Reply-To: <fhjl70$db4$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65260>

Jakub Narebski wrote:
> 
> By the way, what do you think about changing Git.pm config handling
> to the 'eager' one used currently by gitweb, namely reading all the
> config to hash, and later getting config values from hash instead of
> calling git-config? Or at least make it an option?
> 

That seems appropriate, though it may be a slight trade-off between 
complexity and efficiency. I don't think it's strictly necessary, at 
least for git-add--interactive. My experience is that the nine calls to 
config() (that I am adding) do not slow down the program from a user 
perspective (though I haven't tested on a slower computer).

The big reason to do it would be if you wanted to convert gitweb to use 
the standard config() call from Git.pm. Because right now, config() 
isn't efficient, but it probably doesn't need to be.

Dan
