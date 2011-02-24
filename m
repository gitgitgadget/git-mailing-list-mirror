From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Thu, 24 Feb 2011 16:39:52 -0600
Message-ID: <20110224223952.GA22524@elie>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
 <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com>
 <AANLkTike1qDGJ-mLsSRYpBk59_evk9x5oFeGt5RSUg3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 23:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsjrF-0007Xo-Nj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 23:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab1BXWkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 17:40:07 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53590 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab1BXWkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 17:40:06 -0500
Received: by vxi39 with SMTP id 39so897233vxi.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UhpQRVdSQHyl4DEtWF1LXMNbH+Aaex48fpAyPDdFfBA=;
        b=JUM1ukdmtcPhmyM14uFKwbV8sYf9D75tFNZ3ohmWPj4GVfDAMOjQc3gUgUqjrfOKfR
         yXFKHvC7sTCEk9EXWNP9L4iPFYHu5TDzI/7pnKuigLcCEoIhc0B9JKw+SM5Oq/BhoqnY
         mWHQ3D720K8dffvdZ50nJYKH6Kixp8666fVjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pws+45zv9Rh1s1cmkXcxELe+dDi7tOyCI5x2l5Fz6xnh+eJ7Jga7K4bVyvg06SnZsk
         N0jmIo37CB8J34qTLAKk+zp7l0g/DufVvBpd+DTXLpQPeWwBpEeFUXO+sOrcWzVR4XRN
         sAdo+XMfx8sL8mqrZ1N23EUZlU0JFos9E5voc=
Received: by 10.52.158.66 with SMTP id ws2mr2590499vdb.281.1298587203892;
        Thu, 24 Feb 2011 14:40:03 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id b6sm7034vci.0.2011.02.24.14.40.00
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 14:40:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTike1qDGJ-mLsSRYpBk59_evk9x5oFeGt5RSUg3d@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167867>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> IIRC last time this was discussed I asked whether the size of the
> binary mattered for execution startup time (i.e. more so than on
> Unix). We're only invoking printf(1) and git-sh-i18n--envsubst, both
> of which only are (or only need to be) linked to libc.

printf is usually built in to the shell.  I think if we're very
careful about quoting shell metacharacters then we can get by using
eval in place of envsubst.  See the message that

 http://thread.gmane.org/gmane.comp.version-control.git/160396

is a reply to (which does not seem to have hit the ml; sorry about
that).

I hope preprocessing away the "eval" is not needed. :)

> It would also be interesting to have some real world benchmarks on
> Windows with and without this series, maybe it won't be so bad.

Yes, e.g. timing from running the rebase tests in the testsuite
might be interesting.
