Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 11824 invoked by uid 107); 4 Oct 2009 16:32:07 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 12:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270AbZJDQ1N (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 12:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbZJDQ1N
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 12:27:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54753 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757150AbZJDQ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 12:27:12 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n94GQsxE014990
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 4 Oct 2009 18:26:56 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MuTul-0001wF-LZ; Sun, 04 Oct 2009 18:26:27 +0200
To:	Jakub Narebski <jnareb@gmail.com>
Cc:	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
Subject: Re: Git push over git protocol for corporate environment
References: <00163623ac5d75929b0474e66b96@google.com>
	<200910041725.39992.jnareb@gmail.com>
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Date:	Sun, 04 Oct 2009 18:26:27 +0200
In-Reply-To: <200910041725.39992.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 4 Oct 2009 17\:25\:39 +0200")
Message-ID: <vpqtyyf5dn0.fsf@bauges.imag.fr>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 04 Oct 2009 18:26:56 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: n94GQsxE014990
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1255278418.05977@oU9Q92hupEzBg5WW2CUGyg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> On Thu, 1 Oct 2009, Eugene Sajine wrote:
>
>> Thanks to everybody for prompt answers!
>
> You are welcome!
>
>> There is one thing I'm still missing though. Do I understand correctly that  
>> if a person has an ssh access (account) to the host in internal network,  
>> then this won't be enough for him to be able to push to the repo? Should we  
>> still go through the hassle of managing the ssh keys for each particular  
>> user who is supposed to have push access?
>
> Yes, it is enough to push (and fetch) via SSH protocol.

To be a bit more precise: roughly, there are two ways to manage access
to a Git repo via SSH:

* One unix user (typically called "git") managing the repository, and
  eveybody connecting to the repo via ssh://git@.... Then, if you want
  any access control within the owned repositories for this user, you
  need a key-based authentication to be able to distinguish who's
  connecting. This is what gitorious does.

* Everyone has its own unix account, and the repository is shared (via
  ACLs or simple group-based permissions, see git init --shared).
  Then, each user can choose the way he prefers for authentication,
  and if the user has an unrestricted account (i.e. can write
  ~/.ssh/authorized_keys), then it's the job of the users to manage
  this, not the one of the sysadmin.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
