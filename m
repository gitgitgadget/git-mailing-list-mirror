From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Fri, 06 Jun 2014 21:26:03 +0200
Message-ID: <539215CB.10208@gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <20140604154503.GB22681@camelia.ucw.cz> <alpine.DEB.1.00.1406041749590.14982@s15462909.onlinehome-server.info> <20140604161625.GB23226@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>, 
 GIT Mailing-list <git@vger.kernel.org>,
 Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDZMLEGXWQLBBU5LZCOAKGQEVJSOB6I@googlegroups.com Fri Jun 06 21:26:14 2014
Return-path: <msysgit+bncBDZMLEGXWQLBBU5LZCOAKGQEVJSOB6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBU5LZCOAKGQEVJSOB6I@googlegroups.com>)
	id 1WszmG-00043Z-6E
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 21:26:12 +0200
Received: by mail-wg0-f62.google.com with SMTP id b13sf384493wgh.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=U+kIFH7cRCnxTx9Vln+btywpe1AUp46QONcDGBXd0ec=;
        b=fWuNl2S7peY0sCyDbuBEVbS7VNIcnVHn34DkhG5nei+rsWTmk3s5JwBexKE0PBgxV6
         47QEdWLB+kgc/XaytoDIsEUSRFN9prMlhSU0+/bGy65QtDQlthLDKMOMnrgc2DU5/jTc
         q4rF/uV5E4SFOABaJcZCiGuLyKfxDqTl2/udX6wq1iDzjbee0zepf9nQCtDQEDm420Bk
         rogn5gCXju0t96f9wX+e9nKe+rFHYh9nV0csZgoSTODmd8TNTcwXd+L9DClq2OJxD70d
         DsUN7dn0Q3WljCbNGurbcDBS1vmv1fXOkr+XDlHPaKSoGmI0EG5s/zU2MqUhakSmFRRD
         uJQg==
X-Received: by 10.180.14.5 with SMTP id l5mr34036wic.12.1402082771955;
        Fri, 06 Jun 2014 12:26:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.80.227 with SMTP id u3ls145250wix.19.canary; Fri, 06 Jun
 2014 12:26:11 -0700 (PDT)
X-Received: by 10.180.87.71 with SMTP id v7mr1439275wiz.2.1402082771171;
        Fri, 06 Jun 2014 12:26:11 -0700 (PDT)
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com [2a00:1450:400c:c00::231])
        by gmr-mx.google.com with ESMTPS id h4si2016286wib.2.2014.06.06.12.26.11
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 12:26:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:400c:c00::231 as permitted sender) client-ip=2a00:1450:400c:c00::231;
Received: by mail-wg0-f49.google.com with SMTP id m15so3337820wgh.32
        for <msysgit@googlegroups.com>; Fri, 06 Jun 2014 12:26:11 -0700 (PDT)
X-Received: by 10.15.53.1 with SMTP id q1mr1494267eew.7.1402082770935;
        Fri, 06 Jun 2014 12:26:10 -0700 (PDT)
Received: from [192.168.188.20] (p57A24182.dip0.t-ipconnect.de. [87.162.65.130])
        by mx.google.com with ESMTPSA id w6sm24803516eef.20.2014.06.06.12.26.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 12:26:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.msysgit,gmane.comp.version-control.git
In-Reply-To: <20140604161625.GB23226@camelia.ucw.cz>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:400c:c00::231
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250959>

On 04.06.2014 18:16, Stepan Kasal wrote:

>> plan is to switch to mingwGitDevEnv for said release. No more msysGit.
>> Like, bu-bye. Thanks for all the fish.
> 
> Interesting.
> 
> With msysgit, there is the "net installer" - first time I installed
> msys/mingw sucessfully, it was as easy as Cygwin, perhaps even
> easier.

And with mingwGitDevEnv, there's the equivalent installer at [1].

> When I go to mingwGitDevEnv home page, I read about chickens, eggs,
> and upgrading Perl (which msysGit simply gives up, hinting that it is
> almost impossible).

I have absolutely no idea what chickens and eggs that would be. If you care to elaborate, please consider using the mingwGitDevEnv mailing list [2].

> PPS: from marketing point of view, mingwGitDevEnv is far from usable
> name.  Dscho, if you support the idea, would you mind franchising
> msysGit 2.0 for a decent amount?

Doh. Marketing. As if we would sell something. I still believe developers are more interested in getting things done no matter what the tools are called. At east they should be.

[1] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-build-installer/lastSuccessfulBuild/artifact/download.html
[2] http://groups.google.com/group/mingwGitDevEnv

-- 
Sebastian Schuberth

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
