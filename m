From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Fri, 27 Jun 2014 17:46:20 -0400
Message-ID: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com>
References: <B901ECBC8F944F039AFD6B53929FF18C@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0dyn-0004v7-7w
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 23:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbaF0Vql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 17:46:41 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:53457 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbaF0Vql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 17:46:41 -0400
Received: by mail-ve0-f176.google.com with SMTP id db12so5800315veb.7
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+MfoBZ9LPJcL8KZuMIFjuv4/ih1MdDr0/Zt6movtsyg=;
        b=ZsTiv6N+XGVbjd5Q7zu9BSnuiN6WlKBD/ha5xgXvHDkj3UQM0EkZR7F+ryR5OIEaRr
         7wPTmHIipC27N3QoJIf1ML782BpHt75d5BK5PnxAP7sdMYSxcRN3ywmwzleG3TtP+3n+
         iJaM8T8NYwyLt8mhfrUbKe/hM78asQXA3+np+/NlhbMIv+JUaPZ6RC0zsP2HPT1aWtiT
         onRDVOXMYc5xP9M2jX/3X+9gfaS+P9i9/VJvS0JsdUIc/E9+CIYpRToWCa6FLClJ4D9D
         p4EQqhIZ9i9cZVIZU2WgW1/hhY5mAVjhFjUAioKanFS4gVe93ooH3MveZ4gdOMjs5h64
         I/GA==
X-Received: by 10.58.56.102 with SMTP id z6mr21576671vep.7.1403905600295; Fri,
 27 Jun 2014 14:46:40 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Fri, 27 Jun 2014 14:46:20 -0700 (PDT)
In-Reply-To: <B901ECBC8F944F039AFD6B53929FF18C@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252583>

On Fri, Jun 27, 2014 at 4:47 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
> There are two identical files from the same original parent, but both were
> renamed in their own branches. One branch moved the file to a new folder, the
> other renamed the file in the same folder.

You have not stated what you think the issue is.  You have only stated
the setup.


I suppose you want Git to merge without conflict in the end, though,
based on your script.  Is that right?


> Steps to reproduce the issue:
> git init
> git fetch https://github.com/pdinc-oss/CipherShed.git
> git fetch https://github.com/srguglielmo/CipherShed.git
> git checkout -b test b60070f4d0879e277f44d174a163bbb292325fea
> git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68
>
> CONFLICT (rename/rename): Rename "TrueCrypt.sln"->"src/TrueCrypt.sln" in branch
> "HEAD" rename "TrueCrypt.sln"->"CipherShed.sln" in
> "a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68"

Git seems to be doing the correct thing here.


> git reset --hard b60070f4d0879e277f44d174a163bbb292325fea
> git mv src/TrueCrypt.sln src/CipherShed.sln
> git commit -m 'renamed to be congruent with a0c84ff'
> git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68
>
> Sill get a CONFLICT (rename/rename): Rename
> "TrueCrypt.sln"->"src/CipherShed.sln" in branch "HEAD" rename
> "TrueCrypt.sln"->"CipherShed.sln" in "a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68"

Git seems to be doing the correct thing here, too.

> I will have many more to come, any suggestions?

Maybe you meant to move the renamed file to the same folder where it
exists in the merge target.  I do not get a conflict when I do that.

   git reset --hard b60070f4d0879e277f44d174a163bbb292325fea
   git mv src/TrueCrypt.sln CipherShed.sln
   git commit -m 'renamed to be congruent with a0c84ff'
   git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68

No conflict (on that file, anyway).

Regards,
Phil

> This message is copyright PD Inc, subject to license 20080407P00.

p.s. Maybe you should remove this copyright threat in the future when
you are writing to an open source community seeking help.
