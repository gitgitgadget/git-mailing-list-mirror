From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 00/19] Use ref transactions from most callers
Date: Fri, 25 Apr 2014 15:04:34 -0700
Message-ID: <CAL=YDWkArmAdoDeNXqRn3Mxm-_nuOMyhAcooHt8c_pr98pJJbg@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<20140425215318.GA9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:04:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdoEb-0007LQ-Jg
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbaDYWEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:04:36 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:43011 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaDYWEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 18:04:35 -0400
Received: by mail-vc0-f176.google.com with SMTP id lc6so5404765vcb.7
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6NIGMZfu4iFXKk1fFJ5I0DZvgHo2cxQ4u9Znuw/wQIo=;
        b=TBlrHvpMpCrbNM2XPtOtZmP1kgtnVM42D5XJVJyQyCGL9R+vnKPDQCekRKnzDUpNu6
         iVhdDZQ6OlFm/wMYaK06+yIlTF7CoG5nbTQ1Pg5uJ2urnHR85wQkIzQESWiAM3pm9CSj
         oaLsptkFvl50tgbM1EUTfacVE7qVyW+c3+qlJrC7VhnOox6kvFtC/ejAbQDiXoz6AGAZ
         /ApHbfuDf6BFIbbAp6zG0jfsmobMBTe3dlsXA3Rfk+W1zl5BnqPTV9y6kfmF5aPr9A0j
         D1UD3iO75pkMLrvdx1vre1ZyX6wp112vVnzbx+KCEOUrX2D7l1xqgC9Vm/llHaSXMbc5
         ypeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6NIGMZfu4iFXKk1fFJ5I0DZvgHo2cxQ4u9Znuw/wQIo=;
        b=Mn//yu6ih24582Ydnvz56T8yutQpHVFWnpDrYrPbcrFbuuK4SCax7Q9hIIs+CcZ+Jx
         JRVfi/Uwe2DYE3evF7ll7u7c1eqtEQzFhzhSDN0zPQ4Y2GdMgTl5gnk33mwhOrlEOFh1
         r+jQJgZFIMlENh40QAvaX1VJauk6x1S2eglxYWsb/mabmwLgR6LTVCO4XMDqFqZXdxp5
         NBtqyRKrYr+ZRMkcy31kPTjAdUAmQu2wQvoCxzsVY8ATp71uJ8AZVY6NFFpPX4jmB3Hu
         qwI/52oFR9htQl9WyiDHXDV8qHMw7egjbds1LjlJjxsdL5QZplStmQPIDJu7XHBWzwLB
         BzlQ==
X-Gm-Message-State: ALoCoQl0GlMsYsOP5/N1Dh9aeDxz1dgCJKLNEcl84iFAJ20pRRpINUl/n0L9EbGftCo97pKiVQw3S2rk0V+6TXk3beLpAnBoTcTb9SGbnmWFOS20ig0sePVUKHESJpHzHHvY/XwxgpkE9Cw4T87jfKSGo4gvcwB7KZjZO386Kuta9P8Rxy7wgvLmlIf0M0HX/QnOhmWRENgb
X-Received: by 10.220.12.66 with SMTP id w2mr8649806vcw.15.1398463474659; Fri,
 25 Apr 2014 15:04:34 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Fri, 25 Apr 2014 15:04:34 -0700 (PDT)
In-Reply-To: <20140425215318.GA9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247117>

On Fri, Apr 25, 2014 at 2:53 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> This patch series changes most of the places where the ref functions for
>> locking and writing refs to instead use the new ref transaction API.
>
> Thanks.  Is this series based against mh/ref-transaction from "next"?

Yes, against mh/ref-transaction


>
> [...]
>> I think I have covered all issues raised on the previous reviews and also
>> done a bunch of cleanups and improvements to the transaction API.
>
> Whoops, sorry I replied to an old message.
