From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git add . after removing .git/ in a subdirectory triggers
 assertion failure
Date: Fri, 8 Jan 2016 19:10:08 +0700
Message-ID: <CACsJy8C+7PpsOxY=_WXNdzAvrZ=KKsHc1G=2DdmNO1_D8fbhig@mail.gmail.com>
References: <vpqvb74fgr1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 08 13:10:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHVsT-0003iH-3r
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 13:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbcAHMKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 07:10:42 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34824 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107AbcAHMKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 07:10:39 -0500
Received: by mail-lf0-f54.google.com with SMTP id c192so174034443lfe.2
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 04:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NZNriijOvk0QZPTlzyG3/YmzUqMNMzsLJT8Z8B6a790=;
        b=Z2od2oASGOc+tnI5qTUOAyWxs5v1QbdWUySWn91OGS1ITV7u66cCgRGUYvAO6vbZtM
         P1WJg1ahAOJJHUbgVUy0AHEexKX0W59dEhSZAt48heGcny9TPyFNihfisE2G6ChPCBXy
         unZubciB93FrgctyRtG7vZfwPXoYffvBKxtMjr1T3mZlOgbwGYIT8WZ3WJ3UBbvT4QHO
         OV4gV/6pUcI1l0Ndm992ayJQghLT34a7vz3M+akV0Az6DXoUu8rcQgt01v/l4KAH4Rh9
         PRfcKvO4tME/C+CZESitI5/VJSsVVvdqdO/KblBxSL4kO1eaUy4MJ1QGQ8D7VpesJc8O
         aVvQ==
X-Received: by 10.25.208.213 with SMTP id h204mr30965399lfg.112.1452255038059;
 Fri, 08 Jan 2016 04:10:38 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 8 Jan 2016 04:10:08 -0800 (PST)
In-Reply-To: <vpqvb74fgr1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283549>

On Fri, Jan 8, 2016 at 6:33 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> No time to debug this for now, but I have a reproduction script:
>
> mkdir test && cd test
> git init sub
> cd sub/
> touch foo && git add . && git commit -m"foo"
> cd ..
> git init
> git add sub
> rm -fr sub/.git/
> cd sub/
> git add .
>
> In short, sub used to be a submodule, but we removed the .git/ and tried
> to "git add ." the result.
>
> The last line triggers this:
>
> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.

Reported twice in the past and I failed to provide a proper fix:

http://thread.gmane.org/gmane.comp.version-control.git/267095/focus=267404
-- 
Duy
