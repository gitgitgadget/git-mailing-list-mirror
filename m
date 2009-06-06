From: Scott Chacon <schacon@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Sat, 6 Jun 2009 09:33:06 -0700
Message-ID: <d411cc4a0906060933m4f27c40eoaa2b81f983adc177@mail.gmail.com>
References: <200905122329.15379.jnareb@gmail.com>
	 <200906031121.38616.jnareb@gmail.com>
	 <20090603144837.GE3355@spearce.org>
	 <200906031851.12160.jnareb@gmail.com>
	 <20090603165613.GJ3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 18:34:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCyqy-0003og-Uu
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 18:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbZFFQdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 12:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbZFFQdG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 12:33:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:61142 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbZFFQdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 12:33:04 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1363648ywb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pc0GEvJdUy5GYjUhWuoAq+F4NZ0uhEq9cM1ggnaLRD4=;
        b=YzyM810L42P8yO0OD45XEjkWtmuXI4Qq2P5PmpGDWhaH5onbx2LhJLRvW3oSVfqgo7
         H+bsckY+znDi3Go3ToqjYocpWdOYVVa+DCKigrr6CywLCBwTn4wNJGIkSdvpfMPUJlzL
         s+igLbTTOD6VxRN1s8XpeNt1jiO4dTpD5wsoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j+3XfsNWbMZDLQdLc7L5TUwZRgrZ9sPwerJhToN7gG9SpY6mzUS4MkPBSjRq1QAbPb
         G1rCPTXzN6P6b3X1M0gIbrjakEvP5vvqp1sBA5s/IVdbk8ytD3/GgDf9OA4xKWxh9EZw
         Imr46bDgR6O72pfkPWbgTLuDW9vfFx5+Q7wZA=
Received: by 10.100.202.17 with SMTP id z17mr5009180anf.80.1244305986267; Sat, 
	06 Jun 2009 09:33:06 -0700 (PDT)
In-Reply-To: <20090603165613.GJ3355@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120925>

Hey,

On Wed, Jun 3, 2009 at 9:56 AM, Shawn O. Pearce<spearce@spearce.org> wr=
ote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
>> > Oh, and send-pack/receive-pack protocol now has ".have" refs [...]
>>
>> What are those ".have" refs? They are not described in current versi=
on
>> of "Transfer Protocols" (sub)section in "The Community Book". I reme=
mber
>> that they were discussed on git mailing list, but I don't remember w=
hat
>> they were about...
>
> If the remote receiving repository has alternates, the ".have" refs a=
re
> the refs of the alternate repositories. =C2=A0This signals to the cli=
ent that
> the server has these objects reachable, but the client isn't permitte=
d
> to send commands to alter these refs.

Can someone help me out with the '.have' refs?  What do they look
like?  Is this the same as the '.keep' ref Jakub mentioned earlier in
one of the example server responses?

I'm trying to take this whole thread and actually write an RFC style
document for all of this stuff, but I'm still unclear on the .have
portion of the conversation.  Pointing me to an earlier relevant
thread in the Git mailing list would be fine, too - it's difficult to
search for '.have' usefully.

Thanks!
Scott

>
> Its good for a site like GitHub or repo.or.cz where cheap forks are
> implemented by creating a repository that points to a common shared
> base via alternates. =C2=A0The ".have" refs say that the server alrea=
dy
> has everything in that common shared base, so the client doesn't
> have to re-upload the entire project if the fork started out empty,
> or had all refs deleted from it.
>
>> > In packed-refs, Junio had a hard time adding the "peeled-refs"
>> > support, because the first version of the parser was so strict.
>> > But again, somehow he managed to find a backdoor in the old parser=
,
>> > and that backdoor is why that file looks the way it does today.
>>
>> I don't remember what that was about... Nevertheless now we have
>> kind of 'capabilities' section in .git/packed-refs
>
> Sort of. =C2=A0In a file format its worse than a network protocol,
> because the file can't alter its contents based on what the
> reader can understand.
>
>> Interesting... even more so that this problem of designing without
>> extendability in mind (magic number + version) is so persistent :-(
>
> I know. =C2=A0I think we maybe have learned the lesson. =C2=A0I don't=
 know.
>
> --
> Shawn.
>
