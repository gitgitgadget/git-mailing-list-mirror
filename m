From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC] Git to SVN bridge
Date: Mon, 23 Apr 2012 13:06:08 -0500
Message-ID: <20120423180607.GF9635@burratino>
References: <CALkWK0=Mqo=PMv7+_sr22Dnm6xxzxzaXL=Zh+2LsvT=usC7csw@mail.gmail.com>
 <20120418201050.GB30625@burratino>
 <CALkWK0=7SPR-4Km5TUwg+rHm30aC7Uru9GJkkfYnL3OORV7nfg@mail.gmail.com>
 <20120419225659.GA4971@burratino>
 <CALkWK0mdzWQRY=fSmyML1p7352c7Lb3vuYoJd+TXSdTmFX1teg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:06:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMNem-00044T-Nv
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 20:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab2DWSGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 14:06:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59371 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab2DWSGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 14:06:31 -0400
Received: by ghrr11 with SMTP id r11so6335570ghr.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/P9ulfMmjP3YlNlSvlMWKzZYQjGwwHkSeB9QAB1uee4=;
        b=ZiN9uxHb5P1Ui8VwovrgvXeFp4sZksyGcx7peMh56Nf+FjXDx4lG8r58OrMGG7x3Rg
         Tx5Xj53Jy8qGOMQkvPpNdQMe25mJz32U6mGQ2y0w3bLRfUDqQEuWCv0Xed00ldLYX9l8
         RrnSsBKezJShh8c9HbyHzVEeJQ3fIKDHiu+qNhkBxE1FzrS+yiduQdiP21CdeAaLpY0y
         1u8OcAfAQ5pCAu9xcwZz+AZkrucmJJQjGsn7bmABtJiaU+7bEDtozDl8TyQFe8e9jYyq
         KF8SN5ZdP3TzVqtL1lwXlIqJa+LyBQvSU85r67CD268X9d9t0jcrfUvvR59sUZzEQEsw
         vAUg==
Received: by 10.60.13.36 with SMTP id e4mr23706147oec.22.1335204390896;
        Mon, 23 Apr 2012 11:06:30 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id by5sm16930125obb.19.2012.04.23.11.06.12
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 11:06:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mdzWQRY=fSmyML1p7352c7Lb3vuYoJd+TXSdTmFX1teg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196153>

Ramkumar Ramachandra wrote:

>        I'm a little more worried about the mapper- I'm finding it hard
> to imagine a fast-import stream that contains subdirectories
> (branches/*) as opposed to head refs.  Any idea how we'll achieve
> that?

Shouldn't it be very simple?  All you need is a filter that understands
the fast-import syntax and can convert

	commit refs/heads/topic
	...
	M 100644 inline "foo/bar"

to

	commit toplevel
	...
	M 100644 inline "branches/topic/foo/bar"

and

	ls topic@1 "foo/bar"

to

	ls r1 "branches/topic/foo/bar"
