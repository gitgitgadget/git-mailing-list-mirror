From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Tracking empty directories
Date: Tue, 1 Feb 2011 11:28:35 -0600
Message-ID: <20110201172835.GA3771@burratino>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino>
 <201102011451.17456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 18:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkK29-0007Ci-4h
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab1BAR2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 12:28:45 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63976 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab1BAR2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 12:28:44 -0500
Received: by qwa26 with SMTP id 26so6932220qwa.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 09:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lFkpSZe7xBYArv0l78X85umF2Bd0RDIFmsG3k6l4LVU=;
        b=Qr4NjmKYpEcmfzX7wmd2qwxpyv5rDsK1VXaCp1ozKu1MZfy+zJ5OvRYw0ylu293v9e
         hwMCYcJCmv0TucSPGGCMLBYvG/auEQeCzeNTWxEtGHJ6UBNc8PrLZlUaq9zG0/6mv1Uf
         tn1G5nJL+TSrnxPl+uBncQzTrugfoPlVa7Dr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mW1TjpbcZjf5JLpYSoZF10cocZkUvFzk7txYb/4dUOMQ8we8iNamVGpmO4B/MZCasn
         biV31dN7zuEadXyLOvp5FvDOqHGLRBvGACs9f1kVL89N/AXHKfTAOSSSjn2yBh5+hr9y
         hS4hLYXbTmuvcHDFstcycwiHGc99PknJ7r2Xk=
Received: by 10.224.20.67 with SMTP id e3mr2114182qab.183.1296581324262;
        Tue, 01 Feb 2011 09:28:44 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id y17sm15783346qci.33.2011.02.01.09.28.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 09:28:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102011451.17456.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165831>

Jakub Narebski wrote:

> Also one needs to remember that this would require adding extension
> to git index, because currently it tracks only files, and not 
> directories.  Explicitly tracking directories in the index could be 
> useful for other purposes...
>
> The major difficulty of this is IMHO not the UI, but tracking all those
> tricky corner cases (like directory/file conflict, etc.).

I have ideas about how to resolve those tricky corner cases, but not
about what the UI should look like.  How does one go about adding a
directory?  Does it ever get implicitly removed?

Would this actually require an index extension, strictly speaking?
Certainly one ought to register an extension name or bump the version
number to avoid confusing gits that don't know about the feature.
But after that, couldn't we (e.g.) allow the directory name (ending
with '/') as index entry?

A related question is backward compatibility (both for alternative git
implementations and for scripts that did not know that "git ls-files"
might mention an empty directory) which somehow seems less
daunting. ;-)

Jonathan
