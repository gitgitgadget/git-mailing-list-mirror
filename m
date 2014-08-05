From: Nico Williams <nico@cryptonector.com>
Subject: Re: Pluggable backends for refs,wip
Date: Tue, 5 Aug 2014 16:56:42 -0500
Message-ID: <CAK3OfOiu39H8oZMKjra97ZNLHNatNYtFwr8Do_QwoxGXzg4SGw@mail.gmail.com>
References: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:56:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEmiw-0001lp-AT
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 23:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbaHEV4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 17:56:45 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:40397 "EHLO
	homiemail-a89.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753968AbaHEV4o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2014 17:56:44 -0400
Received: from homiemail-a89.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a89.g.dreamhost.com (Postfix) with ESMTP id E73B131805D
	for <git@vger.kernel.org>; Tue,  5 Aug 2014 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=XOJjJPb1rVl4mMXps5vU
	dLRwIoo=; b=XebnVEnKpVi3E/6Hcv6AHv70v5nHkjF5opbgot7LmVyFZCB+P6uc
	8iyuBcWOYuEDkIWUn9qnv6S7rYFjyDdxtm6oJMqG+fvk31yhG7+j9yb1JYAVWWCH
	RdyJEn62oFdoAeoNRaEsxi3U8wZAHxLlmshfHbJ/GeRUzs4A7IltpGw=
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com [74.125.82.169])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a89.g.dreamhost.com (Postfix) with ESMTPSA id 8B5B331805C
	for <git@vger.kernel.org>; Tue,  5 Aug 2014 14:56:43 -0700 (PDT)
Received: by mail-we0-f169.google.com with SMTP id u56so1712511wes.28
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 14:56:42 -0700 (PDT)
X-Received: by 10.180.106.99 with SMTP id gt3mr21308325wib.1.1407275802402;
 Tue, 05 Aug 2014 14:56:42 -0700 (PDT)
Received: by 10.216.231.131 with HTTP; Tue, 5 Aug 2014 14:56:42 -0700 (PDT)
In-Reply-To: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254830>

Personally (a user of, not a maintainer of, git) I really want some
alternative backends.  In particular I'm after something like Fossil's
use of SQLite3; I want a SQLite3 backend for several reasons, not the
least of which is the power of SQL for looking at history.

I'm not sure that I necessarily want a daemon/background process.  I
get the appeal (add inotify and bingo, very fast git status, always),
but it seems likely to add obnoxious failure modes.

As to a SQLite3-type backend, I am of two minds: either add it as a
bolt-on to the builtin backend, or add it as a first-class backend
that replaces the builtin one.  The former is nice because the SQLite3
DB becomes more of a cache/index and query engine than a store, and
can be used without migrating any repos, but the latter is also nice
because SQLite3 provides strong ACID transactional semantics on local
filesystems.

Nico
--
