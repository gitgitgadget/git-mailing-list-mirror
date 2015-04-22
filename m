From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Wed, 22 Apr 2015 21:53:08 +0200
Message-ID: <CAMpP7Napqj1riCQ_iNWnGS8m3ncH6+fY+Rppn5cUfDT=n8aUWg@mail.gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
	<20150420221414.GA13813@hank>
	<CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
	<20150421212427.GB13230@peff.net>
	<CAMpP7NbruKC97L1ROXV0Up9Fks8FJmgB_nxTTWpSHp-8VVE+Xw@mail.gmail.com>
	<20150422194601.GB27656@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:53:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0hw-0004mT-51
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092AbbDVTxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 15:53:09 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35342 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbbDVTxI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 15:53:08 -0400
Received: by oign205 with SMTP id n205so188670896oig.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=M8E4NyVb7y2W8SACYh2NKUEx6m1sKLsB7R3s8Zo/3Xc=;
        b=M8vUDJZ/O555HfxzqKzFe/1EX/iYa2PgeX7CkYc+5ife4owFBMr83vSUdgv2Hhlrt5
         QOlD4pKEc12QzMWoFKFcsd4cSvmPMxYdWkKnidNLE7vV65QAHQCz1aiIxmHiknwLacPL
         tnelQnhT1A5+hjwUepP+6fOVvwgf8odstWGs36lszTeRewYEhdpE7lN+3uU29sIFZjHl
         cN4l8/O6FdhA7BnpTP0iyxi7oHtD09DGe8NPey9xOg38uClkGLh6U68c1VckRBAONTFB
         cKJWWjZqD6ZT8MrxY5uxAqhmNFtdNOiRx74Q1g0jCtsox3lfNV+Io9HBbgodYbq9WBg0
         g//g==
X-Received: by 10.60.120.34 with SMTP id kz2mr10419678oeb.46.1429732388517;
 Wed, 22 Apr 2015 12:53:08 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Wed, 22 Apr 2015 12:53:08 -0700 (PDT)
In-Reply-To: <20150422194601.GB27656@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267627>

On Wed, Apr 22, 2015 at 9:46 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 22, 2015 at 09:30:20PM +0200, erik elfstr=C3=B6m wrote:
>>
>> Yes, that is the problem. A dry run will spot this particular perfor=
mance
>> issue but maybe we lose some value as a general performance test if
>> we only do "half" the clean? Admittedly we clearly lose some value i=
n
>> the current state as well due to the copying taking more time than t=
he
>> cleaning. I could go either way here.
>
> I guess it is a matter of opinion. I think testing only the "find out
> what to clean" half separately is actually beneficial, because it hel=
ps
> us isolate any slowdown. If we want to add a test for the other half,=
 we
> can, but I do not actually think it is currently that interesting (it=
 is
> just calling unlink() in a loop).
>
> So even leaving the practical matters aside, I do not think it is a b=
ad
> thing to split it up. When you add in the fact that it is practically
> much easier to test the first half, it seems to me that testing just
> that is a good first step.
>
> -Peff

Sounds reasonable to me. I'll make this change in v4, thanks!

(Sorry for the duplicate email Jeff, I'm bad at this mailing list thing=
=2E..)

/Erik
