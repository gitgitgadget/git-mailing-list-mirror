From: Patrick Berkeley <patrickberkeley@gmail.com>
Subject: Re: On Tracking Binary Files
Date: Tue, 14 Apr 2009 16:27:10 -0400
Message-ID: <7efce40a0904141327w3cbfbfecwbe7d5d9125fe8d4a@mail.gmail.com>
References: <7efce40a0904140741w28da9b54ucfe4b54bf48b0844@mail.gmail.com> 
	<7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com> 
	<alpine.DEB.1.00.0904141853040.10279@pacific.mpi-cbg.de> <7vws9n2e7p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtpFg-0003Zc-2x
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbZDNU12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 16:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbZDNU12
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:27:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:56489 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZDNU11 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 16:27:27 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2821244ywb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 13:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SBNtTi9/ES7KFCj9F8r8jvnh0QIuHVEhrGb8Qzewj3I=;
        b=n5KGAGJ5zmZbK0GHOODg0f77uQazanbxJ1DfBjazWMY17+AjCU/w47fj1VKrQOHO87
         CBo+yLVs19jebHZjGXp8THXtzZMCCe1nPrRaLAlp5sCPbbWTXBJmrMhkwZXGnuG8wmn5
         mGV3ZxG4b0Xi+rBfSRQpLEoxcPXwBNZ9+1IR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mV4VAMGLTUiq7RDEkVPaG+XLmlwzDSTJGrxbrU+p3QN8wrB3c2kjcUIJX4o69bFh/z
         ap6pC8p2VUyy9PW1hjLovtwIhW3x2yvfzijZMuBr2h1iNS1vqlO3Ivfrt+0+rqgtHUb5
         jZsaMAPgY4T5cQKeF2Iyj5sqg3Z2Is/xigggc=
Received: by 10.150.122.21 with SMTP id u21mr15715021ybc.20.1239740845153; 
	Tue, 14 Apr 2009 13:27:25 -0700 (PDT)
In-Reply-To: <7vws9n2e7p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116566>

Junio,

Thanks a lot for your thorough explanation..

Patrick

On Tue, Apr 14, 2009 at 16:05, Junio C Hamano <gitster@pobox.com> wrote=
:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Tue, 14 Apr 2009, Patrick Berkeley wrote:
>>
>>> Does Git track the deltas on binary files?
>>>
>>> Someone in #git mentioned that if the binaries change too much Git =
no
>>> longer just stores the changes. If this is the case, what is the
>>> breaking point where Git goes from storing the deltas to the entire
>>> new file?
>>
>> Git does not store the deltas as you think it does. =A0The deltifica=
tion of
>> the objects is almost independent from the commmit history, i.e. we
>> _always_ store snapshots for most practical matters.
>
> Always store snapshots sounds as if you are not storing delta at all.=
 =A0I
> think I know what you meant to say, but the way you phrased it is
> misleading.
>
> Documentation/technical/pack-heuristics.txt talks about this in some
> detail. =A0A short version is:
>
> =A0- It does not make a difference if you are dealing with binary or =
text;
>
> =A0- The delta is not necessarily against the same path in the previo=
us
> =A0 revision, so even a new file added to the history can be stored i=
n a
> =A0 delitified form;
>
> =A0- When an object stored in the deltified representation is used, i=
t would
> =A0 incur more cost than using the same object in the compressed base
> =A0 representation. =A0The deltification mechanism makes a trade-off =
taking
> =A0 this cost into account, as well as the space efficiency.
>
> The last point may probably be not covered by pack-heuristics IRC tal=
k
> Linus had in the documentation. =A0Basically:
>
> =A0- A deltified object is stored as an (compressed) xdelta against s=
ome
> =A0 base object. =A0If the best deltified representation we come up w=
ith is
> =A0 larger than the result of just compressing the object without
> =A0 deltification, it is not worth storing it from the space comsumpt=
ion
> =A0 point of view. =A0Thus, we originally said something like "if an
> =A0 attempted delta is larger than half of the object size (assuming
> =A0 average 50% of compression ratio), do not use the deltified
> =A0 representation, it is not worth it". =A0We attempt to delta again=
st many
> =A0 base objects to pick the best possible delta; the number of attem=
pt is
> =A0 called the delta window.
>
> =A0- The base object of a deltified object could also be deltified, a=
nd you
> =A0 may need to repeatedly apply delta on top of some object that is =
not a
> =A0 delta to get to the final object. =A0The length of this chain is =
called
> =A0 delta depth, and obviously you would want to keep the delta depth=
 short
> =A0 to gain a reasonable runtime performance. =A0Thus, when delitifyi=
ng one
> =A0 object A, we make a weighted comparison between the size of the d=
elta
> =A0 to build it out of an object of depth N and the size of the delta=
 to
> =A0 build it out of an object of depth M. =A0A slightly larger delta =
that is
> =A0 based on an object with a shallower delta depth is favored over a
> =A0 smaller delta based on an object with a much deeper delta depth.
>
>
