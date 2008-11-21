From: Johan Herland <johan@herland.net>
Subject: Re: git-status for submodules
Date: Fri, 21 Nov 2008 16:27:10 +0100
Message-ID: <200811211627.10637.johan@herland.net>
References: <20081120033615.GA21128@foursquare.net> <7vabbtqga8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Frey <cdfrey@foursquare.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 16:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3XwI-00005e-Hi
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 16:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbYKUP1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 10:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756388AbYKUP1l
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 10:27:41 -0500
Received: from sam.opera.com ([213.236.208.81]:48229 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756397AbYKUP1k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 10:27:40 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id mALFRAmx018175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Nov 2008 15:27:16 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vabbtqga8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101534>

On Friday 21 November 2008, Junio C Hamano wrote:
> Chris Frey <cdfrey@foursquare.net> writes:
> > I'm using git 1.6.0.4 and trying to make submodules work for me. 
> > The init/add/update steps are a bit tedious, but workable.  The
> > problem I have is when I make a change in a submodule, then
> > git-status does not show the change.
>
> My understanding is that this is exactly by design.  The supermodule
> tracks which commit in the subproject is bound to the tree location.
>
> A mere act of changing something in the subproject directory is just
> a single, incomplete step to create a new commit in the subproject
> and will
>
> not be seen by the superproject's status.  Instead of this workflow:
> > 	cd super
> > 	vi newsuper
> > 	vi existing_file
> > 	cd sub
> > 	vi newsub
> > 	cd ..
> > 	git status
>
> the submodule support is geared toward supporting this layout:
>
> 	- "super" has a subproject X at "sub"
>
>         - When you do a real work on the subproject X, you do so as
> if there is no supermodule.  IOW, subproject X has to be able to
> stand on its own.

Chris' workflow is farily easily supported by running git-status within 
each submodule, like this:

git submodule foreach "git status; true"

If the above is too cumbersome to type, one can easily wrap an alias 
around it:

git config alias.substatus 'submodule foreach "git status; true"'
git substatus


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
