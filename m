X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git and "dumb protocols"
Date: Thu, 02 Nov 2006 10:42:57 +0000
Message-ID: <4549CBB1.7010005@shadowen.org>
References: <vpqu01i16g8.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 10:44:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <vpqu01i16g8.fsf@ecrins.imag.fr>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30709>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfa2r-0005wJ-It for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752819AbWKBKnf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbWKBKnf
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:43:35 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:61706 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752819AbWKBKne
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:43:34 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gfa2C-000400-1S for git@vger.kernel.org; Thu, 02 Nov 2006
 10:42:56 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Matthieu Moy wrote:
> Hi,
> 
> Is it possible with git to push to a server on which git is not
> installed, and if so, how?
> 
>>From the man page of git, sftp doesn't seem supported, and ssh://
> complains about git-receive-pack not being installed on the server.
> 
> The man page documents a rsync:// protocol, but
> 
> $ git push rsync://some.location.com/
> fatal: I don't handle protocol 'rsync'
> $ 
> 
> What am I missing?

To push only makes sense when you have git installed at the receiving
end.  It is the interaction between the source and destination git
instances which renders the push an effective optimisation.

If you are using rsync, then you can just rsync the whole repository out
and what is out there is as valid as your own copy.  Of course a repack
will make the whole thing changed and you'll pay on the next rsync.

git is designed with this use model involved, you 'git
update-server-info' then rsync the repo in-toto out to your http server
and it can be fetch'ed from (all be it less efficiently) by another
client.  All without any requirement for anything other than passive
data delivery at the server end.  Great if you don't have shell access etc.

-apw
