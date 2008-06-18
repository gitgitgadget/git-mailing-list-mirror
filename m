From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 19:52:00 +0200
Message-ID: <200806181952.02048.jnareb@gmail.com>
References: <1213796224-995-1-git-send-email-michael@ndrix.org> <m37icmol6y.fsf@localhost.localdomain> <alpine.DEB.1.00.0806181756540.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 19:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K91qL-00082R-H6
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 19:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbYFRRwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 13:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYFRRwS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 13:52:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:22704 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbYFRRwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 13:52:17 -0400
Received: by ug-out-1314.google.com with SMTP id h2so826279ugf.16
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7000G0FLj/ZSSTV/L6B0tsB4RGRIwN58HGaxzxigdIQ=;
        b=S8mcsioJSgotEg3Q2K5cxb9NUOS/kIR2B96LaTHnTPos1J2E90Cy5Zq4C9tjntENHS
         ip2ZwFGlxY0Ounw8BcBl2sNfwuQqZ/hUdlrwikVlJ79wA4DUN52h0u77DlfPUOUAdI8z
         W9nKsRVwQG1f/P9vw/wNIFqMuSKKXarMN6KMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Dt8WTuVs98Xy+vykqIM2HDk4BaS+hgG8mZYcOBHnQXnqfNPpEaXSxh9KuJnkZlkck6
         0L+oIkmemee4ISIzjkpQsNTRELhRWE74mFW1LrfAgE9a1Oami6Z+Eslgn7gVwKdllKQB
         28NMrCz8uF6VaOy0951vXswTcrxiDvh3wcn+Y=
Received: by 10.210.75.6 with SMTP id x6mr877577eba.29.1213811535767;
        Wed, 18 Jun 2008 10:52:15 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.255.188])
        by mx.google.com with ESMTPS id z33sm13709567ikz.0.2008.06.18.10.52.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 10:52:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0806181756540.6439@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85394>

On Wed, 18 Jun 2008, Johannes Schindelin wrote:
> On Wed, 18 Jun 2008, Jakub Narebski wrote:
> > Michael Hendricks <michael@ndrix.org> writes:
> > 
> > > Instead of using IO::String to create an in-memory filehandle, use 
> > > open() with a scalar reference as the filename.  This feature has been 
> > > available since Perl 5.8.0 (which was released in 2002), so it should 
> > > be available pretty much everywhere by now.
> > 
> > Besides if I understand correctly gitweb very much requires Perl >= 5.8 
> > because of required Unicode support.
> 
> Did I miss something?  Was this patch not more about Git.pm?

Oops... You are right, my mistake.

For my defense I'd like to point out that the patch this patch is
response to was made by gitweb caching project GSoC student, Lea Wiemann
(who should have been CC-ed, by the way).
 
> BTW I think it is not nice at all how the dependency hell with Git.pm is 
> made worse recently.

It is not dependency for Git.pm, but for Git.pm TEST.

> It is fascinating through how much _pain_ we go with the shell scripts to 
> maintain portability, even with _very_ old or obscure systems (see the SCO 
> server patches that came in not long ago!), and just walk over that 
> portability when it comes to Perl...

And I pointed out how it could be resolved (use 5.8 specific feature,
or IO::String, or skip tests).

-- 
Jakub Narebski
Poland
