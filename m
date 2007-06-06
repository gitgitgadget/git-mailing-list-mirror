From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Wed, 6 Jun 2007 12:26:00 +0200
Message-ID: <200706061226.00689.johan@herland.net>
References: <200706040251.05286.johan@herland.net> <7vejkp5ua1.fsf@assigned-by-dhcp.cox.net> <7vwsyh4ewh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 12:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvsiU-0007yM-9Q
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 12:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbXFFK0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 06:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759302AbXFFK0K
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 06:26:10 -0400
Received: from sam.opera.com ([213.236.208.81]:47303 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758645AbXFFK0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 06:26:09 -0400
Received: from pc052.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l56AQ1dZ024692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Jun 2007 10:26:01 GMT
User-Agent: KMail/1.9.6
In-Reply-To: <7vwsyh4ewh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3367/Wed Jun  6 05:14:43 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49279>

On Wednesday 06 June 2007, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johan Herland <johan@herland.net> writes:
> > ...
> >> Or would you rather switch around the "verbose" and the
> >> "parse_and_verify_tag_buffer()" (i.e. not even attempt the thorough
> >> verification unless in verbose mode)?
> >
> > Actually I was thinking about doing something like this.
> >
> > -	if (parse_and_verify_tag_buffer(0, data, size, 1) && verbose)
> > +	if (parse_and_verify_tag_buffer(0, data, size, verbose))
> 
> Well, after running fsck with --verbose, I take the whole
> suggestion back.  I think it is a good idea to do the "thorough"
> tag validation in general, and it should not be buried under the
> verbose output, which is almost useless unless in a very narrow
> special case that you are really trying to see which exact
> object is corrupt.

Take your pick among my patches or feel free to roll your own. :)

> So I think your original patch to signal error on thorough tag
> validation failure is probably a good approach in general.
> People need to know that in git.git fsck would return non-zero
> because of v0.99 tag, but the people who get hit/annoyed by this
> ought to be minority.  It may be the case that a major portion
> of git users currently are the ones who futz with the git.git
> repository, but there would be a serious problem if it continues
> to be the case ;-)

I also noticed that a number of the early tags in the kernel repo use the 
ancient format, and would thus fail fsck.

<stroke-of-madness>
Could we replace the v0.99 tag (and other ancient tags) with "correct" 
versions, and then encourage users who have already cloned to delete their 
v0.99 tag and re-pull? New clones would of course never see the old tag at 
all. This sure as hell sounds similar to inserting foot into mouth before 
shooting oneself in said foot, but it might still be worth considering...
</stroke-of-madness>


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
