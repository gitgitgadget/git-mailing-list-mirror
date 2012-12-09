From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH] gitk: read and write a repository specific configuration
 file
Date: Sun, 09 Dec 2012 14:25:46 +0100
Message-ID: <50C4915A.4040102@poczta.fm>
References: <50BF6629.8050806@xiplink.com> <1354966067-2865-1-git-send-email-stlman@poczta.fm> <7vd2yjeg8f.fsf@alter.siamese.dyndns.org> <20121209104426.GA20818@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, mbranchaud@xiplink.com
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 14:26:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThgtT-0006Ny-09
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 14:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934146Ab2LINZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2012 08:25:50 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:54598 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934112Ab2LINZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 08:25:50 -0500
Received: from [192.168.0.13] (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sun,  9 Dec 2012 14:25:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120825 Thunderbird/10.0.6
In-Reply-To: <20121209104426.GA20818@bloggs.ozlabs.ibm.com>
X-Enigmail-Version: 1.3.5
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1355059548;
	bh=t+vaM2b2KDcuykgtKuRtLreceY8MjSwZRZ3dZkzUvPA=;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:
	 Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:
	 Content-Transfer-Encoding:X-Interia-Antivirus;
	b=jQTCRFz6ZdjIuvylHIW67H5o0TIh9oECEsOp1zqaHIMVTTX6z9NETCRerKIc6mzuu
	 SL6I5diGK+QqemkQC/fm8Z+9c5VmGNQ8v64FspCbsQ1b/9uBLu+ASh7DhzikEwSRId
	 3qT2G5rnl6Ih75YxMmykv8h8AtmSoUGNovTpb0wo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211238>

W dniu 09.12.2012 11:44, Paul Mackerras pisze:
> On Sun, Dec 09, 2012 at 01:18:08AM -0800, Junio C Hamano wrote:
>> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>>
>>> Enable gitk read and write repository specific configuration
>>> file: ".git/k" if the file exists. To make gitk use the local
>>> file simply create one, e.g. with the touch(1) command.
>>>
>>> This is very useful if one uses different views for different
>>> repositories. Now there is no need to store all of them in
>>> ~/.gitk and make the views list needlessly long.
>>
>> I do not use gitk heavily myself, but I have a mixed feeling about
>> this patch.
>=20
> I agree, I think this would be surprising to people who are used to
> the way gitk works now.
>
> I could imagine having a checkbox in the Edit->Preferences dialog to
> say "Save configuration settings locally", and if you check that box,
> then it writes the configuration to .git/gitkconfig or whatever
> (having first saved that setting in the global ~/.gitk).=20

No this isn't a good idea. When you choose to save configuration locall=
y
it means you've alredy changed it to match your local needs and making
it global does not seem reasonable.

> But I think it should be an opt-in thing.

It is opt-in now definitely. One needs to create the local config file,
even an empty one, for gitk to choose it upon doquit/savestuff. I agree
a checkbox may be more convenient but is it "opty" (as in opt-in) enoug=
h?

Then, the checkbox should be added to both "Preferences" and "Edit View=
"
dialogs, anything more?

>> In any case, the filename .git/k may be _cute_, but I do not think
>> we would want to see:
>>
>>     $ ls .git
>>     branches        config       HEAD   index  k     objects
>>     COMMIT_EDITMSG  description  hooks  info   logs  refs
>>
>> It is too cryptic, unless the user _knows_ 'k' is for gitk.  I'd
>> call it $GIT_DIR/gitkconfig or something, if I were supportive for
>> this feature (which I am not enthusiastic, yet).
>=20
> I agree with this too.

Sure, let's vote:

a) .git/gitk
b) .git/gitkconfig
c) .git/gitkrc

--=20
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99=
ska, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziej=
ska.  (c)PP
