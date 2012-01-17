From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/3] git-p4: Search for parent commit on branch creation
Date: Tue, 17 Jan 2012 23:43:18 +0000
Message-ID: <CAOpHH-XCdBOXAAgSGz81oyaN0i0X72=scOvfrDwN31q59c_9QA@mail.gmail.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
 <1326674360-2771-3-git-send-email-vitor.hda@gmail.com> <20120116185738.GA21996@padd.com>
 <CAOpHH-UkyK-c_AHUOPbQQmW9cQQypDvirMR0Jb7vTGSQF7RZpw@mail.gmail.com>
 <CAOpHH-XUj7tF4O_kXfxq2e9Y4VmybNLCqGku_-9H1X+c7v=xwQ@mail.gmail.com> <20120117221830.GA366@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 00:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnIh1-0000xf-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 00:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab2AQXnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jan 2012 18:43:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62598 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932080Ab2AQXnu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 18:43:50 -0500
Received: by lahc1 with SMTP id c1so1857659lah.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fw1tur/erieG8MQJ0UeVbyngzUWZV8SwqeZjhkYaNq4=;
        b=P5yfTrTrs6XD3YZTA9N2zrHqd5E0jR53UlYlxvUoTJAJJNaLMa7MGKGxfk+YCWBTfs
         CZTKkWm/W1EndGGTTSuAMPjLvNWwhj1YENVMBdz0O8dnYHNnqTDDyqqDx25oToDIlDca
         7Sz+bsipkYNSccFd0V7fW2Aw2XbyCTTHKZVAI=
Received: by 10.112.82.73 with SMTP id g9mr4764514lby.60.1326843829335; Tue,
 17 Jan 2012 15:43:49 -0800 (PST)
Received: by 10.152.6.197 with HTTP; Tue, 17 Jan 2012 15:43:18 -0800 (PST)
In-Reply-To: <20120117221830.GA366@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188729>

On Tue, Jan 17, 2012 at 10:18 PM, Pete Wyckoff <pw@padd.com> wrote:
> vitor.hda@gmail.com wrote on Tue, 17 Jan 2012 00:10 +0000:
>> On Mon, Jan 16, 2012 at 11:41 PM, Vitor Antunes <vitor.hda@gmail.com=
> wrote:
>> > On Mon, Jan 16, 2012 at 6:57 PM, Pete Wyckoff <pw@padd.com> wrote:
>> >> 1. =A0Move the tempBranch commit outside of the "for blob" loop.
>> >> =A0 =A0It can have no parent, and the diff-tree will still tell y=
ou
>> >> =A0 =A0if you found the same contents. =A0Instead of a ref for
>> >> =A0 =A0each blob inspected for each change, you'll just have one =
ref
>> >> =A0 =A0per change. =A0Only one checkpoint() after the tempBranch
>> >> =A0 =A0commit should be needed.
>> >
>> > You're right. Completely oversaw that. Will improve the code
>> > accordingly.
>>
>> Apparently I did not oversee it. Assume you have added a new file to
>> HEAD of parent branch, but you branched from a previous commit. When=
 the
>> new branch is committed over HEAD the new file will, incorrectly, be
>> part of it and diff-tree will not work as expected.
>
> I don't get it. =A0This algorithm works on the fact that a "branch"
> in p4 creates a new change that looks exactly like a previous
> change.
>
> The git-p4 sync step, when it detects a branch, starts by saving
> the change in a commit with parent =3D null, so it is its own new
> branch, an orphan, with no parents.
>
> Now the task is to find some commit that has an identical tree to
> this temporary one. =A0You walk back all known p4 commits to try to
> find one that is the same. =A0It doesn't matter if any of those p4
> commits have other commits on top of them.
>
> At each step in the backward walk, the comparison is against the
> unchanged orphan commit.
>
> An ascii-art picture might help me. =A0Or even a test case.

I can see now that I did not understand the "no parent" in your origina=
l
reply. What you just explained makes sense. So, let me try that and I'l=
l
update you tomorrow.

Vitor
