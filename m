From: David Aguilar <davvid@gmail.com>
Subject: Re: How do you best store structured data in git repositories?
Date: Thu, 3 Dec 2009 16:14:10 -0800
Message-ID: <20091204001359.GA6709@gmail.com>
References: <1259788097.3590.29.camel@nord26-amd64> <32541b130912021317y705d1d4cj28e230a3e727df2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sebastianspublicaddress@googlemail.com, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 01:13:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGLnb-0002RF-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 01:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbZLDANP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 19:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbZLDANP
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 19:13:15 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:57651 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZLDANO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 19:13:14 -0500
Received: by ywh12 with SMTP id 12so2047399ywh.21
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 16:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/eD1oNhE3TMIPTxbmLZe+iaATib8ZWJpFJRHn4OpLzY=;
        b=eYtAssSawXKISjSMs1/U9ySyG8er92kpGiDLQpmoEHmwOhBNo6lUbStob05CbVDa/4
         Gu/oWPrzrp+wxROIlTqXcyjQl+PCg5/Yb/ifZ0GEgYx4RN8pFipSBX4Exu35GepLpRz6
         cwFwZJoLx12s5M2E9xEdYWQfVGvx/Q84Aw7Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WxoKKKCVJyDESOS5C91RySLzJvwDadWFJYHer+2R1GNY3hpAgjTIcWqQspC59sIDd+
         QANH8itEH4BQYSAfWpwlvnjJJhrOr34oQX8rPgQDyZluhu3F4ADoFdwh535qemW7MFlx
         ZkaRH66jL9yfUXKCVmh4bV0WKyQ7WLBTJ2NAQ=
Received: by 10.150.127.17 with SMTP id z17mr4171523ybc.61.1259885598526;
        Thu, 03 Dec 2009 16:13:18 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 6sm1009185ywd.52.2009.12.03.16.13.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 16:13:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <32541b130912021317y705d1d4cj28e230a3e727df2e@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134484>

On Wed, Dec 02, 2009 at 04:17:10PM -0500, Avery Pennarun wrote:
> On Wed, Dec 2, 2009 at 4:08 PM, Sebastian Setzer
> <sebastianspublicaddress@googlemail.com> wrote:
> > Do you store everything in a single file and configure git to use
> > special diff- and merge-tools?
> > Do you use XML for this purpose?
> 
> XML is terrible for most data storage purposes.  Data exchange, maybe,
> but IMHO the best thing you can do when you get XML data is to put it
> in some other format ASAP.

I agree 100%.

JSON's not too bad for data structures and is known to
be friendly to XML expats.

http://json.org/


> That said, however, you should still try to make your files as stable
> as possible, because:
> 
> - If your program outputs the data in random order, it's just being
> sloppy anyway
> 
> - 'git diff' doesn't work usefully otherwise (for examining the data
> and debugging)


If you were using Python + simplejson then using something
like the sort_keys=True flag would ensure that your data
is stable as the dictionaries keys will always appear in a
deterministic order.

Since I mentioned JSON and git in the same email then I might as
well also mention an old UGFWIINI candidate:

http://www.ordecon.com/2009/04/22/is-git-more-than-just-a-version-control-system/


Lastly, BERT might not be a good choice for storing inside
of a git repository, but it is a nice format for representing
data structures:

http://github.com/blog/531-introducing-bert-and-bert-rpc


We've been using git for tracking changes to a large set of
JSON files at $dayjob and it's worked out pretty well.

I'd suggest that you try to break your data up into multiple
files if possible.  As someone else mentioned, it's often
easier to diff and merge stuff if you structure things in a
merge-friendly way.

One feature that we've implemented is file referencing
where data can "#include" another data file.  That is
the kind of thing that can make things easier on you if
you foresee having a lot of common data that can be
shared amongst the various different files.

-- 
		David
