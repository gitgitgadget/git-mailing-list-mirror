From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Sun, 14 Feb 2010 09:58:58 -0500
Message-ID: <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com> 
	<20100214064408.GB20630@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 15:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgfwT-0002dA-0S
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 15:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab0BNO7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 09:59:19 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:4806 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0BNO7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2010 09:59:19 -0500
Received: by qw-out-2122.google.com with SMTP id 5so311272qwi.37
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 06:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Mbar2MXpDYcieTX4X6kuykwfx6vZZCa8BzWXY5SLxLY=;
        b=PEwaCHTEOMO6iD4ow7hJfriHXjDsUDfHSBeo92lLmVipUvEOp1jrLYe46+LSU0un3i
         gxbI95YjLJu+nL/W9G5+SBY3/pTLkZVtXf5U9tgox5VNxsKerNXj7hjwB4FZfxUIwZsn
         gXW0JjXlbHreQDF2x1AfZTDSfa69Wddiv5uOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vuhs0UQ8F2DEwV2dGlR1BHKVZoSVWTWNeuC7JgFu+6XWmfmS00yRwL/FWeGDdJI0xd
         ZpKJomvnwu3WyErux/C8e2NhIlhmYrfq1Ju4WcsKCFpVubE2h5NHd/xSfTUy0t/9oU4U
         EKoNraGptdZkbqLPhHU9MxMXBeNi6B8SObQZ4=
Received: by 10.224.83.85 with SMTP id e21mr1853138qal.227.1266159558116; Sun, 
	14 Feb 2010 06:59:18 -0800 (PST)
In-Reply-To: <20100214064408.GB20630@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139910>

On Sun, Feb 14, 2010 at 1:44 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 13, 2010 at 05:01:15PM -0500, Mark Lodato wrote:
>
>> If the argument is not valid for a diff-family program, a completely
>> unhelpful usage message is shown. =C2=A0It seems that all the other =
diff
>> options silently ignore invalid inputs, so this is consistent. =C2=A0=
Perhaps
>> this aspect should be tweaked.
>
> Hmm...the only one I see that silently ignores is "--submodule=3Dbogu=
s".
> But it seems that "git log -Bfoobar" fails but does not print a usefu=
l
> message. =C2=A0Probably both should be fixed, and your option should =
follow
> the same convention as those.

Just wondering, why does diff use a separate option parsing mechanism
than the rest of the code?  Would it be worthwhile to switch to
parse_opt?  This may make the code cleaner, and it would definitely
make the command-line interface more consistent with the rest of the
suite.  From a user's point of view, the biggest win would be "-h"
printing all of the options, like all the non-diff commands do.

> My only complaint in that respect is that there are no tests. =C2=A0H=
owever,
> I'm not sure we can get a very satisfying test, since the test script=
s
> may or may not have stdout going to a tty.

Perhaps I can throw the tests in Jonathan's "tests for automatic use
of pager", t7006-pager?  Or, create a new test that mimics his?

Thanks for the feedback,
Mark
