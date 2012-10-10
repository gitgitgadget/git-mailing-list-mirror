From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 19:32:18 +0700
Message-ID: <CACsJy8CznUShZVdmvGz1bfHHpZ1ZEX3PRUPb0+NNq2ZnvZEzZg@mail.gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net>
 <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com> <50756646.5060505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 14:33:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLvT9-0004E1-FY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 14:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab2JJMcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 08:32:50 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42441 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab2JJMcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 08:32:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so701624iea.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bmXTvDf05N4YF2ofVhLcqW7rTyjoMKvGMKpV/MTTzf0=;
        b=qTTpJWziVWgXAfIU1NI3+ZfBkpAwIx38DuhqT7mrCp2zxHqoBxDP5W13yh2al3RSuh
         ZT9fHhZS9swrfeEvBYd2TU9XndPBW2XfadXri5onC6T5gu4Sh2F2sJVwy+AmgLdbtTGx
         9hs7nQnC/57NnBrFfIRk2P0s7NGG+3MT5bwwy+clJmdVdNUeyD4PWpHr2P7lOd+oKG2f
         McQDEQVnF5OpyXyu061OZ0JHYpuvLiHxrmxYudwcnsOSOY7ff19NSdtmJ7MkFshum65P
         33cK+haz3XwBK6sPqQPTPl7o28I/I3owRktz13MZCiyJgHMdOFeZKX20wXV7E6xkptMO
         3/YQ==
Received: by 10.42.109.194 with SMTP id m2mr18078699icp.48.1349872368393; Wed,
 10 Oct 2012 05:32:48 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Wed, 10 Oct 2012 05:32:18 -0700 (PDT)
In-Reply-To: <50756646.5060505@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207407>

On Wed, Oct 10, 2012 at 7:12 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Is there already an established definition which the "correct"
> .gitattributes are?

If I ask to grep the index then to me it should read only the index.
Although other people can counter that they may want different
attributes than the one stored in index, which either comes from
worktree or $GIT_DIR.

> IIRC, everywhere else we are looking at the
> .gitattributes in the worktree, regardless of whether the object at the
> path in question is in the worktree, the index, or in an old commit.

git-archive has --worktree-attributes to specify where attributes come
from. Sparse checkout can choose to read index version first then
worktree's or the other way around. All normal operations read
worktree version, if not found index version.
-- 
Duy
