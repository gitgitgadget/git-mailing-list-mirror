From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Tue, 6 May 2014 07:30:17 +0700
Message-ID: <CACsJy8B_NiL8LnYXk_O+tbsZxfNbg5EvkbbPtO-crHMmKdZhEA@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8C72QQZd4v+p4bkFFKHnN2Uj1zD-BELwGtYB7sx1P6q6g@mail.gmail.com> <CACsJy8DWK9ysCJobh4oQZe2hxdTaE=n7hH=Nm6bfWzx+yJ=KZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:31:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiFj-0007Xo-GP
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213AbaEFAas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 20:30:48 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:47428 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013AbaEFAas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 20:30:48 -0400
Received: by mail-qa0-f51.google.com with SMTP id w8so4473223qac.24
        for <git@vger.kernel.org>; Mon, 05 May 2014 17:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=cv43KFNN7B4L7qTQm+ZITVTPzotYOxETDeLMOTy36q4=;
        b=GhsbcVj+Slm8PkHKSGwgXzBNFVkaFlja6ybLeKtLbG9NxeMGbNYdi7JycPd86i1q+T
         HxRWlpdOlqYCRRcDZccdhnGTim9S6SvPyqw77uNW3VWRrjxIwGgPKtEj4VWsSojecRkG
         4z5Ou2+OaSkJbrrSb/CemyhZvbVY1hqeF6ujblNVtfdZnDZY05zAHU0dtMMb3+WpGGOd
         LhOWHpMrj11W5yCMnKU14jrg7CJo2hiV8QiWqRlE2Ed8HhOgG4VjrWkP5npSnBIl69d9
         CIcTiAzXJ7DOhJJs6PArQ1TG1Soe1YyJDD7kSpDtr3ej9aFgQQa9ilp/fPAVTd67jkd+
         V1bQ==
X-Received: by 10.224.138.3 with SMTP id y3mr49997665qat.78.1399336247590;
 Mon, 05 May 2014 17:30:47 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 5 May 2014 17:30:17 -0700 (PDT)
In-Reply-To: <CACsJy8DWK9ysCJobh4oQZe2hxdTaE=n7hH=Nm6bfWzx+yJ=KZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248139>

On Tue, May 6, 2014 at 7:26 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> This discard_index() code was added
> recently in e28f764 (unpack-trees: plug a memory leak - 2013-08-13).
> As a workaround, perhaps we only do so when the sequencer is running.

Hmm.. as o->result does not carry cache-tree anyway, the next
assignment after discard_index() will "destroy" cache-tree anyway. I
wrote and deleted the following sentence, but it looks like I should
rewrite again. So if cache-tree has always been destroyed before, be
careful when you try to keep cache-tree as cache-tree invalidation
code in unpack-trees.c may not be well tested.
-- 
Duy
