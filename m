From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: serious problem with `git format-patch' & `git am'
Date: Thu, 26 Feb 2009 12:00:16 -0600
Message-ID: <6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil>
References: <20090225.230352.177616203.wl@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, keithp@keithp.com
To: Werner LEMBERG <wl@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 19:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LckYi-0001Nw-5p
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 19:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbZBZSAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 13:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZBZSAg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 13:00:36 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47424 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbZBZSAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 13:00:35 -0500
Received: by mail.nrlssc.navy.mil id n1QI0H4T014374; Thu, 26 Feb 2009 12:00:17 -0600
In-Reply-To: <20090225.230352.177616203.wl@gnu.org>
X-OriginalArrivalTime: 26 Feb 2009 18:00:17.0180 (UTC) FILETIME=[14D605C0:01C9983C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111584>

Werner LEMBERG wrote:
> [both version 1.6.0.2 and git from 2009-01-24]
> 
> Folks,
> 
> 
> I'm going to convert the FreeType CVS repository to git, using Keith
> Packard's `parsecvs'.  It sometimes happens that there are git entries
> titled
> 
>   *** empty log message ***
> 
> I want to massage the git repository before publishing it, replacing
> those entries with something more meaningful.
> 
> The last time I tested this (using git 1.5.something, I no longer
> remember the exact version) I did the following:
> 
>   . git format-patch <start>..HEAD
>     git reset --hard <start>
> 
>   . Edit the `Subject:' field in the created *.patch files where
>     necessary.
> 
>   . git am --whitespace=nowarn *.patch
> 
> Unfortunately, this no longer works as before, and since I can't find
> a hint in the docs about this change I wonder whether it is a bug.
> 
> With git 1.5.something, if the first paragraph of the commit message
> (as output by parsecvs) looks like this
> 
>    foo foo foo foo
>    bar bar bar bar
>    baz baz baz baz
> 
> it is emitted exactly as-is (after `git format-patch' & `git am');
> gitk shows `foo foo foo foo' as the first line.  However, git version
> 1.6.0.2 and the current git both convert newlines to spaces in the
> first paragraph!  I now get
> 
>   foo foo foo foo bar bar bar bar baz baz baz baz
> 
> as the beginning of the commit message which is VERY bad since
> CVS-style entries often have a long first paragraph, causing
> ugly-looking, overlong lines.
> 
> In case this is an intended change I ask you urgently to provide an
> option to get back the old behaviour of `git format-patch' & `git am'.

I was not aware of this behavior, but it looks like the '-k' option for
both format-patch and git-am is what you want to use.  It will prevent
mailinfo from munging the commit message.

-brandon
