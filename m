From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Configure test for FREAD_READS_DIRECTORIES
Date: Tue, 04 Mar 2008 04:17:50 -0800 (PST)
Message-ID: <m3fxv6isxw.fsf@localhost.localdomain>
References: <200803041048.53399.michal.rokos@nextsoft.cz>
	<200803041217.37027.michal.rokos@nextsoft.cz>
	<7v7igi911y.fsf@gitster.siamese.dyndns.org>
	<200803041248.54197.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 13:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWW6T-00084b-II
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbYCDMR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 07:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbYCDMR4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 07:17:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:62173 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbYCDMRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 07:17:53 -0500
Received: by nf-out-0910.google.com with SMTP id g13so436009nfb.21
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=BJQzV5ecHKRg8ks+W1HnazP6dpkuNHY73I6vvUAzGRA=;
        b=pZfQ+nXHkU47km0n+POmBa53CuoRTCgz8FDb8EeK10TjPbOiwvtagJlzTbtw/fZKwvvJmmy+BqzSHblLblkUTJTLOOmJsYPk802i5MVj7/fpFHZtLurd5SEDTky5CopJ75IkdRPq2iudLIYbPEVMf/+AsXGTv5wSvcil+ebYseI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=G6N3Ssv/ggwdyfqWYt49zYx4nBQLZX2QAKfoz8V8cqItUagi5saIbajRdG+gd8aovCxysK4nXX2MukU23/ExIuEobSmvc06E+wIgepPPNqKgcIpWYbjosSnJJagp/n3u5FbIuZaIn7MMX2AEsOUo89ekTU02QX3mlYBYs6aMf8A=
Received: by 10.82.112.3 with SMTP id k3mr2849145buc.9.1204633071551;
        Tue, 04 Mar 2008 04:17:51 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id j8sm1863031gvb.7.2008.03.04.04.17.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 04:17:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24CI71V011885;
	Tue, 4 Mar 2008 13:18:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m24CI3jf011882;
	Tue, 4 Mar 2008 13:18:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200803041248.54197.michal.rokos@nextsoft.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76080>

Michal Rokos <michal.rokos@nextsoft.cz> writes:
 
> I don't know how many people care about configure script since
> there are missing bits in it again and again. I believe it could
> receive good amount of testing only when it's merged in.

Because configure script is optional, people do tend to forget to add
test to it, when adding new compile configuration option.
Configuration is mainly done by guessing based on uname.

Unfortunately we don't have maintainer for configure script, who would
catch new make configuration options, and add appropriate tests to
./configure.

> I'm trying to make GIT working on HPUX - next patch in my queue is
> about broken vsnprintf() that returns -1 on maxsize overrun. Do you
> think that it's more likely that patch will be accepted when I omit
> "broken vsnprintf()" detection code from configure.ac?

I think it would be better to split patch into two: one adding build
option, or setting it for given operating system or operating system
version, and one adding test to ./configure script.  It is much
simplier to test first patch; the patch to configure needs more
review, as it should work correctly on all operating systems.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
