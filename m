From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Git sideband hook output
Date: Wed, 9 Jun 2010 10:04:59 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
 <20100608214632.GN14847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 10:05:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMGHz-0000qF-1T
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 10:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab0FIIFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 04:05:24 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:59227 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0FIIFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 04:05:21 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o59850md024412;
	Wed, 9 Jun 2010 10:05:00 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Wed, 9 Jun 2010 10:05:00 +0200
Thread-Topic: Git sideband hook output
Thread-Index: AcsHVFTzodhnO77pTDauqwas9xSnUgAVIBOQ
In-Reply-To: <20100608214632.GN14847@spearce.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148751>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Shawn O. Pearce
> Sent: den 8 juni 2010 23:47
> To: Scott Chacon
> Cc: git list
> Subject: Re: Git sideband hook output
> 
> Scott Chacon <schacon@gmail.com> wrote:
> > Prior to 6d525d where Shawn made the receive-pack process send hook
> > output over side band #2, how did the hook output get sent to the
> > client?
> 
> It was sent over stderr, which was proxied down to the client by
> the SSH daemon.
> 
> > On older clients (before this commit) and on older servers,
> > the hook output just shows up without the 'remote:' prefix.
> 
> Because its echoed to the tty by the SSH client, without Git ever
> seeing it.
> 
> > After
> > this commit I get the 'remote:' prefix,

This explains the messy output from hooks I have seen since 
updating to 1.7.1...

> Now its being parsed out of the stream by the git client, using
> the same code that displays the progress messages during clone/fetch.
> 
> > which is kind of annoying.
> 
> Depends on your perspective.  Its nice to know that the messages
> came from the server, rather than from your client.  :-)

And it is very annoying that the output format has suddenly changed
so that the output from hooks that rely on the previous no-prefix
format no longer fit on an 80 char wide terminal where they used to
fit just fine.

> > Is
> > there a way to suppress this to get the old output format?
> 
> No.  Other than to have the hook not output anything at all.
> 
> --
> Shawn.

Here is +1 for giving us back the no-prefix output. I would like
to suggest adding a configuration option to allow users to enable 
the "remote: " prefix if they want it.

//Peter
