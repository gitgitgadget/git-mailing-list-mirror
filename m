From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Thu, 12 Jun 2008 16:10:42 +0200
Message-ID: <200806121610.43674.jnareb@gmail.com>
References: <20080612002258.GC7200@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 16:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6nWn-0001eb-6k
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 16:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbYFLOKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 10:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758728AbYFLOKz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 10:10:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:64138 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977AbYFLOKy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 10:10:54 -0400
Received: by ug-out-1314.google.com with SMTP id h2so349318ugf.16
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=s6gXxqBRxmv0zrIhJN6Y2kmB2JTzy6HP8/fHarzsoVA=;
        b=IJ8hQbhFMG3YttTC7xnG6duFGdyEbpPCsp0vPoAOHs8adY/TaBeUKfx/09Nm/Ip5yM
         cTH+lCi2S9VcIBjl7hVE5UeUSvnmX4zFEdhXewrxWmWcWtkHA07+4yUg8HnLdG0kk4pF
         QpogPYX0IxPAf2crHeAukdF6ZuiqriEjpibuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fHnKnLdaY5mvl5/1sptHHTNu9RBLyyqArMnTc2AxX67hMBnZVhzMJLdqg7HP8P54mL
         iCAbQ5vXhyWzXEyfDz8cB5aarFW9tUsW4sYCAalvDRJqoFbFMRQbO/zyPfRsBElI3hbB
         BvtR+9I9lZdNuqeBc8evcNsz7tuLdVRXF38Do=
Received: by 10.210.61.8 with SMTP id j8mr1169521eba.199.1213279852662;
        Thu, 12 Jun 2008 07:10:52 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.226.105])
        by mx.google.com with ESMTPS id g11sm2356698gve.8.2008.06.12.07.10.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 07:10:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080612002258.GC7200@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84756>

Stephan Beyer wrote:
>
> git-sequencer(1)
> ================
> 
> NAME
> ----
> git-sequencer - Execute a sequence of git instructions
> 
> SYNOPSIS
> --------
> [verse]
> 'git-sequencer' [--batch] [--onto=<base>] [--verbose] [<file>]
> 'git-sequencer' --continue | --skip | --abort | --edit | --status

I'm not sure if --edit should be mentioned in line with "processing"
commands: --continue, --skip, --abort and related --status.
 
I'm not sure if it is necessary at all, but if we want to have this
equivalent to "git rebase --interactive" it should be, I think, put
separately.

> Alternatively, you can [...] correct the TODO file with
> 
>     git sequencer --edit

Can you ensure that editor would be invoked with current line
at the current action (isns?)?  Or will you be presenting only
with not performed yet actions?  If not, what would happen if
user modifies actions which had been done already?

In short, this is difficult thing to implement... besides of
course initial edit, with series file seeded by current history
"replay" description.
 
> OPTIONS
> -------
> <file>::
> 	Filename of the TODO file.  If omitted, standard input is used.
> 	See 'TODO FILE FORMAT' below.

Omitted for standard input, --stdin for standard imput, or special
filename of '-' for standard input?
 
> --onto=<base>::
> 	Checkout given commit or branch before sequencing.
> 	If you provide a branch, sequencer will make the provided
> 	changes on the branch, i.e. the branch will be changed.

I'm not sure if repeating rebase design is best idea.  But this
ferature is certainly necessary...
 
> --status::
> 	Show the current status of git-sequencer and what
> 	operations can be done to change that status.

How it would look like?  Current caller, current operation, progress
report (action n/m), status (e.g. CONFLICT or edit, or amend),
suggested actions (--continue, sometimes --skip, --abort)?
 
> --edit::
> 	Invoke editor to edit the undone rest of the TODO file.

Ahh... only the rest of the file...

> -v::
> --verbose::
> 	Be more verbose. [XXX: to be defined more accurately, i.e. print diffstat]

I think it would be nice to have --quiet mode (which perhaps --batch
would imply, or perhaps not), which would make git-sequencer to not
report progress report (i.e. which actions are being done).
 
> git-sequencer will usually be called by another git porcelain, like
> linkgit:git-am[1] or linkgit:git-rebase[1].

Or git-cherry-pick, or git-revert.

-- 
Jakub Narebski
Poland
