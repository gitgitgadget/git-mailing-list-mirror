From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: push race
Date: Mon, 15 Oct 2012 16:09:40 +0200
Message-ID: <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 16:10:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNlN2-00081i-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 16:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab2JOOKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 10:10:02 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33738 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab2JOOKB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 10:10:01 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so4926581obb.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x5yP0gPs6SAZ84Q8EPjNW7VQm9/umYMUxdKzM/J/v9E=;
        b=tSZ0TLkStQIP+cMfke3edl7OjO6pSy7tbHzNYMXUrFF7JkbVMa16CkYHBZLvT7fGmk
         P0gxJL5fW3vnYEnJTZQkKsfEQwiR/+qf5ZEiqAkRfPNAYWr9McksgbNtb1GIypOFoZf6
         Ihwu2/a7q0lI4AhnEA/kv6YMMTRWK7ixtFDeS8ITADH/Y/J2CmzFGUIM8TUKVo+YzScs
         SOBKZzEaLz7SNOl8+E/nm429A7SwYRxm9BI8Szi4kw6WW94QE7hk+L7IJAsD3mXXK9M6
         C4a2FFetA1FH4K72OdPW7YAPOX2Bcm0KJlYny+ftOXwuAuT7zRhrzZGRdS7ok/XnQsnE
         vFMQ==
Received: by 10.182.38.65 with SMTP id e1mr9541335obk.3.1350310200654; Mon, 15
 Oct 2012 07:10:00 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Mon, 15 Oct 2012 07:09:40 -0700 (PDT)
In-Reply-To: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207747>

On Mon, Oct 15, 2012 at 11:14 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hello,

FWIW we have a lot of lemmings pushing to the same ref all the time at
$work, and while I've seen cases where:

 1. Two clients try to push
 2. They both get the initial lock
 3. One of them fails to get the secondary lock (I think updating the ref)

I've never seen cases where they clobber each other in #3 (and I would
have known from "dude, where's my commit that I just pushed" reports).

So while we could fix git to make sure there's no race condition such
that two clients never get the #2 lock I haven't seen it cause actual
data issues because of two clients getting the #3 lock.

It might still happen in some cases, I recommend testing it with e.g.
lots of pushes in parallel with GNU Parallel.
