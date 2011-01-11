From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 14:50:43 -0600
Message-ID: <20110111205043.GA19928@burratino>
References: <4D262D68.2050804@cfl.rr.com>
 <201101112048.57326.j6t@kdbg.org>
 <20110111195107.GA18714@sigill.intra.peff.net>
 <201101112100.32083.j6t@kdbg.org>
 <4D2CBC1A.9000302@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 21:51:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PclBJ-0001iT-Ds
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 21:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1AKUvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 15:51:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57911 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab1AKUu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 15:50:59 -0500
Received: by wwa36 with SMTP id 36so2239524wwa.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZxG64P1vWBQG8l0xMyREt9k5BEf44spmCqQTiBgYAdI=;
        b=gEVvR2XuoO4xOBD1+7lV5EjnqhsF5vPbPaNQDB/ip5NRyh6Wgcx6t8CZy7AWXOGgY3
         CapGMqDeQXo/79ogOrzZ4QHwXBnqcCgcgGs6CWx+lnD2lSeOaLTlpkV/HyaRvE026chD
         1taj/FF3r28PTC7+T8JnNV/t5MVJwe8ZdBnes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oOM3vH06gQbhEdBvXeFBc6YoOL0qruepGakqz/hq3vZp/4Xtw+CI/BYJOiZEXBrJGx
         wAJoTfk72NmMAwCiNd2hKR1KZB0XeJFg3cKBYWOyLQKu30tyfDno9AiV55KMoBgKvnVx
         +tMeqx8qichRYGrjKqZyMPaEii8b7Pb1e6wnU=
Received: by 10.227.134.206 with SMTP id k14mr108894wbt.5.1294779057591;
        Tue, 11 Jan 2011 12:50:57 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id 7sm14970511wet.24.2011.01.11.12.50.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 12:50:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2CBC1A.9000302@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164990>

Phillip Susi wrote:

> It seems that the recommended use of replace is to locally append
> history back on, after it has been removed upstream with git
> filter-branch.  Using filter-branch is bad, so it makes more sense to me
> to do the remove with git replace, and then if you want to add it back,
> you just have to disable the replace ( and maybe fetch additional objects ).
>
> The one problem that has come up is that when you fetch and tell the
> server you have a commit after the replace, it assumes that you also
> have the commits prior to the replace and may delta against objects you
> do not have.  Fixing that would require informing the server of any
> replacements you have, and it being able to use that information to
> avoid deltas against objects hidden by the replace.
>
> Does that sound like a pretty good summary to everyone?

Yes, except for "Using filter-branch is bad".  Using filter-branch is
not bad.  Also there are many recommended uses of replace: for example,
to swap out a commit that builds for one that doesn't when using "git
bisect", or to stage history changes before making them permanent with
filter-branch.
