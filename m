From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: glob escaping doesn't work with git mv
Date: Thu, 7 Aug 2014 09:10:09 +0700
Message-ID: <CACsJy8APd6JH=32eWqK0m3e9bEWcrme3xZUewCyQxv08w=CyUQ@mail.gmail.com>
References: <CA+cJFMm_vJwk=D0dkhEvfXwWk1S74hONb_g7O9W0iMZD3yAdLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Alan Grover <alan.grover@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 04:10:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFDAI-0005wW-OF
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 04:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbaHGCKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 22:10:41 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:58467 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbaHGCKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 22:10:40 -0400
Received: by mail-ie0-f175.google.com with SMTP id x19so3948476ier.34
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 19:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sLGhM3enh7MnS0wfbj+9CuQR2CmpKwLqMVueDsrLTxI=;
        b=na39/EM6JRqsywOqoJetus1M+PZwYdUsDXpFdwZbYnnZrj52D2n0BKZFlt2yCZJ3Ii
         1XNWNxNIZKVkIcRZYSYXgfhKPAtOrIzRv/31Wf+usg6Ls2hEUxIyP4KsY2II7XQVu+7u
         aKoKIT6X0Qto5XnuX/W+t20SjOLDyCu6ipB7PkiZl2dC5QRNquBWuZVvZ3KbHqK0lS2Y
         MiHUqRGH+Pwb9kEnit9hXoCmSbGaXCY4W/wKEMvI+EZbO6uD2vOSwsMbRjwUOgMjmQlN
         VMpawZztuEcHe7ohs6PtVYzldsJggExUKa/1TvhC4ae4K6i0CCrLLhuWZYRiIjRUJ5CF
         FIlA==
X-Received: by 10.50.124.102 with SMTP id mh6mr937834igb.27.1407377439521;
 Wed, 06 Aug 2014 19:10:39 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Wed, 6 Aug 2014 19:10:09 -0700 (PDT)
In-Reply-To: <CA+cJFMm_vJwk=D0dkhEvfXwWk1S74hONb_g7O9W0iMZD3yAdLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254944>

On Thu, Aug 7, 2014 at 8:52 AM, Alan Grover <alan.grover@gmail.com> wrote:
> Since we can do git add file\*, I tried:
>
> $ git mv file\* newdir
>
> I get a 'bad source, source=file* destination=file*' error. It seems
> to be looking for a file named 'file*' rather than performing glob
> expansion.

This is a known problem (to me at least). Source path processing in
git-mv is a bit complicated and it scared me away from converting to
using pathspec (which supports globbing and stuff). But perhaps if I
just expand pathspec and feed the final path list to git-mv (pretty
much like how shells expand glob) then it probably works..
-- 
Duy
