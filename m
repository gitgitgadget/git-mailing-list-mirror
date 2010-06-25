From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP PATCH 1/7] Add skeleton RA svnclient
Date: Fri, 25 Jun 2010 09:45:44 -0500
Message-ID: <20100625144544.GA7710@burratino>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
 <1277310140-16891-2-git-send-email-artagnon@gmail.com>
 <20100625001427.GA4683@burratino>
 <alpine.561.2.00.1006251156180.2064@daniel2.local>
 <AANLkTimirObq-HBrB4rQdAprN8mfd92rfFKSegJKwMsc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 16:46:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSAAS-0006wd-5s
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 16:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441Ab0FYOp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 10:45:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48958 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449Ab0FYOp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 10:45:57 -0400
Received: by pwj8 with SMTP id 8so2376355pwj.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VrbO7UrUOzF9N2qLY6g5cVg54KKop0p0V2zdBEYfITk=;
        b=KdMniOGWlvKtppehJ+nR1KWWHXJG83H1Fv0ncXno50BQIeLEw92TPcYPJp0lI2Jqvb
         7+2JiAMEEBDicRHNgRwvEnlBJ9Q4xd4pNmT/hUGUaxNdM9vKD8Cokkskni3VE5eWQeIM
         zdmHiixsbierwlfFrlQbO6PksmUYtOO3o0cQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tDRL0Mjk7BM5YLLCFrx21G/yl38DCaTPXJIHT+2aWz94WFHmpRTLywBQGS1v5JoSJz
         riJ78WQ7OOQih8UCSKMfiuLUvxpWsqn+WujCGa9q3XbQpKQlOdvx9E440NILSo1spkuC
         E8Q5H2pEBHuePTODBa7qVSdCEyRJmYydgDYFA=
Received: by 10.142.250.10 with SMTP id x10mr969896wfh.341.1277477156737;
        Fri, 25 Jun 2010 07:45:56 -0700 (PDT)
Received: from burratino ([98.212.3.231])
        by mx.google.com with ESMTPS id e32sm153762wfj.3.2010.06.25.07.45.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 07:45:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimirObq-HBrB4rQdAprN8mfd92rfFKSegJKwMsc@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149688>

Hi Ram,

Ramkumar Ramachandra wrote:

> I also highly recommend reading the API documentation and
> going through the code for answers to "why is it like THIS" questions
> as I haven't manged to clean out the Subversion style yet.

If this code is ultimately destined for the svnsync tree (as it seems
it is), it might be possible to save time by just sticking to the svn
style.  I think this would be a typical place where we relax the git
style guidelines a bit.

On the other hand, during development, if you want to use some other
style (or if you want to write in Smalltalk for that matter), that=E2=80=
=99s
fine by me.  I don=E2=80=99t want to dictate your development style.  I=
 am
only mentioning style now because I suspect it would be easier to
review code that follows a single convention (which could be
Subversion=E2=80=99s, or Git=E2=80=99s, or some well defined hybrid, or=
 something else
entirely, or ...).

>> SVN_ERR does not print anything. =C2=A0It may return(), though.

Ah, so it is an exception handling mechanism.

> These svn_cmdline functions are actually shortcuts- they do all the
> initializations required for a "typical" command line SVN client. It
> saves me the trouble of having to figure out what I missed
> initializing: I'll be using more of them in future; to eliminate the
> auth baton creation by hand, for example.

Thanks again for the explanations.

Jonathan
