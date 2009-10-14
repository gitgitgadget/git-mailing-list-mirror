From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 3/8] imap-send: use run-command API for 
 tunneling
Date: Wed, 14 Oct 2009 21:58:58 +0200
Message-ID: <200910142158.59073.j6t@kdbg.org>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <200910132159.11616.j6t@kdbg.org> <40aa078e0910131327q682c7044x854fec4de60b0c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 14 21:59:24 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyA0A-0005mI-0C
	for gcvm-msysgit@m.gmane.org; Wed, 14 Oct 2009 21:59:14 +0200
Received: by yxe5 with SMTP id 5so4241271yxe.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 Oct 2009 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:from:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=0rtIOwYhCLZNPO+ySGACyYyh9dCUhMQ5MG5aYVQsyPk=;
        b=pIgtP/915b/m95Rl9zx4P9v/3V5EadiFzinDMkbnZtZQ0VJ0EqhYtnKhtF32kv/3Tc
         TOkFXCI9Hz0yPXfS5heDQTwF+xdzFCu5DWO2mprsFLLQL9jBNn2E7SsfDuTrk6CgtfD8
         tsgSkGtJCRwjkjdnKNvbnyfi1DK/84BjITZM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=VexoSTx9Wbr+EHzVZcbZDIlNGY098Ia/xSMHh0PFkSeQLybAvzMDmUtyMJ9QXB6Jvj
         2z5qzUaL+vxV9mLi3/x1VJyj+TJq9n8t5HfO/E+5MHugGg46imZ4KpR+CPL564k8v7+h
         Nf9khbDNrZuR/BecCCXF0+wkrkGrbZdFA8EeE=
Received: by 10.101.81.7 with SMTP id i7mr1051022anl.36.1255550345512;
        Wed, 14 Oct 2009 12:59:05 -0700 (PDT)
Received: by 10.176.181.37 with SMTP id d37gr7420yqf.0;
	Wed, 14 Oct 2009 12:58:54 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.173.7 with SMTP id a7mr709216ebp.3.1255550332888; Wed, 14 Oct 2009 12:58:52 -0700 (PDT)
Received: by 10.211.173.7 with SMTP id a7mr709215ebp.3.1255550332869; Wed, 14 Oct 2009 12:58:52 -0700 (PDT)
Received: from dx.sixt.local ([93.83.142.38]) by gmr-mx.google.com with ESMTP id 14si593277ewy.5.2009.10.14.12.58.52; Wed, 14 Oct 2009 12:58:52 -0700 (PDT)
Received-SPF: neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=93.83.142.38;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from localhost (localhost [127.0.0.1]) by dx.sixt.local (Postfix) with ESMTP id 31F0419F5F8; Wed, 14 Oct 2009 21:58:59 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0910131327q682c7044x854fec4de60b0c43@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130329>


On Dienstag, 13. Oktober 2009, Erik Faye-Lund wrote:
> If I were to fix this, I'd prefer not using sh at all on Windows. I've
> seen that connect.c doesn't prepend "/bin/sh -c" at all, requiring
> tunnels to be self-contained scripts or native binaries, unless I'm
> mistaken. I'm not sure if this works at all on Windows, though. I just
> think that the assumption that sh is the shell that is going to run
> the tunnel is wrong to make, especially on Windows.
>
> I'm really unsure if it's worth the hassle.

We already depend on the existence of a Bourne shell for our scripted 
commands. There are already more places in the code that run "sh" 
than "/bin/sh".

-- Hannes
