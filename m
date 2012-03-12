From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 12 Mar 2012 13:46:42 +0100
Message-ID: <vpq1uoyx9zh.fsf@bauges.imag.fr>
References: <1kguf28.1u417v5fn74afM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com (Junio C Hamano),
	marcnarc@xiplink.com (Marc Branchaud),
	cmn@elego.de (Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto),
	git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Mon Mar 12 13:47:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S74em-0001y9-70
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab2CLMrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 08:47:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58140 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456Ab2CLMrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 08:47:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2CCgNMI029035
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Mar 2012 13:42:23 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S74eB-0000Hq-SL; Mon, 12 Mar 2012 13:46:43 +0100
In-Reply-To: <1kguf28.1u417v5fn74afM%lists@haller-berlin.de> (Stefan Haller's
	message of "Mon, 12 Mar 2012 12:22:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Mar 2012 13:42:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2CCgNMI029035
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332160945.61269@iXMtV4JW7Nxe++bu2/+kaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192865>

lists@haller-berlin.de (Stefan Haller) writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> What do you set "upstream" to in your flow?
>
> The remote topic branch with the same name.

OK, so once it is configured, 'current' and 'upstream' do the same
thing. The difference is how the upstream is configured, and what
happens if you forget to do it.

> 1) After creating a new local topic branch, I must remember to use
> "push -u origin new-branch" the first time I push it.

For this case, I'd say 'upstream' is superior to 'current', because it
will remind you to set the upstream on the first push, while 'current'
will let you silently continue with the upstream unconfigured (which you
need for 'pull' and 'status').

> I don't want to have to remember whether this is the first time I
> push; it would be nice to be able to say "git push" the first time as
> well.

(If you're going to work colaboratively, I'd say it makes sense to push
an empty branch, just to let other people know that the branch is
created, but that's not the point here)

Probably the ideal command for you would be to allow something like

  git checkout -b topic origin/master --set-upstream=origin/topic

> 2) I get bitten by commands that configure the "wrong" upstream branch
> without me realizing it, like "checkout -b topic origin/master".

You may want to set branch.autosetupmerge to false, then. It will
disable the "set upstream" magic (but unfortunately, it will also
disable it for a plain "git checkout new-branch" which would create
new-branch automagically if origin/new-branch already exists).

Just to be clear: I'm not saying that your workflow is wrong, but my
feeling is that you wouldn't be hurt by 'push.default=upstream'. The
area of potential improvement for your case would be at branch creation
time more than at push time.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
