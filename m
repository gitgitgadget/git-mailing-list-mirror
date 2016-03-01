From: 'John Keeping' <john@keeping.me.uk>
Subject: Re: Trouble Cloning Git remote repository
Date: Tue, 1 Mar 2016 15:28:13 +0000
Message-ID: <20160301152813.GD1766@serenity.lan>
References: <009f01d170e9$ecd5cae0$c68160a0$@optonline.net>
 <CACsJy8A5539X+VhUAnNfn5Q_uW1pa5oYb9YAAF8=u3XfdhAeMw@mail.gmail.com>
 <00e001d17250$47c63fe0$d752bfa0$@optonline.net>
 <CACsJy8CSrmahLztOmmU+R4KTifhRs5nsSPKOdYHHw57UqDv8oQ@mail.gmail.com>
 <20160229093451.GC1766@serenity.lan>
 <002701d173cb$b3604080$1a20c180$@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Duy Nguyen' <pclouds@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Fred's Personal <freddiewik@optonline.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 16:28:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aamDw-0002VU-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 16:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbcCAP22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 10:28:28 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:58976 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbcCAP20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 10:28:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 850EACDA555;
	Tue,  1 Mar 2016 15:28:25 +0000 (GMT)
X-Quarantine-ID: <V28K-lqXLRbZ>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id V28K-lqXLRbZ; Tue,  1 Mar 2016 15:28:24 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 15E5FCDA598;
	Tue,  1 Mar 2016 15:28:15 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <002701d173cb$b3604080$1a20c180$@optonline.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288034>

On Tue, Mar 01, 2016 at 10:04:49AM -0500, Fred's Personal wrote:
> Thanks for the insight, it's been a while since I debugged a Windows call
> stack. Can you give me commands to view what gets passed to
> CreateProcessW().

Sorry, my Windows knowledge is several years old.  Maybe procmon[1] will
show them?

[1] https://technet.microsoft.com/en-us/sysinternals/processmonitor.aspx

> -----Original Message-----
> From: John Keeping [mailto:john@keeping.me.uk] 
> Sent: Monday, February 29, 2016 4:35 AM
> To: Duy Nguyen
> Cc: Fred's Personal; Git Mailing List
> Subject: Re: Trouble Cloning Git remote repository
> 
> On Mon, Feb 29, 2016 at 08:20:46AM +0700, Duy Nguyen wrote:
> > On Mon, Feb 29, 2016 at 12:48 AM, Fred's Personal 
> > <freddiewik@optonline.net> wrote:
> > > Duy,
> > >
> > > Thanks for advice, here is the result of executing the lines you
> suggested:
> > >
> > > user1@Host1 MINGW64 ~/gitrepository (master) $ export GIT_TRACE=1
> > >
> > > user1@Host1 MINGW64 ~/gitrepository (master) $ git clone -v 
> > > ssh://user1@Host2/srv/centralrepo
> > > 12:33:47.928365 git.c:348               trace: built-in: git 'clone'
> '-v' 'ssh://user1@Host2/srv/centralrepo'
> > > Cloning into 'centralrepo'...
> > > 12:33:48.022110 run-command.c:343       trace: run_command: 'C:\Program
> Files (x86)\PuTTY\plink.exe' 'user1@Host2' 'git-upload-pack
> '\''/srv/centralrepo'\'''
> > 
> > This command looks good to me. So I have no clue what goes wrong :-) 
> > Maybe you can execute this command directly, with more plink debugging 
> > options or something. You don't have to run git-upload-pack. Just 
> > spawn a shell. Another option is try something other than plink (does 
> > git-for-windows come with ssh.exe?)
> 
> On Windows it's probably going through mingw_spawnve_fd() which reassembles
> a quoted command line from the individual arguments.  It would be
> interesting to see what gets passed to CreateProcessW().
> 
> > > ##>>>Lines from $HOME/.bashrc (See below, removed here for clarity)
> > >
> > > + user1@Host2 git-upload-pack /srv/centralrepo
> > > bash: user1@Host2: command not found
> > > fatal: Could not read from remote repository.
> > >
> > > Please make sure you have the correct access rights and the 
> > > repository exists.
> > >
> > >
> > > Regards,
> > > Fred
> > >
> > > freddiewik@optonline.net
> > >
> > >
> > > -----Original Message-----
> > > From: Duy Nguyen [mailto:pclouds@gmail.com]
> > > Sent: Saturday, February 27, 2016 4:36 AM
> > > To: Fred's Personal
> > > Cc: Git Mailing List
> > > Subject: Re: Trouble Cloning Git remote repository
> > >
> > > On Sat, Feb 27, 2016 at 6:03 AM, Fred's Personal
> <freddiewik@optonline.net> wrote:
> > >> $ git clone -v ssh://user1@Host2/srv/centralrepo Cloning into 
> > >> 'centralrepo'...
> > >>>>>Lines from $HOME/.bashrc
> > >>   + export
> > >> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/
> > >> usr
> > >> /games
> > >> :/usr/local/games
> > >>   +
> > >> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/
> > >> usr
> > >> /games
> > >> :/usr/local/games
> > >>   + PROMPT_COMMAND=
> > >>   + CDPATH=
> > >>   + '[' '' = yes ']'
> > >>   + PS1='${debian_chroot:+($debian_chroot)}\u:\W\$ '
> > >>   + export GIT_TRACE_PACKET=1
> > >>   + GIT_TRACE_PACKET=1
> > >>   + export GIT_TRACE=1
> > >>   + GIT_TRACE=1
> > >>>>>End of Lines from $HOME/.bashrc
> > >> ## WHERE DOES The following line COME FROM????What Script spits out 
> > >> this line????
> > >>   + user1@Host2 git-upload-pack /srv/centralrepo
> > >
> > > Try set GIT_TRACE=1 at the clone line, I have a feeling that this line
> should be "ssh user@Host2..." but "ssh" is missing.
> > >
> > > $ export GIT_TRACE=1
> > > $ git clone -v ssh://user1@Host2/srv/centralrepo
> > > --
> > > Duy
> > >
> > >
> > > -----
> > > No virus found in this message.
> > > Checked by AVG - www.avg.com
> > > Version: 2016.0.7442 / Virus Database: 4537/11702 - Release Date: 
> > > 02/26/16
> > >
> > >
> > 
> > 
> > 
> > --
> > Duy
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in the 
> > body of a message to majordomo@vger.kernel.org More majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> 
> 
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2016.0.7442 / Virus Database: 4537/11716 - Release Date: 02/28/16
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
