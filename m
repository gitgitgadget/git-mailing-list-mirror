From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sun, 16 Nov 2008 13:12:48 +0100
Message-ID: <200811161312.50090.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <7vprkx5gqb.fsf@gitster.siamese.dyndns.org> <cb7bb73a0811150425j2475db8dsdee57c1cc5e208ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 13:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1gWJ-00007v-S2
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 13:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYKPMNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 07:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYKPMNG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 07:13:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47183 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYKPMNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 07:13:05 -0500
Received: by ug-out-1314.google.com with SMTP id 39so213239ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dOlSSsINQfHvc6XI0DZ94xMw0V8ZHLPgMPRXv53cJfY=;
        b=C13+L8PIJotYOsbjMxXrEDWeKJLck2amgaA73OdgdNrhlhxO7uEh/ZSyS6GfzOfqXQ
         c4cIUCosjiWejFMOUw6ma+3dusJ5k9fbHWieOUGa9g+qH4rI1zLTUD9TEmS3B406WQsO
         WZoYWz4rhtZcMotJ7ZkQhCwy8CH0qDfMxgZc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aT8F8Mbs1xDfkJ0yRTzJXfWFdTYuK+5aWuz/eooL8Y8xoW0dDRi/XQkMReB0V+5uW1
         I0Y0pKnopweajDcfNFoSjCmiQhUTw+BSpIQhjoFc+bpK5Z+oNxTenVqfK0Vhm3oupuUX
         25AZF91nyZlayZ7yi2l7O1sbdQ6sp4wCbz3mA=
Received: by 10.210.52.9 with SMTP id z9mr2916989ebz.177.1226837581933;
        Sun, 16 Nov 2008 04:13:01 -0800 (PST)
Received: from ?192.168.1.11? (abwa41.neoplus.adsl.tpnet.pl [83.8.224.41])
        by mx.google.com with ESMTPS id 7sm2521432eyg.9.2008.11.16.04.12.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 04:13:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0811150425j2475db8dsdee57c1cc5e208ab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101123>

Giuseppe Bilotta wrote:
> On Sat, Nov 15, 2008 at 1:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> Second, this patch wouldn't do what you want from it if there are
>>> remotes with '/' in name.  I for example use "gsoc2008/gitweb-caching"
>>> for Lea Wiemann repository with her GSoC 2008 work on adding caching
>>> to gitweb.
>>
>> I think your point is if you also use gsoc2008/gitstats from another
>> remote repository, these two sets of remote tracking branches will be
>> shown grouped together.  But is it a bad thing?  After all, you chose to
>> use hierarchical names for them, _and_ you chose to use the same toplevel
>> hierarchy name for them.  Doesn't that mean you _wanted_ to have them both
>> appear in the same GSoC 2008 group?

Actually I _don't_ have 'gsoc2008/gitstats' remote, nor gsoc2008/gitstats/*
remote-tracking branches. 'gsoc2008/gitweb-caching' is the only remote
with hierarchical name. But I digress...

> The problem is that we have gsoc2008/gitweb-caching/branch1
> gsoc2008/gitweb-caching/branch2 gsoc2008/gitstats/branch3
> gsoc2008/gitstats/branch3, and my current code would show
> gitweb-caching/branch1, gitweb-caching/branch2 etc under gsoc2008.

I'm not sure if it wouldn't be simpler solution to just code _sorting_
heads-like view ('heads', 'remotes', 'tags') by ref name, or by age.
It would be best to have both, even...

Even without dividing 'remotes' view into subcategories (and
subsubcategories) you would have natural grouping:

 gsoc2008/gitweb-caching/branch1
 gsoc2008/gitweb-caching/branch2
 gsoc2008/gitstats/branch3
 gsoc2008/gitstats/branch4

if sorted by branch (ref) name, and not (possibly)

 gsoc2008/gitweb-caching/branch1
 gsoc2008/gitstats/branch4
 origin/todo
 gsoc2008/gitweb-caching/branch2
 gsoc2008/gitstats/branch3

when sorted by age (hmmm... committerdate or authordate?)

> Having branch1 and branch2 under gsoc2008/gitweb-caching, and branch3
> and branch4 under gsoc2008/gitstats would be more logical,
> remote-wise, but it would of course lose the coupling between all the
> gsoc2008 remotes.
> 
> If deep nesting is not a problem, I can code something to have
> gitweb-caching and gistats under gsoc2008, and the respective branches
> within.

The problems with nesting is those pesky remotes with only single
tracked branch to them; they are I think quote common... well, unless
you do one-shot pull, directly into local branch.

All that said, splitting 'remotes' section is difficult; using first
dirname as section is probably easiest, and good enough in most cases.
That is why I think this part should be put into separate series, to
not hinder rest of patches.

-- 
Jakub Narebski
Poland
