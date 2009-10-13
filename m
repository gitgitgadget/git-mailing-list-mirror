From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 3/8] imap-send: use run-command API for
 tunneling
Date: Tue, 13 Oct 2009 21:59:11 +0200
Message-ID: <200910132159.11616.j6t@kdbg.org>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com> <1255461925-2244-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:59:40 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnWl-0008F7-UA
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:59:24 +0200
Received: by mail-yx0-f141.google.com with SMTP id 5so3413623yxe.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:from:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=mBCqE9P40eHcms8eHfK8+iFxqB0Ts+epK6Cwuyzx8g4=;
        b=pHdrz0yk5mbLnLRXQieJ+JRb0w+27EqPzEeRc7VLISbQznO1yfVm9GQ/u5qRcN7pEp
         Ol4j659aCuI3GCsLAMRvMd/Qm6I1s0rch/OlCXHTuYZ5HhnB3Mvqp3Nhs58hYDIBAdQm
         lbNq26/w2yMLZXdgt45x5Kf9CuHr0k0F4h8Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=zR3DWVCRQdP6cOCkbYlS4cWEA5Qh2Fl6faNbH75BUL2j0fR/OE/qRZ3RC2HqZcC2Rx
         1N/cHqSJE8fQhcGz8mvwe5hqxqNtU1+7F2D74ApoysShRknCrQwurEVwrEry4tU31gOT
         hRl9m16vmJ249LSQnGpC4TYcZ31wggSF+rsho=
Received: by 10.101.62.10 with SMTP id p10mr906332ank.14.1255463957033;
        Tue, 13 Oct 2009 12:59:17 -0700 (PDT)
Received: by 10.176.11.6 with SMTP id 6gr7405yqk.0;
	Tue, 13 Oct 2009 12:59:06 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.147.36 with SMTP id z36mr947408ebn.13.1255463945054; Tue, 13 Oct 2009 12:59:05 -0700 (PDT)
Received: by 10.211.147.36 with SMTP id z36mr947407ebn.13.1255463945034; Tue, 13 Oct 2009 12:59:05 -0700 (PDT)
Received: from dx.sixt.local ([93.83.142.38]) by gmr-mx.google.com with ESMTP id 13si338885ewy.2.2009.10.13.12.59.04; Tue, 13 Oct 2009 12:59:05 -0700 (PDT)
Received-SPF: neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=93.83.142.38;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from localhost (localhost [127.0.0.1]) by dx.sixt.local (Postfix) with ESMTP id B099F19F586; Tue, 13 Oct 2009 21:59:11 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1255461925-2244-4-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130197>


On Dienstag, 13. Oktober 2009, Erik Faye-Lund wrote:
> +		argv[0] = "/bin/sh";
> +		argv[1] = "-c";
> +		argv[2] = srvc->tunnel;
> +		argv[3] = NULL;

Is there a particular reason that you run "/bin/sh" with a path? I doubt that 
this works on Windows.

-- Hannes
