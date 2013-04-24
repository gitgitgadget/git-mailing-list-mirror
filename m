From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 13:37:32 -0700
Message-ID: <20130424203732.GJ29963@google.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com>
 <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com>
 <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
 <20130424191453.GG29963@google.com>
 <CALkWK0=KWu3=j5sLK3hr=Gx5xLnLaPAY+E=J0_izRCj9YcBTEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6Rj-0007Cc-Te
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009Ab3DXUhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:37:38 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:34695 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005Ab3DXUhh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:37:37 -0400
Received: by mail-da0-f52.google.com with SMTP id j17so1061435dan.25
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dQnf0mkGJyBE+iQlLu0OPcixTOYLs8cPK8ECM/n1BOQ=;
        b=gBISlAsOrbiJReAUWdv0HfjpmLFXq03s7VXsWoLU19xxk54rTK2YVetSenldVN9oLG
         ogsDaY4DjPuCkyyybL37F+EaS/SL7oc0MIVJBnde6+XfhpSyJaE0cOZhlk4TMQX/IGJx
         IYao6ctXT9FsVvzIM5ooDnqf3qJBq1HsnwRitF1WJIA3FTqiT2WYZNk2xAcG87YlZ4wG
         IL+ZvkFCczrBjImqNLfJJTDMYuP3dM9cUKuwjjHRzd8/9k+neudWKoxX+OWm7++qDz5Y
         688PNxRUjmnIj4PrMl5I9d43bNxpVWwPP5ESmc75UkdxvU7bIxVUMWUNcxAhz7PEaNvg
         K/NQ==
X-Received: by 10.68.230.39 with SMTP id sv7mr22242517pbc.154.1366835857133;
        Wed, 24 Apr 2013 13:37:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 9sm4250607pbi.45.2013.04.24.13.37.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 13:37:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=KWu3=j5sLK3hr=Gx5xLnLaPAY+E=J0_izRCj9YcBTEg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222316>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Because typing paths does not make my intent perfectly clear.
>
> I'm not able to understand this.  Doesn't your prompt tell you which
> directory you're in, and if you're in a git repository?  When you type
> out paths, you know what is inside and what is outside your
> repository.  By extension, you know when --no-index is implied and
> when it isn't.
>
> Can you explain what your problem is?

Are you wondering why I use --no-index or why I think we should
eventually stop moving into --no-index mode by default?

The answers are different.  I use --no-index because it means I don't
have to think about whether the files I am comparing are in a Git
repository.  It's relaxing.  I'm not advocating that you follow suit;
I'm just describing my own usage of the command.

I think git should eventually stop doing --no-index implicitly because
it is a very different mode using the same syntax triggered by
external conditions.  That is

 * hard to document
 * problematic for scripts calling "git diff", can create lurking bugs
 * unnecessarily complicated.  For example:
   * "git diff -h" output depends on whether I am in a git worktree.
   * git searches for a .git directory, possibly hitting filesystem
     automount points, just to decide whether its arguments are inside
     the current repository.
