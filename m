From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git and peer review
Date: Mon, 5 May 2008 08:52:38 +0800
Message-ID: <46dff0320805041752t1190534dy3740c88f5380098f@mail.gmail.com>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com>
	 <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Toby Allsopp" <Toby.Allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Mon May 05 02:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsoxa-0007ZN-Kx
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 02:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYEEAwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 20:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYEEAwk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 20:52:40 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:64640 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYEEAwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 20:52:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so496652and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=P3Ukt5Rph8GndzATSEpt3bwLJnTRYFhNM7+9LgSr1pQ=;
        b=e9JLOrxaZvnVP/uPx4pWFWuEVe0ygaT/nVhQNykZzfzSayyjeawsHtdNv6jny7HuUtf6Sz9fGF6FJuFE640gJhd1U6bgWID6MX6IM0HGG/OMSvZ//Qtp0wUOkmPGrMkyWifhW4JOrs0xMerhwy/bbgQ3Qii+0y4UHqT+b84dgoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ipv+/b0k+RfyOazCojMynrm0tnxS9h2KVDQRFNxQhsEGjWBQccE5gzE12dEtzg+ReoPSoGo3S4VYilRlSShhas7QLgql7kllj8TvBtDayGI0oaADFtYueDOmLG1XqKCdbWvzQbhr8KQioZe7rLYGRjO/BALOgZqR/movMJTl0Po=
Received: by 10.100.212.13 with SMTP id k13mr7033711ang.43.1209948758383;
        Sun, 04 May 2008 17:52:38 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 4 May 2008 17:52:38 -0700 (PDT)
In-Reply-To: <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81213>

On Mon, May 5, 2008 at 4:21 AM, Toby Allsopp <Toby.Allsopp@navman.co.nz> wrote:
> On Sat, May 03 2008, Ping Yin wrote:
>
>  > Case 1
>  >     I ask someone to review my patches at my machine. If the review
>  > passes, i have to add Reviewed-by line to each commit and then merge
>  > it to the master branch. However, i find no easy way to add
>  > reviewed-by line. Maybe adding --reviewed-by  option to cherry-pick or
>  > rebase or merge?
>  >
>  > Case 2
>  >    The reviewer is the maintainer, so i ask him to pull and review. So
>  > now it is his turn to add review-by line. But still, how?
>
>  I do something similar using git filter-branch --msg-filter.  I have a
>  little shell script call git-add-checked (our convention is to have a
>  "checked: " line in the commit message):
>
>  --8<---------------cut here---------------start------------->8---
>  #!/bin/sh
>
>  usage() {
>     cat <<EOF
>  Usage: git-add-checked <checker> [<filter-branch options>] <rev-list options>
>  EOF
>  }
>
>  checker="$1"
>  [ -n "$checker" ] || { usage >&2; exit 2; }
>  shift
>
>  set -x
>  git filter-branch --msg-filter "sed '\$a\\
>  \\
>  checked: $checker'" "$@"
>  --8<---------------cut here---------------end--------------->8---
>
>  Then, after getting my changes reviewed, I just do:
>
>  $ git-add-checked joe.bloggs trunk..
>
>  This adds a "checked: joe.bloggs" line at the end of the commit message
>  for all of the commits on the current branch since trunk (which is a
>  remote branch maintained by git-svn).
>

Great, very useful for me. THX.


-- 
Ping Yin
