From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Submodules use case: web development based on modular CMS
Date: Sun, 27 Jan 2008 16:00:52 +1300
Message-ID: <46a038f90801261900s2c4fa348wd5e0aea4ed9f1c12@mail.gmail.com>
References: <200801270139.57830.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 04:01:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIxm4-0002NC-6j
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 04:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYA0DAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 22:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYA0DAy
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 22:00:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:43947 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbYA0DAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 22:00:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so770093ugc.16
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 19:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6IRJQPFZmBtjNbQ7hhmSryHOJYyGapMU0xWYappAiGg=;
        b=C/hvlXOjSIckvloHeheFZqVTKgleDvVgujzHq+hzNz0kQkI+aaBtMzW4DlKpq0tquiq84eza1ehIIhGEFmJeTz9vGIbNz+rdDkXPwBIN5rspxGqo/yZzuO4wC6qCiGQ9YYOSOhsL/xYJc3NEP/McuM1dj3N9sgxFPGxQTrYM1EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YsqVdQf9APcZSNnpNrEkGAYlQTg/zhDnmxDCv7DPQtwhD4y3nll2YG1wHzdSgOElJCOjslqkMTBBa6GIRGuL4sMo1iFAyEkOv/orbwtnIGDGYuRI1019xVO5A3uRfVuRuEiozGuUtOCPtgNoIZiMEygS9S42UBb8VfwvAopIwig=
Received: by 10.67.196.4 with SMTP id y4mr625696ugp.39.1201402852123;
        Sat, 26 Jan 2008 19:00:52 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Sat, 26 Jan 2008 19:00:52 -0800 (PST)
In-Reply-To: <200801270139.57830.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71800>

On Jan 27, 2008 1:39 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> A bit of time ago I have stumbled upon the following blog entry
> (question): "Agaric wants version control that lets Drupal core and
> contrib replace entire directories within our checkouts"[1]
>   http://tinyurl.com/yv3jp4

While it is possible to use submodules, I tend to think that you can
just use your own repo / branch "off" the main project, just like
unofficial kernel modules do.

It does have a number of advantages -- including being explicit wrt to
what version of the core project the module is developed against.
Drupal and similar projects (like Moodle) do have a module API, but
it's not *that* stable -- in spite of the best intentions, those APIs
get subtle changes all the time. You should have your "release" script
package only the module subdirectories -- and perhaps any delta in the
core (of Drupal) that needs to be applied. In many "contrib" projects
I've seen module files and little patch files that you are supposed to
apply - and maintenance of those is a pain. It makes more sense to use
git over the whole tree.

So it's a tradeoff -- IMHO, at first blush it looks more "natural" to
use submodules, but as things progress over time I think it forces a
lot of additional and ill-fitted work like maintaining patches, or
adding tags that indicate "developed against Drupal v1.2.3". And the
day the contrib module becomes official, "merging it in" is a bit of a
mess if you want to preserve history. So in the long haul, it makes a
lot more sense to use the "branch off the full project" approach that
has served the kernel modules so well.

In that sense, I think that gitk's tree getting merged in a
subdirectory is good as an example of what git can do, but a bit
pointless as gitk depend quite tightly on the behaviour of git
commands. So distributing gitk separately would be a big pain as each
gitk version is usable against a narrow set of git revisions. Luckily,
it gets merged into git and that's how it gets distributed.

My .2c anyway ;-)


m
