From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] sh-setup: Write a new require_clean_work_tree function
Date: Sun, 26 Sep 2010 20:46:06 +0200
Message-ID: <vpqtylcgx75.fsf@bauges.imag.fr>
References: <4C9E07B1.50600@workspacewhiz.com>
	<1285514516-5112-2-git-send-email-artagnon@gmail.com>
	<vpqmxr4piyf.fsf@bauges.imag.fr> <20100926173956.GA15143@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 20:48:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzwHE-0000Dl-DJ
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 20:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab0IZSqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 14:46:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42703 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab0IZSqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 14:46:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8QIfFn2012282
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 26 Sep 2010 20:41:15 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OzwEg-0004QK-KC; Sun, 26 Sep 2010 20:46:06 +0200
In-Reply-To: <20100926173956.GA15143@kytes> (Ramkumar Ramachandra's message of "Sun\, 26 Sep 2010 23\:09\:59 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 26 Sep 2010 20:41:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8QIfFn2012282
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1286131277.92078@o4pMLdz1PJcabfmYS26DdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157250>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Also, you probably want to give all the error before you "exit 1",
>> hence stg like:
>
> Hm, is that a good idea? We want the output to be functional and
> indicative: it should tell the user what to do immediately.

Yes, but I find this very painfull when you

$ git do-something
error: you need X before you can do-something
$ do X
$ git do-something
error: Ah, you also need Y before you can do-something

> I'm afraid that displaying both errors will make the output very
> verbose. We can just tell the user about the unstaged changes, and
> wait for them to commit or stash it. Either way, both commit and
> stash will affect the index by default :)

A plain commit will get rid of staged changes, not of unstaged ones.

Your patch shows unstaged changes first. If the only problem was
unstaged changes, then "git stash --keep-index" would be a good
solution. As a user, I prefer knowing both problems to find the right
solution (and avoid trying to solve only unstaged changes before
noticing I need to solve the other one too).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
