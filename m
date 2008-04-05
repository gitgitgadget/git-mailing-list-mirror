From: "Sean Brown" <seanmichaelbrown@gmail.com>
Subject: Re: git repository size vs. subversion repository size
Date: Fri, 4 Apr 2008 22:27:12 -0400
Message-ID: <1086fb5f0804041927m5aba1912sc71a19b8f8221e06@mail.gmail.com>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com>
	 <20080404221728.GA30728@atjola.homenet>
Reply-To: seanmichaelbrown@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 05 04:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhy8Z-0006Qy-KB
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 04:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYDEC1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 22:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbYDEC1P
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 22:27:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:51094 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYDEC1O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2008 22:27:14 -0400
Received: by fg-out-1718.google.com with SMTP id l27so298920fgb.17
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 19:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kmvk/wjIYcEpvb3Hjv7jAxgXPHS9O5/TE8YyvuszvcU=;
        b=OpMGrjntqJvA4DMgrqZK3HarbMTpbn577uLRyB0ezAJjYjDcB6JtDdsfwrl4/72q5nLGHo8YlSc0zxH9aibCBM9LWdvGU/7/cc/S2NTOjo66z2hChNInb/Bwg+IdSNK6dAw1TFIfddBjB8SltRKI7NdPsgYtXuiozD+byoH1980=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BG4aeVuLH4vxcBYNQUNA5yn8BPasm+6EArXJrRxGJz+PmmijgHS2hyk5BbHl6FLAGd3bzbPzeZ1e1ueMD+bbGV1EXQUKh/CyWUW8p5EysI//kOheDVOqd1NlEJkrZ2UnYKYcIoSh0bOVo/63QRDm/k4dEq/UFRIKy0WPCL/195o=
Received: by 10.86.53.8 with SMTP id b8mr1285201fga.32.1207362432748;
        Fri, 04 Apr 2008 19:27:12 -0700 (PDT)
Received: by 10.86.98.11 with HTTP; Fri, 4 Apr 2008 19:27:12 -0700 (PDT)
In-Reply-To: <20080404221728.GA30728@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78831>

On Fri, Apr 4, 2008 at 6:17 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de=
> wrote:
> On 2008.04.04 18:02:56 -0400, Sean Brown wrote:
>  > Last night I decided to see what storage size differences I might =
see
>  > between an svn repo and a git one.  So I imported a highly used
>  > subversion repository into git and was shocked to see how huge the=
 git
>  > version was.  I used a repo that has a lot of branches and tagged
>  > releases just to make sure importing into git would in fact keep a=
ll
>  > of the history.  It did keep the history, but the total disk usage=
 was
>  > very different:
>  >
>  > $subversionbox # du -hs ./my_sample_website/
>  > 67M   ./my_sample_website
>  >
>  > $localhost # du -hs ./git-samplesite/
>  > 3.6GB ./git-samplesite/
>
>  How much of that is in the .git/svn directory? The contents of that
>  directory are used to map git commits to svn revision and git versio=
ns
>  before 1.5.4 had a quite space consuming file format for that. The n=
ew
>  format is a lot better. If you want to switch completely, you can ev=
en
>  just delete the .git/svn directory, as that's only required as long =
as
>  you want to interact with the corresponding svn repository.
>
>  And finally, you might want to repack to repository once after the
>  initial import, to get a smaller repo. Something like:
>  git repack -a -d -f --window=3D100 --depth=3D100
>

The svn folder (in the.git directory) was only about 4.2 MB.  After
running the repack (and then after that git gc as mentioned by another
in this thread), it's still about 3.5 GB.

git-samplesite (master)]$ du -hs ./*
2.1G	./branches
1.4G	./tags
 66M	./trunk

The site does have a lot of binary files (PDFs, photographs an such).
I suppose we could leave all of the branches and tags in subversion
and just move the trunk to git, but I was hoping to make a clean break
from subversion.

If anyone has any further suggestions I'd love to hear them.

Sean

--=20

Sean Brown
seanmichaelbrown@gmail.com
