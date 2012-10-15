From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push race
Date: Mon, 15 Oct 2012 18:53:28 +0700
Message-ID: <CACsJy8Aw1iM9BTqv4jmoEK+a1gzKUL0rfVGFsnebofd67LxZew@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <vpqd30k806o.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:54:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNjFL-0007Dx-GY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab2JOLyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:54:00 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34026 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab2JOLx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:53:59 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4829742oag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ql+SCH9Or5kfqe96U/c8+tFMIpOytTboymdn0zG0Ol0=;
        b=vRHj/3KJwHrD3iRrJbS7yKHQSuHsz0ogAfVJg2j2rTbdXOMIHNN8/5eEqaNSk8uay4
         hDIrA5J8g8SUXJyjanQgxTVyo9bnONxdZ6HpqrynufvX8ks2Nt4GhjyJKRxiwSgbZuhA
         2tsonXHi60czZQGixAe2Guaugmtypc8xDoA0LTLIGlRyLgReNL0lZKJFXNva83JL3yIn
         OvBgSLzxUmIcvcziw6pRsX6kdkzyvnq8qclvHs0Jq+nGdbXMxpz6yUIYQ6M54GQaOf5f
         o6lWnfaqB0jG/VNkvdcV4omF70XWpKhoME71EVicDfvw1ejBZbs9m5PJsjOohzftAY2a
         ESBw==
Received: by 10.182.174.39 with SMTP id bp7mr1353268obc.1.1350302038771; Mon,
 15 Oct 2012 04:53:58 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Mon, 15 Oct 2012 04:53:28 -0700 (PDT)
In-Reply-To: <vpqd30k806o.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207740>

On Mon, Oct 15, 2012 at 6:05 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
>> the push command checks first if the tips of the branches match those
>> of the remote references, and if it does uploads the snapshot.
>
> The update does two things: upload objects to the database, and then
> update the reference. Adding objects to the database does not change the
> repository until the objects are reachable from a ref. Updating the ref
> is usually done giving the expected old sha1, and locks the ref, so it
> can't change in the meantime.
>
> I don't know this part of the code very well, but check refs.c for the C
> part, and "git update-ref" for the plumbing interface.

I think it's lock_any_ref_for_update(), which is called inside
refs.c:update_ref().
-- 
Duy
