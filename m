From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding all commits which modify a file
Date: Tue, 24 Jan 2012 02:36:09 +0100
Message-ID: <CA+gHt1AYrCv_9MJwBntt_+-GRb4N81PxxO8HXP-XU0pCiFWAVw@mail.gmail.com>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
 <4F1B4764.3010501@gmail.com> <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
 <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com> <CA+55aFynLN7kBYh7i-kh+Xd1Qn-wKBePcokmJRNfe8RYA0cCZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Groothuis <ngroot@lo-cal.org>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 02:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpVJL-0002Ms-UK
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 02:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab2AXBgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 20:36:31 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35341 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab2AXBga convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 20:36:30 -0500
Received: by pbaa10 with SMTP id a10so1950817pba.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 17:36:30 -0800 (PST)
Received: by 10.68.72.230 with SMTP id g6mr26794419pbv.119.1327368990254; Mon,
 23 Jan 2012 17:36:30 -0800 (PST)
Received: by 10.68.56.164 with HTTP; Mon, 23 Jan 2012 17:36:09 -0800 (PST)
In-Reply-To: <CA+55aFynLN7kBYh7i-kh+Xd1Qn-wKBePcokmJRNfe8RYA0cCZA@mail.gmail.com>
X-Gm-Message-State: ALoCoQl9kWDp5EFLuqExS3O1kfPwHPK8Gtkjkg87K4wO4HxmPV3wwgadbQ8RNnvDtIt9FrvBATlx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189034>

On Tue, Jan 24, 2012 at 2:15 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jan 23, 2012 at 4:58 PM, Santi B=E9jar <santi@agolina.net> wr=
ote:
>>
>> If you add parent rewriting (--parent, --graph or see it in gitk, wi=
th
>> --full-history) you'll get your B2 commit as it adds commits to have=
 a
>> meaningful history. But I don't think this is what you are asking fo=
r.
>>
>> =A0You could try the following patch (sorry for the whitespace damag=
e,
>> also attatched):
>>
>> Subject: [PATCH/RFC] revision: merging branches with different conte=
nt
>> is interesting in --full-history
>
> The concept seems sane.
>
> But please check the interaction with "--simplify-merges" too, just i=
n
> case. The merge simplification looks at TREESAME too, so I suspect
> your change may break merge simplification.

Indeed, there is a bad interaction with --simplify-merges. If you add
--simplify-merges it not only increase the number of commit but
changes them :-(

$ ./git rev-list --full-history --simplify-merges HEAD Makefile >
rev-list.simp-merges
$ ./git rev-list --full-history HEAD Makefile > rev-list.new
$ diff rev-list.new rev-list.simp-merges -u | diffstat
 rev-list.simp-merges | 1841 ++++++++++++++++++++++++++----------------=
---------
 1 file changed, 944 insertions(+), 897 deletions(-)

Santi
