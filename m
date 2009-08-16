From: Frank Li <lznuaa@gmail.com>
Subject: quick question about __stdcall at run-command.c mingw.c
Date: Mon, 17 Aug 2009 07:19:22 +0800
Message-ID: <1976ea660908161619x5182762sade051f24fef13db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 01:19:52 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcp0u-0005Mj-KL
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 01:19:48 +0200
Received: by ywh4 with SMTP id 4so4426632ywh.22
        for <gcvm-msysgit@m.gmane.org>; Sun, 16 Aug 2009 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version:received
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=rPubwfACWHOSu0/2WOKZvE/6cUwY0xPvHdfyQlxVQ3Q=;
        b=x3evr9w8uw+nKYV/IxjIW2Bm6byPjoBj3gN2HA6osU3GNR93Ebr8Todm4Q4C6oAYZV
         p6lUTZMGDNajusQfiiBlHewGhPtZujzFtlXQ5Si5fbMdL88t10xKF7wQVwRUH5nGnyKM
         HHHknf5HzTi7d9Ev5q/dsaNAY3bwh2bOHB68g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:date:message-id
         :subject:from:to:content-type:content-transfer-encoding:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=VQerPKnVevbz5DISc7fzsRh0T3gAJdV45svTcscAQ1ueQGlIBi4XWQWm0Rq2rcA5jC
         Ble520VSH/y4UX0GAFLVie9fxXPo2J6wiP6GfyC9dgAjRbQvRx7b7s19fsuxf4UgQhmF
         h2oUQbgl1G+coCIKOXHMfOihfu9IPeUUrACj4=
Received: by 10.101.131.13 with SMTP id i13mr920784ann.14.1250464776305;
        Sun, 16 Aug 2009 16:19:36 -0700 (PDT)
Received: by 10.176.54.11 with SMTP id c11gr6323yqa.0;
	Sun, 16 Aug 2009 16:19:25 -0700 (PDT)
X-Sender: lznuaa@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.224.29.80 with SMTP id p16mr635870qac.16.1250464764420; Sun, 16 Aug 2009 16:19:24 -0700 (PDT)
Received: by 10.224.29.80 with SMTP id p16mr635869qac.16.1250464764395; Sun, 16 Aug 2009 16:19:24 -0700 (PDT)
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145]) by gmr-mx.google.com with ESMTP id 18si395551qyk.9.2009.08.16.16.19.23; Sun, 16 Aug 2009 16:19:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.145 as permitted sender) client-ip=74.125.92.145;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.145 as permitted sender) smtp.mail=lznuaa@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by qw-out-1920.google.com with SMTP id 5so897884qwf.0 for <msysgit@googlegroups.com>; Sun, 16 Aug 2009 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:date:message-id:subject :from:to:content-type:content-transfer-encoding; bh=wF3qycRLEs9nexvQ/nEORh0qsB0+DApadwZasmSa/kc=; b=cCuSUPTTEs6bTm2zMFSqFhV4X+VpNH1ahuW29TMMg1kvPSolFIc8OtJNLRxgl5ub10 HD/rAdwuvZToBfSYKzT2ZNcRFKr0psvOtW/20X4zM+r8+WMsYBZGG3yjUa7KczoapeS5 i8QpNz36RIhdPx0FO/qYRRSK5nPZtHhpZ/078=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:date:message-id:subject:from:to:content-type :content-transfer-encoding; b=IgBGwx6jGxA+Mpgh0zCIdYzhzitRvuufFV5/V4XGvYunICHQBkZmQ/2jYr++hcwzdh azwdbf8DNb+5ojzn2CeWMFUKdEH2vUsNk+3MFJrSP2rhfMWJ/ZWUZMjHzGcC//7/gsoX 7QiYHa21DQprzpNezBCmDj8tMrFixI/ruAFDU=
Received: by 10.224.101.79 with SMTP id b15mr3874923qao.66.1250464763006; Sun,  16 Aug 2009 16:19:23 -0700 (PDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126094>


I am tring to clear VC build patch.

I found __stdcall position break MSVC build.

static __stdcall unsigned run_thread(void *data)

MSVC require __stdcall should be between return type and function name.
like
static unsigned __stdcall run_thread(void *data)

I think msys gcc should support MSVC format.

Should I directly change to MSVC format or add _MSC_VER marcro like

#if defined(__MINGW32__)
static __stdcall unsigned run_thread(void *data)
#elif defined(_MSC_VER) /*MSVC must put __stdcall between return value
and function*/
static unsigned __stdcall run_thread(void *data)
#endif
