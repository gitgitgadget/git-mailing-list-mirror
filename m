From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: Binary grep t7008 known breakage vanished on Cygwin
Date: Tue, 19 Apr 2016 09:42:32 +0100
Message-ID: <20160419084232.GE2345@dinwoodie.org>
References: <20160418152149.GD2345@dinwoodie.org>
 <5715147F.7020609@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 10:42:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asRF5-0002Sx-8W
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 10:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbcDSImi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 04:42:38 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38254 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbcDSImg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 04:42:36 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so16894439wme.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 01:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+r63JA8l7wyqbGnFD07jp5ghSMBow14F0Gd5PVbgYUk=;
        b=vkVbfW/Bh5QFkrV9GmETx1Chxt7FlSghz0jK1tjs+qGJT8Ln0GMnh4Pn0owAkbJoe2
         C0D4RdB47ZpYOlZgZu+lsUHJO9AWutT1LZm8GP3tNf5FS0/kCra1qQL9mXB2SIjL6U/x
         stCE7AuQ+xja6Q2lUPCuHVfxVpMtgqplmfTOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+r63JA8l7wyqbGnFD07jp5ghSMBow14F0Gd5PVbgYUk=;
        b=OEbce5ABa1R7Ea/Ogn9OdJoixh6bcyL5mNtGHCjf+pUcYiNTDyExz6sh/aFKH/ceZm
         33ZWmZbvNsw/9znsWFh5T5/jkwpsjAbd+x2bk5jkyf13zysv0XFpz+yeBgQUsu5Y1qlp
         UB0WWOtJ2/9hfHv5A7vUzeGbLlgIXQZcmwJjFs0Hz6Y4BxF59zFyc+WIsuYkAd//ph5l
         M2BrCW96kU3YzzhumlzklU5rvnN1dM4jW6r5NnubbIFEcfn/fFcWfErSqeqGyrsucmB1
         NPWwW/Jw9b/Aand6hLLe4ZGWSTXQg3fxQIDWWdw9YQPuHrhlzA5GQILNfs7VuUKPBY1n
         qK8w==
X-Gm-Message-State: AOPr4FXqezZaMbwN9fF4pvH1+8EaHgJgtQSxgqHwT5J4MLr5RfqoTnh7I5/bZyYDGbDm7Q==
X-Received: by 10.194.92.163 with SMTP id cn3mr1806840wjb.3.1461055354840;
        Tue, 19 Apr 2016 01:42:34 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id kj9sm68413833wjb.14.2016.04.19.01.42.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 01:42:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5715147F.7020609@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291852>

On Mon, Apr 18, 2016 at 06:08:15PM +0100, Ramsay Jones wrote:
> On 18/04/16 16:21, Adam Dinwoodie wrote:
> > t7008.12 is marked as an expected failure, but building Git on Cygwin
> > including a `make configure && ./configure` step has the test
> > unexpectedly passing.  Building without the configure step has the test
> > failing as expected.
> > 
> > This appears to be behaviour specific to Cygwin; at least I get that
> > test failing on my CentOS box regardless of whether I perform the
> > configure step.
> 
> Yes, the configure sets NO_REGEX= whereas the config.mak.uname sets
> NO_REGEX=UnfortunatelyYes.
> 
> [Note that the regex bug (see t0070-fundamental.sh test #5) now seems to
> pass with the 'native' regex library]

Ah, that makes sense.

I'm still not quite sure what the "correct" thing to do here is; it
looks as though the NOREGEX=UnfortunatelyYes can disappear from
config.mak.uname, but that still leaves t7008.12 passing when it's
expected to fail.

Adam
