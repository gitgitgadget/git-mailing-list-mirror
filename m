From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Did we break receive-pack recently?
Date: Sun, 5 Aug 2012 18:37:51 -0700
Message-ID: <CA+sFfMcA2qUcigPg_ijWJmiTKYY9V4f4f6XQp8xT76wLaUXSxA@mail.gmail.com>
References: <7vk3xe6r1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:37:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCGb-0007GF-8w
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab2HFBhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:37:53 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62879 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168Ab2HFBhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:37:52 -0400
Received: by vbbff1 with SMTP id ff1so2168258vbb.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 18:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y5QyqPVGDlDOJ4VGeaVcOqjVppEVTr+PpK90cJBQFZg=;
        b=bazDs4y2h1x9h2WoVWLNJXIpRk9AxGcDlqY45yHvjk+1RmgLtEIMTzCBh/AHlRmLfD
         PV3qt9IN/gyx8N4j+HJlvWaMA6zsXQtXL6ETRklVCPALNLHz904fyhiI2JWHZwwUEuY/
         INgOBZ8kjMBHinC9gFy+GlrpODCkn3+9UI46I4Qvhd0AKrrcCEDAtasE+ASpAKmz696o
         cHdpAXcd4dHFnD+AH7VZ5fKmWQZvN0KzwybswAiqsBJtQ/PkWZDa8qDHZ8vu3mv2Z4CM
         IyXgZNnDmOWr1l7oCut2hhxd+h0dCMbgdCUxboCLl+6Tko8OHaWEnakPmIrcXa68s+is
         RPFw==
Received: by 10.52.69.83 with SMTP id c19mr5983708vdu.79.1344217071711; Sun,
 05 Aug 2012 18:37:51 -0700 (PDT)
Received: by 10.59.5.196 with HTTP; Sun, 5 Aug 2012 18:37:51 -0700 (PDT)
In-Reply-To: <7vk3xe6r1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202946>

On Sat, Aug 4, 2012 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I just saw this:
>
>     $ git push ko
>     ko: Counting objects: 332, done.
>     Delta compression using up to 4 threads.
>     Compressing objects: 100% (110/110), done.
>     Writing objects: 100% (130/130), 32.27 KiB, done.
>     Total 130 (delta 106), reused 21 (delta 20)
>     Auto packing the repository for optimum performance.
>     fatal: protocol error: bad line length character: Remo
>     error: error in sideband demultiplexer
>     To ra.kernel.org:/pub/scm/git/git.git
>     ...
>
> What is unusual with this push is that it happened to trigger the
> auto-gc on the receiving end and the message "Auto packing the
> repository..." came back to the pusher just fine, but somebody
> nearby seem to have tried to say "Remo"(te---probably) without
> properly using the sideband.

Or perhaps "Remo" is short for "Removing...".

Perhaps this is the source:

   $ grep Remo builtin/prune.c
   printf("Removing stale temporary file %s\n", fullpath);

-Brandon
