From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Getting a list of commits between 2 points without upstream changes
Date: Mon, 18 Jul 2011 12:33:27 +1200
Message-ID: <CAFOYHZDUyQpVc5m4w9jcDsmed+UR8a_zxzR0mBAjPf7_A80MQg@mail.gmail.com>
References: <CAFOYHZC5hQ9JV8a5d20AaPR_eYFDViama+4148MPumvvJ-n6wQ@mail.gmail.com>
	<20110718001749.GA706@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 18 02:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qibpz-0000Ip-R4
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 02:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351Ab1GRAd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 20:33:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38122 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab1GRAd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 20:33:27 -0400
Received: by vxh35 with SMTP id 35so1320452vxh.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rMF8tNG4zlWC7A7kPwPzMTqdtNwe8de6yeDpTSZKd1U=;
        b=AwX+7FHP+mOP2tXpb8hvZ9998WlWPga51l7taGSOps8NDSRMXJcLy2/q/kWFZKT4RH
         oqHxWMpve+PtxSBPux9od6QfJcKW3gLshYRzGuMv7kJKS+U3mnABE8xi2RBHkQhwot52
         2gBiN5rvJjyEEzmTHfxgWHB6X70uAJIwZ5wog=
Received: by 10.220.103.135 with SMTP id k7mr1586315vco.123.1310949207101;
 Sun, 17 Jul 2011 17:33:27 -0700 (PDT)
Received: by 10.220.191.202 with HTTP; Sun, 17 Jul 2011 17:33:27 -0700 (PDT)
In-Reply-To: <20110718001749.GA706@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177328>

On Mon, Jul 18, 2011 at 12:17 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 18, 2011 at 11:49:57AM +1200, Chris Packham wrote:
>
>> I'm trying to send round an incremental changelog for my project whi=
ch
>> contains just my changes without changes that have been made upstrea=
m.
>> The history look something like this.
>>
>> ---o--o--o--o--o--o--o--o-- upstream
>> =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\
>> =C2=A0 =C2=A0 =C2=A0\-m--A--m--B--m--C--D-- topic
>>
>> What I want is a changelog with just B, C and D in it (i.e. no merge
>> commits and no commits already in upstream). I know if I wanted A,B,=
C
>> and D I could just do 'git log --no-merges upstream..topic'. If I do
>> 'git log --no-merges B..topic' I get the merged commits from upstrea=
m.
>> In set-speak what I think want is the union of upstream..topic and
>> B..topic.
>
> I'm not clear on what makes "B" more special than "A" in the graph
> above. But assuming you know A, don't you just want:

What makes A special in this case is that commits up to and including
A have been reviewed, regression tested etc. My use-case is really
about telling people what has been worked on since the last time the
code was reviewed.

>
> =C2=A0git log --no-merges topic ^upstream ^A
>
> ? That is, "everything in topic, but not in upstream, nor in the pare=
nt
> of A". Or if you know A and not B, you can use "^B^!" (which means "d=
o
> not include commits that are in any parent of B").

Brilliant, that's exactly what I wanted. Thanks.

>
> -Peff
>
