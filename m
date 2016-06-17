Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD3B1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbcFQVlY (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:41:24 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:47763 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbcFQVlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:41:23 -0400
Received: from homiemail-a21.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
	by hapkido.dreamhost.com (Postfix) with ESMTP id D7EB1C9636
	for <git@vger.kernel.org>; Fri, 17 Jun 2016 14:41:22 -0700 (PDT)
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 1BDFD30007B;
	Fri, 17 Jun 2016 14:41:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=date
	:message-id:from:to:cc:subject:in-reply-to:references
	:mime-version:content-type; s=novalis.org; bh=KpnNU64MluHdQA4NaC
	X3VOgo6Ko=; b=UvsBZs9vviVUtDe60zBCqgqNX0PInlOFOHIOj3V3gRsMleLAc9
	pIHBI6FM3Wkx0cWdCttY4S99d9kWxu2nQ1Pf5GZ1+qcc7tGzlq7WJBqhtbq16KWm
	3ScdjKOfF57ICDwNzioYNR9K5EZfu+uzyp9iKgqWkC+6ylGAYYgJ6aHww=
Received: from frank (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id A42A2300072;
	Fri, 17 Jun 2016 14:41:21 -0700 (PDT)
Date:	Fri, 17 Jun 2016 17:39:12 -0400
Message-Id: <8737ob1on3.fsf@novalis.org>
From:	David Turner <novalis@novalis.org>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v12 11/20] index-helper: use watchman to avoid refreshing index with lstat()
In-Reply-To: <CACsJy8DzyvFOHU_8xoWUcjej=Ws7_v475=Q2iZmwKhkzYaZ7sg@mail.gmail.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
	<1463694357-6503-12-git-send-email-dturner@twopensource.com>
	<CACsJy8DzyvFOHU_8xoWUcjej=Ws7_v475=Q2iZmwKhkzYaZ7sg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> > -                       if (really && cache_errno == EINVAL) {
> > +                       if (really || cache_errno == EINVAL) {
> >                                 /* If we are doing --really-refresh that
> >                                  * means the index is not valid anymore.
> >                                  */
> 
> This looks really odd. I don't see why we would need this. It seems
 > first appeared in your "do not apply" patch [1]. Maybe leftover?
> 
> I found this while re-reading the series and I have not put much time
> in studying this code yet. So I may be wrong. I'll post again if I
> find that it's true after some more staring.
I don't remember the exact details here, but I think we needed this so
that we would ever refresh a file that watchman told us had been
modified.  We definitely were missing some invalidation if we didn't
have it.
P.S. Please CC novalis@novalis.org on these emails as I don't always
check the git mailing list.
P.P.S. I am testing out using emacs to send this message, so if
it ends up screwed up, I apologize.
Date: Fri, 17 Jun 2016 17:38:03 -0400
Message-ID: <874m8r1op0.fsf@novalis.org>
