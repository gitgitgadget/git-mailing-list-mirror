From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] supply '-n' to gzip to produce identical tarballs
Date: Sun, 10 Apr 2011 15:55:06 +0200
Message-ID: <201104101555.09798.jnareb@gmail.com>
References: <1302415936-7362-1-git-send-email-frase@frase.id.au> <m362qm4kvu.fsf@localhost.localdomain> <20110410101345.GD1521@bacardi.wooloowin.frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Sun Apr 10 15:55:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8v72-0000xK-BN
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 15:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab1DJNzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 09:55:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36824 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1DJNzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 09:55:14 -0400
Received: by bwz15 with SMTP id 15so3874545bwz.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=T+ASkeOKtVPkM4k3drIHSI45KhAQ9rlKo+lCMXb7J28=;
        b=sajSFn1JIhqWNlqICpusUu+VB3GO6uTkIslS790PpDQBmgl/4lUUklQEGnBavu0/ve
         iY9ZXSRTq2rZ6lbzY7V6oFG83anHU+I3EjlBd8+aAbl/J6QMJXjdMbsvE7Geb8F5D2by
         uRZBtkFXykMQxfdwG28oZe5Wbgtfgy0PQn3EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dFv9eAvdN+LdAu87nygvZW2N9HIA1z+xn7DQRXVOURX4fzq3lpRJiS3WOnDdWatrWX
         /DfXU1N14tUSBaQEghOzmh+lQpe5m/M6J8b62uFEWSbSgDg2Lyq1hIiBOijvGxk8XH/o
         4yAl0aQkn/K+5/n6HzAbJ1MS13Bde7bNQcrKo=
Received: by 10.204.14.5 with SMTP id e5mr3875400bka.122.1302443713326;
        Sun, 10 Apr 2011 06:55:13 -0700 (PDT)
Received: from [192.168.1.13] (abwa66.neoplus.adsl.tpnet.pl [83.8.224.66])
        by mx.google.com with ESMTPS id b6sm2669542bkb.10.2011.04.10.06.55.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 06:55:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110410101345.GD1521@bacardi.wooloowin.frase.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171252>

On Sun, 10 Apr 2011, Fraser Tweedale wrote:
> On Sun, Apr 10, 2011 at 12:38:32AM -0700, Jakub Narebski wrote:
> > Fraser Tweedale <frase@frase.id.au> writes:
> > 
> > > Subject: [PATCH] supply '-n' to gzip to produce identical tarballs
 
> > Very good description, except subject line should denote which
> > subsystem this commit affects, i.e.:
> > 
> >   gitweb: supply '-n' to gzip to produce identical tarballs
>  
> Thank you.  Do I need to amend the message and resubmit the patch?  (first
> time submitting a patch to git; I used git send-email).

I don't think so.  I guess that Junio can do such trivial amend when
applying, at the time he is adding his signoff.

> > Hmmm... gzip in gitweb's 'snapshot' action gets data compressed from
> > standard input, not from filesystem.  Isn't -n / --no-name no-op then?
> > Just asking...
> 
> It is not no-op; I have tested to confirm this.  I'm not sure whether
> a file name is recorded in the stdin case, or if so what it is, but the
> timestamp is recorded and that makes the difference.

Thanks for the clarification.

For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>


> > > -		'compressor' => ['gzip']},
> > > +		'compressor' => ['gzip', '-n']},
> > 
> > Perhaps it would be more clear to use
> > 
> >   +		'compressor' => ['gzip', '--no-name']},

> Definitely, if the argument is the same (or even present) on all systems.
> On FreeBSD and GNU both '-n' and '--no-name' are do the job, but an audit
> of other systems should be done to ensure they don't break.  I chose '-n'
> as it seemed the more conservative choice.

So you choose '-n' because it has more chance of being widely supported,
isn't it?  Good enough for me.

-- 
Jakub Narebski
Poland
