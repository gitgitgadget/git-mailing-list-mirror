From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 21:37:05 +0100
Message-ID: <200810272137.07309.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810270252.23392.jnareb@gmail.com> <b6jwksWkldU6N726dbI3k3yYE6WL1aXJERb9Oh1lNd8g5zdTavgRew@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Arne Babenhauserheide <arne_bab@web.de>, mercurial@selenic.com,
	SLONIK.AZ@gmail.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Oct 27 21:38:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuYr9-0002Pc-GF
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 21:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbYJ0UhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbYJ0UhQ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 16:37:16 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:52344 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbYJ0UhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 16:37:15 -0400
Received: by ey-out-2122.google.com with SMTP id 6so897736eyi.37
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 13:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=atIjAX0LTmFLyv8oXkcTS0NsrnOwBxO88AnLNazSCDc=;
        b=nvBMO3wDjHEDlZVl+OpYBWH3T91YHbVfTtHPlG6bZm8PacNdlncWSihxtOcQc6cKHU
         Bxiw6xrjMHoGpta0ExHpdYo0RBj+6niqpltceMgf+LndZXnZ2JWOtjV8FS4zVHHMY7c5
         8zlejFmTQIwfobF1MQPhvyZb2twsYQrc8WssY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LhB/cnc3hIcehTVWb4Yj3w6lEdCpyzZiVBXhwhj2UkTNlxjuLQ/lbZcjnnJ9dBYQdy
         +srqLkO0NfpxtbPYjRPshNlocQpBnA99MzF1QUNDZcsbwFPzzYu6zoQEjgXSR2ucbPqX
         iVvgPJ7y7uJ7GV+zfVONn3N3bet9Q59qpftqw=
Received: by 10.210.104.20 with SMTP id b20mr7227103ebc.94.1225139833020;
        Mon, 27 Oct 2008 13:37:13 -0700 (PDT)
Received: from ?192.168.1.11? (abwe94.neoplus.adsl.tpnet.pl [83.8.228.94])
        by mx.google.com with ESMTPS id z34sm351773ikz.0.2008.10.27.13.37.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 13:37:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b6jwksWkldU6N726dbI3k3yYE6WL1aXJERb9Oh1lNd8g5zdTavgRew@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99263>

On Mon, 27 Oct 2008, Brandon Casey wrote:
> Jakub Narebski wrote:
> > On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
> > >
> > > Also, looking at git, git users still have to garbage collect regularly, which 
> > > shows to me that the design wasn't really cleaner. 
> > 
> > Well, they have to a lot less than they used to, and there is 
> > "git gc --auto" that can be put in crontab safely.
> 
> I think you missed the most convincing argument _for_ explicit garbage collection.
> 
> By allowing explicit repository packing, git allows you to delay a cpu intensive
> operation til later, when time doesn't matter, like at the end of the day right
> before I go home. It also allows more cpu intensive delta/compression algorithms
> to be used.
> 
> By contrast, mercurial performs deltafication and compression on each commit.
> So, acceptable commit speed must be weighed against the complexity of the
> deltafication/compression algorithm and file format.

On the one hand one can use different compression for loose (immediate)
and packed (in a free time) objects.

On the other access from "smart" client (git://, ssh://, future "smart"
HTTP server) results in creating a pack, so we cannot allow for too
tight pack compression, or to be more exact too much CPU load taken.

The ability to vary 'quality' of pack compression is very useful to
distinguish between very loosely packed fast-import pack, and tightly
repacked in free time.

-- 
Jakub Narebski
Poland
