From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sun, 16 Nov 2008 13:26:09 +0100
Message-ID: <cb7bb73a0811160426g1e56faa7ia9b1f398fea039a8@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vprkx5gqb.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0811150425j2475db8dsdee57c1cc5e208ab@mail.gmail.com>
	 <200811161312.50090.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 13:27:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1giu-0003My-CC
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 13:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbYKPM0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 07:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYKPM0M
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 07:26:12 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:36885 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYKPM0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 07:26:11 -0500
Received: by ey-out-2122.google.com with SMTP id 6so812193eyi.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 04:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jovx2GsK7h2/JuwKwNrxOWOwhTM4jG3x7iEvmnExvJg=;
        b=c8uiEzRpKVIPiua2Z+ebT5Jdd1yek7gBtqBmgwd0KWMIcSZwZALO2KnfoEHMhmbW76
         kFrDmE/StKgnai8bBOUilTJBR5UK9dEdvN5EDEKpa1ju9RIW/DHYTsyai0zSJi+XliMg
         A1zLWGA1VnrTTZtvFocK/I0OEf346Yk0yTdAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xBQ6OZpNScchmsYyug4VPdU/YWdyBLdjncqLze2xANJ1RRgE8/+RC3bczkRsPYN4zP
         fibMJZ+j0puoDHZ/VkmsLTNl9UYegp463UczlcUJVO8id7bheS7xmEHcGadSdWf/afql
         E7Htjm2l1l8pOwcC5qzEkvMm1bTBgnPh+Pba8=
Received: by 10.210.126.5 with SMTP id y5mr2976689ebc.6.1226838369825;
        Sun, 16 Nov 2008 04:26:09 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sun, 16 Nov 2008 04:26:09 -0800 (PST)
In-Reply-To: <200811161312.50090.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101124>

On Sun, Nov 16, 2008 at 1:12 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>> The problem is that we have gsoc2008/gitweb-caching/branch1
>> gsoc2008/gitweb-caching/branch2 gsoc2008/gitstats/branch3
>> gsoc2008/gitstats/branch3, and my current code would show
>> gitweb-caching/branch1, gitweb-caching/branch2 etc under gsoc2008.
>
> I'm not sure if it wouldn't be simpler solution to just code _sorting_
> heads-like view ('heads', 'remotes', 'tags') by ref name, or by age.
> It would be best to have both, even...
>
> Even without dividing 'remotes' view into subcategories (and
> subsubcategories) you would have natural grouping:
>
>  gsoc2008/gitweb-caching/branch1
>  gsoc2008/gitweb-caching/branch2
>  gsoc2008/gitstats/branch3
>  gsoc2008/gitstats/branch4
>
> if sorted by branch (ref) name, and not (possibly)
>
>  gsoc2008/gitweb-caching/branch1
>  gsoc2008/gitstats/branch4
>  origin/todo
>  gsoc2008/gitweb-caching/branch2
>  gsoc2008/gitstats/branch3
>
> when sorted by age (hmmm... committerdate or authordate?)

Sorting is another interesting feature to look into, yes, but as you
mention it's a separate feature that would complement grouping.

>> Having branch1 and branch2 under gsoc2008/gitweb-caching, and branch3
>> and branch4 under gsoc2008/gitstats would be more logical,
>> remote-wise, but it would of course lose the coupling between all the
>> gsoc2008 remotes.
>>
>> If deep nesting is not a problem, I can code something to have
>> gitweb-caching and gistats under gsoc2008, and the respective branches
>> within.
>
> The problems with nesting is those pesky remotes with only single
> tracked branch to them; they are I think quote common... well, unless
> you do one-shot pull, directly into local branch.

My idea with this would be to only create a group if it has at least N
> 1 (probably N=2) entries.

> All that said, splitting 'remotes' section is difficult; using first
> dirname as section is probably easiest, and good enough in most cases.
> That is why I think this part should be put into separate series, to
> not hinder rest of patches.

Yes, I will resend the 'remote_heads' feature as a new (reduced)
patchset, then add (separate patchset) grouping for ref lists, and
then add (yet another patchset) detached head.

-- 
Giuseppe "Oblomov" Bilotta
