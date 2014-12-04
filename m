From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Thu, 4 Dec 2014 00:36:46 -0800
Message-ID: <CAGZ79kby-RdwzgXWvVgD42uiEis7SCnuAdSjO2EL03uN4s=LgA@mail.gmail.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com>
	<20141203051344.GM6527@google.com>
	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
	<20141203210031.GA6631@peff.net>
	<20141203213858.GC6527@google.com>
	<20141204075920.GA27142@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 09:37:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRuB-0000lR-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbaLDIgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:36:47 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:45558 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaLDIgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:36:47 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so18335196igb.7
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dht90lbGO/tQHil/sPnAPrC5KnE6JqvrJV6bkTLARmo=;
        b=M/L9FxHMRDd3wym0l5pupaKuGSGf9wLFmNfQfsYJUAOI1V0Tcg30nuq7BS0uCTNgxc
         Ql5Kp1S4n307xkgYs9MpoTBGn8hvGP7b2LCr/xymai9oYoWC+/gbLoFYs487fZlej4EO
         QllkshwFsiDs+riMMLlDdJJ8mQ6qDvfS64kcxjuw44qtq3HwjEJuhYPqW323y+OFCvba
         Ojysih+di4E/zl/oW2yNOb+wpAu8k6NHlfdalJD7GnUOoIc8mYmj6ipqDnYR2tmMUw/f
         /VlDi7u9pqD9KazdyzZHgeepIEjrIq4GC6gS4f3sX0sybJ1fX/MRF4nCYJOAcnqCi9P4
         +7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dht90lbGO/tQHil/sPnAPrC5KnE6JqvrJV6bkTLARmo=;
        b=fJWfYp603dwh9aNWH45i0Ka+GPH18OxbTMrQgaxl+GDmHOa5N/QtAT5HCMQ528u7Z0
         c3yKJ+zKGovomXrYlD+uApuIiawpBYgKdgrWnure6Nk9nKcAk2WMaDCFUypstj3dAfQq
         oNPxTYYYMdGQtQ93YQi90oF16ENTi1lPNXBTOVsjTPRWLfMbxG/1trscp7G3sB2UAQS3
         NEzP2NY4OlLPnzbwv55orm4iF/TVPSyxtNAVezVnzmUYryi5FH1YyWs3M198a/Cf4XFC
         sYtOS3GPasK0pjZHURmqbnlNT8H6SIGrt0BSngCK5FwAFfTY0nEdf2W85/hFifA7DHLG
         Dh9g==
X-Gm-Message-State: ALoCoQl2qd8/DVJ8G1hkWVy6+mxshwmxL8vm4FQiTRuFJi0DgQP0bxYPhW8MCZLY3v30jWf0ZmW4
X-Received: by 10.107.153.147 with SMTP id b141mr8626962ioe.49.1417682206237;
 Thu, 04 Dec 2014 00:36:46 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Thu, 4 Dec 2014 00:36:46 -0800 (PST)
In-Reply-To: <20141204075920.GA27142@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260746>

> Your solution adds a strbuf. That helps with context and stomping, but
> loses readability and adds allocation.

> If we changed the strbuf to a fixed-size buffer, that would help the
> allocation issue. Some messages might be truncated, but it seems
> unlikely in practice. It still loses readability, though.

> What about a struct that has an errno-like value _and_ a fixed-size
> buffer? I'm thinking something like:

What do you mean by the allocation being an issue?
We're only populating the error buffer in the error case, so you're
not talking about performance/speed I'd assume?
As error handling breaks in the least expected ways, I'd rather go
with well tested string buffer codes there?
