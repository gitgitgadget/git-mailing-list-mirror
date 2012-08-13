From: Christopher Marshall <christopherlmarshall@gmail.com>
Subject: Re: git svn clone, a non-standard layout question
Date: Mon, 13 Aug 2012 09:29:53 -0400
Message-ID: <CANW+GuRoQJtZW6ZCwDQEj9OQD4C3BqxqX--2JV+=jkddagQgig@mail.gmail.com>
References: <CANW+GuQ=egge=NcdSakChYXXZkW=MsG9f3i9yNvoutXXVFcPzQ@mail.gmail.com>
	<20120813063132.GD10899@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 15:30:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0uiW-0006pR-Hh
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 15:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab2HMN3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 09:29:55 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:65262 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab2HMN3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 09:29:54 -0400
Received: by weyx8 with SMTP id x8so2471753wey.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IfxEDDCBhPk4gywWUjetQ6OLMhG8DzbiHlaP584p71M=;
        b=YJ79AepB9PkAXsYz4C+N1IIc/3U1llcMU6/+aWpAMXqteXy+EkEbJ/ZLBJX/djRJe8
         H5Lt+leiMzGIQ0dHygjj0NSxBdoLYQSC/E33Uh2y63orGtNq3I5l9IYeOk9dwWEqgP2s
         cRDFc0+M+SSjqC3ZGvNgdqCJiVYkp+Ddk7wCdoeg0Pgt0YIol5yOn6GJDJqTdNBQo7Ym
         ujEFRmweoNh7kQ71emuKwWz5rKPpDXe8AA6tFTblILa0qUSkePMoJZ+Kk94OWyofdQ3D
         EkDBKCCSd+65v8+OZ02dnnoQM5ZaNorvllafScx6VXW19UOJmMCDWT9Fnm04SrtEapGK
         fmIA==
Received: by 10.217.2.133 with SMTP id p5mr6402665wes.143.1344864593517; Mon,
 13 Aug 2012 06:29:53 -0700 (PDT)
Received: by 10.194.34.34 with HTTP; Mon, 13 Aug 2012 06:29:53 -0700 (PDT)
In-Reply-To: <20120813063132.GD10899@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203335>

>
> I had a similar problem, but I solved it using "ignore-paths" and "ignore-refs".
> If I remember correctly, you need to set both to ignore bdir directly without
> ignoring b3, b4,...
>
> For ignore-refs, pls see cdb51a13c3cf4830d499d1138160eacdd2b8aa46, as it is currently
> undocumented.
>
> So I would try experimenting with the following settings:
>
> [svn-remote "svn"]
>         url = file:///home/chris/programs/svn/repo
>         fetch = trunk:refs/remotes/svn/trunk
>         tags = tags/*:refs/remotes/svn/tags/*
>         branches = branches/{b1,b2}:refs/remotes/svn/*
>         branches = branches/bdir/{b3,b4}:refs/remotes/svn/*
>
>         # Operates on the imported git branches
>         ignore-refs  = ^refs/remotes/bdir$
>
>         # Operates on the SVN branches; you might try it first without this statement
>         ignore-paths = ^branches/bdir$
> --

Peter:

Thanks for the advice.  I tried this:

[svn-remote "svn"]
        url = file:///home/chris/programs/svn/repo
        fetch = trunk:refs/remotes/svn/trunk
        branches = branches/*:refs/remotes/svn/*
        tags = tags/*:refs/remotes/svn/tags/*
        branches = branches/bdir/*:refs/remotes/svn/bdir2/*
        ignore-paths  = ^branches/bdir$
        ignore-refs  = ^refs/remotes/bdir$

It doesn't seem to change anything.

Chris
