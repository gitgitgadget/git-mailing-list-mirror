From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in case
Date: Fri, 8 Oct 2010 14:44:05 -0500
Message-ID: <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
	<20101008135034.GC5163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 08 21:48:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4IvL-0000f0-Tu
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 21:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab0JHToI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 15:44:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56395 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0JHToG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 15:44:06 -0400
Received: by vws3 with SMTP id 3so461103vws.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j7TJdgfg2tvrdvAtBjJeRn1TE0bdZ90jTjVOcVKctbk=;
        b=YJrzJjzjasx9brz1mr7CzpcUbdhhFOXhzoRsZz/cVwazzVm65WUBh3hJfcJbEz8qHE
         4X9Bv+PTh+qskK2RY0dKCXqZ+ncaU8IhCCIexm56OPJldK3w2glIBXTtn2eR+3zhORld
         Ht9WerQ7Tf+SL6yC+XR+3+TXZduyFamgkyZME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rC9RDq1gsnFGHXcVUPDa4wgkvd+r9FCTrVy749XjdwvZgtwsKeFhZ8y91r1BU+u7nl
         Ub0ccwXCsH2knvb9A28aAlTipAvDZDIQ0EofAwOH20VD3tppr+7g1KoKgVqWiexOxOyy
         dxXkJWtXv3TzrmL31GduY3aRyZOJt7CQBVtPQ=
Received: by 10.220.71.20 with SMTP id f20mr837236vcj.20.1286567045364; Fri,
 08 Oct 2010 12:44:05 -0700 (PDT)
Received: by 10.220.187.9 with HTTP; Fri, 8 Oct 2010 12:44:05 -0700 (PDT)
In-Reply-To: <20101008135034.GC5163@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158528>

On Fri, Oct 8, 2010 at 8:50 AM, Jeff King <peff@peff.net> wrote:
> You can do:
>
> =A0git ls-files | tr A-Z a-z | sort | uniq -d

Thanks, but the main issue is that this is a very large repository
with tens of thousands of paths (files and directories).

git ls-files thus takes a long time, almost a second. Since this is a
commit-heavy repo, I'd rather avoid that overhead.

Incidentally, there's an SVN hook that does the exact same thing that
I want to do:

http://svn.apache.org/repos/asf/subversion/trunk/contrib/hook-scripts/c=
ase-insensitive.py

D
