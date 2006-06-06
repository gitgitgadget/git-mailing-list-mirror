From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: New release?
Date: Tue, 6 Jun 2006 10:30:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606061019440.11478@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 10:30:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnWxM-0006Wr-Uz
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 10:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWFFIaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 04:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWFFIa3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 04:30:29 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4274 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932148AbWFFIa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 04:30:29 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 40554C20;
	Tue,  6 Jun 2006 10:30:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3327FBF3;
	Tue,  6 Jun 2006 10:30:28 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 19C13B96;
	Tue,  6 Jun 2006 10:30:28 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21369>

Hi,

On Mon, 5 Jun 2006, Junio C Hamano wrote:

>          - letting fetch-pack ask for an arbitrary commit object the
>            user obtained out of band (Eric W Biederman) -- waiting for
>            updated patch.  We would need a corresponding one-liner patch
>            to upload-pack when we do this.
> 
> This can wait.

I think that this could be an important step towards a sensible "shallow 
clone": we could introduce "remote alternates", where sha1_file 
transparently loads (and stores) single commit objects and tree objects 
together with their subtrees and blobs from a remote, if they are not 
present in the shallow repo yet.

This will be blazingly _slow_, I guess, if one does any such stupid thing 
as git-fsck-objects... However, it should be fixable (expensive commands, 
i.e. commands traversing extensive history/object lists, could just barf 
if the repo is shallow).

>          - using ~/.gitrc to give a fall-back default when
>            $GIT_DIR/config does not have values.
> 
> I suspect this would be more involved than Pasky's initial
> patch; but it can wait.

I think that this is quite important for the aliases to be useful. 
However, it does not blend well with the mmap()ifying of the config 
reading.

Also, there is the problem of unique keys. You want unique keys to be only 
unique _per config file_, i.e. the local config can override the user's 
config. This is probably only relevant for git-repo-config, though.

Ciao,
Dscho
