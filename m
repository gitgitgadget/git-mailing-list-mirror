From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Finding a branch point in git
Date: Thu, 31 May 2012 13:37:43 -0700
Message-ID: <CAJsNXTkWKP9xY-yBQF6PuF_YyGshV5xaXG-oBWAO138cFUyT1g@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
	<20120528062026.GB11174@sigill.intra.peff.net>
	<CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
	<20120528190639.GA2478@sigill.intra.peff.net>
	<CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
	<20120530215415.GB3237@sigill.intra.peff.net>
	<CAMP44s1Q26B9hCdubfDiP2_YUUWGOtyyA=gSwqpGOE4FfZrN8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 22:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaC7x-0003oQ-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 22:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872Ab2EaUhp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 16:37:45 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33763 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964865Ab2EaUho convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 16:37:44 -0400
Received: by lahd3 with SMTP id d3so1041528lah.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=izKj3uHTxOrhOVOniwOJFZWM34RNJV/BND/yiB5/isc=;
        b=PJPrQz5JmOUmcmzjwANk7tgmLq9UlSsm+hKM7pcV1BfGtHeFNfDgcCv3HFZ9BRjYph
         a7nMD8KKA2KPomHowanIxhEzBImQo9bVI05ww6Ue4K9Yg9Hjp0xFEaca8YxgkWV6HhJU
         SviKCwJtN1EowTlzI2KsdTCYtPOHNNtO0eUntP96+OtdvnrRJotyom1HL4erfo/WrVps
         kE3CwJ25gVUhkFGz1oKSOqxt4B6qTv85PwpLvaBZWdGyNlDI5M9hedv5D4/ZSrRLsYFZ
         lYs/vi+5bCOdMz3MZcSaISZXN/Sq7WrJLLEiwDXQic8rbUghcz3ZWFAVELKE1PL2XWt6
         vZkw==
Received: by 10.112.30.226 with SMTP id v2mr622324lbh.103.1338496663134; Thu,
 31 May 2012 13:37:43 -0700 (PDT)
Received: by 10.112.5.102 with HTTP; Thu, 31 May 2012 13:37:43 -0700 (PDT)
In-Reply-To: <CAMP44s1Q26B9hCdubfDiP2_YUUWGOtyyA=gSwqpGOE4FfZrN8A@mail.gmail.com>
X-Google-Sender-Auth: eRRfeSkqdR4cCxnBU9aeOIRkPIU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198946>

On Thu, May 31, 2012 at 8:27 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 30, 2012 at 11:54 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, May 30, 2012 at 07:07:39PM +0200, Felipe Contreras wrote:
>>
>>> On Mon, May 28, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
>>> > On Mon, May 28, 2012 at 02:36:04PM +0200, Felipe Contreras wrote:
>>> >
>>> >> > What about a history with multiple branches?
>>> >> >
>>> >> > --X--A--B--C--D----E =A0(master)
>>> >> > =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 /
>>> >> > =A0 =A0 =A0 G--H--I---J =A0 (branch X)
>>> >> > =A0 =A0 =A0 =A0 =A0 \ =A0 =A0/
>>> >> > =A0 =A0 =A0 =A0 =A0 =A0K--L =A0 =A0(branch Y)
>>> >> [...]
>>> >>
>>> >> Yes, but then you would need to specify a second branch. I would=
 avoid
>>> >> that if possible.
>>> >
>>> > I agree that is less nice. But I don't think the operation is
>>> > well-defined with a single branch. If you ask for "when did branc=
h X
>>> > split", then in the above graph it is unclear if you meant "split=
 from
>>> > master", or "split from Y".
>>>
>>> If you look from the context that I explained in the first mail; it
>>> would be from *any* branch; IOW; find the first commit from branch =
X
>>> (G), and then find the parent. That would be the first commit where
>>> branch X started.
>>
>> I'm not sure that's possible, though, in the face of criss-cross mer=
ges.
>> How do we distinguish the history above from one in which branch Y w=
as
>> forked from master at G, and then branch X was forked from branch Y =
at
>> H?
>
> That is true, but we could use the algorithm used by name-rev: G woul=
d
> have a distance 3 from branch X, and distance 2 from Y, so it would b=
e
> considered part of branch Y.
>
> Sure, it's not possible to know _for sure_, but this is a bit like
> renames; we don't really know if a file was renamed or not, but we ca=
n
> make a good guess.

Obviously G is part of branch Y, branch X, and branch master.  I'm
sure I'm missing the whole point of this exercise, because it seems to
me that it's just needlessly confusing to say anything else.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
