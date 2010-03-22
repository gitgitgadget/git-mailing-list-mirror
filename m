From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 15:31:27 +0800
Message-ID: <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 08:31:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntc6n-0006nN-VO
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 08:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab0CVHb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 03:31:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:61953 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab0CVHb2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 03:31:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1102295qwh.37
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sel/ql+r11nbm7A7rzW0oSU6tlAeShlnrp/US2jUpQU=;
        b=ab3FR0HmIMhh61gIU4W6vog/mou20yhFiZqlSYPCt1L27z+poaDfBDleEWddOM3efk
         w4Lxigkq05wKwNthUo2k/6rupcLzvscG3OY5vs2wd1f8FdLRqGJyJ3bYdcak0A6FhwR2
         Ph3rmcLYJ3bNajKSZppe1Z1odKN01ursYcq4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VTeUkDq372oKL0zHSJVAIitcYixjwdfREMmPN866M1H6DB+Ia4Bd4aXjqlQWCGZqQN
         +CF/eGlcp7KNvcL50U9pdtFPC+AsRv5/F31rOA2gQFu++pW5/Kz1mtJ4qRnk18uvreqL
         IlN4JtT3kScSmk9QjcjFqoFoR1DzD/5MJs+6U=
Received: by 10.229.233.139 with SMTP id jy11mr2499799qcb.38.1269243087924; 
	Mon, 22 Mar 2010 00:31:27 -0700 (PDT)
In-Reply-To: <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142905>

On Mon, Mar 22, 2010 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Bo Yang <struggleyb.nku@gmail.com> writes:
>
>> The 'blame' way is very good if we only support one line range. But =
if
>> we want to support multiple line ranges, I don't think it is suitabl=
e
>> for that case. Anyway, how can I specify multi-ranges which refers t=
o
>> multiple files at multiple revision and multiple line ranges using
>> above syntax?
>
> I would sort of see you may want to be able to say "explain lines 10 =
thru
> 15 of config.h and lines 100-115 of hello.c that appear in v1.2.0", b=
ut I
> think it is a total nonsense to ask for "ll 10-15 of config.h in v1.2=
=2E0
> and ll 110-115 of hello.c in v1.0.0". =A0After all they never existed=
 in the
> same revision (otherwise you would have said "ll 7-13 of config.h and=
 ll
> 110-115 of hello.c that appear in v1.0.0"). =A0So I would reject the
> SVN-like "rev@" in the first place.
>
> While I don't seriously buy "multiple files" either, if that is reall=
y
> needed, I could be pursuaded with =A0"log -- path1:10-15 path2:1-7", =
or
> "log -L path1:10-15 -Lpath2:1-7 -- path1 path2" or something similarl=
y
> ugly like these, but that is not how we generally name things, and it
> probably shouldn't be a new option to "log" anymore.
>
> On the other hand, multiple ranges in a single file is something that
> may be quite reasonable, e.g.
>
> =A0$ git log -L10-15 -L200-210 -- Makefile
> =A0$ git log -L'*/^#ifdef WINDOWS/,/^#endif \/\* WINDOWS \/\*/' -- co=
nfig.h

Yeah, maybe one file multiple ranges is most rationale.

> As I already said, I wouldn't be so worried about multiple-range feat=
ure,
> but I would be worried about the usefulness of this feature, even for=
 the
> case to track a single range of a single file, starting from one give=
n
> revision.

I am sorry, but I did not catch up you here. You worried about the
usefulness of the multi-range feature or the line level history
browser?

I think tracking a single range of a single file, starting from one
given revision is useful when the line of history split on some point.
This can let users focus on a single line of history using this
feature.

>When you want to know where the first few lines of Makefile
> came from, and if blame says the first line came from 2731d048, that
> really means that between the revision you started digging from and t=
he
> found revision, there is no commit that touched that particular line,=
 but
> equally importantly, that before that found revision, there wasn't a
> corresponding line in that file---blame stopped exactly because there=
 is
> nobody before that found revision that the line can be blamed on.
>
> So implementing "git log -L1,10 -- Makefile" might be just the matter=
 of
> doing something like:
>
> =A01. Run "git blame -L1,10 -- Makefile";
> =A02. Note the commits that appear in the output;
> =A03. Topologically sort these commits;
> =A04. Run "git show <the result of that toposort>"
>
> which is not very satisfying.

Yes, this is not satisfying. But as I understand, the line level
history browser will do more than just this. It will not stop on 'step
4', it can follow the change history recursively and deeply, to find
more. I think this is useful when we focus just one a range of code
and want to know how it become into such a now condition.

Anyway, it is not a bad thing too add a new convenient feature to a
daily tool. :)

Regards!
Bo
