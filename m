From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2] Fix symlink __stdcall problem at MSVC
Date: Fri, 21 Aug 2009 10:57:10 +0800
Message-ID: <1976ea660908201957l76ebf555wbbbda0dbfb8cbdd7@mail.gmail.com>
References: <1250778072-4324-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Aug 21 04:57:34 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-px0-f159.google.com ([209.85.216.159])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeKJp-00068d-Ne
	for gcvm-msysgit@m.gmane.org; Fri, 21 Aug 2009 04:57:33 +0200
Received: by mail-px0-f159.google.com with SMTP id 31so2685059pxi.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 20 Aug 2009 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=95XRPGOVhjSnzMv3v0K4BPvo4+q+rfvlNtwjTLXK4G0=;
        b=UHRNdvFDOZUXmup4MNTOIeMUWL46O0h73uF7qzM9Pyt9LbcROs0Ysi0MPJ1xzNsLTH
         8Xcof9EW6ciPnRvFT20LgUhQDPQyu4TV8ao1TAiMVBBWWN29rUShfbkDI7rcya49STxq
         jR4wJCVEO0OaaiVRmv2+H1tofnzv09HlGaVCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=dLNpFR0fClw1uvJQbtDpC+AjfHGEP9lcv2dHhY91YjHdwanlbAvAov11xUE2+/7gfW
         4k5Tj3w+2432R8zA4Hn6+Ce3exHiEgZPXCoA7FDm4o7a3Bs47AuDJjhCoPER2+zU250/
         v1yYuuJaM30vR7ROF3SA+VMtssnW+sHBzHuDk=
Received: by 10.220.82.208 with SMTP id c16mr240902vcl.28.1250823447096;
        Thu, 20 Aug 2009 19:57:27 -0700 (PDT)
Received: by 10.230.121.93 with SMTP id g29gr6626vbr.0;
	Thu, 20 Aug 2009 19:57:13 -0700 (PDT)
X-Sender: lznuaa@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.77.231 with SMTP id h39mr303301vck.1.1250823431620; Thu, 20 Aug 2009 19:57:11 -0700 (PDT)
Received: by 10.220.77.231 with SMTP id h39mr303300vck.1.1250823431594; Thu, 20 Aug 2009 19:57:11 -0700 (PDT)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24]) by gmr-mx.google.com with ESMTP id 24si177624vws.7.2009.08.20.19.57.10; Thu, 20 Aug 2009 19:57:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.24 as permitted sender) client-ip=74.125.92.24;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of lznuaa@gmail.com designates 74.125.92.24 as permitted sender) smtp.mail=lznuaa@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by qw-out-2122.google.com with SMTP id 3so265221qwe.25 for <msysgit@googlegroups.com>; Thu, 20 Aug 2009 19:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=lWqxSJSKFY/+b9EwY+Fg+4ojNBjoEvrskg77x8zVbrQ=; b=qqoBxOlV/gjWicBw/FXjBKCyeMlmQ+zpILnsOb7NW/lcbKFW28MEuy75ydEyYsiWuG 4SqTagw5qQTOgGN5h9nx61F+bGzq/6wnL8YuPBnl2122WXfPwQ9qrGMpwNVLjAxqF9L4 0zcNNmrHnKgR//na6UnQJGBO2o/JzbaAt/wD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=TCJusHzFTpzfM0easORN7YQgLNKGnJfmy2Cq0KplvcY0yjiJJ2RWKh3VV9D4bXFmpY Xlw2nZDoBpwpuzdI5MscRORwVVqd8Z3a4+P1MjbTMLz9HxWCiLygViGHfUFjLvwKbFMG z0xmLErwYKyCfzi0mkHnEbJXpYUGOj12nTFU4=
Received: by 10.224.78.207 with SMTP id m15mr440263qak.3.1250823430393; Thu,  20 Aug 2009 19:57:10 -0700 (PDT)
In-Reply-To: <1250778072-4324-1-git-send-email-lznuaa@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126668>


>
>  int symlink(const char *oldpath, const char *newpath)
>  {
> -       typedef BOOL WINAPI (*symlink_fn)(const char*, const char*, DWORD);
> +       typedef BOOL (WINAPI *symlink_fn)(const char*, const char*, DWORD);
>        static symlink_fn create_symbolic_link = NULL;
>        if (!create_symbolic_link) {
>                create_symbolic_link = (symlink_fn) GetProcAddress(
> --
> 1.6.4.msysgit.0
>

This is new patch for latest devel branch mingw.c.
