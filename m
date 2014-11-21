From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 3/4] engine.pl: split the .o and .obj processing
Date: Fri, 21 Nov 2014 10:48:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411211043050.13845@s15462909.onlinehome-server.info>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-4-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GitList <git@vger.kernel.org>, Marius Storm-Olsen <mstormo@gmail.com>, 
    Ramsay Jones <ramsay@ramsay1.demon.co.uk>, 
    Jonathan Nieder <jrnieder@gmail.com>, 
    Michael Wookey <michaelwookey@gmail.com>, 
    Msysgit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCZPH74Q5YNRB44UXSRQKGQEGPRCJNI@googlegroups.com Fri Nov 21 10:48:44 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB44UXSRQKGQEGPRCJNI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB44UXSRQKGQEGPRCJNI@googlegroups.com>)
	id 1XrkpW-0005KD-Ie
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 10:48:42 +0100
Received: by mail-wi0-f189.google.com with SMTP id r20sf453086wiv.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=aA5ZXzQla93+ynWXUVc8brBxlXfGKFj5x7DS6qlMaE4=;
        b=SQjM7iMeUH//+RN4qDx5AJHRSl/hNTU2fNyNW8pmUvh/wRZ1eCDy04JIp4MT1O3B1S
         kB1nDaN+b24wfviPMAbkUltKEVHU+5LjgOWak5+3oCLeVbnwcmDxUJe9t54ypedjWyia
         uTjrH0cFgnytnendfxfmqYq4s50FM6sHvRt2olacnDrP8senMjLnphQOkaGOy+vlAReX
         oMkIItHXHrpT7r+pDsKxlJuhWDy9VqBrCBIrWPTE8JLTMLHB4tEHRkUIZ3JvyTW+c3dX
         wKZcWCOKYi9EHLN4klxeyyu9xv0tokK5j987cxxBthJtBTMa5Z08k/yf/wmaMXCkqV4r
         SOTA==
X-Received: by 10.152.2.167 with SMTP id 7mr67978lav.4.1416563316970;
        Fri, 21 Nov 2014 01:48:36 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.121.72 with SMTP id li8ls185090lab.101.gmail; Fri, 21 Nov
 2014 01:48:35 -0800 (PST)
X-Received: by 10.152.6.133 with SMTP id b5mr250744laa.10.1416563315143;
        Fri, 21 Nov 2014 01:48:35 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id el8si342847wib.3.2014.11.21.01.48.35
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Nov 2014 01:48:35 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LaWlT-1YEC8J0r3X-00mI1J;
 Fri, 21 Nov 2014 10:48:28 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1416526682-6024-4-git-send-email-philipoakley@iee.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:L7RwdZ7YG0/HhgVaMXF09xtTT0DADxK5CzaZHXgDXtd4T7VcHV2
 zYkTDweCdPPgE9Ihfl8v9G5EUZsO8TzY8cQPrX1zwZzIllggqPSpfe6BDSxaCDPxqhM4tA/
 uvMM0GXoe/gFLEfo6U20f8el+7kPY+W4W7zfoDTyX/9q4Py9Zgd35p571SAFNmvKa6fZnqN
 IDJAOCVbwqwdQP/qJRCyg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Hi Philip,

On Thu, 20 Nov 2014, Philip Oakley wrote:

> Commit 4b623d80f7352 added an .obj file (invalidcontinue.obj) which was not
> processed correctly.
> 
> The generate engine then mistakenly did a s/.o/.c/  to create a request
> to compile invalidcontinue.cbj.

This is good. However, this:

> Split the '/\.(o|obj)$' in engine.pl#L353 into:
> 
>         } elsif ($part =~ /\.o$/) { # was '/\.(o|obj)$'
>             push(@objfiles, $part);
>         } elsif ($part =~ /\.obj$/) { # was '/\.(o|obj)$'
>             # push(@objfiles, $part); # do nothing
>         } else {

just repeats what the diff says, so it is unnecessary in the commit
message.

> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
> index 8e41808..16c3dd5 100755
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -264,7 +264,9 @@ sub handleCompileLine
>          } elsif ($part =~ /\.(c|cc|cpp)$/) {
>              $sourcefile = $part;
>          } else {
> -            die "Unhandled compiler option @ line $lineno: $part";
> +            print "full line: $line\n";
> +            print "A:-Unhandled compiler option @ line $lineno: $part\n"; # die (if !DEBUG)
> +#            die "Unhandled compiler option @ line $lineno: $part";

This needs to be backed out. I agree that it is nice to get going and to
debug, so I would split it out into its own commit while working on the
branch, but then drop it before submitting.

> @@ -290,14 +292,15 @@ sub handleLibLine
>[...]
>      foreach (@objfiles) {
>          my $sourcefile = $_;
> -        $sourcefile =~ s/\.o/.c/;
> +        $sourcefile =~ s/\.o$/.c/;

Ah, I see from the context that my earlier comment about the white-space
delimiter was wrong: at this stage, we already have split the list. So
this is groovy.

> @@ -343,8 +346,10 @@ sub handleLinkLine
>          } elsif ($part =~ /\.(a|lib)$/) {
>              $part =~ s/\.a$/.lib/;
>              push(@libs, $part);
> -        } elsif ($part =~ /\.(o|obj)$/) {
> +        } elsif ($part =~ /\.o$/) { # was '/\.(o|obj)$'
>              push(@objfiles, $part);
> +        } elsif ($part =~ /\.obj$/) { # was '/\.(o|obj)$'
> +            # push(@objfiles, $part); # do nothing

How about the following instead?

+		} elsif ($part eq 'invalidcontinue.obj') {
+			# ignore
 		} elsif ($part =~ /\.(o|obj)$/) {

? After all, this change is really only about handling the newly
introduced invalidcontinue.obj correctly.

Ciao,
Johannes
