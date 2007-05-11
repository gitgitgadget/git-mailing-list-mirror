From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Fri, 11 May 2007 13:26:35 +0200
Message-ID: <200705111326.35577.jnareb@gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <f20gjc$rne$1@sea.gmane.org> <7vd518gkyo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 13:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmTGH-0003oZ-Qf
	for gcvg-git@gmane.org; Fri, 11 May 2007 13:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135AbXEKL0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 07:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757414AbXEKL0L
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 07:26:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:48927 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135AbXEKL0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 07:26:08 -0400
Received: by wr-out-0506.google.com with SMTP id 76so998291wra
        for <git@vger.kernel.org>; Fri, 11 May 2007 04:26:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LAT8Z3ZcASw97IVcJuiwBT2uSdkVSYVmbVZFKoDh0j/rddOvFU0teo8tI89GS9yXEfIAVwRIn3EpAp4q22iQOGGrxZ0lZMg7roR2HnX1qtdQjYZb9Wh2wzIQQDp86JuQLZ5+EgEqeezYM7lD2Ra0UKNIrFiXGrnZynDEWsOM8n4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bJ/Qu15bsZIJ/Xllcb8P8EjcPCgUUY+OI4ayMpGVIjR6QbwUuJXDRN0ygAd1yUyjsOTrH1wM0Ej17hjUkFNnj9HESuX1G0OvgLyfWXlpfZOnRm4vJY/n+vW8HewTBQ7B6hY1fupP2Dsz2fkRrH6OAYt5go8pbizt0oZ4wNImhVk=
Received: by 10.78.154.9 with SMTP id b9mr768756hue.1178882766390;
        Fri, 11 May 2007 04:26:06 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id p32sm5916251ugc.2007.05.11.04.26.04;
        Fri, 11 May 2007 04:26:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd518gkyo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46951>

On Fri, 11 May 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> In the new version of git I *think* you can use "git add -u path/"
> 
> I know you meant well, but next time could you please check the
> fact before speaking?

> 		if (i < argc)
> 			die("-u and explicit paths are incompatible");

> The list is getting more and more cluttered recently, perhaps
> which is a good sign that more new people are actually using
> git.  Let's try to keep the signal quality of the messages on
> the list high.

I'm sorry I haven't checked this before writing, especially that
information in the synopsis contradict a bit the information in
the `-u' option description:

Documentation/git-add.txt:

  SYNOPSIS
  --------
  'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...

  -u::
        Update all files that git already knows about. This is what
        "git commit -a" does in preparation for making a commit.

I should have checked the facts before following the synopsis.

I think however that "git add -u dir/" could be quite useful; it is
not needed to have `-u' and explicit paths incompatibile. I wouldn't
change the fact that you can say "git add -u" and do not need 
"git add -u ." (like in the case without `-u' switch: you need 
"git add ." to 'add' all unignored files).


Below there is a patch which corrects synopsis for git add;
unless you want to go the route of allowing "git add -u dir/"...

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Fri, 11 May 2007 13:22:13 +0200
Subject: [PATCH] Documentation: Correct synopsis for git-add command

Change SYNOPISIS section of Documentation/git-add.txt to mark it
explicitely that "-u option and explicit paths are incompatible",
and that "add --interactive does not take any parameters".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-add.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ea27018..e5fc0da 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,7 +7,8 @@ git-add - Add file contents to the changeset to be committed next
 
 SYNOPSIS
 --------
-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
+'git-add' [-n] [-v] [-f] [-u | [--] <file>...]
+'git-add' (--interactive | -i)
 
 DESCRIPTION
 -----------
-- 
1.5.1.3


-- 
Jakub Narebski
Poland
