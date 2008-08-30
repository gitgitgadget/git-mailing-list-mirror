From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 22:37:15 +0200
Message-ID: <200808302237.17017.jnareb@gmail.com>
References: <20080830173947.GF7185@schiele.dyndns.org> <20080830183413.GG7185@schiele.dyndns.org> <20080830183949.GA16415@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Robert Schiele <rschiele@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:38:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXDM-0008NB-Gf
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbYH3Uh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbYH3Uh0
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:37:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:54686 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbYH3UhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:37:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so856901fgg.17
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a+j0zdYI/xu6CK8y+BsQESTVrEqwsLwDoIwUz8w6sl8=;
        b=kAXGEbqeGKu6ejzzPAKOmqyKQNTAlAhv4j0e1Zyu49iaMm6Q0IgWTBQhux3NDMu5Xq
         XZdpBxs5PLsLDrLIDLkbJEn6sHQnmIEMf2QNwWJVgQPUgUbMOVE/0Pb2fxlfalc+nrbT
         R/Lo1CSc8n/9k/wN2ZKbHPqX1HL1VKoJ1j4ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NeoKS4dIbukIFrbckC2MWwIG1MqElnUr0AcYYp8TSFA5pA1n3hMNstlpuDhrZHXszn
         OGGeniny2bXcNeoKik1Ik475RMvAmPjw0K55nSg7lQL6MGn5HnUsUVDdMRRxDOluK67h
         Kr3KP8Cz5p3SBBCOv4Ihtp88YV1RSjh7lVCfo=
Received: by 10.86.80.17 with SMTP id d17mr3225145fgb.47.1220128643424;
        Sat, 30 Aug 2008 13:37:23 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.200.211])
        by mx.google.com with ESMTPS id e20sm3842343fga.1.2008.08.30.13.37.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 13:37:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080830183949.GA16415@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94419>

On Sat, 30 August 2008, Jeff King wrote:
> On Sat, Aug 30, 2008 at 08:34:13PM +0200, Robert Schiele wrote:
> 
> > If there are problems with that change I recommend just using my
> > initial patch changing the documentation to require Perl 5.8 since my
> > interest in Perl 5.6 support is not big enough to mess around with
> > quoting all that stuff.  If someone really needs this he or she can
> > still do it --- it should be not too difficult.

First, IIRC gitweb requires Perl 5.8 _anyway_ because of unicode stuff.

> I think it is as simple as:
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index da768ee..4ee6f89 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -61,7 +61,7 @@ sub run_cmd_pipe {
>  		return qx{@args};
>  	} else {
>  		my $fh = undef;
> -		open($fh, '-|', @_) or die;
> +		open($fh, '-|', join(' ', map { quotemeta($_) } @_)) or die;
>  		return <$fh>;
>  	}
>  }
> 
> But I didn't do any testing beyond checking that "git add -i 'file with
> spaces'" which was broken by your patch now works at all.

No, you would need something like this code from gitweb.perl (used in
very rare cases where list form of open cannot be used, which means
when we need pipeline like for compressed snapshot, or redirecting
stdout and/or stderr to /dev/null like when getting type of possibly
not existing object in git_object)

 # quote the given arguments for passing them to the shell
 # quote_command("command", "arg 1", "arg with ' and ! characters")
 # => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
 # Try to avoid using this function wherever possible.
 sub quote_command {
 	return join(' ',
 		    map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
 }


Or you can use "open $fd, '-|'" to fork, an "manually" exec/system.
-- 
Jakub Narebski
Poland
