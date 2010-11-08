From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: history missing
Date: Mon, 8 Nov 2010 03:02:31 -0600
Message-ID: <20101108090230.GC2430@burratino>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Vitaliy Semochkin <vitaliy.se@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 10:02:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFNcq-0000DM-Sg
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 10:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab0KHJCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 04:02:45 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42049 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab0KHJCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 04:02:44 -0500
Received: by ywc21 with SMTP id 21so3150061ywc.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 01:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1al8e96AcvBrOnYfCzQHXnHvYnuBeCF9vsCvam64MEA=;
        b=Z159uDvUA2lxpXIJ51CLLSVlzDEaSmDcGzYBLG8X/NeYd6Cu7fjMzatwyHZUJImety
         8M3tOoNiGvLMOqtWhCLlD6bR3yHv0XeE6Vgo92/LJCGahYZNXa8W/g5q/BCC3Sm8G/uC
         /Wp3fga/5tHMWvah0ocekOq655RAw3le06S88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ohYL2eU5Dql6fZeTe9D5kPph15EFtq7mPECXhx9rwMALgjS3QJAfRDamRa/oIgy2ct
         WoQrL9Q4qjXDcUS3BaEDyViamhe+GYEDyEJOHrDxXEefmqRHE+rVr6JhlU1Es6p5bLnv
         IrNCOoGiBSWgdsL4EcGBX4c43Om4x59IIjYh8=
Received: by 10.151.102.12 with SMTP id e12mr929935ybm.311.1289206964094;
        Mon, 08 Nov 2010 01:02:44 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id o10sm1335666yha.27.2010.11.08.01.02.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 01:02:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160916>

Hi Vitaliy,

Vitaliy Semochkin wrote:

> I cloned a remote repository
> to check recent changes in origin/master I do:
> git fetch origin master
> git log origin master
> 
> recently I found out that log doesn't show recent commits

Yes, this can be confusing.

The "git fetch" command can be used in two ways: to update
remote-tracking branches and to grab some particular branch (or
other ref) quickly.

Updating remote-tracking branches
---------------------------------

Use "git fetch <remote>", or "git fetch --all" if you want to update
all remote-tracking branches.

Inspecting a particular branch
------------------------------

Use "git fetch <remote> <branch>"; this will fetch that branch and
store it as FETCH_HEAD.  You can "git log FETCH_HEAD", "git merge
FETCH_HEAD", etc, to interact with the branch head you just
downloaded.

If you want to fetch a branch to a local branch, you could use

	git fetch <remote> <branch>
	git branch <local-branch-name> FETCH_HEAD

but there is also a shorter way to write that:

	git fetch <remote> <branch>:<local-branch-name>

This form is especially useful for grabbing a subtree of the branch
hierarchy all at once:

	git fetch junio refs/heads/sg/*:gabor/*

The "git fetch <remote>" form is syntactic sugar for this syntax.  The
'fetch' lines in .git/config describe what remote:local ref specifiers
will be implicitly added to the command line after the name of a
configured remote repository.

See the "git fetch" manual for details and examples.

Hope that helps,
Jonathan
