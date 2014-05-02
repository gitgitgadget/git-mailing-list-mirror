From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 4/7] pull: add --merge option
Date: Thu, 01 May 2014 21:41:34 -0500
Message-ID: <536305def1e35_23b2147b2f0bb@nysa.notmuch>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-5-git-send-email-felipe.contreras@gmail.com>
 <20140502013753.GE75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 04:52:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg3aP-0002q5-J1
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 04:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbaEBCwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 22:52:16 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:64085 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaEBCwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 22:52:15 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so118126oag.41
        for <git@vger.kernel.org>; Thu, 01 May 2014 19:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ArpnIxMy/6zGObN8Evl2Cm3efbRKS8nnZxYAe/xMtwY=;
        b=GJfgmszp9WPDT8AZZ4SI3M5kRtYzfH4W7Choo3hjeGKz3efoT+N67VL99Vo5LZCtJr
         uPPXsD/h5Yv3bSweoyG9Zm0suMRvy/2UpeU9bzDYG1etsGSaxX+YLgc4RxRLW1vRIuao
         /KNFKupKbHHM2OSA+o+ZDZ3yhomuyOOBQRHXFWaIuSQx8x3tMv0NGM5N05lih33SwYDO
         MrnP9EXcFa1CnLqzwuigyF44GHdDxd26PSeOHLyPp85EXgxZCStFlLbCDJHH7ez2tKfN
         00hN19YoSvhAUyhk9XrF8QVlu3p+IWNZGaxNnJCDzmEEfrN29PJnMvCZUB3hyNIE6BV7
         2ptw==
X-Received: by 10.60.17.132 with SMTP id o4mr14392121oed.34.1398999134992;
        Thu, 01 May 2014 19:52:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm124470052oej.5.2014.05.01.19.52.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 19:52:13 -0700 (PDT)
In-Reply-To: <20140502013753.GE75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247921>

brian m. carlson wrote:
> On Thu, May 01, 2014 at 07:00:05PM -0500, Felipe Contreras wrote:
> > Also, deprecate --no-rebase since there's no need for it any more.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/git-pull.txt |  8 ++++++--
> >  git-pull.sh                | 10 +++++++++-
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > index 9a91b9f..767bca3 100644
> > --- a/Documentation/git-pull.txt
> > +++ b/Documentation/git-pull.txt
> > @@ -127,8 +127,12 @@ It rewrites history, which does not bode well when you
> >  published that history already.  Do *not* use this option
> >  unless you have read linkgit:git-rebase[1] carefully.
> >  
> > ---no-rebase::
> > -	Override earlier --rebase.
> > +-m::
> > +--merge::
> > +	Force a merge.
> > ++
> > +See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
> > +to make `git pull` always use `--merge`.
> 
> So I'm confused here, and maybe you can enlighten me.  As I read this
> documentation, --merge would always force a merge, like --no-ff.  If so,
> I don't see an option to preserve the existing behavior, which is the
> I-don't-care-just-do-it case.  If the behavior is different, then this
> documentation needs to be improved, I think, along with the
> documentation earlier in the series.

I don't understand what is your point.

So basically you think these should be the same?

  % git pull --merge --no-merge --rebase --no-rebase
  % git pull

-- 
Felipe Contreras
