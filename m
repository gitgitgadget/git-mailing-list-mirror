From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there a way to control the number of revisions will be saved by git
Date: Wed, 03 Dec 2008 04:58:40 -0800 (PST)
Message-ID: <m3ljuxifer.fsf@localhost.localdomain>
References: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
	<49366C03.5080506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tzury Bar Yochay <tzury.by@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rKj-0007LZ-1X
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbYLCM6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 07:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYLCM6o
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 07:58:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:57006 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbYLCM6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 07:58:43 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1835325nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 04:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=sbJ0GNEYzHsS5oz2gL1kYPB+h8NuWZBN8SJE1EX7hUo=;
        b=L/DmNNcuOj64Agd20CVKFgAsDFtzwPbvRFE7XFKVFGtqQRhisX6wCrr4M3xABqE1/9
         QxeRZH4aWtplF1KztnwzYH/JoB4by2QYpMV56AH6pg9yrXW0OLDUmoRFJRj4xrBCS5Ct
         zkCRm8jX8hBNftMCLxWC6rdWI+0g8Cw+Yo/cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=FuNx9i/5D+xOujPJRMyiKZb9BQ2jzVN469zIvw/3Eu93ZWvk0jbdZFILnAVYL3L8Xp
         R9lMa16jsjtH3cAAG7fKUfheU7VO6cm/57fDtqUzvorWa9Yb6iZ6ABRH0l1csZe4iRK5
         53OHgu8rSmKFg7F2NCWyosY6rT82rtSJI5+UY=
Received: by 10.210.73.12 with SMTP id v12mr15357008eba.107.1228309121712;
        Wed, 03 Dec 2008 04:58:41 -0800 (PST)
Received: from localhost.localdomain (abvo179.neoplus.adsl.tpnet.pl [83.8.212.179])
        by mx.google.com with ESMTPS id c24sm7354633ika.9.2008.12.03.04.58.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 04:58:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB3CwbqM027402;
	Wed, 3 Dec 2008 13:58:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB3CwaC0027399;
	Wed, 3 Dec 2008 13:58:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <49366C03.5080506@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102248>

Johannes Sixt <j.sixt@viscovery.net> writes:
> Tzury Bar Yochay schrieb:

> > Say I wish to save only 100 generations back (per branch).
> > Is it possible to configure git so it will save only N records back.

Why would you want that, by the way?

> No.
> 
> > If git cannot be configured for that, Is there a way to shrink the
> > repository manually so it will contain the last N generations?
> 
> Yes:
> 
>   $ git rev-parse HEAD~$N >> .git/info/grafts
>   $ git filter-branch HEAD
> 
> This assumes that your history is strictly linear and you do not have
> tags. It also rewrites the $N commits so that they now have different
> SHA1s. For this reason, don't share this repository with anyone - it leads
> to confusion.

Or just use shallow clone

  git clone --depth <depth> <repository>

to have new copy (clone) of <repository> to have only <depth> commits
back.  See man git-commit; but it might be not what you want.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
