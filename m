From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Sat, 6 Jun 2009 19:41:15 +0200
Message-ID: <200906061941.16521.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <20090603165613.GJ3355@spearce.org> <d411cc4a0906060933m4f27c40eoaa2b81f983adc177@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 19:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCztf-0007yS-HI
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 19:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbZFFRl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbZFFRlZ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 13:41:25 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:51597 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbZFFRlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 13:41:24 -0400
Received: by fxm9 with SMTP id 9so1241228fxm.37
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DYVeC10+FBLXbkaPVZzgIbVhkwRezluRSRqRUpbyQ7Q=;
        b=A7v43Pmflj+3429elGnqUSqw/JhS/IZuhgH1lK788LL2hYexhXv0XDXg1k0UbDC9dQ
         3bK83xZw6Tnb828Wld4Q0F9537V2i+sVWEvBECMhQtiv+DOfraZCRCws9mSbwDoP3uyT
         L5GHMkYh1zapqKx55sBK/PL2Rn4sMCENtrwGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=J1LZ8/Z7gNyex9A4cBa8RGKvsEebFVX6XU8m2VWoa79EPuyPX9x7VQBImSCDAKa0/A
         qk3Gfn7nKHLqJ+ULSGlMp3G9nC2UNKO+SsgHa6YSn7IcwXXFV3OuBpnCDwDlOS0FcEnG
         9sQ0YcjFUBZ/4ORPAcaT+x05xE6mnTO8Q3MHE=
Received: by 10.86.33.9 with SMTP id g9mr5210934fgg.41.1244310085786;
        Sat, 06 Jun 2009 10:41:25 -0700 (PDT)
Received: from ?192.168.1.13? (abwg130.neoplus.adsl.tpnet.pl [83.8.230.130])
        by mx.google.com with ESMTPS id 4sm511435fge.3.2009.06.06.10.41.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 10:41:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <d411cc4a0906060933m4f27c40eoaa2b81f983adc177@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120927>

On Sat, 6 Jan 2009, Scott Chacon wrote:
> On Wed, Jun 3, 2009 at 9:56 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
>>>>
>>>> Oh, and send-pack/receive-pack protocol now has ".have" refs [...]
>>>
>>> What are those ".have" refs? They are not described in current vers=
ion
>>> of "Transfer Protocols" (sub)section in "The Community Book". I rem=
ember
>>> that they were discussed on git mailing list, but I don't remember =
what
>>> they were about...
>>
>> If the remote receiving repository has alternates, the ".have" refs =
are
>> the refs of the alternate repositories. =C2=A0This signals to the cl=
ient that
>> the server has these objects reachable, but the client isn't permitt=
ed
>> to send commands to alter these refs.
>=20
> Can someone help me out with the '.have' refs?  What do they look
> like?  Is this the same as the '.keep' ref Jakub mentioned earlier in
> one of the example server responses?

This was my mistake, and even more that was double mistake. It is=20
'.have', not '.keep', and (as Shawn said) it can be found in response
during _push_ as a reply from git-receive-pack, not during fetch / clon=
e
as reply from git-upload-pack.

If a repository you want to push to uses alternates (e.g. was cloned
using --shared option, or using --reference=3D<repository path> option)=
,
then refs from repository which serves as source of alternate=20
(additional) object database are shown as '.have' refs.


Create some repository, add some objects to it that it is not empty,
then clone it (locally) using e.g. "git clone --mirror --shared",
do some work on clone (for example delete one of branches), then try to
push.
=20
I used "ssh localhost git-receive-pack /path/to/clone.git" as a dummy
client to see what response from git-receive-pack would be:

  0059c0a92eb6f58c25a4c00e5e754e6de83e103231a1 .have report-status dele=
te-refs ofs-delta\n=20
  0033efd990cb1a5f35b2b3e8b0ef0a85f43b118b8688 .have\n
  0033c0a92eb6f58c25a4c00e5e754e6de83e103231a1 .have\n
  003fefd990cb1a5f35b2b3e8b0ef0a85f43b118b8688 refs/heads/master\n
  0000

'.have' are references in repository which given repository borrows
object from, i.e. which object database is in $GIT_DIR/objects/info/alt=
ernates
file.

Sidenote: here as far as I can see we do not use "\0" trick...=20
which is a bit strange (at least for me).

>=20
> I'm trying to take this whole thread and actually write an RFC style
> document for all of this stuff, but I'm still unclear on the .have
> portion of the conversation.  Pointing me to an earlier relevant
> thread in the Git mailing list would be fine, too - it's difficult to
> search for '.have' usefully.

Well, "Transfer Protocols" section in "Git Community Book" is a good
start. I think that it would be better to have pack protocol described
first there, not necessary with the amount of detail required for=20
technical reference documentation (format) like RFC.

Currently the "Pushing Data" subsection in "Transfer Protocols" consist
currently of two short paragraphs... and that is the section where=20
description of fake '.have' refs should go to. They do not matter and
are not used for fetching.


P.S. I'll try to send, as a summary of this thread (and my experiments)=
,
second round of my comments about smart protocols section of "Transfer
Protocols" section soon, and most probably third round would be in the
form of a patch to Markdown sources for this section (chapter).

--=20
Jakub Narebski
Poland
