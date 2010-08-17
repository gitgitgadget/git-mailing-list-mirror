From: Shawn Pearce <spearce@spearce.org>
Subject: Re: limiting ref visibility to specific users
Date: Tue, 17 Aug 2010 09:55:26 -0700
Message-ID: <AANLkTi=aSwu0JttExA8CN=2GhFYwt10+cCvUR77jibmj@mail.gmail.com>
References: <20100817150921.GB12682@nibiru.local> <AANLkTikbT+e+7+LxrP6TkuuQ=8rMxuTnvFcUbUFzaUgk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>, weigelt@metux.de
X-From: git-owner@vger.kernel.org Tue Aug 17 18:55:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlPS9-0003o3-So
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 18:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402Ab0HQQzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 12:55:49 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59175 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab0HQQzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 12:55:48 -0400
Received: by gxk23 with SMTP id 23so2600159gxk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 09:55:47 -0700 (PDT)
Received: by 10.150.166.15 with SMTP id o15mr7583057ybe.38.1282064146186; Tue,
 17 Aug 2010 09:55:46 -0700 (PDT)
Received: by 10.231.180.100 with HTTP; Tue, 17 Aug 2010 09:55:26 -0700 (PDT)
In-Reply-To: <AANLkTikbT+e+7+LxrP6TkuuQ=8rMxuTnvFcUbUFzaUgk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153762>

On Tue, Aug 17, 2010 at 8:48 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Aug 17, 2010 at 10:09, Enrico Weigelt <weigelt@metux.de> wrote:
>> I'd like to control which refs are visible to certain users
>> (when coming via ssh). Is there already some generic way to
>> do that (eg. passing some filter rule by a calling wrapper ?)
>
> Shawn, weren't you looking into something similar for Gerrit? Although
> I think what you were investigating would allow the user to get the
> rest of the refs somehow?

Yup.  We implemented this in JGit by allowing the application to
provide an implementation of a RefFilter interface, only the refs that
the filter approves are shown to the remote client.  During
receive-pack (server side of push) the RefFilter also is used to
restrict what objects the client may mention as a delta base, or as an
object in the graph (e.g. commit parent, commit root tree, or tree
entry member).

There is no equivalent in C Git.  You have to use either Gerrit Code
Review, or build your own server on top of JGit to take advantage of
that feature.

-- 
Shawn.
