From: Mike Hommey <mh@glandium.org>
Subject: Re: Truncating and cleaning a imported git repositary to make it
	more usable
Date: Fri, 28 Mar 2008 21:44:52 +0100
Organization: glandium.org
Message-ID: <20080328204452.GA15737@glandium.org>
References: <1206707716.9819.15.camel@malory> <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com> <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com> <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com> <47ED204E.3020602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 21:46:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfLSW-0006F6-6T
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 21:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbYC1UpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 16:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbYC1UpN
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 16:45:13 -0400
Received: from vuizook.err.no ([194.24.252.247]:38359 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904AbYC1UpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 16:45:12 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JfLRa-0001jT-1q; Fri, 28 Mar 2008 21:45:04 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JfLRU-0004dg-JI; Fri, 28 Mar 2008 21:44:52 +0100
Content-Disposition: inline
In-Reply-To: <47ED204E.3020602@viscovery.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78436>

On Fri, Mar 28, 2008 at 05:43:58PM +0100, Johannes Sixt wrote:
> Alex Bennee schrieb:
> > On Fri, Mar 28, 2008 at 3:52 PM, Alex Bennee <kernel-hacker@bennee.com> wrote:
> > 
> >>  ajb@pitcairn:/export/git/fresh.git$ git-filter-branch --tree-filter
> >>  'rm -rf big_dira big_dirb' dev-branch
> >>  warning: refname 'dev-branch' is ambiguous.
> >>  Which ref do you want to rewrite?
> > 
> > Ignore me. Not sure why but:
> > 
> > git-checkout dev-branch
> > git-filter-branch --tree-filter  'rm -rf big_dira big_dirb' HEAD
> 
> You really shouldn't do it this way, unless you do it on a ramdisk. Better
> use an --index-filter. This is modeled after the last example in the man
> page (and, of course, untested):
> 
> git filter-branch --index-filter \
>         'git ls-files -s |
> 	 grep -v "	big_dira" |
> 	 grep -v "	big_dirb" |
>                 GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>                         git update-index --index-info &&
>          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

git filter-branch --index-filter 'git rm -r --cached big_dira big_dirb'
should be working nowadays.

Mike
