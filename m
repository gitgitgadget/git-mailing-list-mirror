From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFD] Documentation/HOWTO translated into Japanese
Date: Thu, 14 Jun 2007 20:29:09 -0400
Message-ID: <29741172-099F-499B-8A73-A85C6360129D@mac.com>
References: <20070610.204845.115909592.tshibata@ab.jp.nec.com> <9a8748490706100524o2dff1954ja7406f9303d8499f@mail.gmail.com> <20070610162221.GA12830@suse.de> <466C3B64.4070806@citd.de> <20070611060759.GB914@suse.de> <20070611134326.GH11166@waste.org> <12c511ca0706111038j37e188b6n2677b1789d14de23@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>, Greg KH <gregkh@suse.de>,
	Matthias Schniedermeyer <ms@citd.de>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	m-ikeda@ds.jp.nec.com, git@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756339AbXFOA31@vger.kernel.org Fri Jun 15 02:30:22 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756339AbXFOA31@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyzhk-0007h4-5c
	for glk-linux-kernel-3@gmane.org; Fri, 15 Jun 2007 02:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339AbXFOA31 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 14 Jun 2007 20:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbXFOA3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jun 2007 20:29:17 -0400
Received: from smtpout.mac.com ([17.250.248.186]:64621 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbXFOA3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jun 2007 20:29:17 -0400
Received: from mac.com (smtpin05-en2 [10.13.10.150])
	by smtpout.mac.com (Xserve/smtpout16/MantshX 4.0) with ESMTP id l5F0TFJB003793;
	Thu, 14 Jun 2007 17:29:15 -0700 (PDT)
Received: from [10.0.2.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin05/MantshX 4.0) with ESMTP id l5F0TBC6017058
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 14 Jun 2007 17:29:12 -0700 (PDT)
In-Reply-To: <12c511ca0706111038j37e188b6n2677b1789d14de23@mail.gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50227>

On Jun 11, 2007, at 13:38:10, Tony Luck wrote:
>> I'd rather have a single file, marked "Japanese" (in Japanese),  
>> that had pointers to current translations. These will always be at  
>> least as current as whatever we have in the tree, if not more so.  
>> Especially when someone is trying to figure out how to work based  
>> on the year-old kernel their embedded vendor gave them.
>
> Knowing whether a translation is current or not would be useful ...  
> perhaps the translated files could include the GIT blob SHA1 of the  
> version they were translated from (and some human readable version  
> string too :-) This would allow someone reading the documentation  
> to know whether is really was current.  If it isn't, it provides an  
> easy path to see what changed in the source document since the  
> translation was made. This same diff should lighten the load for  
> people maintaining the translation.

Well, actually, if you're going that route then extend GIT to have  
support for "related" files.  Essentially you should be able to add  
metadata to a git tree which says: "files $SHA1-$PATH1, $SHA2-$PATH2,  
[...], are related".  Then there would be a "git list-related"  
command with a "--mismatch" option which would list paths for which  
$SHA1 doesn't correspond to $PATH1 or $SHA2 doesn't correspond to  
$PATH2, etc.  Some clever updating of related-status during commit/ 
clone/pull/etc could store information in the index about whether or  
not any given file is up-to-date with respect to its co-related files.

For translations, when the English version of a document is updated  
it will automatically result in a "mismatch", allowing translators to  
do a simple git-diff and see what happened.  Likewise, if the  
Japanese document is updated without changing the relationship then  
it might mean that somebody should see what changed and update the  
English version as well.  If you determine that the change was  
irrelevant for the other language (spelling/grammar fixes, etc), then  
you just update the relationship and commit that change.

It would probably be pretty trivial to implement a prototype using a  
'.gitrelated' file in the root of the git tree, although better  
integration with the index would really speed handling with lots of  
related files; instead of linear searching just iterate over the  
prepared-during-checkout "out-of-date" list.

Cheers,
Kyle Moffett
