From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [cgit PATCH] use Host: header to generate cgit_hosturl
Date: Mon, 1 Sep 2008 22:36:49 +0200
Message-ID: <8c5c35580809011336v58b139acu5078cafd3440c786@mail.gmail.com>
References: <20080901063033.GA21848@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 01 22:38:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaG9s-0002xY-0B
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbYIAUgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 16:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYIAUgu
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 16:36:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:30263 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYIAUgt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 16:36:49 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1440533waf.23
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lZGfN15qRs6fRhVk5PTe4mmTuujarmQ7SmngBsf6rUQ=;
        b=x6CtXcbH5ppZM/aP/hWouYnzwhnpOrb0XL0bj7viAVH2bE5m2DTDUHOonpvUS4e8F4
         X19uF5ceouJdhvHGkyXdLoVOgzU0WupgXvJgVuURLT5mQl26QyvhYBsTaX69DEtqONWf
         BIz0qa/sG77Wir8Sqqt0Cu7yPcqrDmE5ytDLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JTPE0OydRno6teKA+Gx0CnxGiUrQJQAxjD0SBA8Tt5hIlWX3z2XnqzR4C61fimn/fh
         uruqhAH3odDaAtwl9oi1BFuOYmqEeZoWblRiSQT2M1y0tY+QrN8iWOPP7Pfo0qmJPzdH
         3LqG+FqiObw2UPbvMcnAR4OFXHx2GJqto3DtM=
Received: by 10.114.148.1 with SMTP id v1mr5560769wad.199.1220301409341;
        Mon, 01 Sep 2008 13:36:49 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Mon, 1 Sep 2008 13:36:49 -0700 (PDT)
In-Reply-To: <20080901063033.GA21848@untitled>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94608>

On Mon, Sep 1, 2008 at 8:30 AM, Eric Wong <normalperson@yhbt.net> wrote:
> I run an instance of lighttpd for cgit behind nginx (nginx
> doesn't execute CGI).  So the port (SERVER_PORT=33333) that
> lighttpd runs on sends to cgit is different from the standard
> port 80 that public clients connect to (via nginx).
>
> This was causing the Atom feed URL to show the private port
> number that lighttpd was running on.
>
> Since the HTTP/1.1 "Host" header includes the port number if
> running on a non-standard port, it allows non-client-facing HTTP
> servers to transparently generate public URLs that clients can
> see.

This makes a lot of sense, thanks for the detailed description.


> So use the "Host" header if it is available and fall back to
> SERVER_NAME/SERVER_PORT for some clients that don't set
> HTTP_HOST.

Maybe it would be better to use a new cgitrc parameter as fallback if
the client doesn't provide the "Host" header?

--
larsh
