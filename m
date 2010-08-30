From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 21:02:36 -0500
Message-ID: <20100830020236.GH2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
 <20100829212419.GC1890@burratino>
 <AANLkTik_kPy8p-OTy8E7fcLFMfKFHex2ppw4Oy7BesUX@mail.gmail.com>
 <20100829223218.GL1890@burratino>
 <AANLkTik3H6hVgViAX5ur9Tq4tFQ9mJEPuTmAwcrLStvU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:04:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Optjg-0000IG-KY
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab0H3CEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 22:04:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34744 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab0H3CEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 22:04:31 -0400
Received: by ywh1 with SMTP id 1so1489368ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6jaMTunUyREGklVoeXQqKVgTzjR7yYxI7cybo7U84g8=;
        b=jM/1TtIE6upeKKxlNx1LwC9KDdDj3eFIIzp7dMWVPdJH5A18t0uvv3kFjm6ketW5Zs
         ZwLfQ4FN5dDhMNy1RR4hOIch9k/iRlG0k90mX6lwAdPWD7IMolwV1tK7vUCqwt6LKT0i
         eYlrwqg7aWaphaWp2sXCpdlwPBI6+xDTGLH/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MDX0v5Y56e45KbwPlo/hC2ZkcumU8Rbj+9d0LjY2XPNp4fUMc0ySdTTy8dZDlPIPZJ
         RrtJbTK8kNHYTSl0bnIa/0nbiev7o12QWnf6BWW/f+TGdLPWb0HhtPuQzD5hxU7zONnI
         Qe//MEfXPD6fPB/FBQonSR5ROBVXbpQNY+/Us=
Received: by 10.150.142.17 with SMTP id p17mr4542579ybd.265.1283133860704;
        Sun, 29 Aug 2010 19:04:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f6sm2118092yba.19.2010.08.29.19.04.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 19:04:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik3H6hVgViAX5ur9Tq4tFQ9mJEPuTmAwcrLStvU@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154748>

Sverre Rabbelier wrote:
> On Sun, Aug 29, 2010 at 17:32, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> where an error might go undiagnosed (and any error message drowned out
>> by the summary fast-import writes at the end).
>>
>> Will think more.
>
> As far as I'm concerned that should be the responsibility of the
> importer. If there is an error it should make sure not to drown the
> error message with it's summary. I think it does a pretty good job at
> that already though, doesn't it? It even saves a log file to try and
> help you diagnose what went wrong.

I was thinking specifically of the case where one is unlucky enough
for the stream to end at a valid, early spot.

The way all importers seem to end up is to call "git fast-import" as a
child process (rather than advertising an interface like

	svnrdump dump <URI> | svn-fe | git fast-import

) so maybe this is not such a big deal.
