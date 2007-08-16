From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Thu, 16 Aug 2007 12:13:28 -0400
Message-ID: <9e4733910708160913i29e18e80v107bcc3732e9db95@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
	 <20070815053231.GJ27913@spearce.org>
	 <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
	 <20070815171152.GA15155@auto.tuwien.ac.at>
	 <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com>
	 <alpine.LFD.0.999.0708151453390.5415@xanadu.home>
	 <86d4xn5287.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708161103080.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILhyZ-0002sd-O5
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 18:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765298AbXHPQNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 12:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764978AbXHPQNb
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 12:13:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:54895 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764886AbXHPQNa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 12:13:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so322776wah
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 09:13:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KtExiHHf1jbp9dXUtRcNu9WNHtzG5WuvCJ3aouNr5zQr7VntvqbO+2u0CuyGvB+hNHM+HLYMK5OHNBcOTQPTFFdWj87Tqj9u/QJs2TUQlzVLdaE0Xi4D2badi5z9n2N0WU6YFQA8qJ8qvtImGSkdb+IESdXDF+Mr228YvC2qhHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bbIlSqB7ezBlwF/A2CHi0n6x6+41vIbvZ9BmLli6XgwQcpM76bRSRSqcFo8Fg0Wgs3nGE/FwSsR3cZTvp2K1kTMXFW7m2KP08jpuH/INnEmCmS5scfNI2z5rNNQE5nvdXqXiyMWwaL6wpO3U3hPmkkqOsGK0LSSpaWfZTPmJcKQ=
Received: by 10.114.107.19 with SMTP id f19mr40766wac.1187280808527;
        Thu, 16 Aug 2007 09:13:28 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Thu, 16 Aug 2007 09:13:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708161103080.16727@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56024>

On 8/16/07, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 16 Aug 2007, David Kastrup wrote:
> > If I understand correctly, delta indices
> > for the search window are kept, and the current file is compared
> > against them.  Locality might be better if just one delta index gets
> > calculated and then compared with all _upcoming_ delta candidates in
> > one go.
>
> This appears so obvious that I attempted that a while ago already.
>
> The idea turned up to be so complex to implement correctly and produced
> suboptimal results in practice that I abandoned it.

In practice it doesn't really matter what you do. Most developers have
a decent amount of RAM. Disks run at 50MB/sec or more. The entire pack
file ends up in the kernel disk cache within a few seconds.

Turning the twenty minute delta search into 6-7 minutes is a much more
obvious win.


>
> See http://marc.info/?l=git&m=114610715706599&w=2 for the details if
> you're interested.
>
> PS: please at least CC me when replying to my mails
>
>
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
