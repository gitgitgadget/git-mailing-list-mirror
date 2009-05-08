From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with 
	Git 1.6.3
Date: Fri, 8 May 2009 13:45:05 +0200
Message-ID: <81b0412b0905080445j6d91f05jb13169ebd0245935@mail.gmail.com>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
	 <1241708714-20326-2-git-send-email-spearce@spearce.org>
	 <200905080102.44053.robin.rosenberg@dewire.com>
	 <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>
	 <7vprekbfik.fsf@alter.siamese.dyndns.org>
	 <20090508004741.GU30527@spearce.org>
	 <81b0412b0905080024r211864bfhe7f70acabe0880c6@mail.gmail.com>
	 <alpine.DEB.1.00.0905081003460.18521@pacific.mpi-cbg.de>
	 <7vljp80yt4.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0905081153050.4601@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 13:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2OVv-0007pv-MA
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 13:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbZEHLpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 07:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbZEHLpH
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 07:45:07 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:51905 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbZEHLpG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 07:45:06 -0400
Received: by bwz22 with SMTP id 22so1321327bwz.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g6KXoYdZbI9pyus+Vwh2S0FvLxcivnhVzNjij01wZvc=;
        b=TvZIkyuFiyIEZuuNhAR6N+VfPUEnCtbIJ+UXYorMBdBfWjgp7/e6o+crlFVOzlWt6Z
         wpO6I+wOiDAb1V5zd5d5YyBdk2oZpZQzdl3g5ZunFNp4JC7lheeYn0/uOhojZMOY0QNt
         +TNBM8g36mJ4QxRggEJ6/fOR7/t/PvabSNmt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xgn/RKBLkJiNDkOBfRlCfGQ/nr5KW7fe+3IdxkDbRLS4nxlTNKu/FpdZlh3dk7UElZ
         wEHR1W/+7Xauy9GGsZsihV+QDyIse9m5JVhqH6J5cOgNpqNI+edm3cAgDOA/lLp1CrZU
         idzCyFWOGI9NH1Tk1mUljTF9K2HSApmg+Finw=
Received: by 10.204.119.71 with SMTP id y7mr3533938bkq.16.1241783105070; Fri, 
	08 May 2009 04:45:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905081153050.4601@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118601>

2009/5/8 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Fri, 8 May 2009, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> There must be at least some deprecation period during which also =
the
>> >> old .lock lockfiles are considered and created. Just imagine some=
one
>> >> modifying the ref with an older version, which knows nothing abou=
t
>> >> ..lck.
>> >
>> > As lock files are only supposed to be created by Git itself, and h=
ave
>> > a maximum lifetime until the end of the process, I think we do not
>> > need a grace period at all.
>>
>> Could there be people with slightly older git and shiny new jgit (or=
 the
>> other combination) working on the same repository?
>
> You mean concurrently? =C2=A0Sure, but do we have to care? =C2=A0Peop=
le doing this
> certainly know what they are doing, and live happily even with a 0.5"
> hole in their foot.

I certainly hope that'll be you, one day.

Of course people run git concurrently on the same repo. Even from diffe=
rent
machines.

That's _why_ we have the locking in the first place.

And of course there will be different versions of git installed on
these machines.
And most certainly the people will not know what they were doing, blame=
 the
hole on Git (and maybe even shoot you in return, after they'll find tha=
t stupid
message of yours in archives).
