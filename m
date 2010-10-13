From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] fast-import: Let importers retrieve the objects
 being written
Date: Tue, 12 Oct 2010 19:07:41 -0500
Message-ID: <20101013000741.GK15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-3-git-send-email-david.barr@cordelta.com>
 <20101012223827.GB15587@burratino>
 <AANLkTi=MWyK=_7jK7B_0+GD4fWJcyjk7n+zAP2eKKw2H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 02:11:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5owI-0000Ns-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 02:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab0JMALE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 20:11:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48112 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0JMALD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 20:11:03 -0400
Received: by qwa26 with SMTP id 26so719071qwa.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5SyUbYGITD/OTZaxHTcGFWwlNl6q24yW2C2mvU0+Nec=;
        b=ZwoquD6Su6EV3YGSN4hcgml0dmrpvdrADMZLIwcwbuQ77Ui1q4slLjAxGsR/x1JQaJ
         eflaEycyCKGKUj2+noLNnADfvzY/jIsdb4t03jiHFiUNcvnkU3sMnut3pCkAF6fraBp7
         pavfc7jKmeIvkmFgpdd0OXL5WL3j9vgCndnaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aIsK+mha2T3UnguAfMwuXyg5GzoUyUJxf6qK8UgcnUDzH23wKEnOFPHN41zOMt8NKB
         AecevDhB9pptxKvAZwZxADSePE01CjRYr6Wk2Xpz+YtBy/DrrEFAvuam9qw3R9h5zdRD
         f7XqebJcXcjeF36iubXtC+rYroK+DVJy1fsYU=
Received: by 10.229.251.210 with SMTP id mt18mr6924632qcb.151.1286928662054;
        Tue, 12 Oct 2010 17:11:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm6767074qcb.0.2010.10.12.17.11.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 17:11:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=MWyK=_7jK7B_0+GD4fWJcyjk7n+zAP2eKKw2H@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158901>

Sverre Rabbelier wrote:
> On Wed, Oct 13, 2010 at 00:38, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> At any rate, that is not needed for the current version of svn-fe,
>> is it? =C2=A0So maybe it would make sense to strip down the patch to=
 just
>> allow
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cat <blob>
>
> Do we want some sort of type indicator to make it easier to extend? S=
o
> "cat blob <blob>"?

I'm not convinced it's needed.  cat-file does that to allow peeling
references:

	git cat-file tree v1.7.1
vs
	git cat-file tag v1.7.1

But the "cat" name might be too valuable namespace to reserve for only
this.  I have no strong preference either way.  Maybe the command
should be named "cat-blob".
