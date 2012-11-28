From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 09:44:56 +0100
Message-ID: <CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
	<7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
	<CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 09:45:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TddGb-0007XS-Pc
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 09:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab2K1Io6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 03:44:58 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36943 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2K1Io5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 03:44:57 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so7793174vbb.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 00:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kQfyKU1H6pI8y1nZUQ9X54QOun3YTwdf4P3ULG8QEYg=;
        b=XVGV5LRAJ58e4fZ3Ns1VbP7NQRPVmBTn74bYANgOlZ+FhCrSWFgFM5XwNik//QrwPR
         rxKh8YbL51bD69GyYVqJqif6P5IqxS50jROSEM9Ui5a4Zj3vXKZUnz+dxexM1NvTpmhm
         8RbL9m12Yu3Dhzq5puKLCFO9smV14Yt3xo3q96zaVhtxZGNqKsATiLJ75WePhB+9/XTH
         sHxMgCq+D0FTnZs+me1yIVU/7pVpK4P312Lv76RFcG7THwH/XJGLyu2fGb0DhT9S/Z0s
         1nF+9cmPAzJ5pGRg9yiz4eqdBhiUzx0GuG3e7WUJ4IcfWPM5FsKmPe2yoibhXtiaQgOE
         dTgw==
Received: by 10.58.239.138 with SMTP id vs10mr29034678vec.16.1354092296984;
 Wed, 28 Nov 2012 00:44:56 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Wed, 28 Nov 2012 00:44:56 -0800 (PST)
In-Reply-To: <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210721>

On Wed, Nov 28, 2012 at 9:19 AM, Thomas Berg <merlin66b@gmail.com> wrote:
> On Wed, Nov 28, 2012 at 8:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> There is room for new headers, and older versions of git will ignore
>>> them. You could add a new "committer-timestamp" field that elaborates on
>>> the timestamp included on the committer line. Newer versions of git
>>> would respect it, and older versions would fall back to using the
>>> committer timestamp.
>>>
>>> But I really wonder if anybody actually cares about adding sub-second
>>> timestamp support, or if it is merely "because SVN has it".
>>
>> Roundtrip conversions may benefit from sub-second timestamps, but
>> personally I think negative timestamps are more interesting and of
>> practical use.  Prehistoric projects need them even if they intend
>> to switch to Git, never to go back to their original tarballs and
>> collection of RCS ,v files.
>
> If roundtripping to other version control systems is an argument,
> adding sub-second timestamps could potentially create as many problems
> as it solves. For example, I've been using the hg-git bridge, and it
> supports roundtripping between git and mercurial today (for most repos
> I've tried anyway). I may have missed something, but this could imply
> that mercurial doesn't care about sub-second timestamps either. If so,
> and if git suddenly were to record it, it would no longer be as
> straight forward to represent git history in hg.

I'm not entirely sure. The API seems to return a float for the time,
but at least as far I can see, it never has any decimals anyway.

But it doesn't really matter, mercurial doesn't have a committer
information either. This is solved by tools like hg-git by storing the
information in an 'extra' field, which can store anything.

Unfortunately git doesn't have a similar field, so people have been
using the commit message to store extra information.

Either way, I don't see the point in changing git's commit format for
external tools. The git-notes functionality works just fine for that,
it just needs to be attached in the relevant places, like 'git
fast-export'.

BTW. Have you checked git's native support for hg?[1]

Cheers.

[1] http://felipec.wordpress.com/2012/11/13/git-remote-hg-bzr-2/

-- 
Felipe Contreras
