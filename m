From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: pushing from a shallow repo allowed?
Date: Mon, 16 Feb 2009 11:00:21 +0100
Message-ID: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com>
References: <20090212220254.GA1517@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0IT-00025a-51
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbZBPKAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZBPKAZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:00:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:53233 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbZBPKAY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:00:24 -0500
Received: by nf-out-0910.google.com with SMTP id d21so199866nfb.21
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IPlmo+s33WCZsKShwAXQX9RAe1CioyfshBuRJPqU0Y0=;
        b=d2PMzD78PAHdU4c+xWLJ1cRmOk/SgNVOC+btUnh50/3QUTpd4wcUUUvZKK3aN5Wljt
         CieEfVXohZiJ5cn8lF9Gngf1tv9AjsaSL7EQ7NXBwCPsK+Hc5pPyDXCSEBOiSt5sv4HF
         8RJ4Q+5EXDIud/ut/p8VYXDfGM6GhfjlFRsuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=unnQrRT5fmiNIXlZKZBIZfv1FlsnkHBP4zQcedMnScIFL8pKWXmZ41DAPh9AKrTB+a
         EeQbH6/3D4qXvCgWX6w4oFP5wbHi9LMR7jsSMXpW2fham1ce3oX6rd814LwGvdU28hHV
         Q8GDDquC1giGXxGqXW8mle4gICZyXLgNW0WLY=
Received: by 10.210.36.8 with SMTP id j8mr2209777ebj.83.1234778421967; Mon, 16 
	Feb 2009 02:00:21 -0800 (PST)
In-Reply-To: <20090212220254.GA1517@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110156>

2009/2/12 Joey Hess <joey@kitenet.net>:
> git-clone(1):
>        A shallow repository has a number of
>        limitations (you cannot clone or fetch from it, nor push from nor
>        into it)
>
> This and other documentation (shallow.txt, RelNotes-1.5.0.txt) says you
> can't push from a shallow repo. But in a simple test of making a commit
> to a shallow repo and pushing it out, it seems to work. AFAICS, git only
> guards against pushes *into* a shallow repo, and fetching/cloning from a
> shallow repository.
>
> Are the docs out of date, or is there really still some problem
> with pushing from a shallow repo?

AFAIK, it will work in simple cases, but isn't guaranteed to work.

> BTW, --depth seems to be ignored when making a local clone.
> This seems to have been fixed in the old shell git-clone in
> d4110a9726c7cd5cda35b7dd03dc8f85fe3dff0c, was it accidentially lost
> in the C version?
>
> joey@gnu:~/src/other> git clone --depth 2 git git.shallow
> Initialized empty Git repository in /home/joey/src/other/git.shallow/.git/
> joey@gnu:~/src/other> cd git.shallow
> joey@gnu:~/src/other/git.shallow> git-log --pretty=oneline|wc -l
> 17009
>
> git version 1.5.6.5

You most likely need to use the file:// syntax for this to work,
otherwise git will just hardlink/copy the whole objects dir without
looking at it.

-- 
Mikael Magnusson
