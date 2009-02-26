From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFH] rebase -i optimization
Date: Thu, 26 Feb 2009 15:55:41 +0100
Message-ID: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Ras
X-From: git-owner@vger.kernel.org Thu Feb 26 15:57:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lchfr-0006Iu-RU
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 15:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbZBZOzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 09:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbZBZOzw
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 09:55:52 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:33022 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbZBZOzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 09:55:51 -0500
Received: by fxm24 with SMTP id 24so552661fxm.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=CmO+13SyRGx/KY/q7oywW7eFXtNJ7dLAonz/Wzn4qGE=;
        b=dMqY2y3H1sxFEIvfcaWwh2IRE9ounbBtHK3uFyLMkFhh1w1n3L5PGfJuGFSyBulf9y
         CXw+in/pMq7Es0fxcUWH3FJb0Pgf3EUkInrK642U74tGEe1EhEP5gM5T79Hu9idYwkmv
         QWDRj9bDXODm6n309wBktiDMLkFgik12sz2B8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=saA3K5tUeB6n3mj///6bhe/q8Id5moNWHvyeh3AszCfS4irt8UuFVtZqU+1dLe5yZA
         AoUi0bkxHxnK7EyL6Pzrt7gx/yCHlOXdYhHcynMKzkR3I4RrGoloAQWoJIunPEn1RssR
         2aaFjRzGvINEyBlzN+oXdQGighwIQzJH+Far0=
Received: by 10.103.252.17 with SMTP id e17mr723535mus.14.1235660148299; Thu, 
	26 Feb 2009 06:55:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111568>

Heya,

I am currently working on a large set of patches for Melange, and as
such I'm using rebase -i a lot to polish things a bit. I do this
mainly by 'git rebase -i master' from my topic branch, then change on
of the 'pick' lines into an 'edit', and then fix up the commit and
'git rebase --continue'. Now I notice I'm waiting a lot for 'rebase
-i' to finish picking the first bunch of commits that I didn't change.
Now obviously I couldof done 'git rebase -i <foo>', but then I have
first figure out what the last commit I want to change is.
Would there be a reason to not reset to the last 'pick' commit instead
of to the 'based on' branch (as long as there history is linear)? If
so, what would be the best way to go around and implement this?

(to's based on who made the most changes to git-rebase--interactive.sh
and cc-ed those involved with git-sequencer)

-- 
Cheers,

Sverre Rabbelier
