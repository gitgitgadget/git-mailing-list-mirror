From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 6 Apr 2010 19:56:36 +0400
Message-ID: <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
References: <loom.20100406T161552-321@post.gmane.org>
	 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
	 <4BBB53F5.9010106@op5.se>
	 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 17:56:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzB8t-0000HS-Ly
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 17:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab0DFP4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 11:56:39 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:63480 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0DFP4i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 11:56:38 -0400
Received: by bwz1 with SMTP id 1so32817bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6oBpsOoLKJymlNJ9afeMl2kz5eeyMd/CT0IgUeM6nGs=;
        b=fhYeqv+D6IuIWmK7XFwsXzG8dkuGNlAwDcLFIms3IsHcvVkgBpAIBftJbIUH1W7Q2e
         QZO0oZpn57cauTV31lklpvBQb8nKuQ7sOWTw27jkQWqHovCoJ/flNgWlqcuzULUmyfbg
         a6xGSCSQcT0uXA44VxLC9GA1NON27V450eAIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=deTZF1qUNC1nr/Huz76YhjsNLxe8cRFrx80dzN7VfMyfTwaeWa6iagL6T1Ak8UVuvT
         noTO2Mbp8p6TsdIVCpXv8HXXDKWoFJd/0dDbmRskTQ33iJuFpGP/g/j2rUNw+VJydZBQ
         cwf93dbBTLBKLiDEIDitKjum8wRNekzZRdi/o=
Received: by 10.204.65.135 with HTTP; Tue, 6 Apr 2010 08:56:36 -0700 (PDT)
In-Reply-To: <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
Received: by 10.204.139.68 with SMTP id d4mr8338353bku.66.1270569396401; Tue, 
	06 Apr 2010 08:56:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144152>

Why does git compute checksums on the client side? Isn't it already
calculated on the "server" side?

2010/4/6 Shawn Pearce <spearce@spearce.org>:
> Nope, the resolving deltas phase is about computing the checksums of =
each
> object on the client side of the connection.=C2=A0 Repacking the serv=
er might
> have little impact on this phase, other than maybe to reduce the size=
 and
> thus the disk io required to scan the entire pack.
>
> On Apr 6, 2010 9:32 AM, "Andreas Ericsson" <ae@op5.se> wrote:
>> On 04/06/2010 05:29 PM, Vitaly wrote:
>>> I didn't try this, but I'll give it a try, thanks.
>>>
>>> And what does this stage mean?
>>>
>>
>> It means the server is busy creating a packfile to send
>> over the wire. If you pack the repository before cloning
>> from it, deltas from the packfile will simply be copied
>> into the new pack. This will provide a huge speedboost,
>> so make sure to repack the repository on the server every
>> once in a while.
>>
>> --
>> Andreas Ericsson andreas.ericsson@op5.se
>> OP5 AB www.op5.se
>> Tel: +46 8-230225 Fax: +46 8-230231
>>
>> Considering the successes of the wars on alcohol, poverty, drugs and
>> terror, I think we should give some serious thought to declaring war
>> on peace.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
