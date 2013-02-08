From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: `git checkout --orpan` leaves a dirty worktree
Date: Fri, 8 Feb 2013 12:04:02 -0800
Message-ID: <20130208200402.GB8461@google.com>
References: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uBU-0005Dg-M5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946934Ab3BHUEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:04:09 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:55235 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946873Ab3BHUEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:04:08 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so1911135daj.22
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mPYirdu2Qjy7ZKv9MJhBDi0qrX/8OOYpZqfYsb00ABM=;
        b=GCYkRn9hi74KUd8J4SAreAgdYiDNESWvMnw2UYlLzcVFlbEXPS4f9mxxFYTId5uMRA
         wtCAJYorD+7mQ9Q6m7hKyW0wQzA91M8OeZnkqbjnx/rGxcw4ySS7rxlQXU1O6Ay4h/yi
         1DrDha23YUn80TUzdrGS9iTpZT/hRLq8uk64PhQZ68SrG3ppqZtj0Kh/khtAPdQONK4v
         AKMdE9CjDWhlKm/s2VDbvb4BkCWsdgicxos6QwBWPeJmd9+Iruf9HN7Z/ovRPoPKXE2j
         CX/MtOz9S04pdTXzHAFSdy+QB8AixpfgDK9eXPBqJERkiUI1Z2XARXF86o1PbZxmt56d
         N4ZQ==
X-Received: by 10.66.85.101 with SMTP id g5mr20568226paz.17.1360353847650;
        Fri, 08 Feb 2013 12:04:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id m3sm56830796pav.4.2013.02.08.12.04.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 12:04:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215808>

Ramkumar Ramachandra wrote:

> Why should I have to `git rm -rf .` after a `git checkout --orphan`?
> What sort of misfeature/ incomplete feature is this?

One designed for the "going open source" use case, where you have
existing code that you want to put into a new branch without history.
When there is no existing code, it seems simpler to do

	cd ..
	git init code-that-has-nothing-to-do-previous-cwd
	cd code-that-*
	... hack hack hack ...
	git commit
	git remote add origin <url>
	git push -u origin master

BTW, I suspect a clearer way to say what you meant is "Sounds like a
misfeature" which is gentler and more focused than an implied "What
kind of idiot designed this?"  Even if you are thinking the latter. :)

Hope that helps,
Jonathan
