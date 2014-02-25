From: Joel Nothman <joel.nothman@gmail.com>
Subject: Re: [PATCH] help: include list of aliases in git-help --all
Date: Wed, 26 Feb 2014 09:32:28 +1100
Message-ID: <CAAkaFLX49C5CoXcPL9ZBLvNuHnCNg+0QSMfWLzJ0VU_wxOH5zw@mail.gmail.com>
References: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com>
	<xmqqsir757hy.fsf@gitster.dls.corp.google.com>
	<CAAkaFLVRP3WF=2hyBo9uxutJ8iLPyBVkiBs=29xN13762r32Bg@mail.gmail.com>
	<xmqqk3ci6eun.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 23:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIQYE-0007Sc-83
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 23:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbaBYWca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 17:32:30 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:56779 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaBYWc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 17:32:29 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so114298qcy.25
        for <git@vger.kernel.org>; Tue, 25 Feb 2014 14:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MC1cJDXKzMqLTYN30ptCycIuey78IhO7m9YCZJMB0qU=;
        b=Q4nyOlpymw0LRTVjx7hG+OHjzP+05bZJgptfkLohmXKENOV95UQ7M1bdfPkgDcdLSy
         24y4PHigSXUA6JYtz/OthiHxpoOhBL0uSFvjwntHfak+YGJ26DRTEldq0RW+FlXPQFjI
         dKuXR8tB2J2snrWawNTRk5TW2aTw27pSFviz3h6hvKHO4ABwP1pw8bjZba/NXsiLWprE
         mcUm/wyEvk2a3EF8s4DwYHKGQzT3k7OojQMFWtFwiqCHGEsKVHuDA3rMFecfiGIevUoj
         R+r//KJb4nj8hV3KU+cfVz4FNBbYbuylVvH7pLD/AbmnIFNsufnxY3quoV0MslFKfy16
         xBOw==
X-Received: by 10.224.67.193 with SMTP id s1mr3463954qai.53.1393367548926;
 Tue, 25 Feb 2014 14:32:28 -0800 (PST)
Received: by 10.140.92.161 with HTTP; Tue, 25 Feb 2014 14:32:28 -0800 (PST)
In-Reply-To: <xmqqk3ci6eun.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242690>

On 26 February 2014 08:51, Junio C Hamano <gitster@pobox.com> wrote:
> Joel Nothman <joel.nothman@gmail.com> writes:
>
>> arguments to git help. They are also like commands in that it is
>> possible to forget their name, or whether they are defined on a
>> particular workstation, and to hence want a listing.
>
> I did envision that it would be useful for the last case, but then
> the users would be helped even more if they can get a list of ONLY
> aliases, not buried in many standard commands they already know
> about.

The list is partitioned. It is partitioned already between
git-installed commands and others on the path. This patch adds a third
partition when required. So they *do* see only aliases... after all
the commands.

Note also that any command on the path will override an alias with the
same name. So in order to list (effective) aliases, you need to
calculate the list of commands as well. If someone defines an alias
overridden by a command, git help -a now makes that apparent by
excluding the alias and including the command above it, while `git
config --get-regexp ^alias` does not.

> In other words, I was not fundamentally opposed to *a* way to get a
> list that includes aliases, but I was not convinced if it is a good
> idea to *change* the output, which people knew would consist of
> commands but not aliases, to suddenly start including aliases.

I don't think this will concern most users for whom aliases are
non-existent, and hence no section will be shown.
