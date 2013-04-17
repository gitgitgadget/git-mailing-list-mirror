From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Wed, 17 Apr 2013 21:36:35 +1000
Message-ID: <CACsJy8DxspNbopJbSsvcCZZwMFees1JVV_iV5r7dXRJTngzmFA@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
 <CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com>
 <CACsJy8C9mrJzmg4FjqBMAZis7WQUpyhNH7TMTLbebWQE124YMg@mail.gmail.com> <CALkWK0nLamX1XKcg2t7VWJTPuFhX+ctEGE=4sjSSd7JqMmGzPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 13:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USQfq-0006bt-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 13:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966164Ab3DQLhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 07:37:08 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:32803 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966099Ab3DQLhG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 07:37:06 -0400
Received: by mail-oa0-f54.google.com with SMTP id l20so1483157oag.13
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EIAWX5QCXgsXdrz07h/naO477YLN+Z9+mizHMzRjCwE=;
        b=jz0gNOx4meUACGZd6/QRW303feMrZx6/PtPJS6aVnRr/yblqXHfIOsW4PHvFJXmhyw
         m2GKvswy/usInEzu7LCQnAJBy7V+LugHXyL+6rihmicVfK7ciTraS9MY/G3wJgrYofrh
         AFUJiRneP+xe8rFut7TsErfQ6sQfkX1pptqJvZ8fnvVTo/l8Yi3U+sFppmLcQQlLkOAC
         kIdmkbXH9lYfKLhqkMxfi64PvpatT508LNX2xrlkYKKga/1JRyWuDlRfx5H6o6f45k4Q
         4oQVe3hR9rIPl6DThLdWBT8BvJ20/Of6LPh+M4wdZpKnn3/ag4RQ004U3+bfaHIMVBUZ
         J82A==
X-Received: by 10.182.111.199 with SMTP id ik7mr2302377obb.44.1366198625736;
 Wed, 17 Apr 2013 04:37:05 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 04:36:35 -0700 (PDT)
In-Reply-To: <CALkWK0nLamX1XKcg2t7VWJTPuFhX+ctEGE=4sjSSd7JqMmGzPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221537>

On Wed, Apr 17, 2013 at 9:13 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> No, submodule code does not change "git clone". If I'm not mistaken,
>> submodule will not kick in until you type "git submodule something".
>> If I turn clone.submoduleGitDir on, how can I undo my mistake in a
>> user friendly way?
>
> So, if you currently want to add a submodule, you have to 'git
> submodule add', which runs clone internally apart from other things.
> How do you undo this mistake?

Well, it has "submodule" in the command line. My first reaction would
be looking for "git submodule rm" or something.

> What I'm essentially proposing is to give the job of cloning back to
> clone, and the job of adding back to add, instead of creating an
> unnatural abstraction over them using 'git submodule add'.  The point
> being: why would you ever _want_ to clone inside a worktree unless you
> intend to add a submodule?  In other words, you intent for running a
> 'git clone' inside a worktree is exactly the same as your intent for
> running a 'git submodule add' inside a worktree.  Ofcourse, if you
> have a fringe case where that was _not_ your intent, we'll provide a
> command-line switch to turn off the relocation for that clone.

No, the point is people make mistakes. What do we do in that case? Or
will you introduce yet another "gc" command for clean up ~/bare?
--
Duy
