From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for p4merge
Date: Wed, 28 Oct 2009 02:27:19 -0700
Message-ID: <20091028092718.GB90780@gmail.com>
References: <1256721087-72534-1-git-send-email-jaysoffian@gmail.com>
 <76718490910280221u4e1d3e78me7f9b0b45f590e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 10:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N34oU-0004V9-MT
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbZJ1J1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 05:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbZJ1J1U
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:27:20 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:51609 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbZJ1J1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 05:27:19 -0400
Received: by ywh40 with SMTP id 40so458092ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BaFqlogQX5HHcZEIACc0FBKTglHVLWFbPUV7a1Kt43A=;
        b=J4P/O0VLq+E7VcLyamDoS6cEZ3osB3v7Qyzv73qTGFFPq+dpyhaxfjJK1v6otQLDhk
         cwBuTdNIGMSBwZhSFvr7brWYOrBbS9VFrAAUWvByw1UYk17hJMWUG7nCQoRNONRqHPP6
         BRS3N8Fd8b52ekO+YNDuLK4dE+imGoxjqmWdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rLihEaEoGXcPsccGPSW+8SVci2OBQ3oiOJSzutn/1vS9NWirbyBeuiDI16FGadhkZE
         BXhb3t483eARn01DaTzXEeLnmo1+baygSuQF1CZ8nIvmzYjDnOREQ6eAetJ9IU0F+XfM
         N0Ej5+Ys9suMB59IfuTgrGqq4dOea4y/mZkVc=
Received: by 10.90.41.29 with SMTP id o29mr11204255ago.101.1256722043964;
        Wed, 28 Oct 2009 02:27:23 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm363570yxd.16.2009.10.28.02.27.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 02:27:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <76718490910280221u4e1d3e78me7f9b0b45f590e56@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131439>

On Wed, Oct 28, 2009 at 02:21:46AM -0700, Jay Soffian wrote:
> On Wed, Oct 28, 2009 at 2:11 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> > Add native support for p4merge as a diff / merge tool. There are two
> > oddities. First, launching p4merge on Mac OS X requires running a helper
> > shim (which in turn is looked for in a couple common locations, as it's
> > very unlikely to be in PATH). Second, p4merge seems to require its file
> > arguments be absolute paths.
> >
> > Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> > ---
> 
> Amusing. I didn't see Scott's patch.

Apologies Jay!

It's late and I saw Scott listed in the CC: and guessed wrong ;)

Thanks for the patch again, man.  Good stuff.



> 
> But, in my testing, for things to work properly I needed to use
> launchp4merge per:
> 
> http://kb.perforce.com/AllPerforceApplications/StandAloneClients/P4merge/CommandLineP..rgeOnMacOsX
> 
> And I also found things didn't work properly unless I provided an absolute path.
> 
> (Aside, the "right" way to launch p4merge, at least on 10.6 would be:
> 
> /usr/bin/open -b com.perforce.p4merge -W -n --args <args to p4merge...>
> 
> This way OS X's launch services would find p4merge.app wherever it is
> on the user's system. But, I think some of these options to open are
> 10.6 specific and in practice looking in /Applications and
> $HOME/Applications I think is a sane enough default.)
> 
> j.

-- 
		David
