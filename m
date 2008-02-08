From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 08 Feb 2008 10:14:35 -0800
Message-ID: <1202494475.31361.45.camel@brick>
References: <200802081828.43849.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNXkp-0000KC-OZ
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 19:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709AbYBHSOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 13:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758010AbYBHSOl
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 13:14:41 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:60306 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709AbYBHSOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 13:14:40 -0500
Received: by py-out-1112.google.com with SMTP id u52so5593447pyb.10
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=6y+iAOqpIxZbyvKJx6H6JEXOxO2QM1JnHJYjySdRtBc=;
        b=NrKHpoD8HO6pllI8Lvo8pWfCIEuKCbvxpILkcliy/XT+oK98lF3v87W6/eEqDLh/Bun6Mmj4dfbgbTOBN0EcRI1JoT+SLTk5PzMq3ZIUfQYc31zMp3Ko3IeaIT+bjpVN3SYAi1oItGU9k3lQEDe+55aVeL87zusaWQxGBxMjDbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=fiJnrAAy4I78txGg8MfKQWiVraNNzcfQU30j+FXsNxao7wKQQecsnrPiAay6TL1kja0zokkQcT3vTTPBtukzB1CvT3GKu2Mn0gjCJmySZ/cYkVFnAh4mq/4ubiwSGR1HaQ4mQL0ldsgOpuIyItIrlYa4UcDNmMyf4fDlciA0+rM=
Received: by 10.141.75.6 with SMTP id c6mr8720371rvl.43.1202494478120;
        Fri, 08 Feb 2008 10:14:38 -0800 (PST)
Received: from ?128.189.248.121? ( [128.189.248.121])
        by mx.google.com with ESMTPS id c3sm14099655rvf.37.2008.02.08.10.14.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Feb 2008 10:14:37 -0800 (PST)
In-Reply-To: <200802081828.43849.kendy@suse.cz>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73120>

On Fri, 2008-02-08 at 18:28 +0100, Jan Holesovsky wrote:
> Hi,
> 
> This is my attempt to implement the 'lazy clone' I've read about a bit in the
> git mailing list archive, but did not see implemented anywhere - the clone
> that fetches a minimal amount of data with the possibility to download the
> rest later (transparently!) when necessary.  I am sorry to send it as a huge
> patch, not as a series of patches, but as I don't know if I chose a way that is
> acceptable for you [I'm new to the git code ;-)], I'd like to hear some
> feedback first, and then I'll split it into smaller pieces for easier
> integration - if OK.
> 
> Background:
> 
> Currently we are evaluating the usage of git for OpenOffice.org as one of the
> candidates (SVN is the other one), see
> 
>   http://wiki.services.openoffice.org/wiki/SCM_Migration
> 
> I've provided a git import of OOo with the entire history; the problem is that
> the pack has 2.5G, so it's not too convenient to download for casual
> developers that just want to try it.  Shallow clone is not a possibility - we
> don't get patches through mailing lists, so we need the pull/push, and also
> thanks to the OOo development cycle, we have too many living heads which
> causes the shallow clone to download about 1.5G even with --depth 1.  Lazy
> clone sounded like the right idea to me.  With this proof-of-concept
> implementation, just about 550M from the 2.5G is downloaded, which is still
> about twice as much in comparison with downloading a tarball, but bearable.

For comparison, how big was the svn repo you're testing?  My experience
has been about 15-20 times smaller than SVN once a tuned repack has
been done.

Cheers,

Harvey
