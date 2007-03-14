From: Theodore Tso <tytso@mit.edu>
Subject: Re: [GIT PULL] Please pull mergetool.git
Date: Wed, 14 Mar 2007 02:17:44 -0400
Message-ID: <20070314061744.GA12710@thunk.org>
References: <E1HRI5K-0008T9-9e@candygram.thunk.org> <20070314055923.GA20978@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 07:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRMoS-0008T7-QW
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 07:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbXCNGSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 02:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030667AbXCNGSN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 02:18:13 -0400
Received: from thunk.org ([69.25.196.29]:42093 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030480AbXCNGSN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 02:18:13 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HRMu5-0003Q5-HV; Wed, 14 Mar 2007 02:24:05 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HRMnx-00043b-1e; Wed, 14 Mar 2007 02:17:45 -0400
Content-Disposition: inline
In-Reply-To: <20070314055923.GA20978@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42177>

On Wed, Mar 14, 2007 at 01:59:23AM -0400, Shawn O. Pearce wrote:
> Theodore Ts'o <tytso@mit.edu> wrote:
> > +    base_mode=`git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}'`
> > +    local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
> > +    remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
> > +
> > +    base_present   && git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
> > +    local_present  && git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
> > +    remote_present && git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
> 
> Why not use `git checkout-index --stage=all "$path"` ?
> E.g.:
> 
> 	git checkout-index --stage=all "$path" |
> 	read base_temp local_temp remote_temp path
> 
> I'm not trying to nitpick, I'm just curious about why this particular
> feature of checkout-index was not useful here.

1)  I didn't know about it.

2) If I used it would I have to have renamed the files to
<path>.LOCAL, <path>.BASE, et.al, because with most of the graphical
merge tools, the filename is the only thing which gets displayed to
tell the user which file came from the local branch or the remote
branch or the base revision --- since file names such as
.merge_file_QBaxrn and .merge_file_prSEqs don't have a lot of human
meaning.....

So I don't know that it would havce saved much in the script.  You
replace three invocations to git-cat-file with one invocation to
git-checkout-index plus three invocations to mv.

Regards,

						- Ted


			
