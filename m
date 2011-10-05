From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Thu, 6 Oct 2011 09:47:11 +1100
Message-ID: <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org> <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 00:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBaFg-0004Zm-0Y
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 00:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935501Ab1JEWrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 18:47:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51393 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934900Ab1JEWrm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 18:47:42 -0400
Received: by bkbzt4 with SMTP id zt4so2676895bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HHgQ8P6+M/ywxwVrDxdrTlii4llFEOxdxH25n2hGQZU=;
        b=g4FXGQzbdfVEPqjO8Wyb8i+U3n1JZuj5WMSY0+KOudJO5K+M65B+R4PK43jM8xBET1
         7BeYXWrTlCkHe4hiJY7cEQN8z/OoBvoLrLozt0aZHc3VFXrfqkP9f4+XdEp7xSGR0bcV
         ztvtlQ5pdHTa/C6i3aGKkehzUxZkHntuJBs2A=
Received: by 10.204.129.4 with SMTP id m4mr8533bks.251.1317854861142; Wed, 05
 Oct 2011 15:47:41 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 15:47:11 -0700 (PDT)
In-Reply-To: <7vzkhf713u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182899>

On Thu, Oct 6, 2011 at 5:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I do not necessarily think that it is a good approach to forbid the same
> branch to be checked out in two different places, by the way. One reason
> people would want to keep multiple workdirs is so that while they are
> still working on a branch and are not yet at a good "stop point" to even
> make a temporary commit to get interrupted, they find it sometimes
> necessary to be able to build the tip of that same branch and even make a
> small in-working-tree fixes (which later will be carried back to the
> primary branch). The problem arises only when one of the repositories try
> to update or delete the branch while it is checked out in another working
> tree.

I think of two options:

 - detach from the already locked branch (pretty much like what we do
with tags now)

 - refuse normally but let "checkout -f" do it anyway. However the
checkout lock will remain at the original worktree. If you want to
update branch from the second checkout, do "commit -f" and take
responsibility for your action.
-- 
Duy
