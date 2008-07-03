From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Thu, 3 Jul 2008 12:10:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031209440.9925@racer>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <200807022104.20146.johannes.sixt@telecom.at>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: prohaska@zib.de, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,  Junio C Hamano <gitster@pobox.com>,  "Edward Z. Yang" <edwardzyang@thewritingpot.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 03 13:13:13 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEMkS-0002m3-Gf
	for gcvm-msysgit@m.gmane.org; Thu, 03 Jul 2008 13:13:13 +0200
Received: by wa-out-0708.google.com with SMTP id n36so1278671wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 03 Jul 2008 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=WDQTlONdbckH3iqOmog0QnG0yIhoE8NIa62UorSlD40=;
        b=HSzDmAQ2T1etzCLpD7Yls0mBMOME6j4qSFq1ib9qAt1Bhb92JJpZrIG0QCoDLwqhKC
         Pe2MveQT4BIUZ91coqDBKHrUaPNAZuceqGB+bpWTlEdrhi7746rs8kTz6DXhraMfXsC9
         0ZsWe24WXRaIXfsiAbOqi+5oo/QILLwv9nHvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=tcXUk9012jZlcnDQ/QdJkjDXT6U5jzx8G/wgd3vRv21EfOAWvWjtuFGF33vmL3iyFr
         ZLVJKTlAZp0dU1KZFA1MXrc24K5rSSPm2D0sXcsdXbPBUSmunDse5NyyH7sto9XSi7fC
         ECM++Ml6Qn4jcvNnvjADJ4UQlsW7Q9LEeEAfA=
Received: by 10.114.81.1 with SMTP id e1mr644254wab.9.1215083529865;
        Thu, 03 Jul 2008 04:12:09 -0700 (PDT)
Received: by 10.107.113.4 with SMTP id q4gr2592prm.0;
	Thu, 03 Jul 2008 04:12:09 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.115.17.11 with SMTP id u11mr5359265wai.18.1215083529644; Thu, 03 Jul 2008 04:12:09 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 22si9439604yxr.2.2008.07.03.04.12.09; Thu, 03 Jul 2008 04:12:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 03 Jul 2008 11:12:08 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp040) with SMTP; 03 Jul 2008 13:12:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9Ozc1h1H9l72mmxLBCeNxTNFwukQd3bsgMaT6aW uNgiNnl1NVahYZ
X-X-Sender: gene099@racer
In-Reply-To: <200807022104.20146.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87263>


Hi,

On Wed, 2 Jul 2008, Johannes Sixt wrote:

> On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> > From: Edward Z. Yang <edwardzyang@thewritingpot.com>
> >
> > PuTTY requires -P while OpenSSH requires -p; if plink is detected
> > as GIT_SSH, use the alternate flag.
> >
> > Signed-off-by: Edward Z. Yang <edwardzyang@thewritingpot.com>
> > Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> > ---
> >  connect.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/connect.c b/connect.c
> > index 574f42f..0d007f3 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -599,11 +599,13 @@ struct child_process *git_connect(int fd[2], const
> > char *url_orig, conn->argv = arg = xcalloc(6, sizeof(*arg));
> >  	if (protocol == PROTO_SSH) {
> >  		const char *ssh = getenv("GIT_SSH");
> > +		int putty = ssh && strstr(ssh, "plink");
> >  		if (!ssh) ssh = "ssh";
> >
> >  		*arg++ = ssh;
> >  		if (port) {
> > -			*arg++ = "-p";
> > +			/* P is for PuTTY, p is for OpenSSH */
> > +			*arg++ = putty ? "-P" : "-p";
> >  			*arg++ = port;
> >  		}
> >  		*arg++ = host;
> 
> What about installing a wrapper script, plinkssh, that does this:
> 
> #!/bin/bash
> 
> if test "$1" = -p; then
> 	port="-P $2"
> 	shift; shift
> fi
> 
> exec plink $port "$@"
> 
> and require plink users to set GIT_SSH=plinkssh?

I like that better than this special-casing of plink.

Ciao,
Dscho
