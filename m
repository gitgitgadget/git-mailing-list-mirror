From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 17:31:49 +0200
Message-ID: <33f4f4d70806240831q14caacddp66645e1bcfb6d14b@mail.gmail.com>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
	 <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
	 <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
	 <8aa486160806240727r6fc6de6doec8300700293a3a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:32:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBAVj-0003mU-2S
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 17:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbYFXPbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 11:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYFXPbv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 11:31:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:5213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbYFXPbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 11:31:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1196485fgg.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/kZzs/bL1PWtbiKmqrycKfGsN1xqJ1TtmshvJAetSJA=;
        b=Ij1AxS5lgfYACkpkNlXrkIjEAhOZqrfOWnIv0snGLrQjc5UCCxw7jcolQVcY/mRGAz
         S8Xu8lImfg3d/KAQxSfWD8jzgfCAu2ZzPxBwnpzu/6i4kTeXdhMDDUzHHToRF6gsUyyE
         oZ+jAGgOjigPevFi4W+sUyymW2zSlA4xt8xOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MT/yWxe1F+yl2By698xI99uuxyzWQYiCkve1pwBpdjQVeCl6AorjxUeko8C71vuZtb
         Vchq8OjxH3JaeX3u7/SXJOWdQTCnj2di6ds/fx8UIfPJoizPANRcGIX5izfb1X/A2WII
         7GO2Z8kNnKXZ31mMHyUSiIZFsI5JpcMXEmRZc=
Received: by 10.86.89.1 with SMTP id m1mr9116733fgb.45.1214321509110;
        Tue, 24 Jun 2008 08:31:49 -0700 (PDT)
Received: by 10.86.68.16 with HTTP; Tue, 24 Jun 2008 08:31:49 -0700 (PDT)
In-Reply-To: <8aa486160806240727r6fc6de6doec8300700293a3a7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86074>

>>> git branch -a
>>>
>
> empty?

Sorry, my mistake. It lists "master"

>>> git-pull bogustree refs/tags/foo_tag:refs/heads/b
>>
>> actually does update branch "b". I find the behaviour quite inconsistent.
>
> You asked explicitly to update branch b with :refs/heads/b.

I'm not sure what you mean. I asked it to update local branch "b"
against remote tag "foo_tag" and it did just that. I find it
inconsistent that pull can do this, but fetch can't.

> Can you explain why you have to do it this way? Or the whole workflow?

I am looking into the possibility of writing a tool that handles
configurations of trees. For instance, I want the tool to be able to
consume some version of a configuration and create, update or reset
branches in other trees accordingly.
The main stumbling block is actually that a lot of git commands have
side effects on the working tree (usually because they do something
with a "current" branch). In my mind, the user should be able to
select a configuration that effectively fast forwards branches in some
trees and resets branches in others -- all of it without touching any
working trees (unless there is an explicit checkout).
The example in this case is that fetching tags to update a branch
isn't possible. Pulling *is* possible, but would also update the
current branch and the working tree.

/Klas
